import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigate_between_state.freezed.dart';
part 'navigate_between_state.g.dart';

@freezed
class NavigateBetweenState with _$NavigateBetweenState {
  NavigateBetweenState._();

  factory NavigateBetweenState({
    @JsonKey(name: 'source') required String source,
    @JsonKey(name: 'destination') required String destination,
    @JsonKey(name: 'selected') required String selected,
    @JsonKey(name: 'visited') required List<String> visited,
    @JsonKey(name: 'distance') required double distance,
  }) = _NavigateBetweenState;

  factory NavigateBetweenState.empty() {
    return NavigateBetweenState(
      source: '',
      destination: '',
      selected: '',
      visited: [],
      distance: 0.0,
    );
  }

  factory NavigateBetweenState.init({
    required String source,
    required String destination,
  }) {
    return NavigateBetweenState(
      source: source,
      destination: destination,
      selected: source,
      visited: [source],
      distance: 0.0,
    );
  }

  bool get active => source.isNotEmpty && destination.isNotEmpty;

  int get steps => !active
      ? 0
      : completed
          ? visited.length - 2
          : visited.length - 1;

  bool get completed => visited.isNotEmpty && visited.last == destination;

  factory NavigateBetweenState.fromJson(Map<String, dynamic> json) =>
      _$NavigateBetweenStateFromJson(json);
}
