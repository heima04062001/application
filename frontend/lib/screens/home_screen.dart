import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/list_provider.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsState = ref.watch(listNotifierProvider);

    return itemsState.when(
      data: (items) => Scaffold(
        appBar: AppBar(title: const Text('タスクアプリ')),
        body: Column(
          children: [
            const SearchBarWidget(),
            TaskListWidget(tasks: items),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('タスクアプリ')),
        body: const Center(child: CircularProgressIndicator()),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
      error: (err, stack) => const SizedBox(),
    );
  }

  // BottomNavigationBarのビルドメソッド
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
      },
    );
  }
}

// 検索バーをStatelessWidgetに変更
class SearchBarWidget extends StatelessWidget {

  const SearchBarWidget({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child:  const TextField(
        decoration: InputDecoration(hintText: '検索欄'),
      ),
    );
  }
}

// タスクリストをStatelessWidgetに変更
class TaskListWidget extends StatelessWidget {
  final List<dynamic> tasks;

  const TaskListWidget({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final item = tasks[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text('ステータス: ${item.status}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    context.go('/edit/${item.id}');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    context.go('/detail/${item.id}');
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}




              
