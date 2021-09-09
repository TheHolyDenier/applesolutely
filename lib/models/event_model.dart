import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class Event extends HiveObject {
  @HiveField(41)
  String idItem;
  @HiveField(42)
  String idCollection;
  @HiveField(43)
  String idElement;

  Event(
      {required this.idItem,
      required this.idCollection,
      required this.idElement});
}
