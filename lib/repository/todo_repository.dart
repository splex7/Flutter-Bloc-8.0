import 'package:todolist/model/todo.dart';

/// Get Todos
/// Delete Todos
/// Create Todos

class TodoRepository {
  Future<List<Map<String, dynamic>>> getTodos() async {
    // add await 1 sec
    await Future.delayed(const Duration(seconds: 1));
    return [
      {
        'id': 1,
        'title': 'Todo 1',
        'completed': false,
        'createdAt': '2021-01-01 00:00:00',
      },
      {
        'id': 2,
        'title': 'Todo 2',
        'completed': false,
        'createdAt': '2021-01-01 00:00:00',
      },
      {
        'id': 3,
        'title': 'Todo 3',
        'completed': false,
        'createdAt': '2021-01-01 00:00:00',
      },
      {
        'id': 4,
        'title': 'Todo 4',
        'completed': false,
        'createdAt': '2021-01-01 00:00:00',
      },
      {
        'id': 5,
        'title': 'Todo 5',
        'completed': false,
        'createdAt': '2021-01-01 00:00:00',
      },
    ];
  }

  Future<Map<String, dynamic>> createTodo(Todo todo) async {
    await Future.delayed(const Duration(seconds: 1));

    return todo.toJson();
  }

  Future<Map<String, dynamic>> deleteTodo(Todo todo) async {
    await Future.delayed(const Duration(seconds: 1));

    return todo.toJson();
  }
}
