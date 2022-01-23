import 'package:flutter/material.dart';
import 'package:todo_list/Controllers/initial_controller.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late InitialController controller;

  @override
  void initState() {
    controller = InitialController();
    controller.listaTasks.addListener(() {
      controller.ordenaListaByCompleted();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: const Color(0xFF7fff00), width: 3)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Minhas Tarefas",
                  style: TextStyle(
                      fontSize: 38,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: controller.taskTitleController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintText: "Nome da Tarefa",
                            fillColor: const Color(0xFF444444),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async =>
                                await controller.createTask(),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFF7fff00)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                            child: const Text(
                              "Adicionar",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: controller.listaTasks.value.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.075,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: const Color(0xFF444444),
                                border: Border(
                                  left: controller
                                          .listaTasks.value[index].completed
                                      ? const BorderSide(
                                          color: Color(0xFF7fff00),
                                          width: 6.0,
                                        )
                                      : const BorderSide(
                                          color: Colors.transparent,
                                          width: 6.0,
                                        ),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 7, right: 7),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            return await controller
                                                .updateTask(index);
                                          },
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Text(
                                                controller.listaTasks
                                                    .value[index].title,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20)),
                                          ),
                                        ),
                                      ),
                                      const Visibility(
                                        visible: false,
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Icon(
                                            Icons.info,
                                            color: Color(0xFF7fff00),
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      GestureDetector(
                                        onTap: () async =>
                                            controller.deleteTask(controller
                                                .listaTasks.value[index].id),
                                        child: const MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Icon(
                                            Icons.close,
                                            color: Color(0xFF7fff00),
                                            size: 24,
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
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
