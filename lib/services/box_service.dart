import 'package:hive/hive.dart';
import '../models/dictionary_model.dart';
import './colors_service.dart';

class BoxService {
  static late Box<Dictionary> dictionaries;

  static void openDictionaryList() {
    BoxService.dictionaries = Hive.box<Dictionary>('dictionaries');
    for (var i = 0; i < dictionaries.length; i++) {
      UtilsService.addDictionaryColor(dictionaries.getAt(i)!.key);
    }
  }

  static addDictionary(Dictionary d) {
    BoxService.dictionaries.add(d);
    UtilsService.addDictionaryColor(d.key);
  }

  static removeDictionaries(List<dynamic> toRemove) {
    BoxService.dictionaries.deleteAll(toRemove);
    toRemove.clear();
  }
}
