import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/dictionary_model.dart';
import '../services/colors_service.dart';

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
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          left: 0,
          child: Container(
            color: UtilsService.dictionaryColors[widget.dictionary.key],
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(widget.dictionary.name,
                    style: Theme.of(context).textTheme.headline1),
              ),
            ),
          ),
        ),
        if (widget.selected)
          const Positioned(
            child: Icon(Icons.check_box),
            right: 0,
            top: 0,
          )
      ],
    );
  }
}
