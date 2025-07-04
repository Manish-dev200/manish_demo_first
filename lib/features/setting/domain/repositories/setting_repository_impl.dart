
import '../../data/datasources/setting_remote_data_source.dart';
import '../../data/repositories/setting_repository.dart';

class settingRepositoryImpl implements ProductDetailRepository{
  SettingRemoteDataSource remoteDataSource;
  settingRepositoryImpl(this.remoteDataSource);



}