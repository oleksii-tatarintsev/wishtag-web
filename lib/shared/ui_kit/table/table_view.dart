import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/shared/styles.dart';
import 'package:wishtag_web/shared/ui_kit.dart';

class GenericDataTable<IDType, T> extends StatefulWidget {
  final List<T> data;
  final List<ColumnDefinition<T>> columns;
  final IDType Function(T item) idGetter;
  final Widget Function(T item)? rowActionsBuilder;
  final List<int> itemsPerPageOptions;
  final int initialItemsPerPage;

  final ValueChanged<List<IDType>>? onSelectionChanged;
  final ValueChanged<Map<String, dynamic>>? onFiltersApplied;

  const GenericDataTable({
    required this.data,
    required this.columns,
    required this.idGetter,
    super.key,
    this.rowActionsBuilder,
    this.onSelectionChanged,
    this.onFiltersApplied,
    this.itemsPerPageOptions = const [15, 25, 50, 100],
    this.initialItemsPerPage = 10,
  });

  factory GenericDataTable.fromColumns({
    required List<T> data,
    required List<ColumnDefinition<T>> columns,
    required IDType Function(T item) idGetter,
    Key? key,
    Widget Function(T item)? rowActionsBuilder,
    ValueChanged<List<IDType>>? onSelectionChanged,
    ValueChanged<Map<String, dynamic>>? onFiltersApplied,
  }) {
    return GenericDataTable<IDType, T>(
      key: key,
      data: data,
      columns: columns,
      idGetter: idGetter,
      rowActionsBuilder: rowActionsBuilder,
      onSelectionChanged: onSelectionChanged,
      onFiltersApplied: onFiltersApplied,
    );
  }

  @override
  State<GenericDataTable<IDType, T>> createState() => _GenericDataTableState<IDType, T>();
}

class _GenericDataTableState<IDType, T> extends State<GenericDataTable<IDType, T>> {
  late final List<TextEditingController> _filterControllers =
      widget.columns.map((_) => TextEditingController()).toList();

  final ValueNotifier<Set<IDType>> _selectedIdsNotifier = ValueNotifier({});
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier(1);
  late final ValueNotifier<int> _itemsPerPageNotifier = ValueNotifier(widget.itemsPerPageOptions.first);

  @override
  void initState() {
    super.initState();
    _currentPageNotifier.addListener(() {
      _selectedIdsNotifier.value = {};
      if (widget.onSelectionChanged != null) {
        widget.onSelectionChanged!([]);
      }
    });
  }

  @override
  void dispose() {
    for (final controller in _filterControllers) {
      controller.dispose();
    }
    _selectedIdsNotifier.dispose();
    _currentPageNotifier.dispose();
    _itemsPerPageNotifier.dispose();
    super.dispose();
  }

  List<T> get _filteredData {
    return widget.data.where((item) {
      bool matches = true;
      for (int i = 0; i < widget.columns.length; i++) {
        final col = widget.columns[i];
        if (col.filterPredicate != null) {
          final filterText = _filterControllers[i].text;
          if (filterText.isNotEmpty) {
            matches = matches && col.filterPredicate!(item, filterText);
          }
        }
      }
      return matches;
    }).toList();
  }

  List<T> get _pagedData {
    final filtered = _filteredData;
    final totalPages = max(1, (filtered.length / _itemsPerPageNotifier.value).ceil());
    if (_currentPageNotifier.value > totalPages) {
      _currentPageNotifier.value = totalPages;
    }
    final startIndex = (_currentPageNotifier.value - 1) * _itemsPerPageNotifier.value;
    final endIndex = min(startIndex + _itemsPerPageNotifier.value, filtered.length);
    return filtered.sublist(startIndex, endIndex);
  }

  void _applyFilters() {
    _currentPageNotifier.value = 1;
    final Map<String, dynamic> filters = {};
    for (int i = 0; i < widget.columns.length; i++) {
      filters[widget.columns[i].header.toLowerCase()] = _filterControllers[i].text;
    }
    if (widget.onFiltersApplied != null) {
      widget.onFiltersApplied!(filters);
    }

    /// TODO: remove in future
    setState(() {});
  }

  void _clearFilters() {
    for (final controller in _filterControllers) {
      controller.clear();
    }
    _applyFilters();
  }

  void _toggleSelectAll(bool? value) {
    final visibleIds = _pagedData.map(widget.idGetter).toSet();
    final newSelection = Set<IDType>.from(_selectedIdsNotifier.value);
    if (value == true) {
      newSelection.addAll(visibleIds);
    } else {
      newSelection.removeAll(visibleIds);
    }
    _selectedIdsNotifier.value = newSelection;
    if (widget.onSelectionChanged != null) {
      widget.onSelectionChanged!(newSelection.toList());
    }
  }

