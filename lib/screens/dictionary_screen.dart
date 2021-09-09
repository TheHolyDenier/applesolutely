import 'package:applesolutely/models/dictionary_model.dart';
import 'package:applesolutely/models/item_model.dart';
import 'package:applesolutely/services/box_service.dart';
import 'package:applesolutely/services/colors_service.dart';
import 'package:applesolutely/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'dictionary_form_screen.dart';
import 'item_form_screen.dart';

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

    return FutureBuilder(
      future: Hive.openBox<Item>(dictionary.name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.hasError
              ? Text(snapshot.error.toString())
              : _getWidget(context);
        }
        return const Scaffold(
          body: Text('I am loading'),
        );
      },
    );
  }

  late List<Item> items;
  SafeArea _getWidget(BuildContext context) {
    BoxService.openDictionary(dictionary.name);
    items = BoxService.activeDictionary.values.toList();
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
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _openNewItem,
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

  void _newItem(Item item) {
    // dictionary.updateDictionary(newDictionary);
    // dictionary.save();
    // setState(() {});
    Navigator.pop(context);
  }

  void _openNewItem() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
          builder: (BuildContext context) => ItemFormScreen(_newItem),
          fullscreenDialog: true),
    );
  }
}
