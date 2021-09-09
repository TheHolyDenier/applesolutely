// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 1;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      callingName: fields[10] as String?,
      isFavorite: fields[11] as bool,
      familyName: fields[12] as String?,
      alsoKnownAs: (fields[13] as List?)?.cast<String>(),
      images: (fields[16] as List?)?.cast<String>(),
      summary: fields[14] as String?,
      relatedItems: (fields[17] as List?)?.cast<int>(),
      tags: (fields[18] as List?)?.cast<String>(),
    )..collections = (fields[15] as List?)?.cast<Collection>();
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(9)
      ..writeByte(10)
      ..write(obj.callingName)
      ..writeByte(11)
      ..write(obj.isFavorite)
      ..writeByte(12)
      ..write(obj.familyName)
      ..writeByte(13)
      ..write(obj.alsoKnownAs)
      ..writeByte(14)
      ..write(obj.summary)
      ..writeByte(15)
      ..write(obj.collections)
      ..writeByte(16)
      ..write(obj.images)
      ..writeByte(17)
      ..write(obj.relatedItems)
      ..writeByte(18)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
