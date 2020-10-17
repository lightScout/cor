// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preference.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPreferenceAdapter extends TypeAdapter<UserPreference> {
  @override
  UserPreference read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPreference(
      preferenceName: fields[0] as String,
      state: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserPreference obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.preferenceName)
      ..writeByte(1)
      ..write(obj.state);
  }

  @override
  // TODO: implement typeId
  int get typeId => throw UnimplementedError();
}
