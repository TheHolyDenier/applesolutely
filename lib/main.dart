import 'package:applesolutely/models/collection_model.dart';
import 'package:applesolutely/models/dictionary_model.dart';
import 'package:applesolutely/models/element_model.dart';
import 'package:applesolutely/models/item_model.dart';
import 'package:applesolutely/screens/dictionary_screen.dart';
import 'package:applesolutely/screens/main_screen.dart';
import 'package:applesolutely/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(DictionaryAdapter())
    ..registerAdapter(ItemAdapter())
    ..registerAdapter(CollectionAdapter())
    ..registerAdapter(ElementAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Applesolutely',
      theme: ThemeService.get(),
      home: FutureBuilder(
        future: Hive.openBox<Dictionary>('dictionaries'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.hasError
                ? Text(snapshot.error.toString())
                : const MainScreen();
          }
          return const Scaffold(
            body: Text('I am loading'),
          );
        },
      ),
      routes: {
        MainScreen.route: (context) => const MainScreen(),
        DictionaryScreen.route: (context) => const DictionaryScreen(),
      },
    );
  }
}
