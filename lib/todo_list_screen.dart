import 'package:flutter/material.dart';
import 'package:todo_list/todo.dart';

import 'package:todo_list/new_todo_dialog.dart';
import 'package:todo_list/todo_list.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];
  bool _addButtonEnable = false;

  _toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }

  _addTodo() async {
    final todo = await showDialog<Todo>(
      context: context,
      builder: (BuildContext context) {
        return NewTodoDialog();
      },
    );

    if (todo != null) {
      setState(() {
        todos.add(todo);
      });
    }
  }

  _addStringTodo(String str) {
    setState(() {
      if (str != null && str.isNotEmpty) {
        todos.add(Todo(title: str));
        newTodoController.clear();
      }
    });
  }

  TextEditingController newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Todo List',
        style: TextStyle(color: Colors.black),
      )),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            padding: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 5.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.add),
                Flexible(
                  child: TextField(
                    controller: newTodoController,
                    decoration: InputDecoration(
//                      border: OutlineInputBorder(
//                        borderSide:
//                            BorderSide(width: 1, style: BorderStyle.none),
//                        gapPadding: 10.0,
//                      ),
                      border: UnderlineInputBorder(),
//                 icon: Icon(Icons.add_box),
//              labelText: '请输入',
                      contentPadding: EdgeInsets.all(10),
                      hintText: '输入代办事项',
                    ),

                    // showCursor: true,
                    onSubmitted: _addStringTodo,
                    onChanged: _addTodoChanged,
                    onTap: _addTodoTap,
                  ),
                ),
                Container(
                  margin: new EdgeInsets.symmetric(horizontal: 4.0),
                  child: new IconButton(
                    icon: Icon(
                      Icons.send,
                      color: _addButtonEnable ? Colors.black : Colors.grey,
                      // TODO 如何根据输入切换ICONButton可用性
                    ),
                    onPressed: _addStringTodo(newTodoController.text),
                    tooltip: '点击添加',
                  ),
                ),
//                Container(
//                  child: Icon(
//                    Icons.send,
//                    color: _addButtonEnable ? Colors.black : Colors.grey,
//                  ),
//                )
              ],
            ),
            decoration: BoxDecoration(
//              color: Colors.grey,
              border: new Border.all(color: Colors.amber, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(6.0)),

//              // 边色与边宽度
//              borderRadius: new BorderRadius.vertical(
//                top: Radius.elliptical(20, 20),
//                bottom: Radius.elliptical(20, 20),
//              ), // 也可控件一边圆角大小
            ),
          ),
          Expanded(
            child: TodoList(
              todos: todos,
              onTodoToggle: _toggleTodo,
            ),
          )
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add),
//        onPressed: _addTodo,
//      ),
    );
  }

  void _addTodoChanged(String value) {
    print(newTodoController.text);
    print("value: " + newTodoController.text);

    _addButtonEnable = value != null && value.isNotEmpty;
  }

  void _addTodoTap() {
    print(newTodoController.text);
    String value = newTodoController.text;
    _addButtonEnable = value != null && value.isNotEmpty;
  }
}
