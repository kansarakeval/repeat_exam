import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("To-Do"),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.list))],
        ),
        body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {},
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            Get.toNamed("edit");
          },
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
