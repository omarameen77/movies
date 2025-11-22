import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_theme.dart';
import 'package:movies/features/movies_details/business_logic/cast_cubit/cast_cubit.dart';
import 'package:movies/features/movies_details/business_logic/cast_cubit/cast_state.dart';

class CastSection extends StatelessWidget {
  const CastSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastCubit, CastState>(
      builder: (context, state) {
        if (state is CastLoaded) {
          final listCast = state.cast;
          if (listCast.isEmpty) {
            return Text("");
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Cast", style: TextStyleHelper.font18WhiteBold),
              SizedBox(height: context.height * 0.01),

              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listCast.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: context.height * 0.01),
                itemBuilder: (context, index) {
                  final cast = listCast[index];
                  return Card(
                    margin: EdgeInsets.all(1),
                    color: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.blackFour,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              cast.urlSmallImage ?? '',
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          title: Text(
                            "Name : ${cast.name ?? "Unknown"}",
                            style: TextStyleHelper.font15WhiteRegular,
                          ),
                          subtitle: Text(
                            "Character : ${cast.characterName ?? "No character info"}",
                            style: TextStyleHelper.font14GreyRegular,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        } else if (state is CastError) {
          return Center(
            child: Text(
              "Not found cast!",
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppColors.red),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
