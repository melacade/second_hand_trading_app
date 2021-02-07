import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final T model;
  final Widget child;
  final Function(T) onReady;
  bool exist = false;

  ProviderWidget(
      {this.model, this.child, this.onReady, this.builder, this.exist = false});

  @override
  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  @override
  void initState() {
    super.initState();
    if (widget.onReady != null) {
      widget.onReady(widget.model);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.exist) {
      return ChangeNotifierProvider<T>.value(
        value: widget.model,
        child: Consumer<T>(
          builder: widget.builder,
          child: widget.child,
        ),
      );
    }
    return ChangeNotifierProvider<T>(
      create: (_) => widget.model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
