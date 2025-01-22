
import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo_item.freezed.dart';
part 'todo_item.g.dart';

// `ToDoItem`の状態を`bool`型に変更
@freezed
class ToDoItem with _$ToDoItem {
  const factory ToDoItem({
    required int id,
    required String title,
    required String description,
    required bool status, // `status`を`bool`型に変更
  }) = _ToDoItem;

  // JSONからToDoItemを生成するファクトリーメソッド
  factory ToDoItem.fromJson(Map<String, dynamic> json) => _$ToDoItemFromJson(json);
}






