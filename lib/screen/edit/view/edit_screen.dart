import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:repeat_exam/screen/edit/controller/edit_controller.dart';
import 'package:repeat_exam/screen/edit/model/edit_model.dart';
import 'package:repeat_exam/utils/db_helper.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtDis = TextEditingController();
  EditController controller = Get.put(EditController());
  @override
  void initState() {
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("To-Do"),
              leading: IconButton(onPressed: (){},icon: const Icon(Icons.arrow_back_ios_new),),
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.dark_mode_outlined)),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text("Add To-Do",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              DBHelper helper = DBHelper();
                              helper.insertDB(EditModel(
                                title: txtTitle.text,
                                description: txtDis.text,
                              ),);
                              txtTitle.clear();
                              txtDis.clear();
                              Get.back();
                            }, icon: const Icon(Icons.save)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.grid_view_sharp)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.restart_alt)),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: txtTitle,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Title"),
                        hintText: "ToDo",
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: txtDis,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Description"),
                        hintText: "Write Here",
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        const Text("Pick Date"),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.calendar_month)),
                        const Spacer(),
                        const Text("1/06/2024"),
                      ],
                    )
                  ],
                ),
              ),
            ),
        ),
    );
  }
}
