import 'package:e_commerce_app/modules/shared/data/remote_data_source.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';

class SharedDataRepo implements SharedDomainRepo {
  final SharedRemoteDataSource dataSource;

  SharedDataRepo(this.dataSource);
}
