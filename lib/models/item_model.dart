import 'package:hive/hive.dart';

import './collection_model.dart';

part 'item_model.g.dart';

@HiveType(typeId: 1)
class Item extends HiveObject {
  @HiveField(10)
  String? callingName;
  @HiveField(11)
  bool isFavorite;
  @HiveField(12)
  String? familyName;
  @HiveField(13)
  List<String>? alsoKnownAs;
  @HiveField(14)
  String? summary;
  @HiveField(15)
  List<Collection>? collections;
  @HiveField(16)
  List<String>? images;
  @HiveField(17)
  List<int>? relatedItems;
  @HiveField(18)
  List<String>? tags;
  Item(
      {this.callingName,
      this.isFavorite = false,
      this.familyName,
      this.alsoKnownAs,
      this.images,
      this.summary,
      this.relatedItems,
      this.tags});

  void update(Item newItem) {
    if (callingName != newItem.callingName) {
      callingName = newItem.callingName;
    }
    if (isFavorite != newItem.isFavorite) {
      isFavorite = newItem.isFavorite;
    }
    if (familyName != newItem.familyName) {
      familyName = newItem.familyName;
    }
    if (alsoKnownAs != newItem.alsoKnownAs) {
      alsoKnownAs = newItem.alsoKnownAs;
    }
    if (images != newItem.images) {
      images = newItem.images;
    }
    if (summary != newItem.summary) {
      summary = newItem.summary;
    }
    if (relatedItems != newItem.relatedItems) {
      relatedItems = newItem.relatedItems;
    }
    if (tags != newItem.tags) {
      tags = newItem.tags;
    }
  }
}
