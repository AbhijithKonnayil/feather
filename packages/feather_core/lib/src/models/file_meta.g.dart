// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileMeta _$FileMetaFromJson(Map<String, dynamic> json) => FileMeta(
  path: json['path'] as String,
  type: json['type'] as String?,
  target: json['target'] as String?,
  isExternal: json['isExternal'] as bool? ?? false,
);

Map<String, dynamic> _$FileMetaToJson(FileMeta instance) => <String, dynamic>{
  'path': instance.path,
  'type': instance.type,
  'target': instance.target,
  'isExternal': instance.isExternal,
};
