import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_map_state.freezed.dart';
part 'explore_map_state.g.dart';

@freezed
class ExploreMapState with _$ExploreMapState {
  ExploreMapState._();

  factory ExploreMapState({
    @JsonKey(name: 'distance') required int distance,
  }) = _ExploreMapState;

  factory ExploreMapState.empty() {
    return ExploreMapState(
      distance: 0,
    );
  }

  factory ExploreMapState.init({
    required List<String> countryList,
    required String initialCountryToFind,
  }) {
    return ExploreMapState(
      distance: 0,
    );
  }

  factory ExploreMapState.fromJson(Map<String, dynamic> json) => _$ExploreMapStateFromJson(json);
}
