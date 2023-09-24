import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/widgets/listen_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      // width: 1000,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.amber,
                    child: ListenWidget(
                        child: Container(), x: "Price", y: ["Cars"]),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.red,
                    child: ListenWidget(
                        child: Container(),
                        x: "Money",
                        y: ["Guns", "Company A"]),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.amber,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
