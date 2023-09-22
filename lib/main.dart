import 'package:flutter/material.dart';
import 'service_locator.dart' as dependency_injection;
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.setup();

  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
      child: Container(),
    );
  }
}
