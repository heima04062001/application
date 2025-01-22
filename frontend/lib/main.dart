import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:your_flutter_project/screens/detail_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_todo_screen.dart';
import 'screens/edit_todo_screen.dart';
import'models/todo_item.dart';
import 'providers/list_provider.dart';

// GoRouter の設定をトップレベルで定義
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();  // const を削除
      },
    ),
    GoRoute(
      path: '/add',
      builder: (BuildContext context, GoRouterState state) {
        return AddToDoScreen();  // const を削除
      },
    ),
    
    GoRoute(
  path: '/edit/:id',
  builder: (BuildContext context, GoRouterState state) {
    final int id = int.parse(state.params['id']!);

    return Consumer(
      builder: (context, ref, child) {
        // fetchItemsProviderをwatchしてリストを取得
        final itemsAsyncValue = ref.watch(fetchItemsProvider);
        final items =itemsAsyncValue.value as List<dynamic>;
            // idに一致するToDoItemをリストから検索
            final todoitem = items.firstWhere(
              (item) => item.id == id);
             return EditToDoScreen(item: todoitem); // 見つかったアイテムを画面に表示
          },
        );
      },
    ),
  
   GoRoute(
  path: '/detail/:id',
  builder: (BuildContext context, GoRouterState state) {
    final int id = int.parse(state.params['id']!);

    return Consumer(
      builder: (context, ref, child) {
        // fetchItemsProviderをwatchしてリストを取得
        final itemsAsyncValue = ref.watch(fetchItemsProvider);
        final items =itemsAsyncValue.value as List<dynamic>;
            // idに一致するToDoItemをリストから検索
          final todoitem = items.firstWhere(
              (item) => item.id == id,orElse:() =>ToDoItem(id: -1, title: '', description: '', status:true));
             return DetailScreen(todoItem: todoitem); // 見つかったアイテムを画面に表示
          },
        );
      },
    ),
    
    
  ],
);

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      title: 'タスク管理アプリ',
    );
  }
}



