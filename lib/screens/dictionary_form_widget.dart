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
  final _dictionaryNameController = TextEditingController();
  final _dictionarySummaryController = TextEditingController();
  bool _isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('New Dictionary'), actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.callback(_dictionaryNameController.text.trim());
              }
            },
            icon: const Icon(Icons.save_outlined),
          ),
        ]),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: const BoxDecoration(color: Colors.red),
                      height: 300,
                      width: 300),
                  //TODO: BUTTONS TO UPLOAD IMAGE
                  const SizedBox(height: 10),
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
                    controller: _dictionaryNameController,
                    decoration: const InputDecoration(
                        hintText: 'It', labelText: 'Name'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _dictionarySummaryController,
                    decoration: const InputDecoration(
                      hintText: 'Written by SKing',
                      labelText: 'Summary',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mark as favorite',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Switch(
                        value: _isFavorite,
                        onChanged: (bool value) {
                          _isFavorite = value;
                          setState(() {});
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
