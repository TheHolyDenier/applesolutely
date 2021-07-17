import 'package:hive/hive.dart';

import './collection_model.dart';

part 'item_model.g.dart';

@HiveType(typeId: 1)
class Item extends HiveObject {
  @HiveField(10)
  String callingName;
  @HiveField(11)
  String? prosoponym;
  @HiveField(12)
  List<String>? alsoKnownAs;
  @HiveField(13)
  String? summary;
  @HiveField(14)
  List<Collection>? collections;
  @HiveField(15)
  List<String>? images;

  Item(this.callingName, { this.prosoponym, this.alsoKnownAs, this.summary, this.collections, this.images});
}