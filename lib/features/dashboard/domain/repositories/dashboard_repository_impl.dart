
import '../../data/datasources/home_remote_data_source.dart';
import '../../data/repositories/home_repository.dart';


class HomeRepositoryImpl implements HomeRepository{
  HomeRemoteDataSource remoteDataSource;
  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> getProducts() async {
    return await remoteDataSource.getProducts();
  }

}