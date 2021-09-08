import 'package:applesolutely/services/converter_service.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String? image;
  final Color? color;
  const HeaderWidget({Key? key, this.image, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bytes = image != null && image!.isNotEmpty
        ? ConverterService.base64ToImage(image!)
        : null;
    return bytes != null ? Image.memory(bytes, fit: BoxFit.cover) : Container();
  }
}
