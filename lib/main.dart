// import 'dart:js_util';

import 'dart:io';

import 'package:flutter/material.dart';

import 'data/repositories/windows_repository.dart';
import 'presentation/pages/dashboard_page.dart';
import 'presentation/pages/loading_page.dart';
import 'service_locator.dart' as dependency_injection;

import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.setup();
  // dependency_injection.getIt.get<JsonRemoteData>().serverWatcher(1);
  runApp(App());
}

class App extends StatefulWidget {
  App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  WindowsRepository repository = getIt.get<WindowsRepository>();
  bool parseTable = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // add MultiBlockProvider
      home: Scaffold(
        body: FutureBuilder(
            future: repository.hasData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.data == true) {
                    print("has data");
                    repository.watchExcel(repository.currentPath!);
                    return DashboardPage();
                  } else {
                    print("doesnt have data");
                    return FutureBuilder(
                      future: repository.getPath(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            if (snapshot.data == null) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Файл не выбран"),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await repository.pickFile();

                                        print(snapshot.data);
                                        setState(() {});
                                      },
                                      child: const Text("Выбрать"),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Builder(
                                builder: (context) {
                                  return Center(
                                    child: SizedBox(
                                      width: 600,
                                      height: 300,
                                      child: Dialog(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "${Directory.current.path}  Выбран файл: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "${snapshot.data}",
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const Text(
                                              "Заполнить таблицу автоматически?",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      repository.watchExcel(
                                                          snapshot.data!);
                                                      parseTable = false;
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return LoadingPage(
                                                              shouldParseTable:
                                                                  parseTable,
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    child: const Text("Нет"),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await repository.pickFile();
                                                    print(snapshot.data);
                                                    setState(() {});
                                                  },
                                                  child: const Text(
                                                      "Выбрать другой файл"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      repository.watchExcel(
                                                          snapshot.data!);
                                                      parseTable = true;
                                                    },
                                                    child: const Text("Да"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }

                          default:
                            return const CircularProgressIndicator();
                        }
                      },
                    );
                  }
                default:
                  return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
