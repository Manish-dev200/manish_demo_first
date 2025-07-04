import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_first/core/di/dio_injector.dart';

import '../../data/datasources/home_remote_data_source.dart';
import '../../data/repositories/home_repository.dart';
import '../../presentation/provider/home_view_model.dart';
import '../repositories/home_repository_impl.dart';

// Remote Data Source
final homeRemoteDataSourceProvider = Provider<HomeRemoteDataSource>(
      (ref) => HomeRemoteDataSource(ref.watch(dioProvider)),
);

// Repository
final homeRepositoryProvider = Provider<HomeRepository>(
      (ref) => HomeRepositoryImpl(ref.watch(homeRemoteDataSourceProvider)),
);

// // Use Case
// final getProductsUseCase = Provider<GetProductUseCase>(
//       (ref) => GetProductUseCase(ref.watch(homeRepositoryProvider)),
// );

// ViewModel
final homeViewModelProvider = StateNotifierProvider.autoDispose<HomeViewModel,HomeState>(
      (ref) => HomeViewModel(),
);
