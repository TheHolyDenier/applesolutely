import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/dictionary_model.dart';
import '../services/box_service.dart';

class DictionaryFormWidget extends StatefulWidget {
  const DictionaryFormWidget({Key? key}) : super(key: key);

  @override
  _DictionaryFormWidgetState createState() => _DictionaryFormWidgetState();
}

class _DictionaryFormWidgetState extends State<DictionaryFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _dictionaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              stderr.writeln(
                  'tmp ${BoxService.dictionaries.values.any((element) => element.name == value.trim())}');
              if (BoxService.dictionaries.values
                  .any((element) => element.name == value.trim())) {
                return 'A dictionary with the same name already exists';
              }
              return null;
            },
            controller: _dictionaryController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BoxService.addDictionary(Dictionary(_dictionaryController.text.trim()));
                }
                  setState(() { });
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
