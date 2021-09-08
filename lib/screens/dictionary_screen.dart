import 'package:applesolutely/models/dictionary_model.dart';
import 'package:applesolutely/services/colors_service.dart';
import 'package:applesolutely/widgets/header_widget.dart';
import 'package:flutter/material.dart';

import 'dictionary_form_widget.dart';

class DictionaryScreen extends StatefulWidget {
  static const route = '/dictionary';
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  late Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    dictionary = ModalRoute.of(context)!.settings.arguments as Dictionary;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: MediaQuery.of(context).size.width / 4 * 3,
              backgroundColor: UtilsService.dictionaryColors[dictionary.key],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(dictionary.name),
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                background: Hero(
                    tag: dictionary.key,
                    child: HeaderWidget(
                        image: dictionary.image,
                        color: UtilsService.dictionaryColors[dictionary.key])),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: _openEdit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editDictionary(Dictionary newDictionary) {
    dictionary.updateDictionary(newDictionary);
    dictionary.save();
    setState(() {});
    Navigator.pop(context);
  }

  void _openEdit() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              DictionaryFormScreen(_editDictionary, dictionary: dictionary),
          fullscreenDialog: true),
    );
  }
}
