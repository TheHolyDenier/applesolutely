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
      fields[10] as String,
      prosoponym: fields[11] as String?,
      alsoKnownAs: (fields[12] as List?)?.cast<String>(),
      summary: fields[13] as String?,
      collections: (fields[14] as List?)?.cast<Collection>(),
      images: (fields[15] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(6)
      ..writeByte(10)
      ..write(obj.callingName)
      ..writeByte(11)
      ..write(obj.prosoponym)
      ..writeByte(12)
      ..write(obj.alsoKnownAs)
      ..writeByte(13)
      ..write(obj.summary)
      ..writeByte(14)
      ..write(obj.collections)
      ..writeByte(15)
      ..write(obj.images);
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