  bool? get _headerCheckboxValue {
    final visibleIds = _pagedData.map(widget.idGetter).toSet();
    final selectedVisible = _selectedIdsNotifier.value.intersection(visibleIds);
    if (selectedVisible.isEmpty) {
      return false;
    } else if (selectedVisible.length == visibleIds.length) {
      return true;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.mainBg,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            child: Row(
              children: [
                SizedBox(width: 40),
                for (int i = 0; i < widget.columns.length; i++) ...[
                  Expanded(
                    flex: widget.columns[i].flex,
                    child: Text(widget.columns[i].header, style: AppFonts.tableHeader),
                  ),
                ],
                SizedBox(width: 120, child: Text('Actions', style: AppFonts.tableHeader)),
              ],
            ),
          ),
          ValueListenableBuilder<Set<IDType>>(
            valueListenable: _selectedIdsNotifier,
            builder: (context, selectedIds, _) {
              return Container(
                padding: EdgeInsets.only(bottom: 10),
                color: AppColors.mainBg,
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: AppCheckbox(value: _headerCheckboxValue, tristate: true, onChanged: _toggleSelectAll),
                    ),
                    for (int i = 0; i < widget.columns.length; i++) ...[
                      Expanded(
                        flex: widget.columns[i].flex,
                        child:
                            widget.columns[i].filterBuilder != null
                                ? widget.columns[i].filterBuilder!(_filterControllers[i])
                                : TableFilter(
                                  controller: _filterControllers[i],
                                  placeHolder: 'Filter by ${widget.columns[i].header.toLowerCase()}',
                                ),
                      ),
                    ],
                    SizedBox(
                      width: 120,
                      child: Row(
                        children: [
                          IconButton(onPressed: _applyFilters, icon: const Icon(Icons.search)),
                          SizedBox(width: 4.r),
                          IconButton(onPressed: _clearFilters, icon: const Icon(Icons.clear)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPageNotifier,
              builder: (context, currentPage, _) {
                return ValueListenableBuilder<int>(
                  valueListenable: _itemsPerPageNotifier,
                  builder: (context, itemsPerPage, _) {
                    final pagedData = _pagedData;
                    return ListView.builder(
                      itemCount: pagedData.length,
                      itemBuilder: (context, index) {
                        final item = pagedData[index];
                        final id = widget.idGetter(item);
                        return ValueListenableBuilder<Set<IDType>>(
                          valueListenable: _selectedIdsNotifier,
                          builder: (context, selectedIds, _) {
                            final selected = selectedIds.contains(id);
                            return _TableRowWidget<T, IDType>(
                              index: index,
                              item: item,
                              selected: selected,
                              columns: widget.columns,
                              onSelectedChanged: (bool? value) {
                                final newSet = Set<IDType>.from(selectedIds);
                                if (value == true) {
                                  newSet.add(id);
                                } else {
                                  newSet.remove(id);
                                }
                                _selectedIdsNotifier.value = newSet;
                                if (widget.onSelectionChanged != null) {
                                  widget.onSelectionChanged!(newSet.toList());
                                }
                              },
                              rowActionsBuilder: widget.rowActionsBuilder,
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<int>(
            valueListenable: _currentPageNotifier,
            builder: (context, currentPage, _) {
              return ValueListenableBuilder<int>(
                valueListenable: _itemsPerPageNotifier,
                builder: (context, itemsPerPage, _) {
                  final totalPages = max(1, (_filteredData.length / itemsPerPage).ceil());
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: currentPage > 1 ? () => _currentPageNotifier.value = currentPage - 1 : null,
                        child: Text('Previous', style: AppFonts.regular18),
                      ),
                      Text('Page $currentPage of $totalPages', style: AppFonts.regular18),
                      ElevatedButton(
                        onPressed: currentPage < totalPages ? () => _currentPageNotifier.value = currentPage + 1 : null,
                        child: Text('Next', style: AppFonts.regular18),
                      ),
                      const SizedBox(width: 16),
                      DropdownButton<int>(
                        value: itemsPerPage,
                        items:
                            widget.itemsPerPageOptions
                                .map(
                                  (e) => DropdownMenuItem<int>(
                                    value: e,
                                    child: Text('$e per page', style: AppFonts.regular18),
                                  ),
                                )
                                .toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            _itemsPerPageNotifier.value = newValue;
                            _currentPageNotifier.value = 1;
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TableRowWidget<T, IDType> extends StatefulWidget {
  final int index;
  final T item;
  final bool selected;
  final List<ColumnDefinition<T>> columns;
  final ValueChanged<bool?> onSelectedChanged;
  final Widget Function(T item)? rowActionsBuilder;

  const _TableRowWidget({
    required this.index,
    required this.item,
    required this.selected,
    required this.columns,
    required this.onSelectedChanged,
    super.key,
    this.rowActionsBuilder,
  });

  @override
  State<_TableRowWidget<T, IDType>> createState() => _TableRowWidgetState<T, IDType>();
}

class _TableRowWidgetState<T, IDType> extends State<_TableRowWidget<T, IDType>> {
  late Color backgroundColor = widget.index.isEven ? Colors.white : const Color(0xffFAFAFA);

  @override
  void initState() {
    backgroundColor = widget.index.isEven ? Colors.white : const Color(0xffFAFAFA);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => backgroundColor = Colors.blue.shade50),
      onExit: (_) => setState(() => backgroundColor = widget.index.isEven ? Colors.white : const Color(0xffFAFAFA)),
      child: Container(
        height: 40.r,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            SizedBox(width: 40, child: Checkbox(value: widget.selected, onChanged: widget.onSelectedChanged)),
            for (final col in widget.columns) ...[Expanded(flex: col.flex, child: col.cellBuilder(widget.item))],
            SizedBox(
              width: 120,
              child: widget.rowActionsBuilder != null ? widget.rowActionsBuilder!(widget.item) : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
