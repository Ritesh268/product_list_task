import 'package:flutter/widgets.dart';

enum ViewState { idle, busy }

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.busy;

  ViewState get viewState => _viewState;

  void setViewState(ViewState viewState) {
    if (viewState == _viewState) return;
    _viewState = viewState;
    notifyListeners();
  }
}
