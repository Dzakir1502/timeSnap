import 'package:flutter/widgets.dart';

abstract class AppProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isDispose = false;
  String _errorMessage = '';
  String _snackBarMessage = '';

  bool get isLoading => _isLoading;
  bool get isDispose => _isDispose;
  String get errorMessage => _errorMessage;
  String get snackBarMessage => _snackBarMessage;

  set errorMessage(String param) => _errorMessage = param;
  set snackBarMessage(String param) => _snackBarMessage = param;

  void setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void hideLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void init();

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
}
