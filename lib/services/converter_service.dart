import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class ConverterService {
  static String imageToBase64String(File f) =>
      base64Encode(f.readAsBytesSync());

  static Uint8List base64ToImage(String base64) =>
      const Base64Decoder().convert(base64);

  static Uint8List imageToBase64Int(File f) =>
      Uint8List.fromList(f.readAsBytesSync());
}
