import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DemoListViewPage extends StatefulWidget {
  const DemoListViewPage({super.key});

  @override
  State<DemoListViewPage> createState() => _DemoListViewPageState();
}

class _DemoListViewPageState extends State<DemoListViewPage> {
  bool _shouldShowForm = true;
  List<Todo> listTodo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo List View Page"),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          constraints: BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              displayForm(_shouldShowForm),
              SizedBox(height: 10),
              Expanded(child: displayListTodo(listTodo))
            ],
          )
      ),
    );
  }

  Widget displayForm(bool shouldShowForm) {
    if (shouldShowForm) {
      return makeFormInput(shouldShowForm);
    } else {
      return makeButtonOpenForm(shouldShowForm);
    }
  }

  Widget makeFormInput(bool shouldShowForm) {
    final titleController = TextEditingController();
    final subTitleController = TextEditingController();

    return Container(
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Title",
            ),
            textInputAction: TextInputAction.next,
            maxLines: 1,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          TextField(
            controller: subTitleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Description",
            ),
            textInputAction: TextInputAction.done,
            maxLines: 1,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          Row(
            children: [
              Expanded(child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green),
                ),
                onPressed: () {
                  addNewTodo(titleController.text, subTitleController.text, listTodo);
                },
                child: Text("Add todo", style: TextStyle(color: Colors.white)),
              )),
              SizedBox(width: 20),
              Expanded(child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () {
                  setState(() {
                    setShouldShowForm(!shouldShowForm);
                  });
                },
                child: Text("Cancel", style: TextStyle(color: Colors.white)),
              )),
            ],
          )
        ],
      ),
    );
  }

  Widget makeButtonOpenForm(bool shouldShowForm) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
      ),
      onPressed: () {
        setState(() {
          setShouldShowForm(!shouldShowForm);
        });
      },
      child: Text("+", style: TextStyle(color: Colors.white)),
    );
  }

  Widget displayListTodo(List<Todo> listTodo) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return makeTodoItem(index, listTodo.reversed.toList()[index], listTodo);
      },
      itemCount: listTodo.length,
    );
  }

  Widget makeTodoItem(int index, Todo todo, List<Todo> listTodo) {
    return Card(
      child: ListTile(
        onLongPress: openUpdateDialog,
        title: Text(todo.title),
        subtitle: Text(todo.subTitle),
        trailing: InkWell(
            onTap: () {
              deleteTodo(todo, listTodo);
            },
            child: Icon(Icons.delete, color: Colors.red)
        ),
      ),
    );
  }

  void setShouldShowForm(bool shouldShowForm) {
    _shouldShowForm = shouldShowForm;
  }

  void addNewTodo(String title, String subTitle, List<Todo> listTodo) {
    setState(() {
      setShouldShowForm(false);
      if (title.isEmpty || subTitle.isEmpty) return;
      listTodo.add(Todo(title, subTitle));
    });
  }

  void deleteTodo(Todo todo, List<Todo> listTodo) {
    var index = listTodo.indexOf(todo);
    if (index < 0) return;
    setState(() {
      listTodo.remove(todo);
    });
  }

  void openUpdateDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog();
          },
      );
  }
}

class Todo {
  String title;
  String subTitle;
  Todo(this.title, this.subTitle);
}