import 'package:applesolutely/models/dictionary_model.dart';
import 'package:applesolutely/services/box_service.dart';
import 'package:applesolutely/widgets/dictionary_tile_widget.dart';
import 'package:applesolutely/widgets/remove_action_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'dictionary_form_screen.dart';
import 'dictionary_screen.dart';

class MainScreen extends StatefulWidget {
  static const route = '/main';
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Dictionary> _dictionaries = List.empty(growable: true);
  List<dynamic> toRemove = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    BoxService.openDictionaryList();
    _dictionaries = BoxService.dictionaries.values.toList();
    _sortDictionaries();

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 160.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('title'.tr),
                background: Image.asset('assets/apples.png'),
              ),
              actions: [
                if (toRemove.isNotEmpty)
                  RemoveActionWidget(toRemove.length, _removeDictionaries),
                if (toRemove.isEmpty)
                  IconButton(
                      onPressed: _newDictionary,
                      icon: const Icon(Icons.add_outlined)),
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final Dictionary? d = _dictionaries[index];
                  return d != null
                      ? InkWell(
                          onLongPress: () =>
                              _addRemoveDictionaryFromRemoveList(index),
                          onTap: () {
                            if (toRemove.isNotEmpty) {
                              _addRemoveDictionaryFromRemoveList(index);
                            } else {
                              Navigator.pushNamed(
                                      context, DictionaryScreen.route,
                                      arguments: d)
                                  .then((_) => setState(() {
                                        _sortDictionaries();
                                      }));
                            }
                          },
                          child:
                              DictionaryTileWidget(d, toRemove.contains(d.key)),
                        )
                      : Container();
                },
                childCount: BoxService.countDictionaries(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _sortDictionaries() {
    _dictionaries.sort((a, b) {
      if (a.isFavorite == b.isFavorite) {
        return a.name.compareTo(b.name);
      }
      return a.isFavorite ? -1 : 1;
    });
  }

  void _addRemoveDictionaryFromRemoveList(int index) {
    var d = _dictionaries[index].key;
    toRemove.contains(d) ? toRemove.remove(d) : toRemove.add(d);
    setState(() {});
  }

  void _removeDictionaries() {
    BoxService.removeDictionaries(toRemove);
    setState(() {});
  }

  void _addDictionary(Dictionary dictionary) {
    BoxService.addDictionary(dictionary);
    setState(() {});
    Navigator.pop(context);
  }

  void _newDictionary() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => DictionaryFormScreen(_addDictionary),
        fullscreenDialog: true,
      ),
    );
  }
}
