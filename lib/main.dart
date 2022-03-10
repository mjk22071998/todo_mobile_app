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
        appBar: AppBar(
          title: const Text("Todo List"),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(color: Colors.indigoAccent),
                child: Row(
                  children: [
                    const Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black,
                          labelText: "Enter To Do Task title"),
                    )),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text("Add Task"),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder()
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
