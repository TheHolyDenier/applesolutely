import 'package:applesolutely/models/dictionary_model.dart';
import 'package:applesolutely/models/item_model.dart';
import 'package:applesolutely/models/tile_info_model.dart';
import 'package:applesolutely/services/box_service.dart';
import 'package:applesolutely/services/colors_service.dart';
import 'package:applesolutely/widgets/header_widget.dart';
import 'package:applesolutely/widgets/remove_action_widget.dart';
import 'package:applesolutely/widgets/tile_widget.dart';
import 'package:flutter/material.dart';

import 'dictionary_form_screen.dart';
import 'item_form_screen.dart';

class DictionaryScreen extends StatefulWidget {
  static const route = '/dictionary';
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  late Dictionary _dictionary;
  late List<Item> _items = List.empty(growable: true);
  late Color _color;
  List<dynamic> _toRemove = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _items = BoxService.activeDictionary.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    _dictionary = ModalRoute.of(context)!.settings.arguments as Dictionary;
    _color = UtilsService.dictionaryColors[_dictionary.key] ??
        UtilsService.genRandomColor();
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: MediaQuery.of(context).size.width / 4 * 3,
              backgroundColor: _color,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(_dictionary.name),
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                background: Hero(
                    tag: _dictionary.name,
                    child:
                        HeaderWidget(image: _dictionary.image, color: _color)),
              ),
              actions: [
                if (_toRemove.isNotEmpty)
                  RemoveActionWidget(_toRemove.length, _removeItems),
                if (_toRemove.isEmpty)
                  Wrap(children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: _openEdit,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _openNewItem,
                    ),
                  ]),
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final Item i = _items[index];
                  return TileWidget(TileInfoModel.fromItem(i), false,
                      color: _color, callback: () {
                    i.isFavorite = !i.isFavorite;
                    i.save();
                    setState(() {});
                  });
                  // return DictionaryTileWidget(),
                },
                childCount: _items.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _editDictionary(Dictionary newDictionary) {
    _dictionary.updateDictionary(newDictionary);
    _dictionary.save();
    setState(() {});
    Navigator.pop(context);
  }

  void _openEdit() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              DictionaryFormScreen(_editDictionary, dictionary: _dictionary),
          fullscreenDialog: true),
    );
  }

  void _newItem(Item item) {
    BoxService.addItem(item);
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

  void _removeItems() {
    //  TODO: remove items from database
  }
}
