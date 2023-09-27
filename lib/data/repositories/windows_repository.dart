import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher/watcher.dart';

import '../models/data.dart';

class WindowsRepository {
  late DataAndPlots _dataAndPlots;
  late StreamController<DataAndPlots> _eventStream;
  String? _currentPath;
  bool _hasData = false;

  Future<bool> hasData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _hasData = prefs.getBool("hasData") ?? false;
    _currentPath = prefs.getString("excel");
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("excel", path);
  }

  Future<String?> getPath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("reading json");
    var readJson = await rootBundle
        .loadString("assets/python/output/shared/workitems.json", cache: false);
    _dataAndPlots = dataAndPlotsFromJson(readJson);
    _hasData = true;
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
