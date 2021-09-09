import 'package:applesolutely/models/item_model.dart';
import 'package:applesolutely/widgets/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

typedef ItemCallback = void Function(Item d);

class ItemFormScreen extends StatefulWidget {
  static const route = '/new_item';
  final ItemCallback callback;
  final Item? item;
  const ItemFormScreen(this.callback, {Key? key, this.item}) : super(key: key);

  @override
  _ItemFormScreenState createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _base64Image = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(widget.item != null ? 'edit_item'.tr : 'new_item'.tr),
            actions: [
              IconButton(
                onPressed: () {
                  //TODO: SAVE
                  // if (_formKey.currentState!.validate()) {
                  //   final Dictionary d = widget.dictionary != null
                  //       ? _updateDictionary()
                  //       : _newDictionary();
                  //   widget.callback(d);
                  // }
                },
                icon: const Icon(Icons.save_outlined),
              ),
            ]),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              PickImageWidget((String? str) {
                _updateImage(str, _base64Image);
              })
            ]),
          ),
        ),
      ),
    );
  }

  void _updateImage(String? str, String variable) {
    variable = str ?? '';
    setState(() {});
  }
}
