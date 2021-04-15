// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) {
  return ContactModel(
      year: json['year'] as String ?? '',
      name: json['name'] as String ?? '',
      isGraduation: json['isGraduation'] as String ?? '',
      phoneNumber: json['phoneNumber'] as String ?? '',
      field: json['field'] as String ?? '',
      skill: json['skill'] as String ?? '',
      keyword: json['keyword'] as String ?? '');
}

Map<String, dynamic> _$ContactModelToJson(ContactModel instance) =>
    <String, dynamic>{
      'year': instance.year,
      'name': instance.name,
      'isGraduation': instance.isGraduation,
      'phoneNumber': instance.phoneNumber,
      'field': instance.field,
      'skill': instance.skill,
      'keyword': instance.keyword
    };
