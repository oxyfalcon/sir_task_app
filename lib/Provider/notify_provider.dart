import 'package:app/screens/todo_list_screen/no_to_list.dart';
import 'package:app/screens/done_list_screen/marked_no_to_do_list.dart';
import 'package:app/screens/done_list_screen/marked_todo_list.dart';
import 'package:app/screens/todo_list_screen/todo_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  String todo;
  String description;
  int id;
  bool completed = false;

  Todo({required this.todo, required this.description, required this.id});
}

final todoProvider = NotifierProvider<TodoList, List<Todo>>(() {
  return TodoList();
});

class TodoList extends Notifier<List<Todo>> {
  @override
  List<Todo> build() {
    return [];
  }

  void addTodo(Todo t) {
    state = [...state, t];
  }

  void deleTodo(Todo t) {
    state = List.from(state.where((element) => (element.id != t.id)));
  }

  void editTodo(Todo edited) {
    state = List.from(state.where((element) {
      if (element.id == edited.id) {
        element = edited;
      }
      return true;
    }));
  }

  void markedAdd(Todo t) {
    state[state.indexOf(t)].completed = true;
    state = List.from(state);
  }

  void markedDelete(Todo t) {
    state[state.indexOf(t)].completed = false;
    state = List.from(state);
  }
}

class PageDecider extends Notifier<Widget> {
  @override
  Widget build() {
    final watchingList = ref.watch(todoProvider);
    if (watchingList.isEmpty) {
      return const NoToDoList();
    } else {
      return const ShowingTodo();
    }
  }
}

final pageDeciderProvider =
    NotifierProvider<PageDecider, Widget>(() => PageDecider());

final idProvider = StateProvider<int>((ref) {
  int id = 0;
  return id;
});

class MarkedPageDecider extends Notifier<Widget> {
  @override
  Widget build() {
    final list = ref.watch(todoProvider);
    bool flag = true;
    for (var itr in list) {
      if (itr.completed == true) {
        flag = false;
        break;
      }
    }
    Widget temp;
    (flag) ? temp = const MarkedNoTodoList() : temp = const MarkedTiles();
    return temp;
  }
}

final markedPageDeciderProvider =
    NotifierProvider<MarkedPageDecider, Widget>(() => MarkedPageDecider());
