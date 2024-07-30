import 'package:flutter/widgets.dart';
import 'package:product_list_task/base/after_init.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Function(T) onModelReady;

  const BaseView(
      {super.key, required this.builder, required this.onModelReady});

  @override
  BaseViewState<T> createState() => BaseViewState<T>();
}

class BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>>
    with AfterInitMixin<BaseView<T>> {
  late T model;

  @override
  void didInitState() {
    model = Provider.of<T>(context);
    widget.onModelReady(model);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: widget.builder,
    );
  }
}
