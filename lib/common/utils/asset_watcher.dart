import 'dart:async';
import 'package:flutter_dashboard/data/models/data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

Future<void> assetWatch(
    StreamController<String> eventStream, String fileName, int seconds) async {
  String finalText = await rootBundle.loadString("assets/json/$fileName");
  eventStream.add(finalText);
  while (true) {
    print("watching ...");
    String startText = finalText;
    await Future.delayed(Duration(seconds: seconds));
    finalText = await rootBundle.loadString("assets/json/$fileName");
    print(startText);
    print(finalText);
    if (startText.length != finalText.length) {
      print("new event");
      eventStream.add(finalText);
    } else {
      print("nothing changed");
    }
  }
}

Future<void> serverWatcher(
    StreamController streamController, int seconds) async {
  print("start watching");
  String url = "http://localhost:8000/";
  var response = await http.get(Uri.parse(url));
  print("got response");
  print(response.body);
  String finalText = "";
  if (response.statusCode == 200) {
    String finalText = response.body;
    streamController.add(response.body);
  } else {
    print(response.statusCode);
  }

  while (true) {
    print("Watching ...");
    if (response.statusCode == 200) {
      String startText = finalText;
      await Future.delayed(Duration(seconds: seconds));
      response = await http.get(Uri.parse(url));
      finalText = response.body;

      if (startText != finalText) {
        print("new event");
        streamController.add(response.body);
      } else {
        print("nothing changed");
      }
    } else {
      print(response.statusCode);
    }
  }
}


// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_dashboard/common/utils/asset_watcher.dart';
// import 'package:flutter_dashboard/data/models/data.dart';
// import 'package:flutter_dashboard/domain/repositories/json_repository.dart';
// import 'package:get_it/get_it.dart';
// import 'service_locator.dart' as dependency_injection;
// import 'package:flutter_bloc/flutter_bloc.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dependency_injection.setup();

//   runApp(App());
// }

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // return MultiBlocProvider(
//     //   providers: [],
//     //   child: Container(),
//     // );
//     return const MaterialApp(
//       home: Scaffold(
//         body: Streamer(),
//       ),
//     );
//   }
// }

// class Streamer extends StatefulWidget {
//   const Streamer({super.key});

//   @override
//   State<Streamer> createState() => _StreamerState();
// }

// class _StreamerState extends State<Streamer> {
//   StreamController<String> eventStream = StreamController();
//   @override
//   void initState() {
//     var controller = new StreamController<String>();
//     serverWatcher(controller, 3);

//     controller.stream.listen((item) => setState(() {})); // ловушка

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future:
//           dependency_injection.getIt.get<JsonRepository>().getDataAndPlots(),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.done:
//             if (snapshot.hasData) {
//               return Text(snapshot.data!.data[0].series.toString());
//             }

//             break;
//           case ConnectionState.active:
//             if (snapshot.hasData) {
//               return Text(snapshot.data.toString());
//             }

//             break;
//           default:
//             return const LinearProgressIndicator();
//         }
//         return const LinearProgressIndicator();
//       },
//     );
//   }
// }


 // body: FutureBuilder(
        //   future: dependency_injection.getIt
        //       .get<JsonRepository>()
        //       .getDataAndPlotsFromAssets('test.json'),
        //   builder: (context, snapshot) {
        //     switch (snapshot.connectionState) {
        //       case ConnectionState.done:
        //         if (snapshot.hasData) {
        //           return Text(snapshot.data!.data[0].series.toString());
        //         }

        //         break;
        //       case ConnectionState.active:
        //         if (snapshot.hasData) {
        //           return Text(snapshot.data.toString());
        //         }

        //         break;
        //       default:
        //         return const LinearProgressIndicator();
        //     }
        //     return const LinearProgressIndicator();
        //   },
        // ),