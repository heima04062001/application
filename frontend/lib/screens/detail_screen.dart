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
              if (items != null ) {
                  final itemToDeletelist = items.where((item) => item.id == id );
                  final itemToDelete = itemToDeletelist.first;
                  // アイテムを削除
                  await ref.read(listNotifierProvider.notifier).deleteItem(itemToDelete);
                  // 削除後にホーム画面に遷移
                  context.go('/');
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

          

          // アイテムが見つかった場合
          final selectedItemlist = items.where((item) => item.id == id);
          if (selectedItemlist.isEmpty){
               return const Center(
                child: Text('このIDは見つかりません'),
               );
          }
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
                  decoration: const InputDecoration(
                    labelText: 'タスク名',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
               const SizedBox(height: 16),
                TextField(
                  controller: detailsController,
                  decoration: const InputDecoration(
                    labelText: '詳細',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: statusController,
                  decoration: const InputDecoration(
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
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
}



BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'ToDo作成'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'プロフィール'),
      ],
      currentIndex: 0,
      onTap: (index) {
        if (index == 0){
          context.go('/');
        }
        if (index == 1) {
          context.go('/add');
        }
        // 他の画面への遷移も実装可能
      },
    );
  }





