// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract TodoList {
  uint public taskCount;
  constructor() public {
    taskCount = 0;
  }

  struct Task {
    uint id;
    string content;
    bool completed;
  }
  Task[] private todos;

  function getTaskCount() public view returns(uint) {
    return taskCount;
  }
  function addTask(string memory _content) public {
    ++taskCount;
    Task memory task = Task(taskCount, _content, false);
    todos.push(task);
  }

  function markDone(uint _id) public {
    require(_id <= taskCount);
    todos[_id - 1].completed = true;
  }

  function getTask(uint _id) public view returns(Task memory) {
    return todos[_id - 1];
  }

}
