import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_models/wt_models.dart';

part 'dinosaur.freezed.dart';
part 'dinosaur.g.dart';

@freezed
class Dinosaur with _$Dinosaur {
  static final _titles = [
    'name',
    'diet',
    'period',
    'livedIn',
    'type',
    'length',
    'taxonomy',
    'namedBy',
    'species',
    'link',
  ];

  static final from = ToModelFrom(json: _Dinosaur.fromJson, titles: _titles);
  static final to = FromModelTo(titles: _titles);

  Dinosaur._();

  factory Dinosaur({
    @Default('') @JsonKey(name: 'name') String name,
    @Default('') @JsonKey(name: 'diet') String diet,
    @Default('') @JsonKey(name: 'period') String period,
    @Default('') @JsonKey(name: 'livedIn') String livedIn,
    @Default('') @JsonKey(name: 'type') String type,
    @Default('') @JsonKey(name: 'length') String length,
    @Default('') @JsonKey(name: 'taxonomy') String taxonomy,
    @Default('') @JsonKey(name: 'namedBy') String namedBy,
    @Default('') @JsonKey(name: 'species') String species,
    @Default('') @JsonKey(name: 'link') String link,
  }) = _Dinosaur;

  factory Dinosaur.fromJson(Map<String, dynamic> json) => _$DinosaurFromJson(json);
}
