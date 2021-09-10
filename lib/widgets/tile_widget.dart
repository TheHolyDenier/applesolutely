import 'package:applesolutely/models/tile_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'image_widget.dart';

typedef VoidCallback = Function();

class TileWidget extends StatefulWidget {
  final TileInfoModel tileInfo;
  final bool selected;
  final VoidCallback callback;
  final Color color;
  const TileWidget(this.tileInfo, this.selected,
      {Key? key, required this.callback, required this.color})
      : super(key: key);

  @override
  State<TileWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> {
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
                    tag: widget.tileInfo.name,
                    child: AvatarWidget(widget.tileInfo.name,
                        image: widget.tileInfo.image, color: widget.color),
                  ),
                ),
                title: Text(widget.tileInfo.name,
                    style: Theme.of(context).textTheme.headline5,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                subtitle: widget.tileInfo.summary != null
                    ? Text(widget.tileInfo.summary!)
                    : null,
                trailing: IconButton(
                  onPressed: widget.selected
                      ? null
                      : () {
                          widget.callback();
                          // widget.tileInfo.isFavorite =
                          //     !widget.tileInfo.isFavorite;
                          // widget.tileInfo.save();
                          // setState(() {});
                        },
                  icon: Icon(
                      widget.tileInfo.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: widget.tileInfo.isFavorite
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
