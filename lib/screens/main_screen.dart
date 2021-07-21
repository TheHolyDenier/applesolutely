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
    bool _pinned = true;
  bool _snap = false;
  bool _floating = false;


  @override
  Widget build(BuildContext context) {
    BoxService.openDictionaryList();

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
               pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 160.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('SliverAppBar'),
              background: FlutterLogo(),
            ),
            ),
            const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
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
                children: <Widget>[
                  const Text('pinned'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _pinned = val;
                      });
                    },
                    value: _pinned,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('snap'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _snap = val;
                        // Snapping only applies when the app bar is floating.
                        _floating = _floating || _snap;
                      });
                    },
                    value: _snap,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('floating'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _floating = val;
                        _snap = _snap && _floating;
                      });
                    },
                    value: _floating,
                  ),
                ],
              ),
            ],
          ),
      ),
        ),
      ),
      // child: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Your dictionaries'),
      //     actions: [
      //       if (toRemove.isNotEmpty)
      //         Center(
      //           child: Text(
      //             '${toRemove.length}',
      //             style: const TextStyle(
      //                 fontSize: 16, fontWeight: FontWeight.w500),
      //           ),
      //         ),
      //       if (toRemove.isNotEmpty)
      //         IconButton(
      //           onPressed: () => _removeDictionaries(),
      //           icon: const Icon(Icons.delete_forever_outlined),
      //         )
      //     ],
      //   ),
      //   body: Column(
      //     children: [
      //       const DictionaryFormWidget(),
      //       Expanded(
      //         child: GridView.builder(
      //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 4,
      //             childAspectRatio: 1,
      //             crossAxisSpacing: 5,
      //             mainAxisSpacing: 5,
      //           ),
      //           itemCount: BoxService.dictionaries.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             final Dictionary d = BoxService.dictionaries.getAt(index)!;
      //             return GestureDetector(
      //               onLongPress: () => _addRemoveDictionaryFromRemoveList(index),
      //               onTap: () {
      //                 if (toRemove.isNotEmpty) {
      //                   _addRemoveDictionaryFromRemoveList(index);
      //                 }
      //               },
      //               child: DictionaryTileWidget(d, toRemove.contains(d.key)),
      //             );
      //           },
      //         ),
      //       )
      //     ],
      //   ),
      // ),
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
