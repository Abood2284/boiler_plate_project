import 'package:flutter/material.dart';

import 'logger.dart';

/* 
! Recommended use shared pref instead of this class
* GetStorage is a getX package, you can use any other package to store the data
  -> Inorder to this to work, import get_storage  & get package
  -> And in main method
      ->   await GetStorage.init(); // Initialize GetStorage
      add the above line
*/
class Auth extends ChangeNotifier {
  final log = getLogger('Auth');
  final storage = GetStorage();
  String? _token;

  bool get isAuth {
    log.d(token);
    log.d(token != null);
    return token != null;
  }

  // Future<String?> login() async {
  //   String? token = await getToken();
  //   if (token != null) {
  //     _token = token;
  //     log.d('Token is $_token');
  //     notifyListeners();
  //     return _token;
  //   }
  //   return null;
  // }

  // getDeviceId() async {
  //   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  //   try {
  //     if (Platform.isAndroid) {
  //       var build = await deviceInfoPlugin.androidInfo;
  //       return build.id;
  //     } else if (Platform.isIOS) {
  //       var data = await deviceInfoPlugin.iosInfo;
  //       return data.identifierForVendor;
  //     }
  //   } on PlatformException {
  //     print('Failed to get platform version');
  //   }
  // }

  Future<void> saveToken(String token) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('token', token);
    _token = token;
    storage.write('token', _token);
    log.d('Token : $token Saved');
    // notifyListeners();
  }

// TODO: This method will be called in Splash Screen, if token found -> Navigate to HOME_SCREEN
// -> ELSE -> Navigate to EnterPhoneScreen.dart
  Future<String?> getToken() async {
    // final prefs = await SharedPreferences.getInstance();
    // log.d('Token retrieved ${prefs.getString('token')}');
    // return prefs.getString('token');

    _token = storage.read('token');
    return _token;
  }

  String? get token {
    _token = storage.read('token');
    if (_token != null) {
      return _token;
    }
    return null;
  }

  logout() async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    // _token = null;

    storage.remove('token');
    _token = null;

    notifyListeners();
  }

  // Returns bool based on if we are succesful in finding a valid token and based on that we will render different screens
  Future<bool> tryAutoLogin() async {
    // final prefs = await SharedPreferences.getInstance();
    // // We didnt find any key so there is no data
    // if (!prefs.containsKey('token')) {
    //   return false;
    // }

    // If the specified key doesnt have the data then return false
    if (!storage.hasData('token')) {
      log.d('No token found during auto-login');
      return false;
    }

    log.d('token found during auto-login');

    _token = storage.read('token');
    log.d('$_token after reading from storage');
    notifyListeners();
    return true;
  }
}
