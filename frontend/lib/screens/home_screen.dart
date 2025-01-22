import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/list_provider.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final itemsState = ref.watch(fetchItemsProvider);

  return Scaffold(
    appBar: itemsState.when(
      data: (_) => AppBar(title: const Text('タスク管アプリ')),
      loading: () => AppBar(title: const Text('タスク管アプリ (読み込み中)')),
      error: (err, stack) {
  print('Error: $err');
  print('Stack trace: $stack');
  return AppBar(title: const Text('タスク管理アプリ (エラー発生)'));
}

    ),
    body: itemsState.when(
      data: (items) => Column(
        children: [
          const SearchBarWidget(),
          TaskListWidget(tasks: items),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const SizedBox(),
    ),
    bottomNavigationBar: _buildBottomNavigationBar(context),
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
            subtitle: Text('ステータス: ${item.status? '完了' : '未完了'}'),
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




              
