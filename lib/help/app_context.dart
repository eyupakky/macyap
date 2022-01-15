import 'package:flutter/cupertino.dart';
import 'package:repository_eyup/model/user.dart';
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
  void setMyUser(User myUser);
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

  @override
  void setMyUser(User myUser) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("user_id", '${myUser.userId}');
    preferences.setString("username", '${myUser.username}');
    preferences.setString("firstname", '${myUser.firstname}');
    preferences.setString("lastname", '${myUser.lastname}');
    preferences.setString("image", '${myUser.image}');
  }
}
