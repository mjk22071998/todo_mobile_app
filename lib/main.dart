import 'package:flutter/material.dart';
import 'package:todo_mobile_app/database/db_helper.dart';

import 'models/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To Do app',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  getTasks() async {
    return DBHelper.dbHelper.getAllTasks();
  }

  TextEditingController taskController = TextEditingController();
  String taskText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo.shade900,
        title: const Text("Todo List"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getTasks(),
              builder: (context, taskSnapshot) {
                switch (taskSnapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(
                      child: Text(
                        "You have'nt created any Task yet, Please create one",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.active:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        Text(
                          "Loading data",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    );
                  case ConnectionState.done:
                    {
                      if (taskSnapshot.data == null) {
                        return const Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "You have'nt created any Task yet, Please create one",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else {
                        List<Map<String, dynamic>> maps =
                            taskSnapshot.data as List<Map<String, dynamic>>;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: maps.length,
                            itemBuilder: (context, index) {
                              TodoTask todoTask = TodoTask.fromMap(maps[index]);
                              return Card(
                                elevation: 5,
                                color: Colors.white,
                                margin: const EdgeInsets.all(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        todoTask.task,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "created on ${todoTask.dateTime.day}-${todoTask.dateTime.month}-${todoTask.dateTime.year}",
                                        textAlign: TextAlign.right,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: TextField(
                  controller: taskController,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: InputBorder.none,
                      labelText: "Enter To Do Task title"),
                )),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        taskText = taskController.text;
                        taskController.text = "";
                      });
                      TodoTask newTask =
                          TodoTask(task: taskText, dateTime: DateTime.now());
                      DBHelper.dbHelper.addTask(newTask);
                    },
                    icon: const Icon(Icons.add),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 18.0),
                      child: Text("Add Task"),
                    ),
                    style:
                        ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
