import 'package:freezed_annotation/freezed_annotation.dart';

part 'find_dinosaurs_state.freezed.dart';
part 'find_dinosaurs_state.g.dart';

@freezed
class FindDinosaursState with _$FindDinosaursState {
  FindDinosaursState._();

  factory FindDinosaursState({
    @JsonKey(name: 'total') required int total,
    @JsonKey(name: 'found') required Set<String> found,
    @JsonKey(name: 'collected') required Set<String> collected,
  }) = _FindDinosaursState;

  factory FindDinosaursState.empty() {
    return FindDinosaursState(
      total: 0,
      found: {},
      collected: {},
    );
  }

  factory FindDinosaursState.fromJson(Map<String, dynamic> json) =>
      _$FindDinosaursStateFromJson(json);
}
