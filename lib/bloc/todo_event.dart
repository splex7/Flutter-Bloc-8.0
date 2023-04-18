import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todolist/model/todo.dart';

/// Get TodosEvent
/// Delete TodoEvent
/// Create TodoEvent

@immutable
abstract class TodoEvent extends Equatable {}

// PageNation 이 필요하면 여기를 수정합니다. (ex. page, limit)
class GetTodosEvent extends TodoEvent {
  @override
  List<Object> get props => [];
}

class CreateTodoEvent extends TodoEvent {
  final String title; 

  CreateTodoEvent({required this.title});

  @override
  List<Object> get props => [title];
}

class DeleteTodoEvent extends TodoEvent {
  final Todo todo; 

  DeleteTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}
