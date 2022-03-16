import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: const Text("Todo List"),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: Color.fromARGB(255, 192, 201, 255),borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      labelText: "Enter To Do Task title"),
                )),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.0),
                    child: Text("Add Task"),
                  ),
                  style:
                      ElevatedButton.styleFrom(shape: const StadiumBorder()),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
