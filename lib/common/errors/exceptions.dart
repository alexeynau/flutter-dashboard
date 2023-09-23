class FileException implements Exception {
  final String cause;
  FileException(this.cause);
}

class ModelException implements Exception {
  final String cause;
  ModelException(this.cause);
}
