import 'dart:io';

import 'package:applesolutely/models/item_model.dart';
import 'package:applesolutely/services/converter_service.dart';
import 'package:applesolutely/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:images_picker/images_picker.dart';

typedef ItemCallback = void Function(Item d);

class ItemFormScreen extends StatefulWidget {
  static const route = '/new_item';
  final ItemCallback callback;
  final Item? item;
  const ItemFormScreen(this.callback, {Key? key, this.item}) : super(key: key);

  @override
  _ItemFormScreenState createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _base64Image = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(widget.item != null ? 'edit_item'.tr : 'new_item'.tr),
            actions: [
              IconButton(
                onPressed: () {
                  //TODO: SAVE
                  // if (_formKey.currentState!.validate()) {
                  //   final Dictionary d = widget.dictionary != null
                  //       ? _updateDictionary()
                  //       : _newDictionary();
                  //   widget.callback(d);
                  // }
                },
                icon: const Icon(Icons.save_outlined),
              ),
            ]),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary),
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
            ]),
          ),
        ),
      ),
    );
  }

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
      setState(() {
        _base64Image = ConverterService.imageToBase64String(File(res[0].path));
      });
    }
  }

  void _deletePicture() {
    _base64Image = '';
    setState(() {});
  }
}
