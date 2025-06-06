import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A reusable header widget that mirrors the A1One header:
/// - Rounded bottom corners
/// - Hero animation on the image
/// - Back button in the top-left
/// - Bookmark icon in the top-right
class GameHeader extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  const GameHeader({Key? key, required this.imageUrl, required this.heroTag})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Rounded bottom corners + Hero image
        ClipRRect(
          child: Hero(
            tag: heroTag,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 240,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Back arrow (top-left)
        Positioned(
          top: 40,
          left: 16,
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: Colors.black87,
              ),
            ),
          ),
        ),

        // Bookmark icon (top-right)
        Positioned(
          top: 40,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bookmark_border,
              size: 24,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
