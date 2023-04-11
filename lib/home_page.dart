import 'package:flutter/material.dart';
import 'package:flutter_todo_list/controllers/home_controller.dart';
import 'package:flutter_todo_list/login_page.dart';
import 'package:flutter_todo_list/widgets/grid_container.dart';
import 'package:flutter_todo_list/widgets/search_box.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final toDoController = Get.put(HomeController());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xffEEEEEE),
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: const Color((0xff6D67E4)),
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const MyLoginPage()));
            },
            icon: const Icon(Icons.keyboard_double_arrow_left_rounded),
            iconSize: 30,
          ),
          title: const Text(
            "All Tasks",
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                color: const Color(0xffEEEEEE),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        onChanged: (p0) {
                          toDoController.searchText.value = p0;
                        },
                      ),
                    ),
                    Obx(
                      () => Transform.scale(
                        scale: 2.2,
                        child: Checkbox(
                          activeColor: const Color(0xff6D67E4),
                          checkColor: Colors.white,
                          value: toDoController.showOnlyNotDone.value,
                          side: const BorderSide(width: 2, color: Color(0xFF6D67E4)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onChanged: (val) => toDoController.showOnlyNotDone.value = val ?? false,
                        ),
                      ),
                    ),
                    /* Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => const DoneTasks()));
                          // Get.dialog(
                          //   AlertDialog(
                          //     titlePadding: EdgeInsets.zero,
                          //     contentPadding: EdgeInsets.zero,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(32),
                          //     ),
                          //     actionsAlignment: MainAxisAlignment.center,
                          //     backgroundColor: const Color(0xff6D67E4),
                          //     title: Container(
                          //       padding: const EdgeInsets.all(24),
                          //       color: const Color(0xff6D67E4),
                          //       child: const Text(
                          //         "Completed Tasks",
                          //         style:
                          //             TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                          //         textAlign: TextAlign.center,
                          //       ),
                          //     ),
                          //     content: Obx(
                          //       () => SingleChildScrollView(
                          //         child: Column(
                          //           children: [
                          //             ...toDoController.toDoList
                          //                 .where((p1) => p1.isDone)
                          //                 .map((e) => Padding(
                          //                   padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
                          //                   child: GridContainerWidget(todo: e),
                          //                 ))
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          alignment: Alignment.center,
                          backgroundColor: const Color(0xff6D67E4),
                        ),
                        child: const Icon(Icons.check, size: 30),
                      ),
                    ),*/
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => Expanded(
                  child: toDoController.toDoList
                          .where((p0) => p0.description.contains(toDoController.searchText.value))
                          .isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: Column(
                            children: [
                              Flexible(
                                  child:
                                      Lottie.asset("assets/lotties/new.json", fit: BoxFit.cover)),
                              const Text(
                                "You Dont Have Any Mission",
                                style: TextStyle(
                                    color: Color(0xFF83BFEB),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        )
                      : ListView(
                          padding: const EdgeInsets.all(16),
                          physics:
                              const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          children: [
                            Obx(
                              () => Column(
                                  children: toDoController.toDoList
                                      .where((p0) =>
                                          p0.description
                                              .contains(toDoController.searchText.value) &&
                                          (!toDoController.showOnlyNotDone.value || !p0.isDone))
                                      .map(
                                        (todo) => Padding(
                                          padding: const EdgeInsets.only(bottom: 16.0),
                                          child: GridContainerWidget(
                                              todo: todo,
                                              checkTap: () {
                                                todo.isDone = !todo.isDone;
                                                toDoController.box.put(todo.id, todo.toJson());
                                                toDoController.toDoList.refresh();
                                              },
                                              deleteTap: () => toDoController.deleteTodo(todo.id),
                                              onSave: () {
                                                toDoController.toDoList.add(todo);
                                              }),
                                        ),
                                      )
                                      .toList()),
                            ),
                          ],
                        ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  color: const Color(0xffEEEEEE),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: toDoController.description,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Color(0xff6D67E4)), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Color(0xff6D67E4)), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: "Add your new task",
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                        child: ElevatedButton(
                          onPressed: toDoController.addTask,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff6D67E4), elevation: 5),
                          child: const Text(
                            "+",
                            style: TextStyle(
                                color: Colors.white, fontSize: 40, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
