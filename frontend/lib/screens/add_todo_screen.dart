import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/list_provider.dart';
import '../models/todo_item.dart';

class AddToDoScreen extends ConsumerWidget {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 非同期状態を監視
    final addItemState = ref.watch(listNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text('タスク管理アプリ / 追加')),
      body: addItemState.when(
        // データが正常に取得できた場合
        data: (items) {
          return Column(
            children: [
              TextField(
                controller: taskNameController,
                decoration: InputDecoration(hintText: 'タスク名'),
              ),
              TextField(
                controller: detailsController,
                decoration: InputDecoration(hintText: '詳細'),
              ),
              TextField(
                controller: statusController,
                decoration: InputDecoration(hintText: 'ステータス'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final notifier = ref.read(listNotifierProvider.notifier);
                  final newItem = ToDoItem(
                    id: DateTime.now().day,// 仮のID（サーバー側で生成される場合は変更）
                    title: taskNameController.text,
                    description: detailsController.text,
                    status: statusController.text,
                  );
                  try {
                    await notifier.addItem(newItem);
                     // API経由でアイテムを追加
                    context.go('/'); // ホーム画面に遷移
                  } catch (e) {
                    // エラーハンドリング（適宜メッセージを表示）
                    print('Error: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('タスクの追加に失敗しました')),
                    );
                  }
                },
                child: Text('登録'),
              ),
            ],
          );
        },
        // ローディング中の場合
        loading: () => Center(child: CircularProgressIndicator()),
        // エラーの場合
        error: (error, stackTrace) => Center(
          child: Text('タスクの取得中にエラーが発生しました: $error'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'ToDo作成'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'プロフィール'),
        ],
        currentIndex: 1, // ToDo作成画面なので1に設定
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/'); // ホームに遷移
              break;
            case 1:
              // 現在の画面なので何もしない
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


