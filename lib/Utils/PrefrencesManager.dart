import 'package:shared_preferences/shared_preferences.dart';

class PrefrencesManager{
  static Future<SharedPreferences> _prefs =SharedPreferences.getInstance();
  static SharedPreferences _prefInstance;
  static bool _initCalled=false;

  static void init() async
  {
    _initCalled=true;
    _prefInstance = await _prefs;

  }
  static void dispose() async
  {
    _prefs=null;
    _prefInstance =null;

  }
  /// RETURN ALL KEYS in the persistencestorage
  static Set<String> getkeys(){
    assert(_initCalled,"Prefs.init() must be called first in an initstate prefereably!");
    assert(_prefInstance!=null,"Maybe call prefs.getkeyF() instead sahredprefrences not read yet!");
    return _prefInstance.getKeys();
  }

  //// GET ANY DYNAMIC VALUE FROM STORAGE
  static dynamic getdynamicvalue(String Key){
    assert(_initCalled,"Prefs.init() must be called first in an initstate prefereably!");
    assert(_prefInstance!=null,"Maybe call prefs.getkeyF() instead sahredprefrences not read yet!");
    return _prefInstance.get(Key);

  }
  //// GET ANY BOOL VALUE
  static bool getBool(String Key){
    assert(_initCalled,"Prefs.init() must be called first in an initstate prefereably!");
    assert(_prefInstance!=null,"Maybe call prefs.getkeyF() instead sahredprefrences not read yet!");
    return _prefInstance.getBool(Key)?? false;

  }

  /// SET ANY BOOL VALUE
  static Future<bool> setBool(String Key,bool value) async{
    var instance =await _prefs;
    return instance.setBool(Key, value);

  }static Future<bool> setString(String Key,String value) async{
    var instance =await _prefs;
    return instance.setString(Key, value);
  }
  static String getString(String Key){
    assert(_initCalled,"Prefs.init() must be called first in an initstate prefereably!");
    assert(_prefInstance!=null,"Maybe call prefs.getkeyF() instead sahredprefrences not read yet!");
    return _prefInstance.getString(Key)?? "";

  }

}