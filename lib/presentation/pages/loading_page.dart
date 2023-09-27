import 'package:flutter/material.dart';
// import 'package:pick_files/dashboard_page.dart';

import '../../data/repositories/windows_repository.dart';
import '../../service_locator.dart';
import 'dashboard_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key, required this.shouldParseTable});

  final bool shouldParseTable;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  WindowsRepository repository = getIt.get<WindowsRepository>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: repository.runRobot(widget.shouldParseTable),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return DashboardPage();
            default:
              return const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Парсим данные"),
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
