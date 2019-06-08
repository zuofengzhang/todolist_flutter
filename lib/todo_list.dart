import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

import 'package:todo_list/todo.dart';

typedef ToggleTodoCallback = void Function(Todo, bool);

class TodoList extends StatelessWidget {
  TodoList({@required this.todos, this.onTodoToggle});

  final List<Todo> todos;
  final ToggleTodoCallback onTodoToggle;

  Widget _buildItem(BuildContext context, int index) {
    final todo = todos[index];

    return CheckboxListTile(
      value: todo.isDone,
      title: Text(todo.title),
//      isThreeLine: true,
      selected: !todo.isDone,
      onChanged: (bool isChecked) {
        onTodoToggle(todo, isChecked);
      },
    );
  }

  void _textFieldChanged(String str) {
    print(str);
    if (str != null) {
      todos.add(Todo(title: str));
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        // Column(
        //     children: <Widget>[
        //       // TextField(
        //       //   keyboardType: TextInputType.number,
        //       //   decoration: InputDecoration(
        //       //     contentPadding: EdgeInsets.all(10.0),
        //       //     icon: Icon(Icons.text_fields),
        //       //     labelText: '请输入你的姓名)',
        //       //     helperText: '请输入你的真实姓名',
        //       //   ),
        //       //   // onChanged: _textFieldChanged,
        //       //   autofocus: false,
        //       // ),
        //       ListView.builder(
        //         itemBuilder: _buildItem,
        //         itemCount: todos.length,
        //       )
        //     ],
        //   )
        // Container(
        // child:
        //     Column(
        //   textDirection: TextDirection.ltr,
        //   children: <Widget>[
        //     TextField(
        //       decoration: InputDecoration(
        //         contentPadding: EdgeInsets.all(5.0),
        //         icon: Icon(Icons.star),
        //         labelText: '请输入你的姓名',
        //         // helperText: '请输入你的真实姓名',
        //       ),
        //       autofocus: true,
        //       onSubmitted: _textFieldChanged,
        //     ),
        //     Expanded(
        //       child: ListView.builder(
        //         itemBuilder: _buildItem,
        //         itemCount: todos.length,
        //       ),
        //     )
        //   ],
        // )
        // )
        ListView.builder(
      itemBuilder: _buildItem,
      itemCount: todos.length,
    );
  }
}
