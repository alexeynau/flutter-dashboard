// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dashboard/presentation/widgets/listen_widget.dart';

// class OldSelectorWidget extends StatefulWidget {
//   final String name;
//   final String x;
//   final List<String> y;

//   const OldSelectorWidget(
//       {super.key, required this.x, required this.y, required this.name});

//   @override
//   State<OldSelectorWidget> createState() => _OldSelectorWidgetState();
// }

// class _OldSelectorWidgetState extends State<OldSelectorWidget> {
//   late List<String> chosenData;
//   late bool isSelected;
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     chosenData = List.from(widget.y);
//     print("OldSelectorWidget");
//     return GestureDetector(
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (context) {
//             print(widget.y);
//             return Dialog(
//               child: SizedBox(
//                 width: 500,
//                 child: ListView.builder(
//                   itemCount: widget.y.length,
//                   itemBuilder: (context, index) {
//                     isSelected = chosenData.contains(widget.y[index]);
//                     return CheckboxListTile(
//                       title: Text(widget.y[index]),
//                       value: isSelected,
//                       onChanged: (newBool) {
//                         if (chosenData.contains(widget.y[index])) {
//                           setState(() {
//                             chosenData.remove(widget.y[index]);
//                             print("remove");
//                             isSelected = newBool!;
//                           });
//                         } else {
//                           setState(() {
//                             chosenData.add(widget.y[index]);
//                             print("add");
//                             isSelected = newBool!;
//                           });
//                         }
//                       },
//                     );
//                   },
//                 ),
//               ),
//             );
//           },
//         );
//       },
//       child: ListenWidget(name: widget.name, x: widget.x, y: chosenData),
//     );
//   }
// }
