import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_blockchain/linking/contract_linking.dart';

import './screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContractLinking()),
      ],
      child: MaterialApp(
        title: "TodoList",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("TodoList"),
            backgroundColor: Colors.teal.shade700,
          ),
          body: HomePage(),
        ),
      ),
    );
  }
}
