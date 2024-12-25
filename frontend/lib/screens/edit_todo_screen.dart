import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/list_provider.dart';
import '../models/todo_item.dart';
import 'package:go_router/go_router.dart';

class EditToDoScreen extends ConsumerWidget {
  final int id;

  EditToDoScreen({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 非同期状態を監視
    final state = ref.watch(listNotifierProvider);

    return state.when(
      // データが正常に取得できた場合
      data: (items) {
        // アイテムをリストから取得
        final item = items.firstWhere(
          (item) => item.id == id,
           // アイテムが見つからない場合
        );

        // アイテムが見つからない場合
        if (items.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text('タスク管理アプリ / 編集')),
            body: Center(child: Text('指定されたタスクが見つかりませんでした。')),
          );
        }

        // コントローラーの初期化
        final TextEditingController titleController = TextEditingController(text: item.title);
        final TextEditingController descriptionController = TextEditingController(text: item.description);
        final TextEditingController statusController = TextEditingController(text: item.status);

        return Scaffold(
          appBar: AppBar(title: Text('タスク管理アプリ / 編集')),
          body: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'タスク名'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: '詳細'),
              ),
              TextField(
                controller: statusController,
                decoration: InputDecoration(hintText: 'ステータス'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // 更新したタスク情報を作成
                  final updatedItem = ToDoItem(
                    id: item.id,
                    title: titleController.text,
                    description: descriptionController.text,
                    status: statusController.text,
                  );

                  // Dio を使ってサーバー側で更新
                  try {
                    final notifier = ref.read(listNotifierProvider.notifier);
                    await notifier.modifyItem(item.id, updatedItem); // サーバー更新
                    context.go('/'); // 更新後にホーム画面に遷移
                  } catch (e) {
                    // エラーハンドリング
                    print('Error: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('タスクの追加に失敗しました')),
                    );
                    
                  }
                },
                child: Text('更新'),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'ToDo作成'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'プロフィール'),
            ],
            currentIndex: 2,
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
      },
      // ローディング中の場合
      loading: () => Center(child: CircularProgressIndicator()),
      // エラーの場合
      error: (error, stackTrace) => Center(
        child: Text('タスクの取得中にエラーが発生しました: $error'),
      ),
    );
  }
}

