import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/dictionary_model.dart';

class DictionaryTileWidget extends StatefulWidget {
  final Dictionary dictionary;
  final bool selected;
  const DictionaryTileWidget(this.dictionary, this.selected, {Key? key})
      : super(key: key);

  @override
  State<DictionaryTileWidget> createState() => _DictionaryTileWidgetState();
}

class _DictionaryTileWidgetState extends State<DictionaryTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.album),
                title: Text(widget.dictionary.name,
                    style: Theme.of(context).textTheme.headline4),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              ),
            ],
          ),
          if (widget.selected)
            const Positioned(
              child: Icon(Icons.check_box),
              right: 8,
              top: 8,
            )
        ],
      ),
    );
  }
}
