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
  }) = _NavigateBetweenState;

  factory NavigateBetweenState.fromJson(Map<String, dynamic> json) =>
      _$NavigateBetweenStateFromJson(json);
}
