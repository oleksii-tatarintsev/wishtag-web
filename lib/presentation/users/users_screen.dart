import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/data/models.dart';
import 'package:wishtag_web/shared/data_mock.dart';
import 'package:wishtag_web/shared/styles.dart';
import 'package:wishtag_web/shared/ui_kit.dart';

@RoutePage(name: 'UserGridRoute')
class UserGridScreen extends StatelessWidget {
  const UserGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentWrapper(
      title: 'Users Management',
      actions: [
        AppFilledTextButton(title: 'Delete User(s)', buttonStyle: FilledTextButtonType.red, width: 150.r),
        SizedBox(width: 16.r),
        AppFilledTextButton(title: 'Create User', buttonStyle: FilledTextButtonType.blue, width: 150.r),
        SizedBox(width: 10.r),
      ],
      children: [
        SizedBox(height: 20.r),
        GenericDataTable<String, User>(
          itemsPerPageOptions: [15, 25, 50, 100],
          data: DataMock.users,
          onSelectionChanged: (selectedItems) {
            debugPrint('Selected items: $selectedItems');
          },
          onFiltersApplied: (filters) {
            debugPrint('Filters applied: $filters');
          },
          columns: [
            ColumnDefinition<User>(
              header: 'ID',
              flex: 1,
              cellBuilder: (item) => SelectableText(item.id, style: AppFonts.regular16),
              filterPredicate: (item, filter) => item.id.contains(filter),
            ),
            ColumnDefinition<User>(
              header: 'Name',
              flex: 2,
              cellBuilder: (item) => SelectableText(item.name, style: AppFonts.regular16),
              filterPredicate: (item, filter) => item.name.toLowerCase().contains(filter.toLowerCase()),
            ),
            ColumnDefinition<User>(
              header: 'Email',
              flex: 3,
              cellBuilder: (item) => SelectableText(item.email, style: AppFonts.regular16),
              filterPredicate: (item, filter) => item.email.toLowerCase().contains(filter.toLowerCase()),
            ),
            ColumnDefinition<User>(
              header: 'Status',
              flex: 3,
              cellBuilder: (item) => SelectableText(item.role.name, style: AppFonts.regular16),
              filterPredicate: (item, filter) => item.role.name.toLowerCase().contains(filter.toLowerCase()),
              filterBuilder: (controller) {
                return DropdownButtonFormField<String>(
                  value: controller.text.isEmpty ? null : controller.text,
                  decoration: const InputDecoration(labelText: 'Filter by status', border: OutlineInputBorder()),
                  items:
                      UserRole.values.getStrings
                          .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                          .toList(),
                  onChanged: (value) {
                    controller.text = value ?? '';
                  },
                );
              },
            ),
          ],
          idGetter: (item) => item.id,
          rowActionsBuilder: (item) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  tooltip: 'Edit',
                  onPressed: () => debugPrint('Edit ${item.id}'),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  tooltip: 'Delete',
                  onPressed: () => debugPrint('Delete ${item.id}'),
                ),
                IconButton(
                  icon: const Icon(Icons.visibility, size: 20),
                  tooltip: 'View',
                  onPressed: () => debugPrint('View ${item.id}'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
