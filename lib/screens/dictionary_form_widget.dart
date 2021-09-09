import 'dart:io';

import 'package:applesolutely/models/dictionary_model.dart';
import 'package:applesolutely/services/box_service.dart';
import 'package:applesolutely/services/converter_service.dart';
import 'package:applesolutely/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:images_picker/images_picker.dart';

typedef DictionaryCallback = void Function(Dictionary d);

class DictionaryFormScreen extends StatefulWidget {
  static const route = '/new_dictionary';
  final DictionaryCallback callback;
  final Dictionary? dictionary;
  const DictionaryFormScreen(this.callback, {Key? key, this.dictionary})
      : super(key: key);

  @override
  _DictionaryFormScreenState createState() => _DictionaryFormScreenState();
}

class _DictionaryFormScreenState extends State<DictionaryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dictionaryNameController = TextEditingController();
  final _dictionarySummaryController = TextEditingController();
  bool _isFavorite = false;
  String _base64Image = '';

  @override
  void initState() {
    super.initState();
    if (widget.dictionary != null) {
      _extractDictionaryValues(widget.dictionary!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(widget.dictionary != null
                ? 'edit_dictionary'.tr
                : 'new_dictionary'.tr),
            actions: [
              IconButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final Dictionary d = widget.dictionary != null
                        ? _updateDictionary()
                        : _newDictionary();
                    widget.callback(d);
                  }
                },
                icon: const Icon(Icons.save_outlined),
              ),
            ]),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary),
                    height: MediaQuery.of(context).size.width / 4 * 3,
                    width: MediaQuery.of(context).size.width,
                    child: HeaderWidget(image: _base64Image),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          IconButton(
                            onPressed: _deletePicture,
                            icon: const Icon(Icons.delete),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'error_input_no_text'.tr;
                      }
                      if (value.length < 2) {
                        return 'error_input_length'.tr;
                      }
                      if (BoxService.dictionaries.values
                              .any((element) => element.name == value.trim()) &&
                          (widget.dictionary != null &&
                              widget.dictionary!.name != value.trim())) {
                        return 'error_input_dictionary_name'.tr;
                      }
                      return null;
                    },
                    controller: _dictionaryNameController,
                    decoration:
                        InputDecoration(labelText: 'dictionary_name'.tr),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _dictionarySummaryController,
                    decoration: InputDecoration(
                      labelText: 'dictionary_summary'.tr,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'dictionary_favorite'.tr,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Switch(
                        value: _isFavorite,
                        onChanged: (bool value) {
                          _isFavorite = value;
                          setState(() {});
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _pickPicture() async {
    List<Media>? res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
      quality: 0.1,
      language: Language.English,
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
      quality: 0.1,
      language: Language.English,
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

  Dictionary _newDictionary() =>
      Dictionary(_dictionaryNameController.text.trim(),
          summary: _dictionarySummaryController.text.trim(),
          isFavorite: _isFavorite,
          image: _base64Image);

  Dictionary _updateDictionary() =>
      widget.dictionary!.updateDictionary(_newDictionary());

  void _extractDictionaryValues(Dictionary d) {
    _dictionaryNameController.text = d.name;
    if (d.summary != null && d.summary!.isNotEmpty) {
      _dictionarySummaryController.text = d.summary!;
    }
    _isFavorite = d.isFavorite;
    if (d.image != null && d.image!.isNotEmpty) {
      _base64Image = d.image!;
    }
  }

  void _deletePicture() {
    _base64Image = '';
    setState(() {});
  }
}
