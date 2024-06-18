import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:repeat_exam/screen/edit/controller/edit_controller.dart';
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
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ([...Colors.primaries]..shuffle()).first,
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
                          SizedBox(height: 5,),
                          Text(
                            "Description : ${controller.editList[index].description}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "category: ${controller.editList[index].category}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 5,),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              onPressed: () {
                                DBHelper helper = DBHelper();
                                helper.deleteDB(
                                    id: "${controller.editList[index].id}");
                                controller.getData();
                              },
                              icon: const Icon(Icons.delete_outline),
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
                    crossAxisCount: 2, mainAxisExtent: 180),
                itemCount: controller.editList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    height: MediaQuery.sizeOf(context).height * 0.18,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ([...Colors.primaries]..shuffle()).first,
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
                          SizedBox(height: 5,),
                          Text(
                            "Description : ${controller.editList[index].description}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "category: ${controller.editList[index].category}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 5,),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              onPressed: () {
                                DBHelper helper = DBHelper();
                                helper.deleteDB(
                                    id: "${controller.editList[index].id}");
                                controller.getData();
                              },
                              icon: const Icon(Icons.delete_outline),
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
            Get.toNamed('edit');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
