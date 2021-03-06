import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouter_example/home.dart';
import 'package:gorouter_example/my_storage.dart';
import 'package:gorouter_example/other.dart';

import 'login.dart';

void main() {
  runApp(MyApp());
}

class LoginInfo with ChangeNotifier {
  var _isLoggedIn = false;
  get isLoggedIn => _isLoggedIn;
  set isLoggedIn(value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // static LoginInfo loginInfo = LoginInfo();

  final _router = GoRouter(
    initialLocation: '/',
    urlPathStrategy: UrlPathStrategy.path,
    refreshListenable: loginInfo,
    redirect: (state) {
      if (_snapshot.connectionState == ConnectionState.waiting ||
          !_snapshot.hasData) {
        return '/splash';
      }

      var isLoggingIn = state.location == '/login';
      var isLoggedIn = (_snapshot.data as String).isNotEmpty;

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),
      GoRoute(
        name: 'other',
        path: '/other',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const OtherPage(),
        ),
        routes: [
          GoRoute(
            name: 'detail',
            path: ':id',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: Center(
                child: Text('${state.params['id']}'),
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: LoginPage(loginInfo),
        ),
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
            ),
          ),
        ),
      );
    },
  );
  static late AsyncSnapshot<String?> _snapshot;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MyStorage.getToken(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        _snapshot = snapshot;
        return MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
        );
      },
    );
  }
}
