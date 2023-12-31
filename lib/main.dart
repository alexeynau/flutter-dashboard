// import 'dart:js_util';

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:window_size/window_size.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repositories/windows_repository.dart';
import 'presentation/pages/dashboard_page.dart';
import 'presentation/widgets/file_choose_dialog.dart';
import 'service_locator.dart' as dependency_injection;

import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.setup();

  // var prefs = await getIt.get<SharedPreferences>();
  // await prefs.clear();
  // dependency_injection.getIt.get<JsonRemoteData>().serverWatcher(1);
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('My App');
    // setWindowMaxSize(const Size(max_width, max_height));
    setWindowMinSize(const Size(1050, 600));
  }
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

                  return FileChooseDialog();
                }
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
