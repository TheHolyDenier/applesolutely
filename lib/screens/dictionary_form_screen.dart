import 'package:applesolutely/models/dictionary_model.dart';
import 'package:applesolutely/services/box_service.dart';
import 'package:applesolutely/widgets/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

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
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                PickImageWidget(_updateImage, image: _base64Image),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'error_input_no_text'.tr;
                          }
                          if (value.length < 2) {
                            return 'error_input_length'.tr;
                          }
                          if (BoxService.dictionaries.values.any(
                                  (element) => element.name == value.trim()) &&
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
              ],
            ),
          ),
        ),
      ),
    );
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

  void _updateImage(String? str) {
    _base64Image = str ?? '';
    setState(() {});
  }
}
