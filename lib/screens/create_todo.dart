import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_blockchain/linking/contract_linking.dart';

class CreateTodo extends StatelessWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contractLinking = Provider.of<ContractLinking>(context);
    TextEditingController contentController = TextEditingController();

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Create Todo"),
            backgroundColor: Colors.teal.shade700,
          ),
          body: Column(
            children: [
              const SizedBox(height: 100),
              Center(
                child: SizedBox(
                  width: size.width - 100,
                  child: TextField(
                    controller: contentController,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter your task here",
                        labelText: "Add Todo"),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(colors: [
                        Colors.blueAccent,
                        Colors.blue.shade200,
                        Colors.lightBlue.shade100
                      ]),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 30)
                      ]),
                  child: MaterialButton(
                    onPressed: () {
                      contractLinking.addTask(contentController.text);
                      contentController.clear();
                      Navigator.pop(context);
                    },
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text("Add", style: TextStyle(fontSize: 20)),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
