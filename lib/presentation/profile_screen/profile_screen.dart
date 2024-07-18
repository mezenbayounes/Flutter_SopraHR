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
            appBar: _buildAppBar(context),
            body: Column(
              children: [
                Expanded(
                  child: FutureBuilder<Map<String, String?>>(
                    future: _profileModel.getDataFromSharedPreferences(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          child: _buildProfileContent(context, snapshot.data!),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(child: BottomNavBarV2()),
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
    String imageUrl = 'http://10.0.2.2:3000/' + (data['image_url'] ?? "");
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 36.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: imageUrl,
                  height: 72.adaptSize,
                  width: 72.adaptSize,
                  radius: BorderRadius.circular(36.h),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.h, top: 9.v, bottom: 14.v),
                  child: Column(
                    children: [
                      Text(
                        data['username'] ?? "",
                        style: theme.textTheme.titleSmall,
                      ),
                      SizedBox(height: 8.v),
                      Text(
                        data['email'] ?? "",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.v),
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
          _buildProfileDetailOption(
            context,
            dateIcon: ImageConstant.imgDateIcon,
            birthday: "lbl_birthday".tr,
            birthDateValue: "14-02-2000",
            onTapProfileDetailOption: () {},
          ),
          _buildProfileDetailOption(
            context,
            dateIcon: ImageConstant.imgMailPrimary,
            birthday: "lbl_email".tr,
            birthDateValue: data['email'] ?? "",
            onTapProfileDetailOption: () {},
          ),
          _buildProfileDetailOption(
            context,
            dateIcon: ImageConstant.imgCreditCardIcon,
            birthday: "lbl_phone_number".tr,
            birthDateValue: "53 241 141",
            onTapProfileDetailOption: () {},
          ),
          SizedBox(height: 5.v),
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
