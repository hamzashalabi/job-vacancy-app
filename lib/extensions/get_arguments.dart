import 'package:flutter/material.dart' show BuildContext, ModalRoute;

// adds a method to the existing class BuildContext
// which sends data from a view to another with moving which is done
// through the navigator context
extension GetArgument on BuildContext {
  T? getArgument<T>() {
    final modalRoute = ModalRoute.of(this);
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;
      if (args != null && args is T) {
        return args as T;
      }
    }
    return null;
  }
}
