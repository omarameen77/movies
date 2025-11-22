import 'package:flutter/material.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/profile/widgets/history_widget.dart';
import 'package:movies/features/profile/widgets/profile_header.dart';
import 'package:movies/features/profile/widgets/watch_list_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            surfaceTintColor: AppColors.gold,
            toolbarHeight: context.height * 0.01,
            backgroundColor: AppColors.blackOne,
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(background: ProfileHeader()),
            bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              indicatorColor: AppColors.gold,
              unselectedLabelColor: Colors.grey,
              labelColor: AppColors.white,
              tabs: [
                Tab(text: 'Whats List', icon: Icon(Icons.list,color: AppColors.gold,size: 35,)),
                Tab(text: 'History', icon: Icon(Icons.folder,color: AppColors.gold,size: 30,)),
              ],
            ),
          ),
          SliverFillRemaining(

            child: TabBarView(
              children: [
                WatchListWidget(),
                HistoryWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
