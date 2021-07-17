import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../models/dictionary_model.dart';
import '../widgets/dictionary_tile_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Box<Dictionary> dictionaries;
  List<dynamic> toRemove = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    dictionaries = Hive.box<Dictionary>('dictionaries');
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
                onPressed: () => removeDictionaries(),
                icon: const Icon(Icons.delete_forever_outlined),
              )
          ],
        ),
        body: Column(
          children: [
            ElevatedButton(
              child: const Text('New Dictionary'),
              onPressed: () => addDictionary(),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: dictionaries.length,
                itemBuilder: (BuildContext context, int index) {
                  final Dictionary d = dictionaries.getAt(index)!;
                  return GestureDetector(
                    onLongPress: () => addRemoveDictionaryFromRemoveList(index),
                    onTap: () {
                      if (toRemove.isNotEmpty) {
                        addRemoveDictionaryFromRemoveList(index);
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

  void addRemoveDictionaryFromRemoveList(int index) {
    var d = dictionaries.getAt(index)!.key;
    toRemove.contains(d) ? toRemove.remove(d) : toRemove.add(d);
    setState(() {});
  }

  void addDictionary() {
    var d = Dictionary('Londres nocturno');
    dictionaries.add(d);
    setState(() {});
  }

  void removeDictionaries() {
    dictionaries.deleteAll(toRemove);
    toRemove.clear();
    setState(() {});
  }
}
