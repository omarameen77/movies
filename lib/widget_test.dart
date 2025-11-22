// import 'package:flutter/material.dart';
// import 'package:movies/core/theme/app_colors.dart';
// import 'package:movies/features/profile/widgets/profile_header.dart';

// class WidgetTest extends StatelessWidget {
//   const WidgetTest({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           expandedHeight: 300,
//           pinned: true,
//           flexibleSpace: FlexibleSpaceBar(background: ProfileHeader()),
//           bottom: TabBar(
//             indicatorColor: AppColors.gold,
//             tabs: [
//               Tab(text: 'Whats List', icon: Icon(Icons.list)),
//               Tab(text: 'History', icon: Icon(Icons.folder)),
//             ],
//           ),
//         ),
//         SliverFillRemaining(
//           child: TabBarView(
//             children: [
//               Center(child: Text('Whats List Content')),
//               Center(child: Text('History Content')),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
