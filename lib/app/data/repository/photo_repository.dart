import 'package:timesnap/app/data/source/photo_api_service.dart';
import 'package:timesnap/app/module/repository/photo_repository.dart';
import 'package:timesnap/core/network/data_state.dart';

class PhotoRepositoryImpl extends PhotoRepository{
  final PhotoApiService _photoApiService;

  PhotoRepositoryImpl(this._photoApiService);

  @override
  Future<DataState<String>> get() {
    return handleResponse(
      () => _photoApiService.get(), 
      (p0) => p0,
    );
  }
}