import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhotoPreviewDialogWrapper extends StatelessWidget {
  final Widget child;
  final List<String?> photos;
  final int initialIndex;

  const PhotoPreviewDialogWrapper({required this.child, required this.photos, required this.initialIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => _openFullScreenDialog(context), child: child);
  }

  void _openFullScreenDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) => _FullScreenPhotoDialog(photos: photos, initialIndex: initialIndex),
    );
  }
}

class _FullScreenPhotoDialog extends StatefulWidget {
  final List<String?> photos;
  final int initialIndex;

  const _FullScreenPhotoDialog({required this.photos, required this.initialIndex});

  @override
  FullScreenPhotoDialogState createState() => FullScreenPhotoDialogState();
}

class FullScreenPhotoDialogState extends State<_FullScreenPhotoDialog> {
  late final PageController _pageController;
  late int _currentIndex;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _previousImage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _nextImage() {
    if (_currentIndex < widget.photos.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _handleKeyEvent(BuildContext context) {
    if (HardwareKeyboard.instance.isPhysicalKeyPressed(PhysicalKeyboardKey.arrowLeft)) {
      _previousImage();
    } else if (HardwareKeyboard.instance.isPhysicalKeyPressed(PhysicalKeyboardKey.arrowRight)) {
      _nextImage();
    } else if (HardwareKeyboard.instance.isPhysicalKeyPressed(PhysicalKeyboardKey.escape)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withValues(alpha: 0.3),

      insetPadding: EdgeInsets.zero,
      child: KeyboardListener(
        focusNode: focusNode,
        autofocus: true,
        onKeyEvent: (_) => _handleKeyEvent(context),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: widget.photos.length,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  child: Center(child: Image.network(widget.photos[index]!, fit: BoxFit.contain)),
                );
              },
            ),
            Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Positioned(
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                onPressed: _previousImage,
              ),
            ),
            Positioned(
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 30),
                onPressed: _nextImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
