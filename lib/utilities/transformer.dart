import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<File> saveByteDataToFile(ByteData byteData) async {
  Directory? directory = await getTemporaryDirectory(); // 获取临时目录路径
  String filePath = '${directory.path}/file.png'; // 文件保存路径

  final buffer = byteData.buffer;
  return await File(filePath).writeAsBytes(
      buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
}
