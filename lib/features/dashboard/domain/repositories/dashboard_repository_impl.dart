
import '../../data/datasources/dashboard_remote_data_source.dart';
import '../../data/repositories/dashboard_repository.dart';


class DashboardRepositoryImpl implements DashboardRepository{
  DashboardRemoteDataSource remoteDataSource;
  DashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> getProducts() async {
    return await remoteDataSource.getProducts();
  }

}