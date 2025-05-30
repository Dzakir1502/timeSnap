import 'package:timesnap/app/module/repository/photo_repository.dart';
import 'package:timesnap/core/network/data_state.dart';
import 'package:timesnap/core/use_case/app_use_case.dart';

class PhotoGetBytesUseCase
    extends AppUseCase<Future<DataState<dynamic>>, void> {
  final PhotoRepository _photoRepository;

  PhotoGetBytesUseCase(this._photoRepository);

  @override
  Future<DataState> call({void param}) async {
    final response = await _photoRepository.get();
    if (response.success) {
      final responseBytes = await _photoRepository.getBytes(response.data!);
      return responseBytes;
    } else {
      return response;
    }
  }
}