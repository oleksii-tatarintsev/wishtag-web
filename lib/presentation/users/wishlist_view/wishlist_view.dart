import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/data/models.dart';
import 'package:wishtag_web/shared/data_mock.dart';
import 'package:wishtag_web/shared/styles.dart';
import 'package:wishtag_web/shared/ui_kit.dart';

WishList wishList = DataMock.users.first.wishLists.first;

@RoutePage(name: 'WishListViewRoute')
class WishListViewScreen extends StatelessWidget {
  const WishListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentWrapper(
      title: "Details about '${wishList.title}'",
      children: [
        Text(wishList.description),
        SelectableText.rich(
          TextSpan(
            text: 'Description: ',
            style: AppFonts.bold18,
            children: [TextSpan(text: wishList.description, style: AppFonts.regular18)],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: wishList.wishes.length,
          itemBuilder: (context, index) {
            final wish = wishList.wishes[index];
            final controller = ExpansionTileController();
            return GestureDetector(
              onTap: () {
                controller.isExpanded ? controller.collapse() : controller.expand();
              },
              child: ExpansionTile(
                showTrailingIcon: false,
                controller: controller,
                leading: Container(
                  width: 80.r,
                  height: 80.r,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(image: NetworkImage(wish!.photos.first!), fit: BoxFit.cover),
                  ),
                ),
                title: Text(wish.title, style: AppFonts.tableHeader),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.link)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.map)),
                  ],
                ),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (wish.photos.isNotEmpty)
                        Wrap(alignment: WrapAlignment.start, children: [..._buildPhotos(wish.photos)]),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  List<Widget> _buildPhotos(List<String?> photos) {
    final List<Widget> widgets = [];

    for (final photo in photos) {
      widgets.add(
        PhotoPreviewDialogWrapper(
          photos: photos,
          initialIndex: photos.indexOf(photo),
          child: PhotoPreview(photo: photo!),
        ),
      );
    }

    return widgets;
  }
}
