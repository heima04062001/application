import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/list_provider.dart';
import 'package:go_router/go_router.dart';



class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsState = ref.watch(listNotifierProvider);
return  itemsState.when(
    data: (value) => Scaffold(
      appBar: AppBar(title: Text('タスク管理アプリ')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(hintText: '検索欄'),
              onChanged: (value) {
                // 検索処理を追加する場合はここでフィルタリング
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: value.length,  // itemsの長さを使用
              itemBuilder: (context, index) {
                final item = value[index];
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
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    ), // 内部の AsyncValue を取得
    loading: () => Scaffold(
        appBar: AppBar(title: Text('タスク管理アプリ')),
        body: Center(child: CircularProgressIndicator()),  // ローディングインディケータ
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    error: (err, stack) => SizedBox()

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
          print('ToDo作成ボタンがタップされました。');
          context.go('/add');
        }
        // 他の画面への遷移も実装可能
      },
    );
  }
}



              
