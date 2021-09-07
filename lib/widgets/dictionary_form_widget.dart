import 'package:applesolutely/services/box_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef StringCallback = void Function(String str);

class DictionaryFormWidget extends StatefulWidget {
  final StringCallback callback;
  const DictionaryFormWidget(this.callback, {Key? key}) : super(key: key);

  @override
  _DictionaryFormWidgetState createState() => _DictionaryFormWidgetState();
}

class _DictionaryFormWidgetState extends State<DictionaryFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _dictionaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.callback(_dictionaryController.text.trim());
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
