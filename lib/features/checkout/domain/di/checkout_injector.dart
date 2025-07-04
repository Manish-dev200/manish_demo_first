import 'package:demo_first/features/checkout/presentation/provider/checkout_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_first/core/di/dio_injector.dart';


import '../../../home/data/datasources/home_remote_data_source.dart';
import '../../../home/data/repositories/home_repository.dart';
import '../../../home/domain/repositories/home_repository_impl.dart';
import '../../../home/presentation/provider/home_view_model.dart';
import '../../data/datasources/checkout_remote_data_source.dart';
import '../../data/repositories/checkout_repository.dart';
import '../repositories/checkout_repository_impl.dart';

// Remote Data Source
final checkoutRemoteDataSourceProvider = Provider<CheckoutRemoteDataSource>(
      (ref) => CheckoutRemoteDataSource(ref.watch(dioProvider)),
);

// Repository
final checkoutRepositoryProvider = Provider<CheckoutRepository>(
      (ref) => CheckoutRepositoryImpl(ref.watch(checkoutRemoteDataSourceProvider)),
);

// // Use Case
// final getProductsUseCase = Provider<GetProductUseCase>(
//       (ref) => GetProductUseCase(ref.watch(homeRepositoryProvider)),
// );

// ViewModel
final checkoutViewModelProvider = StateNotifierProvider.autoDispose<CheckoutViewModel,CheckoutState>(
      (ref) => CheckoutViewModel(),
);
