import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';


@freezed
abstract class Todo with _$Todo {
  const Todo._();

  const factory Todo({
    required int id,
    required String title,
    required bool completed,
    required String createdAt,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
