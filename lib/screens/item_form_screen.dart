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
  final _formKeyTags = GlobalKey<FormState>();
  final List<String> _tags = List.empty(growable: true);
  final _tagsController = TextEditingController();
  final _callingNameController = TextEditingController();
  final _familyNameController = TextEditingController();
  final List<TextEditingController> _alsoKnownControllers =
      List.empty(growable: true);
  final _summaryController = TextEditingController();
  bool _isFavorite = false;
  final List<String> _base64Images = ['', '', '', ''];

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _extractItemValues(widget.item!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(widget.item != null ? 'edit_item'.tr : 'new_item'.tr),
            actions: [
              IconButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final Item i =
                        widget.item != null ? _updateItem() : _newItem();
                    widget.callback(i);
                  }
                },
                icon: const Icon(Icons.save_outlined),
              ),
            ]),
        body: SingleChildScrollView(
          child: Column(children: [
            PickImageWidget((String? str) {
              _base64Images[0] = str ?? '';
              setState(() {});
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKeyTags,
                child: Column(
                  children: [
                    if (_tags.isNotEmpty)
                      Wrap(
                        spacing: 3.0,
                        children: [
                          for (var tag in _tags)
                            InputChip(
                                deleteIcon:
                                    const Icon(Icons.remove_circle_outline),
                                label: Text(tag.toUpperCase()),
                                onDeleted: () {
                                  _tags.remove(tag);
                                  setState(() {});
                                }),
                        ],
                      ),
                    Row(children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (_tags.contains(value)) {
                              return 'item_tag_error'.tr;
                            }
                            return null;
                          },
                          controller: _tagsController,
                          decoration: InputDecoration(
                              labelText: 'item_tags'.tr,
                              hintText: 'item_tags_hint'.tr),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (_formKeyTags.currentState!.validate()) {
                            _tags.add(_tagsController.text.trim());
                            _tagsController.clear();
                            setState(() {});
                          }
                        },
                      )
                    ]),
                    const SizedBox(height: 10),
                    Form(
                        key: _formKey,
                        child: Column(children: [
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
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('item_also_known_as'.tr,
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                IconButton(
                                  onPressed: () {
                                    _alsoKnownControllers
                                        .add(TextEditingController());
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.add),
                                )
                              ],
                            ),
                          ),
                          for (var controller in _alsoKnownControllers)
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: controller,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete_outline,
                                      color:
                                          Theme.of(context).colorScheme.error),
                                  onPressed: () {
                                    _alsoKnownControllers.remove(controller);
                                    setState(() {});
                                  },
                                )
                              ],
                            ),
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
                                InputDecoration(labelText: 'item_summary'.tr),
                          ),
                        ])),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text('item_pictures'.tr,
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var i = 1; i < _base64Images.length; i++)
                          Expanded(
                            child: PickImageWidget(
                              (String? str) => _base64Images[i] = str ?? '',
                              inline: true,
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Item _updateItem() {
    final Item i = _newItem();
    widget.item!.update(i);
    return widget.item!;
  }

  Item _newItem() => Item(
      callingName: _callingNameController.text.trim(),
      familyName: _familyNameController.text.trim(),
      images: [
        for (var image in _base64Images)
          if (image.isNotEmpty) image
      ],
      alsoKnownAs: [
        for (var controller in _alsoKnownControllers) controller.text.trim()
      ],
      isFavorite: _isFavorite,
      summary: _summaryController.text.trim(),
      tags: _tags);

  void _extractItemValues(Item item) {
    _callingNameController.text = item.callingName ?? '';
    _familyNameController.text = item.familyName ?? '';
    _isFavorite = item.isFavorite;
    if (item.images != null && item.images!.isNotEmpty) {
      for (var i = 0; i < _base64Images.length; i++) {
        if (item.images![i].isNotEmpty) {
          _base64Images[i] = item.images![i];
        }
      }
    }
    if (item.alsoKnownAs != null && item.alsoKnownAs!.isNotEmpty) {
      for (var knownAs in item.alsoKnownAs!) {
        _alsoKnownControllers.add(TextEditingController(text: knownAs));
      }
    }
    _summaryController.text = item.summary ?? '';
  }
}
