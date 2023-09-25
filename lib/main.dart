// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/data/datasources/json_http.dart';
import 'package:flutter_dashboard/presentation/bloc/chart_bloc/chart_bloc.dart';
import 'package:flutter_dashboard/presentation/colors.dart';
import 'package:flutter_dashboard/presentation/pages/home_page.dart';
import 'package:flutter_dashboard/presentation/pages/sales_page.dart';
import 'service_locator.dart' as dependency_injection;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.setup();
  dependency_injection.getIt.get<JsonRemoteData>().serverWatcher(3);
  runApp(App());
}

class App extends StatefulWidget {
  App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 1;

  final List<Widget> _tabs = [
    const HomePage(),
    const SalesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChartBloc>(create: (context) => getIt<ChartBloc>()),
      ],
      child: MaterialApp(
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
                  setState(() {
                    _currentIndex = tabController.index;
                  });
                }
              });

              return Scaffold(
                appBar: AppBar(
                  backgroundColor: ThemeColors().secondary,
                  title: TabBar(
                    overlayColor:
                        MaterialStatePropertyAll(ThemeColors().secondary),
                    automaticIndicatorColorAdjustment: false,
                    indicatorColor: ThemeColors().secondary,
                    unselectedLabelStyle: TextStyle(fontSize: 14),
                    labelStyle: TextStyle(fontSize: 20),
                    tabs: [
                      Container(
                        color: _currentIndex == 0
                            ? ThemeColors().selected
                            : ThemeColors().secondary,
                        width: MediaQuery.of(context).size.width,
                        child: Tab(
                          height: MediaQuery.of(context).size.height,
                          child: Text(
                            "Главная",
                            style: TextStyle(
                              color: ThemeColors().primarytext,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.all(0),
                        color: _currentIndex == 1
                            ? ThemeColors().selected
                            : ThemeColors().secondary,
                        width: double.infinity,
                        child: Tab(
                          height: MediaQuery.of(context).size.height,
                          child: Text(
                            "Продажи",
                            style: TextStyle(
                              color: ThemeColors().primarytext,
                            ),
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
      ),
    );
  }
}
