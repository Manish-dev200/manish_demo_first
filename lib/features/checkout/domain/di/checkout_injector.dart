import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_first/core/di/dio_injector.dart';
import 'package:demo_first/features/cart/data/datasources/cart_remote_data_source.dart';

import 'package:demo_first/features/cart/domain/usecases/get_products_use_case.dart';
import 'package:demo_first/features/cart/presentation/provider/cart_view_model.dart';

import '../../../home/data/datasources/home_remote_data_source.dart';
import '../../../home/data/repositories/home_repository.dart';
import '../../../home/domain/repositories/home_repository_impl.dart';
import '../../../home/domain/usecases/get_product_use_case.dart';
import '../../../home/presentation/provider/home_view_model.dart';
import '../../data/repositories/cart_repository.dart';
import '../repositories/cart_repository_impl.dart';

// Remote Data Source
final homeRemoteDataSourceProvider = Provider<HomeRemoteDataSource>(
      (ref) => HomeRemoteDataSource(ref.watch(dioProvider)),
);

// Repository
final homeRepositoryProvider = Provider<HomeRepository>(
      (ref) => HomeRepositoryImpl(ref.watch(homeRemoteDataSourceProvider)),
);

// Use Case
final getProductsUseCase = Provider<GetProductUseCase>(
      (ref) => GetProductUseCase(ref.watch(homeRepositoryProvider)),
);

// ViewModel
final homeViewModelProvider = StateNotifierProvider.autoDispose<HomeViewModel,HomeState>(
      (ref) => HomeViewModel(ref.watch(getProductsUseCase)),
);
