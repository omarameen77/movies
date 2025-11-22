import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildScreenShotImage(String imageUrl, {required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        barrierColor: Colors.black.withAlpha(26),
        pageBuilder: (context, animation, secondaryAnimation) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                    child: Container(color: Colors.white.withAlpha(25)),
                  ),
                  Center(
                    child: Hero(
                      tag: imageUrl,
                      child: InteractiveViewer(
                        clipBehavior: Clip.none,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.contain,
                          errorWidget: (_, __, ___) => const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
    child: Hero(
      tag: imageUrl,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[700]!,
            child: Container(color: Colors.grey[850]),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[800],
            child: const Icon(Icons.movie, color: Colors.grey, size: 40),
          ),
        ),
      ),
    ),
  );
}
