import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/colors.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
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
                    color: ThemeColors().background01,
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
