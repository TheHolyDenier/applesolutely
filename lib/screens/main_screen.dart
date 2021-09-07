import 'package:applesolutely/models/dictionary_model.dart';
import 'package:applesolutely/services/box_service.dart';
import 'package:applesolutely/widgets/dictionary_form_widget.dart';
import 'package:applesolutely/widgets/dictionary_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    _dictionaries = BoxService.getDictionaries().values.toList();
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
              flexibleSpace: const FlexibleSpaceBar(
                title: Text('Applesolutely'),
                background: FlutterLogo(),
              ),
              actions: [
                if (toRemove.isNotEmpty)
                  Center(
                    child: Text(
                      '${toRemove.length}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                if (toRemove.isNotEmpty)
                  IconButton(
                    onPressed: _removeDictionaries,
                    icon: const Icon(Icons.delete_forever_outlined),
                  ),
                if (!toRemove.isNotEmpty)
                  IconButton(
                      onPressed: _openBottomSheet,
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
                                  arguments: d);
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

  void _addDictionary(String dictionaryName) {
    BoxService.addDictionary(Dictionary(dictionaryName));
    setState(() {});
    Navigator.pop(context);
  }

  void _openBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: DictionaryFormWidget(_addDictionary),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        );
      },
    );
  }
}
