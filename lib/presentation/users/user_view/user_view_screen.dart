import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/data/models.dart';
import 'package:wishtag_web/shared/styles.dart';
import 'package:wishtag_web/shared/ui_kit.dart';
import 'package:wishtag_web/utils/toast.dart';

@RoutePage(name: 'UserViewRoute')
class UserViewScreen extends StatelessWidget {
  final User user;

  const UserViewScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return ContentWrapper(
      title: 'User Details',
      children: [
        UserCard(user: user),
        Padding(padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 20.r), child: Divider()),
        Text("${user.userName}'s Wishlists", style: AppFonts.title),
        SizedBox(height: 20.r),
        GenericDataTable<String, WishList>(
          itemsPerPageOptions: [15, 25, 50],
          data: user.wishLists,
          onSelectionChanged: (selectedItems) {
            debugPrint('Selected items: $selectedItems');
          },
          onFiltersApplied: (filters) {
            debugPrint('Filters applied: $filters');
          },
          columns: [
            ColumnDefinition<WishList>(
              header: 'ID',
              flex: 2,
              cellBuilder: (item) => SelectableText(item.id, style: AppFonts.regular16),
              filterPredicate: (item, filter) => item.id.contains(filter),
            ),
            ColumnDefinition<WishList>(
              header: 'Name',
              flex: 3,
              cellBuilder: (item) => SelectableText(item.title, style: AppFonts.regular16),
              filterPredicate: (item, filter) => item.title.toLowerCase().contains(filter.toLowerCase()),
            ),
            ColumnDefinition<WishList>(
              header: 'Type',
              flex: 2,
              cellBuilder: (item) => SelectableText(item.type.name, style: AppFonts.regular16),
              filterPredicate: (item, filter) => item.type.toString().toLowerCase().contains(filter.toLowerCase()),
              filterBuilder: (controller) {
                return TableDropDown<String>(
                  controller: controller,
                  placeHolder: 'Filter by type..',
                  value: controller.text.isEmpty ? null : controller.text,
                  items:
                      WishListType.values.getStrings
                          .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                          .toList(),
                  onChanged: (value) {
                    controller.text = value ?? '';
                  },
                );
              },
            ),
            ColumnDefinition<WishList>(
              header: 'Wishes',
              flex: 1,
              hideFilter: true,
              cellBuilder: (item) => SelectableText(item.wishes.length.toString(), style: AppFonts.regular16),
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
                IconButton(icon: const Icon(Icons.visibility, size: 20), tooltip: 'View', onPressed: () {}),
              ],
            );
          },
        ),
      ],
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({required this.user, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.r),
      child: Row(
        children: [
          CircleAvatar(radius: 60.r, backgroundImage: NetworkImage(user.photoUrl!)),
          Padding(
            padding: EdgeInsets.only(left: 20.r),
            child: Column(
              spacing: 4.r,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText.rich(
                  TextSpan(
                    text: 'Name: ',
                    style: AppFonts.bold18,
                    children: [TextSpan(text: user.name, style: AppFonts.regular18)],
                  ),
                ),
                SelectableText.rich(
                  TextSpan(
                    text: 'Email: ',
                    style: AppFonts.bold18,
                    children: [TextSpan(text: user.email, style: AppFonts.regular18)],
                  ),
                ),
                SelectableText.rich(
                  TextSpan(
                    text: 'Status: ',
                    style: AppFonts.bold18,
                    children: [TextSpan(text: user.status.name, style: AppFonts.regular18)],
                  ),
                ),
                SelectableText.rich(
                  TextSpan(
                    text: 'Username: ',
                    style: AppFonts.bold18,
                    children: [TextSpan(text: user.userName, style: AppFonts.regular18)],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.r),
            child: Column(
              spacing: 4.r,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText.rich(
                  TextSpan(
                    text: 'Followers: ',
                    style: AppFonts.bold18,
                    children: [TextSpan(text: user.wishLists.length.toString(), style: AppFonts.regular18)],
                  ),
                ),
                SelectableText.rich(
                  TextSpan(
                    text: 'Following: ',
                    style: AppFonts.bold18,
                    children: [TextSpan(text: user.wishLists.length.toString(), style: AppFonts.regular18)],
                  ),
                ),
                SelectableText.rich(
                  TextSpan(
                    text: 'Level: ',
                    style: AppFonts.bold18,
                    children: [TextSpan(text: user.exp.toString(), style: AppFonts.regular18)],
                  ),
                ),
                SizedBox(height: 18.r),
              ],
            ),
          ),
          Spacer(),
          UserActions(),
        ],
      ),
    );
  }
}

class UserActions extends StatelessWidget {
  const UserActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      child: Wrap(
        spacing: 8.r,
        children: [
          Column(
            spacing: 8.r,
            children: [
              AppFilledTextButton(
                title: 'Unban user',
                buttonStyle: FilledTextButtonType.blue,
                width: 140.r,
                onPressed: () {
                  Toast.add(message: 'User successfully unbanned');
                },
              ),
              AppFilledTextButton(
                title: 'Edit user',
                buttonStyle: FilledTextButtonType.blue,
                width: 140.r,
                onPressed: () {
                  Toast.add(message: 'NOT IMPLEMENTED YET');
                },
              ),
            ],
          ),
          Column(
            spacing: 8.r,
            children: [
              AppFilledTextButton(
                title: 'Ban user',
                buttonStyle: FilledTextButtonType.red,
                width: 140.r,
                onPressed: () {
                  Toast.add(message: 'User successfully banned');
                },
              ),
              AppFilledTextButton(
                title: 'Delete user',
                buttonStyle: FilledTextButtonType.red,
                width: 140.r,
                onPressed: () {
                  Toast.add(message: 'User successfully deleted');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
