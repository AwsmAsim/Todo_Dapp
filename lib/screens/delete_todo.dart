import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_blockchain/linking/contract_linking.dart';

class DeleteTodo extends StatefulWidget {
  const DeleteTodo({Key? key}) : super(key: key);

  @override
  State<DeleteTodo> createState() => _MarkDoneState();
}

class _MarkDoneState extends State<DeleteTodo> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController contentController = TextEditingController();
    var contractLinking = Provider.of<ContractLinking>(context);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Delete Todo"),
          backgroundColor: Colors.teal.shade700,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 100),
                Center(
                  child: SizedBox(
                    width: size.width - 100,
                    child: TextField(
                      controller: contentController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Task Id",
                          labelText: "Delete"),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Container(
                    height: 40,
                    width: 200,
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
                        // print(contentController.text);
                        setState(() {
                          isLoading = true;
                        });
                        String transactionHash = "";

                        contractLinking
                            .deleteTodo(int.parse(contentController.text))
                            .then(
                          (value) {
                            setState(() {
                              isLoading = false;
                            });
                            transactionHash = value;
                            // Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(transactionHash.isNotEmpty
                                    ? "Deleted"
                                    : "Error"),
                                content: Text(transactionHash.isNotEmpty
                                    ? "Transaction Hash: $transactionHash"
                                    : "Some error occurred in accessing blockchain"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      contentController.clear();
                                      int count = 0;
                                      Navigator.of(context)
                                          .popUntil((_) => count++ >= 2);
                                    },
                                    child: const Text("Ok"),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:
                          const Text("Delete", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                )
              ],
            ),
            loadingOverlay(loading: isLoading)
          ],
        ),
      ),
    );
  }
}

Widget loadingOverlay({required bool loading}) {
  return loading
      ? BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
          child: const Center(
              child: SizedBox(
            height: 150,
            width: 150,
            child: CircularProgressIndicator(backgroundColor: Colors.grey),
          )),
        )
      : const SizedBox(height: 0, width: 0);
}
