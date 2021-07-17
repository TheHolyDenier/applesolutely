import 'package:hive/hive.dart';

import './item_model.dart';

part 'dictionary_model.g.dart';

@HiveType(typeId: 0)
class Dictionary extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String? image;

  Dictionary(this.name, {this.image});
}
