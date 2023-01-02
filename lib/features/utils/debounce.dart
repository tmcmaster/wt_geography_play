import 'dart:async';

class Debounce {
  final Duration duration;
  Timer? _timer;

  Debounce({
    this.duration = const Duration(milliseconds: 500),
  });

  void run(void Function() action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(duration, () {
      action();
    });
  }
}
