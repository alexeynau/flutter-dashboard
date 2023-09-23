import '../../common/errors/exceptions.dart';

class Series {
  final String? name;
  final List<num> data;
  final List<String>? index = [];
  Series({this.name, required this.data, List<String>? index}) {
    if (index?.length != data.length) {
      index = [];
      // throw ModelException("index should be the same length as data");
    }
  }
}
