import 'package:applesolutely/services/box_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef StringCallback = void Function(String str);

class DictionaryFormScreen extends StatefulWidget {
  static const route = '/new_dictionary';
  final StringCallback callback;
  const DictionaryFormScreen(this.callback, {Key? key}) : super(key: key);

  @override
  _DictionaryFormScreenState createState() => _DictionaryFormScreenState();
}

class _DictionaryFormScreenState extends State<DictionaryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dictionaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('New Dictionary'), actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.callback(_dictionaryController.text.trim());
              }
            },
            icon: const Icon(Icons.save_outlined),
          ),
        ]),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (value.length < 2) {
                        return 'Dictionaries\' names must be at least 2 characters';
                      }
                      if (BoxService.dictionaries.values
                          .any((element) => element.name == value.trim())) {
                        return 'A dictionary with the same name already exists';
                      }
                      return null;
                    },
                    controller: _dictionaryController,
                    decoration:
                        const InputDecoration(hintText: 'New dictionary name'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
