import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeat_exam/screen/edit/controller/edit_controller.dart';
import 'package:repeat_exam/screen/edit/model/edit_model.dart';
import 'package:repeat_exam/utils/db_helper.dart';
import 'package:repeat_exam/utils/shere_helper.dart';

class EditScreen extends StatefulWidget {
  final EditModel? editModel;

  const EditScreen({super.key, this.editModel});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtDis = TextEditingController();
  EditController controller = Get.put(EditController());

  @override
  void initState() {
    super.initState();
    if (widget.editModel != null) {
      txtTitle.text = widget.editModel!.title!;
      txtDis.text = widget.editModel!.description!;
      controller.selectedCategory.value = widget.editModel!.category!;
      controller.selectedDate.value = widget.editModel!.date ?? '';
    }
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("To Do"),
          actions: [
            Obx(
                  () => Switch(
                value: controller.islight.value,
                onChanged: (value) {
                  ShareHelper shr = ShareHelper();
                  shr.setTheme(value);
                  controller.changeTheme();
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Add To-Do",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.editModel == null) {
                              DBHelper helper = DBHelper();
                              helper.insertDB(
                                EditModel(
                                  title: txtTitle.text,
                                  description: txtDis.text,
                                  category: controller.selectedCategory.value,
                                  date: controller.selectedDate.value,
                                ),
                              );
                            } else {
                              EditModel updatedModel = EditModel(
                                id: widget.editModel!.id,
                                title: txtTitle.text,
                                description: txtDis.text,
                                category: controller.selectedCategory.value,
                                date: controller.selectedDate.value,
                              );
                              controller.updateData(updatedModel);
                            }
                            controller.getData();
                            txtTitle.clear();
                            txtDis.clear();
                            controller.selectedCategory.value = '';
                            controller.selectedDate.value = '';
                            Get.back();
                          }
                        },
                        icon: const Icon(Icons.save),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.grid_view_sharp),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.restart_alt),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                        () => ToggleButtons(
                      isSelected: [
                        controller.selectedCategory.value == 'Low',
                        controller.selectedCategory.value == 'Medium',
                        controller.selectedCategory.value == 'High',
                        controller.selectedCategory.value == 'Urgent'
                      ],
                      onPressed: (int index) {
                        controller.updateCategory(index);
                      },
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Low'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Medium'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('High'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Urgent'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: txtTitle,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Title"),
                      hintText: "ToDo",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: txtDis,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Description"),
                      hintText: "Write Here",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text("Pick Date"),
                      IconButton(
                        onPressed: () => controller.pickDate(context),
                        icon: const Icon(Icons.calendar_month),
                      ),
                      const Spacer(),
                      Obx(
                            () => Text(controller.selectedDate.value.isNotEmpty
                            ? controller.selectedDate.value
                            : 'No date chosen'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}