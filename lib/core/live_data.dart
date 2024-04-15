import 'package:flutter/cupertino.dart';

import 'ui_state.dart';

class LiveData<T extends UIState> with ChangeNotifier {
  T? value;

  void setValue(T value) {
    this.value = value;
  }

  UIState getValue() {
    return this.value!;
  }
}
