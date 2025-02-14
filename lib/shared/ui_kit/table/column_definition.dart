import 'package:flutter/cupertino.dart' show TextEditingController, Widget;

class ColumnDefinition<T> {
  final String header;
  final int flex;

  final Widget Function(T item) cellBuilder;
  final bool Function(T item, String filter)? filterPredicate;
  final Widget Function(TextEditingController controller)? filterBuilder;

  ColumnDefinition({
    required this.header,
    required this.flex,
    required this.cellBuilder,
    this.filterPredicate,
    this.filterBuilder,
  });
}
