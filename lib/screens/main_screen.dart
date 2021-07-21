import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/dictionary_model.dart';
import '../widgets/dictionary_tile_widget.dart';
import '../widgets/dictionary_form_widget.dart';
import '../services/box_service.dart';

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
        appBar: AppBar(
          title: const Text('Your dictionaries'),
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
        body: Column(
          children: [
            const DictionaryFormWidget(),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: BoxService.dictionaries.length,
                itemBuilder: (BuildContext context, int index) {
                  final Dictionary d = BoxService.dictionaries.getAt(index)!;
                  return GestureDetector(
                    onLongPress: () => _addRemoveDictionaryFromRemoveList(index),
                    onTap: () {
                      if (toRemove.isNotEmpty) {
                        _addRemoveDictionaryFromRemoveList(index);
                      }
                    },
                    child: DictionaryTileWidget(d, toRemove.contains(d.key)),
                  );
                },
              ),
            )
          ],
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
