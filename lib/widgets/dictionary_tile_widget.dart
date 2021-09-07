import 'package:applesolutely/services/colors_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/dictionary_model.dart';
import 'image_widget.dart';

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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: ImageWidget(widget.dictionary.name,
                        image: widget.dictionary.image,
                        color: UtilsService
                            .dictionaryColors[widget.dictionary.key]),
                  ),
                  title: Text(widget.dictionary.name,
                      style: Theme.of(context).textTheme.headline5,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
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
