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

  bool _checkCompleted(String value) {
    return _todoListCompleted.contains(value);
  }

  void addTodo(String todoDescription) {
    setState(() {
      _todoList.add(todoDescription);
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
              body: Column(
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
                          child: const Text('Submit'),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(color: Colors.deepPurple),
                          itemCount: _todoList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_todoList[index]),
                            );
                          })),
                ],
              ));
        }));
  }
}
