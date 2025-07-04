import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_first/core/di/dio_injector.dart';


import '../../data/datasources/product_detail_remote_data_source.dart';
import '../../data/repositories/product_detail_repository.dart';
import '../../presentation/provider/product_detail_view_model.dart';
import '../repositories/product_detail_repository_impl.dart';
import '../usecases/get_product_detail_use_case.dart';

// Remote Data Source
final productDetailRemoteDataSourceProvider = Provider<ProductDetailRemoteDataSource>(
      (ref) => ProductDetailRemoteDataSource(ref.watch(dioProvider)),
);

// Repository
final productDetailRepositoryProvider = Provider<ProductDetailRepository>(
      (ref) => ProductDetailRepositoryImpl(ref.watch(productDetailRemoteDataSourceProvider)),
);

// Use Case
final getProductDetailUseCase = Provider<GetProductDetailUseCase>(
      (ref) => GetProductDetailUseCase(ref.watch(productDetailRepositoryProvider)),
);

// ViewModel
final productDetailViewModelProvider = StateNotifierProvider.autoDispose<ProductDetailViewModel,ProductDetailState>(
      (ref) => ProductDetailViewModel(ref.watch(getProductDetailUseCase)),
);
