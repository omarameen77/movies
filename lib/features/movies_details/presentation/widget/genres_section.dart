import 'package:flutter/material.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_theme.dart';


class GenresSection extends StatelessWidget {
  final List<String>? genres;

  const GenresSection({super.key, this.genres});

  @override
  Widget build(BuildContext context) {
    if (genres == null || genres!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Genres", style: TextStyleHelper.font18WhiteBold),
        SizedBox(height: context.height * 0.01),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: genres!.map((genre) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.blackFour,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                genre,
                textAlign: TextAlign.center,
                style: TextStyleHelper.font14goldBold
              ),
            );
          }).toList(),
        ),
        SizedBox(height: context.height * 0.02),
      ],
    );
  }
}
