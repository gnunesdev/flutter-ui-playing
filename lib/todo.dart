import 'package:flutter/material.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  final _todoList = [];
  final _todoListCompleted = [];

  bool checkCompleted(String value) {
    return _todoListCompleted.contains(value);
  }

  handleCheckCompleted(index) {
    final currentItem = _todoList[index];

    if (_todoListCompleted.contains(currentItem)) {
      _todoListCompleted.add(currentItem);
    } else {
      _todoListCompleted.remove(currentItem);
    }
  }

  void addTodo(String todoDescription) {
    setState(() {
      _todoList.add(todoDescription);
      myController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Playing with UI',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Builder(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('ToDo App'),
            ),
            body: Container(
              padding: EdgeInsets.only(left: 24, right: 24, top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: myController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor adicione um todo';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Digite uma task'),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              addTodo(myController.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Adicionado')));
                            }
                          },
                          child: Icon(Icons.add),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 36, bottom: 18),
                      child: Text(
                        "Tarefas a fazer:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      )),
                  Expanded(
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(color: Colors.grey),
                          itemCount: _todoList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: handleCheckCompleted(index),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12, bottom: 12),
                                          child: Text(_todoList[index]))),
                                  Icon(checkCompleted(_todoList[index])
                                      ? Icons.check_box_outline_blank_rounded
                                      : Icons.check_box_outline_blank)
                                ],
                              ),
                            );
                          })),
                ],
              ),
            ),
          );
        }));
  }
}
