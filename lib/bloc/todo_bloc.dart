import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/todo_event.dart';
import 'package:todolist/bloc/todo_state.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/repository/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc({
    required this.repository,
  }) : super(Empty()) {
    on<GetTodosEvent>(_onGeTodos);
    on<CreateTodoEvent>(_onCreateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  // _onGeTodos
  void _onGeTodos(GetTodosEvent event, Emitter<TodoState> emit) async {
    try {
      emit(Loading());
      final todos = await repository.getTodos();
      emit(Loaded(todos: todos.map<Todo>((e) => Todo.fromJson(e)).toList()));
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  _onCreateTodo(CreateTodoEvent event, Emitter<TodoState> emit) async {
    try {
      if (state is Loaded) {
        final parsedState = state as Loaded;

        final newTodo = Todo(
          id: parsedState.todos.length + 1,
          title: event.title,
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

  _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    try {
      if (state is Loaded) {
        final parsedState = state as Loaded;

        //optimistic update
        final newTodos = parsedState.todos.where((todo) => todo.id != event.todo.id).toList();
        emit(Loaded(todos: newTodos));

        // 서버에 요청
        await repository.deleteTodo(event.todo);
      }
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }
}
