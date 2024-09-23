import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/presentation/BottomNavBar/BottomNavBar.dart';
import 'bloc/profile_bloc.dart';
import 'models/profile_model.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/widgets/app_bar/appbar_leading_image.dart';
import 'package:sopraflutter/widgets/app_bar/appbar_subtitle.dart';
import 'package:sopraflutter/widgets/app_bar/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  String emailforpath = "";
  ProfileScreen({Key? key}) : super(key: key);
  ProfileModel _profileModel = ProfileModel();

  static Widget builder(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) =>
          ProfileBloc(ProfileState(profileModelObj: ProfileModel()))
            ..add(ProfileInitialEvent()),
      child: ProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                // Background image with opacity
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.3, // Adjust opacity as needed
                    child: Image.asset(
                      bg, // Background image path from constants.dart
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Main content
                Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<Map<String, String?>>(
                        future: _profileModel.getDataFromSharedPreferences(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SingleChildScrollView(
                              child:
                                  _buildProfileContent(context, snapshot.data!),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: Container(child: BottomNavBarV2(index: 4)),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftBlueGray300,
        margin: EdgeInsets.only(left: 16.h, top: 16.v, bottom: 15.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      title: AppbarSubtitle(
        text: "lbl_profile".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, Map<String, String?> data) {
    emailforpath = data['email'] ?? "";
    String imageUrl = '$baseUrl/' + (data['image_url'] ?? "");
    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0.h),
            child: Column(
              children: [
                Stack(
                  children: [
                    // Wave background
                    Positioned.fill(
                      child: CustomPaint(
                        painter: WavePainter(),
                      ),
                    ),
                    // Profile image
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Container(
                          child: CustomImageView(
                            imagePath: imageUrl,
                            height: 200.adaptSize,
                            width: 174.adaptSize,
                            radius: BorderRadius.circular(90),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centers children horizontally in the Row
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Centers children vertically in the Row
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0), // Adjust padding as needed
                      child: Column(
                        mainAxisSize: MainAxisSize
                            .min, // Makes the Column only as tall as its children
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Centers children horizontally in the Column
                        children: [
                          Text(
                            data['username'] ?? "",
                            style: theme.textTheme.titleSmall,
                          ),
                          SizedBox(height: 8.0), // Adjust height as needed
                          Text(
                            data['email'] ?? "",
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 32.v),

          // All profile detail options in one container with shadow
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), // Rounded edges
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 20,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    10), // Ensure content inside is also rounded
                child: Column(
                  children: [
                    _buildProfileDetailOption(
                      context,
                      dateIcon: ImageConstant.imgUserPrimary,
                      birthday: "Role",
                      birthDateValue: data['role'] ?? "",
                      onTapProfileDetailOption: () {
                        NavigatorService.pushNamed(
                          AppRoutes.addPaymentScreen,
                        );
                      },
                    ),
                    Divider(),
                    _buildProfileDetailOption(
                      context,
                      dateIcon: ImageConstant.imgDateIcon,
                      birthday: "lbl_birthday".tr,
                      birthDateValue: "14-02-2000",
                      onTapProfileDetailOption: () {},
                    ),
                    Divider(),
                    _buildProfileDetailOption(
                      context,
                      dateIcon: ImageConstant.imgMailPrimary,
                      birthday: "lbl_email".tr,
                      birthDateValue: data['email'] ?? "",
                      onTapProfileDetailOption: () {},
                    ),
                    Divider(),
                    _buildProfileDetailOption(
                      context,
                      dateIcon: ImageConstant.imgCreditCardIcon,
                      birthday: "lbl_phone_number".tr,
                      birthDateValue: "53 241 141",
                      onTapProfileDetailOption: () {},
                    ),
                    Divider(),
                    _buildProfileDetailOption(
                      context,
                      dateIcon: ImageConstant.imgLockPrimary,
                      birthday: "lbl_change_password".tr,
                      birthDateValue: "msg".tr,
                      onTapProfileDetailOption: () {
                        onTapProfileDetailOption(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 5.v),
        ],
      ),
    );
  }

  Widget _buildProfileDetailOption(
    BuildContext context, {
    required String dateIcon,
    required String birthday,
    required String birthDateValue,
    Function? onTapProfileDetailOption,
  }) {
    return GestureDetector(
      onTap: () {
        onTapProfileDetailOption!.call();
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 15.v),
        decoration: AppDecoration.fillOnPrimaryContainer,
        child: Row(
          children: [
            CustomImageView(
              color: appTheme.red00,
              imagePath: dateIcon,
              height: 24.adaptSize,
              width: 24.adaptSize,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.h, top: 3.v, bottom: 2.v),
              child: Text(
                birthday,
                style: theme.textTheme.labelLarge!.copyWith(
                  color: theme.colorScheme.onPrimary.withOpacity(1),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(top: 2.v, bottom: 3.v),
              child: Text(
                birthDateValue,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: appTheme.blueGray300,
                ),
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgRightIcon,
              height: 24.adaptSize,
              width: 24.adaptSize,
              margin: EdgeInsets.only(left: 16.h),
            ),
          ],
        ),
      ),
    );
  }

  void onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }

  void onTapProfileDetailOption(BuildContext context) {
    final profileForgetPasswordBloc = context.read<ProfileBloc>();
    final email = emailforpath;
    profileForgetPasswordBloc.add(
      ProfileForgetPasswordSubmitEvent(email: email),
    );
    NavigatorService.pushNamed(
      AppRoutes.changePasswordScreen,
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.red, Colors.orange],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.lineTo(0, size.height + 30);
    path.quadraticBezierTo(
        size.width / 4, size.height + 30, size.width / 2, size.height + 30);
    path.quadraticBezierTo(
        size.width, size.height + 30, size.width / 4, size.height + 30);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
