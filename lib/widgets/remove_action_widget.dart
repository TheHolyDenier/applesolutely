import 'package:flutter/material.dart';

class RemoveActionWidget extends StatelessWidget {
  final int length;
  final void Function() callback;
  const RemoveActionWidget(this.length, this.callback, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Center(
          child: Text(
            '$length',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        IconButton(
          onPressed: callback,
          icon: const Icon(Icons.delete_forever_outlined),
        ),
      ],
    );
  }
}
