import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/shared/styles.dart';

class PhotoPreview extends StatelessWidget {
  final String photo;
  final ValueNotifier<bool> visible = ValueNotifier(false);
  PhotoPreview({required this.photo, super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.zoomIn,
      onEnter: (_) => Future.delayed(Duration.zero, () => visible.value = !visible.value),
      onExit: (_) => Future.delayed(Duration.zero, () => visible.value = !visible.value),
      child: Container(
        margin: EdgeInsets.all(8.r),
        width: 150.r,
        height: 150.r,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(image: NetworkImage(photo), fit: BoxFit.cover),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: visible,
              builder: (context, value, child) {
                return Visibility(
                  visible: value,
                  child: Container(
                    width: 150.r,
                    height: 150.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                    child: Icon(Icons.zoom_in, color: AppColors.mainBg),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
