import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/widgets/listen_widget.dart';

class SelectorWidget extends StatefulWidget {
  final String x;
  final List<String> y;

  const SelectorWidget({super.key, required this.x, required this.y});

  @override
  State<SelectorWidget> createState() => _SelectorWidgetState();
}

class _SelectorWidgetState extends State<SelectorWidget> {
  late List<String> chosenData;
  @override
  void initState() {
    chosenData = List.from(widget.y);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            print(widget.y);
            return Dialog(
              child: ListView.builder(
                itemCount: widget.y.length,
                itemBuilder: (context, index) => ListTile(
                  leading: chosenData.contains(widget.y[index])
                      ? Icon(Icons.check_box_outlined)
                      : Icon(Icons.check_box_outline_blank),
                  title: Text(widget.y[index]),
                  onTap: () {
                    if (chosenData.contains(widget.y[index])) {
                      setState(() {
                        chosenData.remove(widget.y[index]);
                      });
                    } else {
                      setState(() {
                        chosenData.add(widget.y[index]);
                      });
                    }
                  },
                ),
              ),
            );
          },
        );
      },
      child: ListenWidget(x: widget.x, y: chosenData),
    );
  }
}
