import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeat_exam/screen/edit/controller/edit_controller.dart';
import 'package:repeat_exam/screen/edit/view/edit_screen.dart';
import 'package:repeat_exam/utils/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          title: const Text(
            "To Do",
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            Obx(
              () => IconButton(
                  onPressed: () {
                    controller.isGrid.value = !controller.isGrid.value;
                  },
                  icon: Icon(controller.isGrid.value
                      ? Icons.list_rounded
                      : Icons.grid_view_sharp)),
            ),
          ],
        ),
        body: Obx(() => controller.isGrid.value
            ? ListView.builder(
                itemCount: controller.editList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: controller.editList[index].category == 'Low'
                          ? Colors.blue
                          : controller.editList[index].category == 'Medium'
                              ? Colors.green
                              : controller.editList[index].category == 'High'
                                  ? Colors.amber
                                  : controller.editList[index].category ==
                                          'Urgent'
                                      ? Colors.red
                                      : Colors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title : ${controller.editList[index].title}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              "Description : ${controller.editList[index].description}",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.visible,
                              maxLines: 1),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Category : ${controller.editList[index].category}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Date : ${controller.editList[index].date}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.to(() => EditScreen(
                                        editModel: controller.editList[index]));
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    DBHelper helper = DBHelper();
                                    helper.deleteDB(
                                        id: "${controller.editList[index].id}");
                                    controller.getData();
                                  },
                                  icon: const Icon(Icons.delete_outline),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 230),
                itemCount: controller.editList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    height: double.infinity,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: controller.editList[index].category == 'Low'
                          ? Colors.amber
                          : controller.editList[index].category == 'Medium'
                              ? Colors.blue
                              : controller.editList[index].category == 'High'
                                  ? Colors.amber.shade700
                                  : controller.editList[index].category ==
                                          'Urgent'
                                      ? Colors.red
                                      : Colors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title : ${controller.editList[index].title}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Description : ${controller.editList[index].description}",
                            style: const TextStyle(fontSize: 18),
                            overflow: TextOverflow.visible,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Category : ${controller.editList[index].category}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Date : ${controller.editList[index].date}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.to(() => EditScreen(
                                        editModel: controller.editList[index]));
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    DBHelper helper = DBHelper();
                                    helper.deleteDB(
                                        id: "${controller.editList[index].id}");
                                    controller.getData();
                                  },
                                  icon: const Icon(Icons.delete_outline),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => EditScreen());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
