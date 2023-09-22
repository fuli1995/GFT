import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

Future<File> _getLogFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File('${directory.path}/my_app_logs.txt');
}

Future<bool> cleanLogFile() async {
  File file = await _getLogFile();
  if (await file.exists()) {
    String content = await file.readAsString();
    if (content.trim().isEmpty) {
      return true;
    }
  }
  await file.delete();
  return false;
}

class LoggerService {
  late Logger logger;

  LoggerService() {
    _initLogger();
  }

  Future<void> _initLogger() async {
    final file = await _getLogFile();

    logger = Logger(
      level: Level.verbose,
      printer: PrettyPrinter(printTime: true),
      output: FileOutput(file: file),
      // output: null,
    );
  }
}

class LoggerController extends GetxController {
  final LoggerService loggerService = LoggerService();
  Logger get logger => loggerService.logger;
}
