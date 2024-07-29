import 'package:flutter/widgets.dart';

// ignore: constant_identifier_names
enum ViewState { IDLE, BUSY }

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.BUSY;

  ViewState get viewState => _viewState;

  void setViewState(ViewState viewState) {
    if (viewState == _viewState) return;
    _viewState = viewState;
    notifyListeners();
  }
}
