import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_first/core/di/dio_injector.dart';
import 'package:demo_first/features/cart/data/datasources/cart_remote_data_source.dart';

import 'package:demo_first/features/cart/domain/usecases/get_products_use_case.dart';
import 'package:demo_first/features/cart/presentation/provider/cart_view_model.dart';

import '../../../cart/data/repositories/cart_repository.dart';
import '../../../cart/domain/repositories/cart_repository_impl.dart';

// Remote Data Source
final cartRemoteDataSourceProvider = Provider<CartRemoteDataSource>(
      (ref) => CartRemoteDataSource(ref.watch(dioProvider)),
);

// Repository
final cartRepositoryProvider = Provider<CartRepository>(
      (ref) => CartRepositoryImpl(ref.watch(cartRemoteDataSourceProvider)),
);

// Use Case
final getCartProductsUseCase = Provider<GetCartProductUseCase>(
      (ref) => GetCartProductUseCase(ref.watch(cartRepositoryProvider)),
);

// ViewModel
final cartViewModelProvider = StateNotifierProvider.autoDispose<CartViewModel,CartState>(
      (ref) => CartViewModel(ref.watch(getCartProductsUseCase)),
);
