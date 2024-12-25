import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'list_provider.g.dart';

@riverpod
class ListNotifier extends _$ListNotifier {
  late Dio dio;

  // Dioインスタンスの初期化
  void _initializeDio() {
    print("============init");
    dio = Dio(BaseOptions(
       baseUrl: 'http://localhost:3000/',// APIのベースURL
      connectTimeout: Duration(milliseconds: 5000), // タイムアウト設定
      receiveTimeout: Duration(milliseconds: 3000), // タイムアウト設定
    ));
  }

  // buildメソッドで初期値を返す（非同期でデータ取得する）
  @override
  Future<List<ToDoItem>> build() async{
    final items = await fetchItems();
    return items;
  }
  
 

  // アイテム一覧を取得するメソッド
  Future<List<ToDoItem>> fetchItems() async {
  try {
    _initializeDio();  // Dio を初期化
    print('===second===');
    
    final response = await dio.get('/items'); // Todo リストを取得する API エンドポイント
    print('===${response.data}==');
    
    if (response.statusCode == 200) {
    final result = response.data as List<dynamic>;
    final items =result.map((e) => ToDoItem.fromJson(e)).toList();
      return items;
    } else {
      print('エラー: ステータスコードが200ではありません'); // ステータスコードが200でない場合
      throw Exception('Failed to fetch items. Status code: ${response.statusCode}');
    }
    
  } catch (e) {
    // エラーが発生した場合
    print('エラーが発生しました: $e');
    throw Exception('Failed to fetch items: $e');
  }
}



Future<ToDoItem> addItem(ToDoItem item) async {
  _initializeDio();  // Dioを初期化
  try {
    final response = await dio.post('/items', data: item.toJson()); // Todoを追加するAPIエンドポイント
    print(response);
    if (response.statusCode==200) {
      // 新しいアイテムを作成
      final newItem = ToDoItem.fromJson(response.data);
      
      // アイテム追加後にリストを更新する処理
      state = state.when(
        data: (items) {
          // 新しいアイテムをリストの先頭に追加（または末尾など適宜）
          final updatedItems = [...items, newItem]; // 新しいアイテムを追加した新しいリスト
          return AsyncValue.data(updatedItems); // 更新されたリストを返す
        },
        loading: () => AsyncValue.loading(),
        error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
      );
      
      // 新しく追加したアイテムを返す
      return newItem; 
    } else {
      throw Exception('Failed to add todo');
    }
  } catch (e) {
    throw Exception('Failed to add todo: $e');
  }
}

 

Future<ToDoItem> modifyItem(int id, ToDoItem updatedItem) async {
  _initializeDio();  // Dio を初期化
  try {
    final response = await dio.put('/items/$id', data: updatedItem.toJson());
    if (response.statusCode==200) {
      // アイテムが正常に更新された場合、新しいアイテムを返す

      // 更新後のアイテムをリスト内で置き換える処理
      state = state.when(
        data: (items) {
          // アイテムのIDが一致する場合にそのアイテムを置き換え
          final updatedItems = items.map((item) {
            if (item.id == id) {
              return updatedItem; // 更新されたアイテムに置き換える
            }
            return item; // 一致しない場合はそのまま
          }).toList();

          return AsyncValue.data(updatedItems); // 更新したリストを返す
        },
        loading: () => AsyncValue.loading(),
        error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
      );

      return updatedItem;  // 更新後のアイテムを返す
    } else {
      throw Exception('Failed to update todo');
    }
  } catch (e) {
    throw Exception('Failed to update todo: $e');
  }
}

Future<void> deleteItem(ToDoItem item) async {
  _initializeDio();  // Dio を初期化
  try {
    final response = await dio.delete('/items/${item.id}'); // Todo を削除する API エンドポイント
    if (response.statusCode==200) {
      // 削除が成功した場合、新しく更新されたアイテムリストを返す

      // state の更新処理
      state = state.when(
        data: (items) {
          // 削除されたアイテムをリストから除外
          final updatedItems = items.where((existingItem) => existingItem.id != item.id).toList();
          return AsyncValue.data(updatedItems); // 更新されたリストを返す
        },
        loading: () => AsyncValue.loading(),
        error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
      );
    } else {
      throw Exception('Failed to delete todo');
    }
  } catch (e) {
    throw Exception('Failed to delete todo: $e');
  }
}



  // アイテムを削除する
List<ToDoItem> getItems() {
    return (state.asData?.value ?? <ToDoItem>[]) as List<ToDoItem>;// 現在のアイテムリストを返す
  }
}



