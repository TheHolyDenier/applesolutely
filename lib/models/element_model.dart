import 'package:hive/hive.dart';

part 'element_model.g.dart';

@HiveType(typeId: 3)
class Element extends HiveObject {
  @HiveField(30)
  String summary;
  @HiveField(31)
  int? order;
  @HiveField(32)
  String? content;
  @HiveField(33)
  String? date;
  @HiveField(34)
  List<String>? image;

  Element(this.summary,
      {this.content,
      this.date,
      this.order,
      this.image});
}
