import 'package:applesolutely/models/dictionary_model.dart';
import 'package:applesolutely/services/colors_service.dart';
import 'package:applesolutely/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class DictionaryScreen extends StatefulWidget {
  static const route = '/dictionary';
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  @override
  Widget build(BuildContext context) {
    final dictionary = ModalRoute.of(context)!.settings.arguments as Dictionary;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 160.0,
              backgroundColor: UtilsService.dictionaryColors[dictionary.key],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(dictionary.name),
                background:
                    Hero(tag: dictionary.key, child: const HeaderWidget()),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
