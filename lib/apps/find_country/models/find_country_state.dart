import 'package:freezed_annotation/freezed_annotation.dart';

part 'find_country_state.freezed.dart';
part 'find_country_state.g.dart';

@freezed
class FindCountryState with _$FindCountryState {
  FindCountryState._();

  factory FindCountryState({
    @JsonKey(name: 'countryList') required List<String> countryList,
    @JsonKey(name: 'countriesFound') required List<String> countriesFound,
    @JsonKey(name: 'countryToFind') required String countryToFind,
    @JsonKey(name: 'errors') required int errors,
    @JsonKey(name: 'hints') required int hints,
  }) = _FindCountryState;

  factory FindCountryState.empty() {
    return FindCountryState(
      countryList: [],
      countriesFound: [],
      countryToFind: '',
      errors: 0,
      hints: 0,
    );
  }

  factory FindCountryState.init({
    required List<String> countryList,
    required String initialCountryToFind,
  }) {
    return FindCountryState(
      countryList: countryList,
      countriesFound: [],
      countryToFind: initialCountryToFind,
      errors: 0,
      hints: 0,
    );
  }

  bool get active => countryList.isNotEmpty;
  int get total => countryList.length;
  int get correct => countriesFound.length - hints;
  int get remaining => total - correct - errors - hints;
  bool get completed => remaining < 1;

  factory FindCountryState.fromJson(Map<String, dynamic> json) => _$FindCountryStateFromJson(json);
}
