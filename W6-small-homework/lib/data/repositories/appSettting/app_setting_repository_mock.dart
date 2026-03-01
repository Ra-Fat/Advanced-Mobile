import '../../../model/settings/app_settings.dart';
import './app_setting_repository.dart';

class AppSettingRepositoryMock implements AppSettingRepository {
  AppSettings _settings = AppSettings(themeColor: ThemeColor.blue);

  @override
  Future<AppSettings> load() async{
    return _settings;
  }

  @override
  Future<void> save(AppSettings settings) async{
    _settings = settings;
  }
}