import 'package:shared_preferences/shared_preferences.dart';

class SharedManagerUtil {
  static final SharedManagerUtil _instance = SharedManagerUtil._init();
  SharedPreferences? _preferences;
  static SharedManagerUtil get instance => _instance;

  SharedManagerUtil._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }

  Future<bool> setServerTimeDiff(Duration duration) async {
    _preferences ??= await SharedPreferences.getInstance();
    return await _preferences!.setInt('serverTimeDiffrenceInMilliseconds', duration.inMilliseconds);
  }

  Future<Duration?> getServerTimeDiff() async {
    _preferences ??= await SharedPreferences.getInstance();
    final diff = _preferences!.getInt('serverTimeDiffrenceInMilliseconds');
    if (diff != null) {
      return Duration(milliseconds: diff);
    }
    return null;
  }
}
