import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/list_provider.dart';
import '../models/todo_item.dart';
import 'package:go_router/go_router.dart';

class EditToDoScreen extends ConsumerStatefulWidget {
  final ToDoItem item;

  EditToDoScreen({required this.item});

  @override
  _EditToDoScreenState createState() => _EditToDoScreenState();
}

class _EditToDoScreenState extends ConsumerState<EditToDoScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController statusController;
  late  ToDoItem item; 
  @override
  void initState() {
    super.initState();
    // 初期化: 渡された ToDoItem を基に TextEditingController を設定
    item = widget.item;
    titleController = TextEditingController(text:item.title);
    descriptionController = TextEditingController(text:item.description);
    statusController = TextEditingController(text: item.status ? '完了' : '未完了');
  }

  @override
  void dispose() {
    // コントローラーを解放
    titleController.dispose();
    descriptionController.dispose();
    statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('タスク管理アプリ / 編集'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              // アイテムを削除
              context.go('/'); // 削除後にホーム画面に遷移
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'タスク名',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: '詳細',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // 状態を選択するためのDropdownButton
                DropdownButton<String>(
                  value: statusController.text,
                  onChanged: (String? newValue) {
                    setState(() {
                      statusController.text = newValue!;
                    });
                  },
                  items: <String>['未完了', '完了']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                // 更新ボタン
                UpdateTaskButton(
                  item: widget.item,
                  titleController: titleController,
                  descriptionController: descriptionController,
                  statusController: statusController,
                ),
              ],
            ),
          ),
        ],
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
        if (index == 1) {
          context.go('/add');
        }
        if (index == 0) {
          context.go('/');
        }
        // 他の画面への遷移も実装可能
      },
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
        // 更新後のタスクを作成
        final updatedItem = ToDoItem(
          id: item.id,
          title: titleController.text,
          description: descriptionController.text,
          status: statusController.text == '完了', // ステータスを "完了" または "未完了" に変換
        );

        try {
           ref.read(modifyItemProvider(updatedItem)); // アイテムをサーバーで更新
           ref.watch(fetchItemsProvider);
          context.go('/'); // 更新後にホーム画面に遷移
        } catch (e) {
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










