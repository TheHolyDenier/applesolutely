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
  final _callingNameController = TextEditingController();
  final _familyNameController = TextEditingController();
  final List<TextEditingController> _alsoKnownControllers =
      List.empty(growable: true);
  final _summaryController = TextEditingController();
  bool _isFavorite = false;
  String _base64Image = '';
  String _base64ImageFirst = '';
  String _base64ImageSecond = '';
  String _base64ImageThird = '';

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
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        // if (value == null || value.isEmpty) {
                        //   return 'error_input_no_text'.tr;
                        // }
                        // if (value.length < 2) {
                        //   return 'error_input_length'.tr;
                        // }
                        // if (BoxService.dictionaries.values.any(
                        //         (element) => element.name == value.trim()) &&
                        //     (widget.dictionary != null &&
                        //         widget.dictionary!.name != value.trim())) {
                        //   return 'error_input_dictionary_name'.tr;
                        // }
                        return null;
                      },
                      controller: _callingNameController,
                      decoration: InputDecoration(
                          labelText: 'item_calling_name'.tr,
                          hintText: 'item_calling_name_hint'.tr),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _familyNameController,
                      decoration: InputDecoration(
                          labelText: 'item_family_name'.tr,
                          hintText: 'item_family_name_hint'.tr),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'item_favorite'.tr,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Switch(
                          value: _isFavorite,
                          onChanged: (bool value) {
                            _isFavorite = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _summaryController,
                      decoration:
                          InputDecoration(labelText: 'item_family_summary'.tr),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text('item_pictures'.tr,
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: PickImageWidget(
                            (String? str) => _base64ImageFirst = str ?? '',
                            inline: true,
                          ),
                        ),
                        Expanded(
                          child: PickImageWidget(
                            (String? str) => _base64ImageSecond = str ?? '',
                            inline: true,
                          ),
                        ),
                        Expanded(
                          child: PickImageWidget(
                            (String? str) => _base64ImageThird = str ?? '',
                            inline: true,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
