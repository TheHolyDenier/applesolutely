// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'element_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ElementAdapter extends TypeAdapter<Element> {
  @override
  final int typeId = 3;

  @override
  Element read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Element(
      fields[30] as String,
      content: fields[32] as String?,
      date: fields[33] as String?,
      order: fields[31] as int?,
      image: (fields[34] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Element obj) {
    writer
      ..writeByte(5)
      ..writeByte(30)
      ..write(obj.summary)
      ..writeByte(31)
      ..write(obj.order)
      ..writeByte(32)
      ..write(obj.content)
      ..writeByte(33)
      ..write(obj.date)
      ..writeByte(34)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ElementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
