import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/shared/custom_elveted_button.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_theme.dart';
import 'package:movies/features/auth_feature/auth/login/login_screen.dart';
import 'package:movies/features/auth_feature/firebase/firebase_auth.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuthService.getUserData();
    return StreamBuilder<Map<String, dynamic>?>(
      stream: FirebaseAuthService.getUserDetailsStream(),
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        // Get user data
        Map<String, dynamic>? userData = snapshot.data;
        String name = userData?['name'] ?? currentUser?.displayName ?? 'User';
        String? photoUrl = userData?['photoUrl'] ?? currentUser?.photoURL;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // profile image
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: photoUrl != null
                              ? NetworkImage(photoUrl)
                              : AssetImage('assets/images/gamer.png')
                                    as ImageProvider,
                        ),
                        SizedBox(height: context.height * 0.01),
                        Text(name, style: TextStyleHelper.font18WhiteBold),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '0',
                          style: TextStyleHelper.font24WhiteBold.copyWith(
                            color: AppColors.gray,
                          ),
                        ),
                        Text(
                          'Wish List',
                          style: TextStyleHelper.font18WhiteBold,
                        ),
                      ],
                    ),

                    // History Count
                    Column(
                      children: [
                        Text(
                          '0',
                          style: TextStyleHelper.font24WhiteBold.copyWith(
                            color: AppColors.gray,
                          ),
                        ),
                        Text('History', style: TextStyleHelper.font18WhiteBold),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.03),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomElevatedButton(
                        title: 'Edit Profile',
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: context.width * 0.05),
                    Expanded(
                      flex: 1,
                      child: CustomElevatedButton(
                        backgroundColor: AppColors.red,
                        textColor: AppColors.white,
                        title: 'Exit',
                        onPressed: () {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.info,
                            title: 'Are you sure?',
                            text: 'Do you want to log out?',
                            confirmBtnText: 'Logout',
                            cancelBtnText: 'Cancel',
                            confirmBtnColor: Colors.red,
                            backgroundColor: AppColors.blackOne,
                            titleColor: Colors.white,
                            textColor: Colors.white70,
                            showCancelBtn: true,
                            onConfirmBtnTap: () async {
                              Navigator.pop(context);
                              await FirebaseAuthService.signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
