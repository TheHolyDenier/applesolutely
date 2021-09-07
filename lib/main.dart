import 'package:applesolutely/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './models/collection_model.dart';
import './models/dictionary_model.dart';
import './models/element_model.dart';
import './models/item_model.dart';
import './screens/main_screen.dart';

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
        '/main': (context) => const MainScreen(),
      },
    );
  }
}
