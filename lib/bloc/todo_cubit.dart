import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/todo_state.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/repository/todo_repository.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository repository;

  TodoCubit({
    required this.repository,
  }) : super(Empty());

  // getTodos
  Future<void> getTodos() async {
    try {
      emit(Loading());
      final todos = await repository.getTodos();
      emit(Loaded(todos: todos.map<Todo>((e) => Todo.fromJson(e)).toList()));
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  // createTodo
  Future<void> createTodo({required String title}) async {
    try {
      if (state is Loaded) {
        final parsedState = state as Loaded;

        final newTodo = Todo(
          id: parsedState.todos.length + 1,
          title: title,
          completed: false,
          createdAt: DateTime.now().toString(),
        );

        //optimistic update
        emit(Loaded(todos: [...parsedState.todos, newTodo]));

        // 서버에 요청
        final resp = await repository.createTodo(newTodo);

        //update with resp
        emit(Loaded(todos: [...parsedState.todos, Todo.fromJson(resp)]));
      }
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  // deleteTodo
  Future<void> deleteTodo(Todo todo) async {
    try {
      if (state is Loaded) {
        final parsedState = state as Loaded;

        //optimistic update
        final newTodos = parsedState.todos.where((t) => t.id != todo.id).toList();
        emit(Loaded(todos: newTodos));

        // 서버에 요청
        await repository.deleteTodo(todo);
      }
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }
}
