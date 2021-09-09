import 'dart:io';

import 'package:applesolutely/services/converter_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:images_picker/images_picker.dart';

import 'header_widget.dart';

typedef StringNullCallback = void Function(String? str);

class PickImageWidget extends StatefulWidget {
  final StringNullCallback updateImageCallback;
  final String? image;
  final bool inline;
  const PickImageWidget(this.updateImageCallback,
      {Key? key, this.image, this.inline = false})
      : super(key: key);

  @override
  _PickImageWidgetState createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  String _base64Image = '';
  @override
  void initState() {
    super.initState();
    if (widget.image != null && widget.image!.isNotEmpty) {
      _base64Image = widget.image!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.inline ? _widgetInLine() : _widgetHeader(context);
  }

  Widget _widgetInLine() {
    final imageSize = MediaQuery.of(context).size.width / 3 - 20;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.secondary),
              height: imageSize,
              width: imageSize,
              child: HeaderWidget(image: _base64Image),
            ),
            Positioned(
              bottom: 0,
              top: 0,
              right: 0,
              left: 0,
              child: Container(color: const Color.fromARGB(100, 250, 250, 250)),
            ),
            Positioned(
              bottom: 0,
              top: 0,
              right: 0,
              left: 0,
              child: IconButton(
                  icon: const Icon(Icons.delete_outlined),
                  onPressed: _deletePicture,
                  color: Theme.of(context).colorScheme.onSecondary),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: _pickPicture,
              icon: const Icon(Icons.add_photo_alternate_outlined),
            ),
            IconButton(
              onPressed: _takePicture,
              icon: const Icon(Icons.add_a_photo_outlined),
            ),
          ],
        ),
      ],
    );
  }

  Widget _widgetHeader(BuildContext context) => Column(
        children: [
          Container(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.secondary),
            height: MediaQuery.of(context).size.width / 4 * 3,
            width: MediaQuery.of(context).size.width,
            child: HeaderWidget(image: _base64Image),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: _pickPicture,
                child: Row(
                  children: [
                    const Icon(Icons.add_photo_alternate_outlined),
                    Text('pick_picture'.tr)
                  ],
                ),
              ),
              TextButton(
                onPressed: _takePicture,
                child: Row(
                  children: [
                    const Icon(Icons.add_a_photo_outlined),
                    Text('take_picture'.tr)
                  ],
                ),
              ),
              if (_base64Image.isNotEmpty)
                TextButton(
                  onPressed: _deletePicture,
                  child: Row(
                    children: [
                      const Icon(Icons.delete_outlined),
                      Text('delete_picture'.tr)
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      );

  final double _quality = 0.4;
  void _pickPicture() async {
    List<Media>? res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
      quality: _quality,
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio.wh4x3,
        cropType: CropType.rect,
      ),
    );
    _processImage(res);
  }

  void _takePicture() async {
    List<Media>? res = await ImagesPicker.openCamera(
      pickType: PickType.image,
      quality: _quality,
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio.wh4x3,
        cropType: CropType.rect,
      ),
    );
    _processImage(res);
  }

  void _processImage(List<Media>? res) async {
    if (res != null) {
      _base64Image = ConverterService.imageToBase64String(File(res[0].path));
      widget.updateImageCallback(_base64Image);
      setState(() {});
    }
  }

  void _deletePicture() {
    _base64Image = '';
    widget.updateImageCallback(_base64Image);
    setState(() {});
  }
}
