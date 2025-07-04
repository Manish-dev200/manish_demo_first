import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_first/core/di/dio_injector.dart';

import '../../data/datasources/dashboard_remote_data_source.dart';
import '../../data/repositories/dashboard_repository.dart';
import '../../presentation/provider/dashboard_view_model.dart';
import '../repositories/dashboard_repository_impl.dart';
import '../usecases/get_product_use_case.dart';

// Remote Data Source
final dashRemoteDataSourceProvider = Provider<DashboardRemoteDataSource>(
      (ref) => DashboardRemoteDataSource(ref.watch(dioProvider)),
);

// Repository
final dashRepositoryProvider = Provider<DashboardRepository>(
      (ref) => DashboardRepositoryImpl(ref.watch(dashRemoteDataSourceProvider)),
);

// Use Case
final getProductsUseCase = Provider<GetProductUseCase>(
      (ref) => GetProductUseCase(ref.watch(dashRepositoryProvider)),
);

// ViewModel
final dashViewModelProvider = StateNotifierProvider.autoDispose<DashboardViewModel,DashboardState>(
      (ref) => DashboardViewModel(ref.watch(getProductsUseCase)),
);
