import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/pages/test_page.dart';

import '../../data/repositories/windows_repository.dart';
import '../../service_locator.dart';
import '../colors.dart';
import 'new_home_page.dart';
import 'new_sales_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  WindowsRepository repository = getIt.get<WindowsRepository>();

  int _currentIndex = 2;

  final List<Widget> _tabs = [
    const NewHomePage(),
    const NewSalesPage(),
    const TestPage(),
  ];

  @override
  void initState() {
    print("repaint");
    // repository.eventStream.stream.listen((event) {
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: repository.getDataAndPlots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data != null) {
                return DefaultTabController(
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
                            overlayColor: MaterialStatePropertyAll(
                                ThemeColors().secondary),
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
                              Container(
                                color: _currentIndex == 2
                                    ? ThemeColors().selected
                                    : ThemeColors().secondary,
                                width: MediaQuery.of(context).size.width,
                                child: Tab(
                                  height: MediaQuery.of(context).size.height,
                                  child: Text(
                                    "Тест",
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
                );
              } else {
                return Text(" ${Directory.current.path} Нет Данных :(");
              }

            default:
              return const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Рисуем Дашборды"),
                    CircularProgressIndicator()
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
