// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DictionaryAdapter extends TypeAdapter<Dictionary> {
  @override
  final int typeId = 0;

  @override
  Dictionary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dictionary(
      fields[0] as String,
      image: fields[1] as String?,
      summary: fields[2] as String?,
      isFavorite: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Dictionary obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.summary)
      ..writeByte(3)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DictionaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
