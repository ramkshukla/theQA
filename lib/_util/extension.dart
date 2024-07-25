import 'package:flutter/foundation.dart';

extension StringConstants on String {
  get logIt {
    if (kDebugMode) {
      print(this);
    }
  }
}
