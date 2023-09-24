// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/data/datasources/json_http.dart';
import 'package:flutter_dashboard/presentation/colors.dart';
import 'package:flutter_dashboard/presentation/pages/home_page.dart';
import 'package:flutter_dashboard/presentation/pages/sales_page.dart';
import 'service_locator.dart' as dependency_injection;
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.setup();
  dependency_injection.getIt.get<JsonRemoteData>().serverWatcher(3);
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomePage(),
    const SalesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // add MultiBlockProvider
      home: DefaultTabController(
        initialIndex: _currentIndex,
        length: _tabs.length,
        child: Builder(
          builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context);
            tabController.addListener(() {
              if (tabController.indexIsChanging) {
                _currentIndex = tabController.index;
              }
            });

            return Scaffold(
              appBar: AppBar(
                leading: Icon(
                  Icons.access_time_filled,
                  color: ThemeColors().primary,
                ),
                backgroundColor: ThemeColors().secondary,
                title: TabBar(
                  indicatorColor: ThemeColors().secondary,
                  labelColor: ThemeColors().background02,
                  unselectedLabelStyle: TextStyle(fontSize: 14),
                  labelStyle: TextStyle(fontSize: 20),
                  tabs: [
                    Tab(
                      child: Text(
                        "Главная",
                        style: TextStyle(
                          color: ThemeColors().primarytext,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Продажи",
                        style: TextStyle(
                          color: ThemeColors().primarytext,
                        ),
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
