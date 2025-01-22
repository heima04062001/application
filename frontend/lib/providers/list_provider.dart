import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo_item.dart';
part 'list_provider.g.dart';

// Dioのインスタンスを作成するヘルパー関数
Dio createDio() {
  return Dio(BaseOptions(
    baseUrl: 'http://localhost:3000/', // APIのベースURL
    connectTimeout: Duration(milliseconds: 5000), // 接続タイムアウト
    receiveTimeout: Duration(milliseconds: 3000), // レスポンスタイムアウト
  ));
}

// fetchItems用のプロバイダ
@riverpod
Future<List<ToDoItem>> fetchItems(ref) async {
  Dio dio = createDio();

  try {
    final response = await dio.get('/items'); // Todoリストを取得するAPIエンドポイント
    if (response.statusCode == 200) {
      final result = response.data as List<dynamic>;
      return result.map((e) => ToDoItem.fromJson(e)).toList(); // Todoアイテムのリストを作成
    } else {
      throw Exception('Failed to fetch items');
    }
  } catch (e) {
    throw Exception('Failed to fetch items: $e');
  }
}

// addItem用のプロバイダ
@riverpod
Future<void> addItem(ref, ToDoItem item) async {
  Dio dio = createDio();

  try {
    final response = await dio.post('/items', data: item.toJson()); // Todo追加API
    if (response.statusCode == 200) {
          ref.refresh(fetchItemsProvider);
    } else {
      throw Exception('Failed to add todo');
    }
  } catch (e) {
    throw Exception('Failed to add todo: $e');
  }
}

// modifyItem用のプロバイダ
@riverpod
Future<void> modifyItem(ref, ToDoItem updatedItem) async {
  Dio dio = createDio();

  try {
    final response = await dio.put('/items/${updatedItem.id}', data: updatedItem.toJson()); // Todo更新API
    if (response.statusCode == 200) { // 更新されたアイテム
      ref.refresh(fetchItemsProvider);
    } else {
      throw Exception('Failed to update todo');
    }
  } catch (e) {
    throw Exception('Failed to update todo: $e');
  }
}

// deleteItem用のプロバイダ
@riverpod
Future<void> deleteItem(ref, ToDoItem item) async {
  Dio dio = createDio();

  try {
    final response = await dio.delete('/items/${item.id}'); // Todo削除API
    if (response.statusCode == 200) {
      ref.refresh(fetchItemsProvider);
      // 削除後にリストをリフレッシュ
    } else {
      throw Exception('Failed to delete todo');
    }
  } catch (e) {
    throw Exception('Failed to delete todo: $e');
  }
}







