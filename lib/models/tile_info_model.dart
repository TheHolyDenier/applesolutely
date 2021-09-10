import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'dictionary_model.dart';
import 'item_model.dart';

class TileInfoModel {
  String? image;
  String name;
  String? summary;
  bool isFavorite;
  TileInfoModel(this.name,
      {this.image, this.summary, this.isFavorite = false}) {}

  static TileInfoModel fromDictionary(Dictionary d) => TileInfoModel(d.name,
      image: d.image ?? '', summary: d.summary, isFavorite: d.isFavorite);
  static TileInfoModel fromItem(Item i) {
    String fullName = '${i.familyName},';
    if (i.alsoKnownAs != null && i.alsoKnownAs!.isNotEmpty) {
      fullName += ' ${'open_quote'.tr}${i.alsoKnownAs![0]}${'close_quote'.tr}';
    }
    fullName += ' ${i.callingName ?? ''}';
    return TileInfoModel(fullName.trim(),
        image: i.images?[0], summary: i.summary, isFavorite: i.isFavorite);
  }
}
