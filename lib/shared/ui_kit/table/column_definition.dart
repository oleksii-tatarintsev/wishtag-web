import 'package:flutter/cupertino.dart' show TextEditingController, Widget;

class ColumnDefinition<T> {
  final String header;
  final int flex;
  final bool hideFilter;

  final Widget Function(T item) cellBuilder;
  final bool Function(T item, String filter)? filterPredicate;
  final Widget Function(TextEditingController controller)? filterBuilder;

  ColumnDefinition({
    required this.header,
    required this.flex,
    required this.cellBuilder,
    this.hideFilter = false,
    this.filterPredicate,
    this.filterBuilder,
  });
}
