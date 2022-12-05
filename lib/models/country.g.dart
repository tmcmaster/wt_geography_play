// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Country _$$_CountryFromJson(Map<String, dynamic> json) => _$_Country(
      id: json['id'] as String,
      name: json['name'] as String,
      capital: json['capital'] as String? ?? '',
      code: json['code'] as String? ?? '',
      continent: json['continent'] as String? ?? '',
      longitude: json['longitude'] as num? ?? 0.0,
      latitude: json['latitude'] as num? ?? 0.0,
    );

Map<String, dynamic> _$$_CountryToJson(_$_Country instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'capital': instance.capital,
      'code': instance.code,
      'continent': instance.continent,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
