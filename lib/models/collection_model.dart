import 'package:hive/hive.dart';
import './element_model.dart';

part 'collection_model.g.dart';

@HiveType(typeId: 2)
class Collection extends HiveObject {
  @HiveField(20)
  String name;
  @HiveField(21)
  int order;
  @HiveField(22)
  List<Element>? elements;

  Collection(this.name, {this.order = 99, this.elements});
}
