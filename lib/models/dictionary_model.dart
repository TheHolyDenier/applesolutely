import 'package:hive/hive.dart';

part 'dictionary_model.g.dart';

@HiveType(typeId: 0)
class Dictionary extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String? image;
  @HiveField(2)
  String? summary;
  @HiveField(3)
  bool isFavorite;

  Dictionary(this.name, {this.image, this.summary, this.isFavorite = false});
}
