import 'package:flutter/material.dart';
import 'package:new_project/Todo.dart';
class TodoOutput extends StatefulWidget {
  @override
  _TodoOutputState createState() => _TodoOutputState();
}

class _TodoOutputState extends State<TodoOutput> {
   List<Todo> todos = [];

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text('Todo List')),
      body: TodoList(
        todos: todos,
        onTodoToggle: _toggleTodo,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
      );
  }
}


class NewTodoDialog extends StatefulWidget {
  @override
  _NewTodoDialogState createState() => _NewTodoDialogState();
}

class _NewTodoDialogState extends State<NewTodoDialog> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New todo'),
      content: TextField(
        controller: controller,
        autofocus: true,
      ),
      actions: <Widget>[
        MaterialButton(
          child: Text('Cancel',style: TextStyle(color: Colors.blue),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          child: Text('Add',style: TextStyle(color: Colors.blue),),
          onPressed: () {
            final todo = new Todo(title: controller.value.text);
            // get values from textfield
            // debugPrint(controller.value.text);
            controller.clear();
            Navigator.of(context).pop(todo);
           
          },
        ),
      ],
    );
  }
}

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
      onChanged: (bool isChecked) {
        onTodoToggle(todo, isChecked);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildItem,
      itemCount: todos.length,
    );
  }
}
