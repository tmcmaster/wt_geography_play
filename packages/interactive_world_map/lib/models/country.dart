import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_models/wt_models.dart';

part 'country.freezed.dart';
part 'country.g.dart';

@freezed
class Country with _$Country {
  static final from = ToModelFrom(json: Country.fromJson, titles: _titles);
  static final to = FromModelTo(titles: _titles);

  static final _titles = [
    'id',
    'name',
    'capital',
    'code',
    'continent',
    'longitude',
    'latitude',
  ];

  Country._();

  factory Country({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'capital') @Default('') String capital,
    @JsonKey(name: 'code') @Default('') String code,
    @JsonKey(name: 'continent') @Default('') String continent,
    @JsonKey(name: 'longitude') @Default(0.0) num longitude,
    @JsonKey(name: 'latitude') @Default(0.0) num latitude,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
}
