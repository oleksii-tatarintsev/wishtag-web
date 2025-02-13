import 'package:flutter/cupertino.dart' show Widget;

/// Определение колонки для универсальной таблицы
class ColumnDefinition<T> {
  final String header;
  final int flex;
  final Widget Function(T item) cellBuilder;

  /// Фильтр: функция возвращает true, если элемент удовлетворяет фильтру.
  final bool Function(T item, String filter)? filterPredicate;

  ColumnDefinition({
    required this.header,
    required this.flex,
    required this.cellBuilder,
    this.filterPredicate,
  });
}
