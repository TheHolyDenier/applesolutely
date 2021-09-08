import 'package:applesolutely/services/converter_service.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String? image;
  final Color? color;
  const HeaderWidget({Key? key, this.image, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image != null && image!.isNotEmpty
        ? Image.memory(ConverterService.base64ToImage(image!),
            fit: BoxFit.cover)
        : Container();
  }
}
