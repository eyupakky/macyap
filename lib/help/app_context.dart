import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContextProvider<T extends ChangeNotifier> extends InheritedWidget {
  final BaseContext current;

  const ContextProvider(
      {required Key key, required Widget child, required this.current})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static ContextProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ContextProvider>();
  }
}

abstract class BaseContext {
  void clearCashe();

  void setAccessToken(String accessToken);
}

class AppContext implements BaseContext {
  @override
  void clearCashe() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  @override
  void setAccessToken(String accessToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("accessToken", accessToken);
  }
}
