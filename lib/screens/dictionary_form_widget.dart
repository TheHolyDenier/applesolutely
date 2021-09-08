import 'dart:io';
import 'dart:typed_data';

import 'package:applesolutely/models/dictionary_model.dart';
import 'package:applesolutely/services/box_service.dart';
import 'package:applesolutely/services/converter_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:images_picker/images_picker.dart';

typedef DictionaryCallback = void Function(Dictionary d);

class DictionaryFormScreen extends StatefulWidget {
  static const route = '/new_dictionary';
  final DictionaryCallback callback;
  const DictionaryFormScreen(this.callback, {Key? key}) : super(key: key);

  @override
  _DictionaryFormScreenState createState() => _DictionaryFormScreenState();
}

class _DictionaryFormScreenState extends State<DictionaryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dictionaryNameController = TextEditingController();
  final _dictionarySummaryController = TextEditingController();
  bool _isFavorite = false;
  Uint8List? _bytes;
  String _base64Image = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('New Dictionary'), actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final Dictionary d = Dictionary(
                    _dictionaryNameController.text.trim(),
                    summary: _dictionarySummaryController.text.trim(),
                    isFavorite: _isFavorite,
                    image: _base64Image);
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
                      child: _bytes != null
                          ? Image.memory(_bytes!, fit: BoxFit.cover)
                          : Container()),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: _pickPicture,
                          child: Row(
                            children: const [
                              Icon(Icons.add_photo_alternate_outlined),
                              Text('Pick picture')
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: _takePicture,
                          child: Row(
                            children: const [
                              Icon(Icons.add_a_photo_outlined),
                              Text('Take picture')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (value.length < 2) {
                        return 'Dictionaries\' names must be at least 2 characters';
                      }
                      if (BoxService.dictionaries.values
                          .any((element) => element.name == value.trim())) {
                        return 'A dictionary with the same name already exists';
                      }
                      return null;
                    },
                    controller: _dictionaryNameController,
                    decoration: const InputDecoration(
                        hintText: 'It', labelText: 'Name'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _dictionarySummaryController,
                    decoration: const InputDecoration(
                      hintText: 'Written by SKing',
                      labelText: 'Summary',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mark as favorite',
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
      quality: 0.5,
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
      quality: 0.5,
      language: Language.English,
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio.wh4x3,
        cropType: CropType.rect,
      ),
    );
    _processImage(res);
  }

  void _processImage(List<Media>? res) {
    if (res != null) {
      final File f = File(res[0].path);
      _base64Image = ConverterService.imageToBase64String(f);
      _bytes = ConverterService.imageToBase64Int(f);
      setState(() {});
    }
  }
}
