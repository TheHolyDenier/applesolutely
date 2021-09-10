import 'package:applesolutely/models/item_model.dart';
import 'package:hive/hive.dart';

import './colors_service.dart';
import '../models/dictionary_model.dart';

class BoxService {
  static late Box<Dictionary> dictionaries;
  static late Box<Item> activeDictionary;

  static void openDictionaryList() {
    BoxService.dictionaries = Hive.box<Dictionary>('dictionaries');
    for (var i = 0; i < dictionaries.length; i++) {
      UtilsService.addDictionaryColor(dictionaries.getAt(i)!.key);
    }
  }

  static void addDictionary(Dictionary d) {
    BoxService.dictionaries.add(d);
    UtilsService.addDictionaryColor(d.key);
  }

  static void removeDictionaries(List<dynamic> toRemove) {
    BoxService.dictionaries.deleteAll(toRemove);
    toRemove.clear();
  }

  static int countDictionaries() => BoxService.dictionaries.length;

  static void openDictionary(String dictionary) {
    if (!Hive.isBoxOpen(dictionary)) {
      Hive.openBox<Item>(dictionary);
    }
    BoxService.activeDictionary = Hive.box<Item>(dictionary);
  }

  static void addItem(Item item) {
    BoxService.activeDictionary.add(item);
  }

  static countItems() => BoxService.activeDictionary.length;
}
