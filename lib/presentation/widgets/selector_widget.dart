// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_dashboard/presentation/colors.dart';
// import 'package:flutter_dashboard/presentation/widgets/listen_widget.dart';

// import '../../service_locator.dart';
// import '../bloc/bloc/selector_bloc.dart';

// class SelectorWidget extends StatefulWidget {
//   final String name;
//   final String x;
//   final List<String> y;

//   const SelectorWidget(
//       {super.key, required this.x, required this.y, required this.name});

//   @override
//   State<SelectorWidget> createState() => _SelectorWidgetState();
// }

// class _SelectorWidgetState extends State<SelectorWidget> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SelectorBloc, SelectorState>(
//       builder: (context, state) {
//         print(state);
//         return SizedBox(
//           child: GestureDetector(onTap: () {
//             showDialog(
//               context: context,
//               builder: (context) {
//                 print(widget.y);

//                 return Dialog(
//                     child: SizedBox(
//                   width: 400,
//                   child: state is SelectorLoading
//                       ? CircularProgressIndicator()
//                       : state is SelectorLoaded
//                           ? ListView.builder(
//                               itemCount: widget.y.length,
//                               itemBuilder: (context, index) =>
//                                   SelectorTile(name: widget.y[index]))
//                           : Text("No selected"),
//                 ));
//               },
//             );
//           }, child: Builder(
//             builder: (context) {
//               if (state is SelectorLoaded) {
//                 print("${widget.x} ${state.chosenY}");
//                 return ListenWidget(
//                   name: widget.name,
//                   x: widget.x,
//                   y: state.chosenY,
//                 );
//               }
//               if (state is SelectorInitial) {
//                 context
//                     .read<SelectorBloc>()
//                     .add(ChangeSelected(widget.y, widget.y));
//                 return const CircularProgressIndicator(
//                   color: Color.fromARGB(255, 175, 165, 76),
//                 );
//               }
//               return const CircularProgressIndicator(
//                 color: Colors.green,
//               );
//             },
//           )),
//         );
//       },
//     );
//   }
// }

// class SelectorTile extends StatefulWidget {
//   const SelectorTile({super.key, required this.name});
//   final String name;

//   @override
//   State<SelectorTile> createState() => _SelectorTileState();
// }

// class _SelectorTileState extends State<SelectorTile> {
//   bool isSelected = true;
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SelectorBloc, SelectorState>(
//       builder: (context, state) {
//         if (state is SelectorLoaded) {
//           isSelected = state.chosenY.contains(widget.name);
//           return ListTile(
//             leading: isSelected
//                 ? Icon(
//                     Icons.check_box_outlined,
//                     color: ThemeColors().firstgrad5,
//                   )
//                 : const Icon(Icons.check_box_outline_blank),
//             title: Text(widget.name),
//             onTap: () {
//               if (isSelected) {
//                 BlocProvider.of<SelectorBloc>(context)
//                     .add(RemoveValue(widget.name));
//               } else {
//                 BlocProvider.of<SelectorBloc>(context)
//                     .add(AddValue(widget.name));
//               }
//             },
//           );
//         } else
//           return CircularProgressIndicator();
//       },
//     );
//   }
// }
