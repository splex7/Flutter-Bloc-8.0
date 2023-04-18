import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:todolist/model/todo.dart";

@immutable
abstract class TodoState extends Equatable {}

/// Empty
/// Loading
/// Loaded
/// Error

class Empty extends TodoState {
  @override
  List<Object> get props => [];
}

class Loading extends TodoState {
  @override
  List<Object> get props => [];
}

class Loaded extends TodoState {
  final List<Todo> todos;

  Loaded({required this.todos});

  @override
  List<Object> get props => [todos];
}

class Error extends TodoState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
