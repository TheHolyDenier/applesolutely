import 'package:applesolutely/models/dictionary_model.dart';
import 'package:applesolutely/services/colors_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: Hero(
                    tag: widget.dictionary.key,
                    child: AvatarWidget(widget.dictionary.name,
                        image: widget.dictionary.image,
                        color: UtilsService
                            .dictionaryColors[widget.dictionary.key]),
                  ),
                ),
                title: Text(widget.dictionary.name,
                    style: Theme.of(context).textTheme.headline5,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                subtitle: widget.dictionary.summary != null
                    ? Text(widget.dictionary.summary!)
                    : null,
                trailing: IconButton(
                  onPressed: widget.selected
                      ? null
                      : () {
                          widget.dictionary.isFavorite =
                              !widget.dictionary.isFavorite;
                          widget.dictionary.save();
                          setState(() {});
                        },
                  icon: Icon(
                      widget.dictionary.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: widget.dictionary.isFavorite
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.primaryVariant),
                ),
                contentPadding: const EdgeInsets.all(10.0),
                selected: widget.selected,
                selectedTileColor:
                    Theme.of(context).colorScheme.primary.withAlpha(40),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
