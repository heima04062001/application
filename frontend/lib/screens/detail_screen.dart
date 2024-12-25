import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/list_provider.dart'; // ToDoItem モデルをインポート

class DetailScreen extends ConsumerWidget {
  final int id;

  DetailScreen({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // listProvider から状態データ（StateData）を取得
    final itemsState = ref.watch(listNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('タスク管理アプリ / 詳細'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final items = itemsState.asData?.value;

              // idをintに変換できるか確認し、アイテムを削除
              if (items != null && id != null) {
                  final itemToDeletelist = items.where((item) => item.id == id );
                  final itemToDelete = itemToDeletelist.first;
                
                if (itemToDelete != null) {
                  // アイテムを削除
                  await ref.read(listNotifierProvider.notifier).deleteItem(itemToDelete);

                  // 削除後にホーム画面に遷移
                  context.go('/');
                }
              }
            },
          ),
        ],
      ),
      body: itemsState.when(
        // データが取得できた場合
        data: (items) {
          if (items.isEmpty) {
            // アイテムが見つからなかった場合
            return const Center(
              child: Text('指定されたタスクが見つかりませんでした。'),
            );
          }

          // idをintに変換できるか確認し、アイテムを取得
          final index = id;
          if (index == null || index < 0 ) {
            return const Center(
              child: Text('無効なIDです。タスクが見つかりません。'),
            );
          }

          // アイテムが見つかった場合
          final selectedItemlist = items.where((item) => item.id == index); 
          final selectedItem2 = selectedItemlist.first;// 一致するアイテムが見つからなかった場合は null を返す
          final TextEditingController taskNameController = TextEditingController(text: selectedItem2.title);
          final TextEditingController detailsController = TextEditingController(text: selectedItem2.description);
          final TextEditingController statusController = TextEditingController(text: selectedItem2.status);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: taskNameController,
                  decoration: InputDecoration(
                    labelText: 'タスク名',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: detailsController,
                  decoration: InputDecoration(
                    labelText: '詳細',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: statusController,
                  decoration: InputDecoration(
                    labelText: '状態',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
              ],
            ),
          );
        },
        // ローディング中の場合
        loading: () => const Center(child: CircularProgressIndicator()),
        // エラーの場合
        error: (error, stackTrace) => Center(child: Text('データの取得に失敗しました: $error')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'ToDo作成'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'プロフィール'),
        ],
        currentIndex: 0, // ホームが選択されている状態
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/'); // ホームに遷移
              break;
            case 1:
              context.go('/add'); // ToDo作成画面に遷移
              break;
            case 2:
              context.go('/profile'); // プロフィール画面に遷移（仮の遷移先）
              break;
          }
        },
      ),
    );
  }
}





