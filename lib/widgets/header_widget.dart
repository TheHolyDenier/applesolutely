import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String? image;
  final Color? color;
  const HeaderWidget({Key? key, this.image, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: image != null && image!.isNotEmpty
          ? Image.network(
              "https://images.unsplash.com/photo-1547721064-da6cfb341d50")
          : Container(),
    );
  }
}
