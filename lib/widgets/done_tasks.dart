import 'package:flutter/material.dart';
import 'package:flutter_todo_list/controllers/home_controller.dart';
import 'package:flutter_todo_list/widgets/done_container.dart';
import 'package:get/get.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final toDoController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: const Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: const Color(0xff6D67E4),
        title: const Text("Completed Tasks",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                children: [
                  ...toDoController.toDoList.where((p1) => p1.isDone).map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),
                          child: DoneContainer(
                            todo: e,
                            deleteTap: () {
                              toDoController.toDoList.removeWhere((k) => k.id == e.id);
                            },
                          ),
                        ),
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
