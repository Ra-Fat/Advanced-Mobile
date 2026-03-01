import 'package:flutter/widgets.dart';
import 'package:w6_2/data/repositories/appSettting/app_setting_repository.dart';
 
import '../../model/settings/app_settings.dart';

class AppSettingsState extends ChangeNotifier {
  
  final AppSettingRepository _repository;
  AppSettings? _appSettings;

  AppSettingRepository get repository => _repository;
 
  AppSettingsState({required AppSettingRepository repository}) : _repository = repository;

  Future<void> init() async {
    _appSettings = await _repository.load();
    notifyListeners();
  }

  ThemeColor get theme => _appSettings?.themeColor ?? ThemeColor.blue;

  Future<void> changeTheme(ThemeColor themeColor) async {
    if(_appSettings == null)  return;
    _appSettings = _appSettings!.copyWith(themeColor: themeColor);
    repository.save(_appSettings!);
    notifyListeners();
  }
}
