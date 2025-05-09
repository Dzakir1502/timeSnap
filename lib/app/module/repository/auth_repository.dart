import 'package:timesnap/app/module/entity/auth.dart';
import 'package:timesnap/core/network/data_state.dart';

abstract class AuthRepository {
  Future<DataState> login(AuthEntity param);
}
