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
        // コントローラーの初期化
        final TextEditingController titleController = TextEditingController(text: item.title);
        final TextEditingController descriptionController = TextEditingController(text: item.description);
        final TextEditingController statusController = TextEditingController(text: item.status);

        // アイテムが見つからない場合
        if (items.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: const Text('タスク管理アプリ / 編集')),
            body: const Center(child: Text('指定されたタスクが見つかりませんでした。')),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('タスク管理アプリ / 編集')),
          body: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'タスク名'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: '詳細'),
              ),
              TextField(
                controller: statusController,
                decoration: const InputDecoration(hintText: 'ステータス'),
              ),
              UpdateTaskButton(item: item,
                               titleController: titleController,
                               descriptionController: descriptionController,
                               statusController: statusController,),
            ],
          ),
          bottomNavigationBar: _buildBottomNavigationBar(context),
        );
      },
      // ローディング中の場合
      loading: () => const Center(child: CircularProgressIndicator()),
      // エラーの場合
      error: (error, stackTrace) => Center(
        child: Text('タスクの取得中にエラーが発生しました: $error'),
      ),
    );
  }
}


class UpdateTaskButton extends ConsumerWidget {
  final ToDoItem item;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController statusController;
  
  const UpdateTaskButton({
    Key? key,
    required this.item,
    required this.titleController,
    required this.descriptionController,
    required this.statusController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
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
            SnackBar(content: Text('タスクの更新に失敗しました')),
          );
        }
      },
      child: Text('更新'),
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
        if (index == 1) {
          context.go('/add');
        }
        if (index == 0){
          context.go('/');
        }
        // 他の画面への遷移も実装可能
      },
    );
  }









