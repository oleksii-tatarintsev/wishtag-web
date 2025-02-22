import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/data/models/user/user.dart';
import 'package:wishtag_web/shared/styles.dart';
import 'package:wishtag_web/shared/ui_kit.dart';
import 'package:wishtag_web/utils/toast_messenger/toast_controller.dart';

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
        Padding(padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 20.r), child: Divider(),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            WishListWidget(wishlist: user.publicWishes, title: 'Public Lists',),
            WishListWidget(wishlist: user.privateWishes, title: 'Private Lists',),
            WishListWidget(wishlist: user.limitedWishes, title: 'Limited Lists',),
          ],
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
                    children: [TextSpan(text: user.role.toString(), style: AppFonts.regular18)],
                  ),
                ),
                SelectableText.rich(
                  TextSpan(
                    text: 'Username: ',
                    style: AppFonts.bold18,
                    children: [TextSpan(text: user.id, style: AppFonts.regular18)],
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
                    children: [TextSpan(text: user.publicWishes.length.toString(), style: AppFonts.regular18)],
                  ),
                ),
                SelectableText.rich(
                  TextSpan(
                    text: 'Following: ',
                    style: AppFonts.bold18,
                    children: [TextSpan(text: user.privateWishes.length.toString(), style: AppFonts.regular18)],
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

class WishListWidget extends StatelessWidget {
  final List<String?> wishlist;
  final String title;
  const WishListWidget({required this.wishlist, required this.title, super.key});

  List<Widget> _buildWishLists() {
    final List<Widget> list = [];

    if (wishlist.isNotEmpty) {
      for (final wish in wishlist) {
        list.add(SelectableText('• ${wish!}'));
      }
    } else {
      list.add(SelectableText('Nothing to display'));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppFonts.bold20),
        Container(
          height: 450.r,
          width: 300.r,
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
          decoration: BoxDecoration(
            color: AppColors.mainBg,
            border: Border.all(color: AppColors.containerBorder),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildWishLists(),
          ),
        ),
      ],
    );
  }
}
