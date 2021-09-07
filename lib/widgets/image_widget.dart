import 'package:applesolutely/services/colors_service.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String name;
  final String? image;
  final Color? color;
  const AvatarWidget(this.name, {Key? key, this.image, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: image != null && image!.isNotEmpty
          ? CircleAvatar(
              child: Image.network(
                  "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
            )
          : CircleAvatar(
              backgroundColor: color ?? UtilsService.genRandomColor(),
              child: Text(name.substring(0, 2).toUpperCase()),
            ),
    );
  }
}
