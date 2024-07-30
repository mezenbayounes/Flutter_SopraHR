import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/presentation/login_screen/login_screen.dart';

import 'bloc/change_password_bloc.dart';
import 'models/change_password_model.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/core/utils/validation_functions.dart';
import 'package:sopraflutter/widgets/app_bar/appbar_leading_image.dart';
import 'package:sopraflutter/widgets/app_bar/appbar_subtitle.dart';
import 'package:sopraflutter/widgets/app_bar/custom_app_bar.dart';
import 'package:sopraflutter/widgets/custom_elevated_button.dart';
import 'package:sopraflutter/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String email;

  ChangePasswordScreen({required this.email, Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<ChangePasswordBloc>(
        create: (context) => ChangePasswordBloc(
            ChangePasswordState(changePasswordModelObj: ChangePasswordModel()))
          ..add(ChangePasswordInitialEvent()),
        child: ChangePasswordScreen(
          email: '',
        ));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.h, vertical: 26.v),
                    child: Column(children: [
                      _buildOldPassword(context),
                      SizedBox(height: 23.v),
                      _buildNewPassword(context),
                      SizedBox(height: 24.v),
                      _buildConfirmPassword(context),
                      SizedBox(height: 5.v)
                    ]))),
            bottomNavigationBar: _buildSave(context)));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftBlueGray300,
            margin: EdgeInsets.only(left: 16.h, top: 14.v, bottom: 17.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarSubtitle(
            text: "lbl_change_password".tr,
            margin: EdgeInsets.only(left: 12.h)));
  }

  Widget _buildOldPassword(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("lbl_opt".tr, style: Theme.of(context).textTheme.titleSmall),
      SizedBox(height: 12.v),
      BlocSelector<ChangePasswordBloc, ChangePasswordState,
              TextEditingController?>(
          selector: (state) => state.passwordController,
          builder: (context, passwordController) {
            return CustomTextFormField(
                autofocus: false,
                controller: passwordController,
                hintText: "msg".tr,
                hintStyle: CustomTextStyles.labelLargeBluegray300,
                textInputType: TextInputType.visiblePassword,
                prefix: Container(
                    margin: EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
                    child: CustomImageView(
                        imagePath: ImageConstant.imgLock,
                        height: 24.adaptSize,
                        width: 24.adaptSize)),
                prefixConstraints: BoxConstraints(maxHeight: 48.v),
                validator: (value) {
                  if (value == null || (!isValidOTP(value, isRequired: true))) {
                    return "err_msg_please_enter_valid_otp".tr;
                  }
                  return null;
                },
                obscureText: true,
                contentPadding:
                    EdgeInsets.only(top: 15.v, right: 30.h, bottom: 15.v),
                borderDecoration: TextFormFieldStyleHelper.outlineBlueTL5,
                filled: false);
          })
    ]);
  }

  Widget _buildNewPassword(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("lbl_new_password".tr,
          style: Theme.of(context).textTheme.titleSmall),
      SizedBox(height: 12.v),
      BlocSelector<ChangePasswordBloc, ChangePasswordState,
              TextEditingController?>(
          selector: (state) => state.newpasswordController,
          builder: (context, newpasswordController) {
            return CustomTextFormField(
                autofocus: false,
                controller: newpasswordController,
                hintText: "msg".tr,
                hintStyle: CustomTextStyles.labelLargeBluegray300,
                textInputType: TextInputType.visiblePassword,
                prefix: Container(
                    margin: EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
                    child: CustomImageView(
                        imagePath: ImageConstant.imgLock,
                        height: 24.adaptSize,
                        width: 24.adaptSize)),
                prefixConstraints: BoxConstraints(maxHeight: 48.v),
                validator: (value) {
                  if (value == null ||
                      (!isValidPassword(value, isRequired: true))) {
                    return "err_msg_please_enter_valid_password".tr;
                  }
                  return null;
                },
                obscureText: true,
                contentPadding:
                    EdgeInsets.only(top: 15.v, right: 30.h, bottom: 15.v),
                borderDecoration: TextFormFieldStyleHelper.outlineBlueTL5,
                filled: false);
          })
    ]);
  }

  Widget _buildConfirmPassword(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("msg_new_password_again".tr,
          style: Theme.of(context).textTheme.titleSmall),
      SizedBox(height: 11.v),
      BlocSelector<ChangePasswordBloc, ChangePasswordState,
              TextEditingController?>(
          selector: (state) => state.newpasswordController1,
          builder: (context, newpasswordController1) {
            return CustomTextFormField(
                autofocus: false,
                controller: newpasswordController1,
                hintText: "msg".tr,
                hintStyle: CustomTextStyles.labelLargeBluegray300,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.visiblePassword,
                prefix: Container(
                    margin: EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
                    child: CustomImageView(
                        imagePath: ImageConstant.imgLock,
                        height: 24.adaptSize,
                        width: 24.adaptSize)),
                prefixConstraints: BoxConstraints(maxHeight: 48.v),
                validator: (value) {
                  if (value == null ||
                      (!isValidPassword(value, isRequired: true))) {
                    return "err_msg_please_enter_valid_password".tr;
                  }
                  return null;
                },
                obscureText: true,
                contentPadding:
                    EdgeInsets.only(top: 15.v, right: 30.h, bottom: 15.v),
                borderDecoration: TextFormFieldStyleHelper.outlineBlueTL5,
                filled: false);
          })
    ]);
  }

  Widget _buildSave(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_save".tr,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          final changePasswordBloc = context.read<ChangePasswordBloc>();
          final state = changePasswordBloc.state;
          final newPassword = state.newpasswordController?.text ?? '';
          final confirmeNewPassword = state.newpasswordController1?.text ?? '';

          // Check if the new password and confirm password are the same
          if (newPassword != confirmeNewPassword) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error"),
                  content:
                      Text("New password and confirm password do not match."),
                  actions: [
                    ElevatedButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            onTapSave(context);
          }
        }
      },
      margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 50.v),
    );
  }

  void onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }

  Future<void> onTapSave(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? emailFromPrefs = prefs.getString('email');
    final changePasswordBloc = context.read<ChangePasswordBloc>();
    final state = changePasswordBloc.state;
    String email = this.email;
    if (email == "") {
      email = emailFromPrefs ?? "";
    }
    ;
    print(email);
    final newpassword = state.newpasswordController?.text ?? '';
    final otp = state.passwordController?.text ?? '';
    changePasswordBloc.add(ChangePasswordSubmitEvent(otp, newpassword, email));
    NavigatorService.pushNamed(
      AppRoutes.loginScreen,
    );
    // Perform your save operation here using the email and new password
  }
}
