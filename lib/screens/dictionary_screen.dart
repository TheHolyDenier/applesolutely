import 'package:applesolutely/models/dictionary_model.dart';
import 'package:flutter/material.dart';

class DictionaryScreen extends StatefulWidget {
  static const route = '/dictionary';
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  @override
  Widget build(BuildContext context) {
    final dictionary = ModalRoute.of(context)!.settings.arguments as Dictionary;

    return Scaffold(
      appBar: AppBar(
        title: Text(dictionary.name),
      ),
    );
  }
}
