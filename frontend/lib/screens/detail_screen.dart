import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/todo_item.dart'; // ToDoItem モデルをインポート
import '../providers/list_provider.dart'; // プロバイダのインポート

class DetailScreen extends ConsumerStatefulWidget {
  final ToDoItem todoItem;

  DetailScreen({required this.todoItem});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  late TextEditingController taskNameController;
  late TextEditingController detailsController;
  late TextEditingController statusController;
  late ToDoItem todoItem;

  @override
  void initState() {
    super.initState();
    todoItem = widget.todoItem;
    taskNameController = TextEditingController(text: todoItem.title);
    detailsController = TextEditingController(text: todoItem.description);
    statusController = TextEditingController(text: todoItem.status ? '完了' : '未完了');
  }

  @override
  void dispose() {
    taskNameController.dispose();
    detailsController.dispose();
    statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('タスク管理アプリ / 詳細'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              try {
                // 削除操作を非同期に待機
                 ref.read(deleteItemProvider(todoItem));
                // 削除後にアイテムリストをリフレッシュ
                 ref.watch(fetchItemsProvider);
                // ホーム画面に遷移
                context.go('/');
              } catch (e) {
                print('Error: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('タスクの削除に失敗しました')),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // タスク名
            TextField(
              controller: taskNameController,
              decoration: const InputDecoration(
                labelText: 'タスク名',
                border: OutlineInputBorder(),
              ),
              readOnly: true,  // 編集不可
            ),
            const SizedBox(height: 16),
            // 詳細
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(
                labelText: '詳細',
                border: OutlineInputBorder(),
              ),
              readOnly: true,  // 編集不可
            ),
            const SizedBox(height: 16),
            // 状態選択（変更不可）
            DropdownButton<String>(
              value: statusController.text,
              onChanged: null, // 編集不可
              items: <String>['未完了', '完了']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // BottomNavigationBar
  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'ToDo作成'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'プロフィール'),
      ],
      currentIndex: 0,
      onTap: (index) {
        if (index == 0) {
          context.go('/');
        }
        if (index == 1) {
          context.go('/add');
        }
      },
    );
  }
}




