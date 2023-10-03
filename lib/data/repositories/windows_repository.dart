import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher/watcher.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../service_locator.dart';
import '../models/data.dart';

class WindowsRepository {
  late DataAndPlots _dataAndPlots;
  late StreamController<DataAndPlots> _eventStream;
  String? _currentPath;
  bool _hasData = false;

  Future<bool> hasData() async {
    var prefs = getIt.get<SharedPreferences>();
    _hasData = prefs.getBool("hasData") ?? false;
    print("hasData = $_hasData");
    _currentPath = prefs.getString("excel");
    // await getDataAndPlots();
    // _hasData = _dataAndPlots.data.isNotEmpty ? _hasData : false;
    return _hasData;
  }

  StreamController<DataAndPlots> get eventStream => _eventStream;

  Future<void> pickFile() async {
    var file = await FilePicker.platform.pickFiles(allowedExtensions: ['txt']);
    if (file != null) {
      savePath(file.files.first.path!);
    }
  }

  void savePath(String path) async {
    print("setPath");
    _currentPath = path;
    var prefs = getIt.get<SharedPreferences>();
    // var dotEnv = DotEnv();
    // await dotEnv.load(fileName: 'assets/python/.env');
    // dotEnv.env['APP1_FILE_PATH'] = path;

    String envFilePath = 'assets/python/.env';
    String keyToUpdate = 'APP1_FILE_PATH';
    String newValue = path;

    updateEnvFile(envFilePath, keyToUpdate, newValue);

    prefs.setString("excel", path);
  }

  void updateEnvFile(String filePath, String key, String value) {
    File file = File(filePath);
    List<String> lines = file.readAsLinesSync();

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i];
      if (line.startsWith(key)) {
        lines[i] = '$key=$value';
        break;
      }
    }

    file.writeAsStringSync(lines.join('\n'));
  }

  Future<String?> getPath() async {
    var prefs = getIt.get<SharedPreferences>();
    print("getPath");
    if (currentPath != null) {
      return currentPath;
    } else {
      return prefs.getString("excel");
    }
  }

  String? get currentPath => _currentPath;

  Future<bool> runRobot(bool shouldParseTable) async {
    const String debugRobotPath = "assets/python/robot.yaml";
    const String releaseRobotPath =
        "./data/flutter_assets/assets/python/robot.yaml";
    var usePath = debugRobotPath;
    bool firstRobotSuccess = true;
    if (shouldParseTable) {
      var firstRobotResult = await Process.run('rcc',
          ['task', 'run', '--robot', usePath, "--task", "app_1_postprocessor"]);
      firstRobotSuccess = firstRobotResult.exitCode == 0;

      if (firstRobotSuccess) {
        print("First robot succes");
      } else {
        print("First robot error ${firstRobotResult.stderr}");
      }
    }

    var secondRobotResult = await Process.run('rcc',
        ['task', 'run', '--robot', usePath, "--task", "app_1_postprocessor"]);
    var secondRobotSuccess = secondRobotResult.exitCode == 0;

    if (secondRobotSuccess) {
      print("Second robot succes");
    } else {
      print("Second robot error ${secondRobotResult.stderr}");
    }

    return firstRobotSuccess && secondRobotSuccess;
  }

  Future<DataAndPlots> getDataAndPlots() async {
    var prefs = getIt.get<SharedPreferences>();
    print("reading json");
    var readJson = await rootBundle
        .loadString("assets/python/output/shared/workitems.json", cache: false);
    _dataAndPlots = dataAndPlotsFromJson(readJson);
    _hasData = _dataAndPlots.data.isNotEmpty;
    prefs.setBool("hasData", _hasData);

    return _dataAndPlots;
  }

  watchExcel(String pathToExcel) async {
    _eventStream = StreamController.broadcast();
    FileWatcher excelFileWatcher = FileWatcher(pathToExcel);
    print("start watching for $pathToExcel");

    excelFileWatcher.events.listen((event) async {
      print("got event");
      if (event.type == ChangeType.MODIFY) {
        var listenExcelSuccess = await runRobot(false);
        print("robot end job, success: $listenExcelSuccess");
        if (listenExcelSuccess) {
          _eventStream.add(_dataAndPlots);
        }
      }
    });
  }

  @override
  List getSeriesByName(String name) {
    return _dataAndPlots.data
        .firstWhere((element) => element.name == name)
        .series;
  }
}
