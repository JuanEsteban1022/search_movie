import 'dart:async';
// Creditos
// https://stackoverflow.com/a/52922130/7834829

//* Clase generica que retorna un String, objeto, etc.
class Debouncer<T> {
  Debouncer({required this.duration, this.onValue});

  final Duration duration;

  void Function(T value)? onValue;

  //* Valor Generico que recibe
  T? _value;
  Timer? _timer;

  T get value => _value!;

  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue!(_value!));
  }
}
