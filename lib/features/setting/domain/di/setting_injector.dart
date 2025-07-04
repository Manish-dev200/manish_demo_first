import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_first/core/di/dio_injector.dart';


import '../../data/datasources/setting_remote_data_source.dart';
import '../../data/repositories/setting_repository.dart';
import '../../presentation/provider/setting_view_model.dart';
import '../repositories/setting_repository_impl.dart';

// Remote Data Source
final productDetailRemoteDataSourceProvider = Provider<SettingRemoteDataSource>(
      (ref) => SettingRemoteDataSource(ref.watch(dioProvider)),
);

// Repository
final productDetailRepositoryProvider = Provider<ProductDetailRepository>(
      (ref) => settingRepositoryImpl(ref.watch(productDetailRemoteDataSourceProvider)),
);



// ViewModel
final settingViewModelProvider = StateNotifierProvider<SettingViewModel,SettingState>(
      (ref) => SettingViewModel(),
);
