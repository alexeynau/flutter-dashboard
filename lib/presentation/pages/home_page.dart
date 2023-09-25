import 'package:flutter/material.dart';
import 'package:flutter_dashboard/data/models/data.dart';
import 'package:flutter_dashboard/presentation/widgets/listen_widget.dart';
import 'package:flutter_dashboard/presentation/widgets/old_selector.dart';

import '../../domain/repositories/json_repository.dart';
import '../../service_locator.dart';
import '../widgets/column.dart';
import '../widgets/selector_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  JsonRepository repository = getIt.get<JsonRepository>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // width: 1000,
        child: GridView.count(
          crossAxisCount: 4,
          children: const [
            ListenWidget(
              name: "Data",
              x: "Months",
              y: ["Guns"],
            ),
            OldSelectorWidget(
              name: "Data4",
              x: "Months",
              y: ["Guns"],
            ),
            SelectorWidget(
              name: "Data3",
              x: "Money",
              y: ["Guns", "Company A"],
            ),
            SelectorWidget(
              name: "Data2",
              x: "Months",
              y: ["Guns", "Company A"],
            ),
          ],
        ));
  }
}
