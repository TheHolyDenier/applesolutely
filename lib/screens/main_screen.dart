import 'package:applesolutely/models/dictionary_model.dart';
import 'package:applesolutely/services/box_service.dart';
import 'package:applesolutely/widgets/dictionary_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> toRemove = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    BoxService.openDictionaryList();

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
                    onPressed: () => _removeDictionaries(),
                    icon: const Icon(Icons.delete_forever_outlined),
                  )
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final Dictionary d = BoxService.dictionaries.getAt(index)!;
                  return GestureDetector(
                    onLongPress: () =>
                        _addRemoveDictionaryFromRemoveList(index),
                    onTap: () {
                      if (toRemove.isNotEmpty) {
                        _addRemoveDictionaryFromRemoveList(index);
                      }
                    },
                    child: DictionaryTileWidget(d, toRemove.contains(d.key)),
                  );
                },
                childCount: BoxService.dictionaries.length,
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[Text('add new dictionary somehow')],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addRemoveDictionaryFromRemoveList(int index) {
    var d = BoxService.dictionaries.getAt(index)!.key;
    toRemove.contains(d) ? toRemove.remove(d) : toRemove.add(d);
    setState(() {});
  }

  void _removeDictionaries() {
    BoxService.removeDictionaries(toRemove);
    setState(() {});
  }
}
