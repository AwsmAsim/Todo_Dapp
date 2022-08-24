import 'package:flutter/material.dart';
import 'package:todolist_blockchain/screens/create_todo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _doNothing() {}
  void toCreate(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CreateTodo()));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 100),
          CreateButton(
              text: "Create New Todo",
              onPressed: () {
                toCreate(context);
              }),
          const SizedBox(height: 70),
          CreateButton(text: "View All Todos", onPressed: _doNothing),
          const SizedBox(height: 70),
          CreateButton(text: "Modify Todo", onPressed: _doNothing)
        ],
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  CreateButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  String text;
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          onSurface: Colors.black,
          shadowColor: Colors.teal.shade700,
          backgroundColor: Colors.white70,
          elevation: 6.0,
          shape: const StadiumBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Text(text, style: TextStyle(color: Colors.black, fontSize: 25)),
        ),
      ),
    );
  }
}
