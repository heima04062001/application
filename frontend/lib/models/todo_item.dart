import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo_item.freezed.dart';
part 'todo_item.g.dart';

@freezed
class ToDoItem with _$ToDoItem {
  const factory ToDoItem({
    required int id,
    required String title,
    required String description,
    required String status,
  }) = _ToDoItem;

  // JSONからToDoItemを生成するファクトリーメソッド
  factory ToDoItem.fromJson(Map<String, dynamic> json) => _$ToDoItemFromJson(json);
}

