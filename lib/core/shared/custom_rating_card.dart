import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

Widget buildCustomRatingCard({horizontal,vertical , movie}){
  return                 // Rating Badge (Top Left)
    Positioned(
      top: 8,
      left: 8,
      child: Container(
        padding:  EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: AppColors.gold, size: 12),
            const SizedBox(width: 5),
            Text(
              movie.rating?.toStringAsFixed(1) ?? 'N/A',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
}