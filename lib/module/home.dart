import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/todo_bloc.dart';
import 'package:todolist/bloc/todo_cubit.dart';
import 'package:todolist/bloc/todo_event.dart';
import 'package:todolist/bloc/todo_state.dart';
import 'package:todolist/repository/todo_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //use TodoBloc
    // return BlocProvider(create: (context) => TodoBloc(repository: TodoRepository()), child: HomeWidget());
    //use TodoCubit
    return BlocProvider(create: (context) => TodoCubit(repository: TodoRepository()), child: HomeWidget());
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String title = '';

  @override
  void initState() {
    super.initState();
    //use TodoBloc
    // BlocProvider.of<TodoBloc>(context).add(GetTodosEvent());
    //use TodoCubit
    context.read<TodoCubit>().getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        // add new floating action button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<TodoCubit>().createTodo(title: title);
            // empty text field
            setState(() {
              title = '';
            });
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  title = value;
                },
                // empty text field when floating action button is pressed
                controller: TextEditingController(text: title),
              ),
              Expanded(
                // child: BlocBuilder<TodoBloc, TodoState>(builder: (_, state) {
                child: BlocBuilder<TodoCubit, TodoState>(builder: (_, state) {
                  if (state is Empty) {
                    return const Text("Empty");
                  } else if (state is Loading) {
                    return const Center(
                        child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator(strokeWidth: 5)));
                  } else if (state is Error) {
                    return const Placeholder();
                  } else if (state is Loaded) {
                    final items = state.todos;

                    return ListView.separated(
                        itemBuilder: (_, index) {
                          final item = items[index];
                          return ListTile(
                            title: Text(item.title),
                            trailing: Checkbox(
                              value: item.completed,
                              onChanged: (value) {
                                //use TodoBloc
                                // BlocProvider.of<TodoBloc>(context).add(DeleteTodoEvent(todo: item));
                                //use TodoCubit
                                context.read<TodoCubit>().deleteTodo(item);
                              },
                            ),
                          );
                        },
                        separatorBuilder: (_, index) => const Divider(),
                        itemCount: items.length);
                  }
                  return const Text("state is not defined");
                }),
              ),
            ],
          ),
        ));
  }
}
