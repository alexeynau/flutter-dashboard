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
    const TestPage()
  ];
  final List<String> _tabsNames = ["Главная", "Продажи", "Налоги"];
  final List<IconData> _tabsIcons = [
    Icons.home,
    Icons.monetization_on,
    Icons.edit_document
  ];
  @override
  void initState() {
    print("repaint");
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
                        // appBar: AppBar(
                        //   backgroundColor: ThemeColors().secondary,
                        //   title: TabBar(
                        //     overlayColor: MaterialStatePropertyAll(
                        //         ThemeColors().secondary),
                        //     automaticIndicatorColorAdjustment: false,
                        //     indicatorColor: ThemeColors().secondary,
                        //     unselectedLabelStyle: TextStyle(fontSize: 14),
                        //     labelStyle: TextStyle(fontSize: 20),
                        //     tabs: [
                        //       Container(
                        //         color: _currentIndex == 0
                        //             ? ThemeColors().selected
                        //             : ThemeColors().secondary,
                        //         width: MediaQuery.of(context).size.width,
                        //         child: Tab(
                        //           height: MediaQuery.of(context).size.height,
                        //           child: Text(
                        //             "Главная",
                        //             style: TextStyle(
                        //               color: ThemeColors().primarytext,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Container(
                        //         padding: EdgeInsets.all(0),
                        //         margin: EdgeInsets.all(0),
                        //         color: _currentIndex == 1
                        //             ? ThemeColors().selected
                        //             : ThemeColors().secondary,
                        //         width: double.infinity,
                        //         child: Tab(
                        //           height: MediaQuery.of(context).size.height,
                        //           child: Text(
                        //             "Продажи",
                        //             style: TextStyle(
                        //               color: ThemeColors().primarytext,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Container(
                        //         color: _currentIndex == 2
                        //             ? ThemeColors().selected
                        //             : ThemeColors().secondary,
                        //         width: MediaQuery.of(context).size.width,
                        //         child: Tab(
                        //           height: MediaQuery.of(context).size.height,
                        //           child: Text(
                        //             "Тест",
                        //             style: TextStyle(
                        //               color: ThemeColors().primarytext,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        body: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 20),
                                color: ThemeColors().background01,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: ThemeColors().secondary,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 35.0,
                                      right: 3,
                                      left: 3,
                                    ),
                                    child: Column(
                                      children: [
                                        ..._tabs.map(
                                          (e) {
                                            return Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    right: 10, left: 10),
                                                child: GestureDetector(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        _tabsIcons[
                                                            _tabs.indexOf(e)],
                                                        size: 18,
                                                        color: _currentIndex ==
                                                                _tabs.indexOf(e)
                                                            ? ThemeColors()
                                                                .navigationButtonColor
                                                            : ThemeColors()
                                                                .greyText,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        _tabsNames[
                                                            _tabs.indexOf(e)],
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: _currentIndex ==
                                                                    _tabs
                                                                        .indexOf(
                                                                            e)
                                                                ? ThemeColors()
                                                                    .navigationButtonColor
                                                                : ThemeColors()
                                                                    .greyText,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      _currentIndex =
                                                          _tabs.indexOf(e);
                                                    });
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Expanded(
                                          flex: 11,
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            padding: const EdgeInsets.only(
                                                right: 5, left: 5, bottom: 30),
                                            child: TextButton(
                                              onPressed: () {
                                                //Леха сюда пиши что делает кнопка
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                  ThemeColors()
                                                      .navigationButtonColor,
                                                ),
                                              ),
                                              child: SizedBox(
                                                height: 40,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Text(
                                                          "Выбрать другой файл",
                                                          style: TextStyle(
                                                              color: ThemeColors()
                                                                  .navigationButtonText,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: Icon(
                                                        Icons.add,
                                                        color: ThemeColors()
                                                            .navigationButtonText,
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: _tabs[_currentIndex],
                            ),
                          ],
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
