import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://127.0.0.1:8545";
  final String _wsUrl = "ws://127.0.0.1:8545/";
  final String _privateKey =
      "0xd44fe1c876bbb6630e2a384d8eeb71d323fcc6f9fb07952d1e755d06a11c2240";

  late Web3Client _client;
  List<Task> todos = [];
  bool isLoading = true;
  late String _abiCode;

  late EthereumAddress _contractAddress;
  late Credentials _credentials;
  late DeployedContract _contract;
  late ContractFunction _addTask;
  late ContractFunction _markDone;
  late ContractFunction _getTask;
  late ContractFunction _getTaskCount;

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    _client = Web3Client(_rpcUrl, http.Client());

    await getAbi();
    await getCredentials();
    await getDeployedContracts();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/artifacts/TodoList.json");

    var jsonAbi = jsonDecode(abiStringFile) as Map<String, dynamic>;
    _abiCode = jsonEncode(jsonAbi['abi']);
    // _contractAddress = EthereumAddress.fromHex(
    //     jsonAbi['networks']['1660235388841']['address'] as String);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
    // _contractAddress = await _credentials.extractAddress();
    _contractAddress =
        EthereumAddress.fromHex("0xf726f1fce634059306b1181f94e2920b671bad96");
  }

  Future<void> getDeployedContracts() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, 'TodoList'), _contractAddress);

    _getTaskCount = _contract.function('taskCount');
    _addTask = _contract.function('addTask');
    _markDone = _contract.function('markDone');
    _getTask = _contract.function('getTask');
    getTodos();
  }

  getTodos() async {
    print(_contract.address);
    print(_getTaskCount.name);

    List<dynamic> taskList = await _client.call(
        sender: _contractAddress,
        contract: _contract,
        function: _getTaskCount,
        params: <dynamic>[]);
    print("Done");
    print(taskList);
    int taskCount = taskList[0].toInt();
    taskList.clear();
    print(taskCount);
    for (int i = 1; i <= taskCount; i++) {
      var eachTask = await _client.call(
          contract: _contract, function: _getTask, params: [BigInt.from(i)]);
      todos.add(Task(
          id: eachTask[0][0].toInt(),
          content: eachTask[0][1].toString(),
          completed: eachTask[0][2]));
    }
    isLoading = false;
    notifyListeners();
  }

  addTask(String content) async {
    isLoading = true;
    notifyListeners();
    try {
      await _client.sendTransaction(
          _credentials,
          Transaction.callContract(
              contract: _contract,
              function: _addTask,
              parameters: [content],
              maxGas: 1000000));
    } catch (e) {
      print("error $e");
    }
    getTodos();
  }

  markDone(int id) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract, function: _markDone, parameters: [id]));
  }
}

class Task {
  int id;
  String content;
  bool completed;

  Task({required this.id, required this.content, required this.completed});
}
