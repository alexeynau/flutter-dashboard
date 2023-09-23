// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/pages/home_page.dart';
import 'package:flutter_dashboard/presentation/pages/sales_page.dart';
import 'service_locator.dart' as dependency_injection;
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.setup();

  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  // int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomePage(),
    const SalesPage(),
    // FavoritesScreen(),
    // ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // add MultiBlockProvider
      home: DefaultTabController(
        length: _tabs.length,
        child: Builder(
          builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context);
            tabController.addListener(() {
              if (!tabController.indexIsChanging) {
                // Your code goes here.
                // To get index of current tab use tabController.index
              }
            });

            return Scaffold(
              appBar: AppBar(
                leading: const Icon(
                  Icons.access_time_filled,
                  color: Colors.green,
                ),
                backgroundColor: Colors.white,
                title: const TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        "Главная",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Продажи",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: _tabs.map((e) {
                  return e;
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
