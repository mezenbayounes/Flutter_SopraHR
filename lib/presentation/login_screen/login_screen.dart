import 'bloc/login_bloc.dart';
import 'models/login_model.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/core/utils/validation_functions.dart';
import 'package:sopraflutter/widgets/custom_elevated_button.dart';
import 'package:sopraflutter/widgets/custom_icon_button.dart';
import 'package:sopraflutter/widgets/custom_outlined_button.dart';
import 'package:sopraflutter/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:sopraflutter/domain/googleauth/google_auth_helper.dart';
import 'package:sopraflutter/domain/facebookauth/facebook_auth_helper.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(LoginState(loginModelObj: LoginModel()))
          ..add(LoginInitialEvent()),
        child: LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image with opacity
          Opacity(
            opacity: 0.6, // Adjust opacity as needed
            child: Image.asset(
              'assets/images/bglogin.jpeg', // Path to your background image
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Main content
          SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(left: 16.h, top: 120.v, right: 16.h),
              child: Column(
                children: [
                  _buildPageHeader(context),
                  SizedBox(height: 28.v),
                  // Container with shadow effect for text fields and button
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    padding: EdgeInsets.all(16.h), // Adjust padding as needed
                    child: Column(
                      children: [
                        // Email Field with Shadow
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.0),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: BlocSelector<LoginBloc, LoginState,
                              TextEditingController?>(
                            selector: (state) => state.emailController,
                            builder: (context, emailController) {
                              return CustomTextFormField(
                                controller: emailController,
                                hintText: "lbl_your_email".tr,
                                textInputType: TextInputType.emailAddress,
                                prefix: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      16.h, 12.v, 10.h, 12.v),
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgMail,
                                    height: 24.adaptSize,
                                    width: 24.adaptSize,
                                  ),
                                ),
                                prefixConstraints:
                                    BoxConstraints(maxHeight: 48.v),
                                validator: (value) {
                                  if (value == null ||
                                      !isValidEmail(value, isRequired: true)) {
                                    return "err_msg_please_enter_valid_email"
                                        .tr;
                                  }
                                  return null;
                                },
                                contentPadding: EdgeInsets.only(
                                    top: 15.v, right: 30.h, bottom: 15.v),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10.v),
                        // Password Field with Shadow
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.0),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 35, 9, 9),
                          ),
                          child: BlocSelector<LoginBloc, LoginState,
                              TextEditingController?>(
                            selector: (state) => state.passwordController,
                            builder: (context, passwordController) {
                              return CustomTextFormField(
                                controller: passwordController,
                                hintText: "lbl_password".tr,
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.visiblePassword,
                                prefix: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      16.h, 12.v, 10.h, 12.v),
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgLock,
                                    height: 24.adaptSize,
                                    width: 24.adaptSize,
                                  ),
                                ),
                                prefixConstraints:
                                    BoxConstraints(maxHeight: 48.v),
                                validator: (value) {
                                  if (value == null ||
                                      !isValidPassword(value,
                                          isRequired: true)) {
                                    return "err_msg_please_enter_valid_password"
                                        .tr;
                                  }
                                  return null;
                                },
                                obscureText: true,
                                contentPadding: EdgeInsets.only(
                                    top: 15.v, right: 30.h, bottom: 15.v),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 16.v),
                        CustomElevatedButton(
                          text: "lbl_sign_in".tr,
                          onPressed: () {
                            onTapSignIn(context);
                          },
                        ),
                        SizedBox(height: 18.v),
                      ],
                    ),
                  ),
                  // SizedBox(height: 16.v),
                  // _buildOrLine(context),
                  // SizedBox(height: 16.v),
                  //_buildSocialAuthentication(context),
                  SizedBox(height: 17.v),
                  GestureDetector(
                    onTap: () {
                      onTapTxtDonthaveanaccount(context);
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "msg_forgot_password".tr,
                            style: theme.textTheme.bodySmall?.copyWith(
                                color: Color.fromARGB(255, 67, 67, 67),
                                fontSize: 15
                                // Set text color to black
                                ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 7.v),
                  SizedBox(height: 5.v),
                  SizedBox(height: 150),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Column(children: [
      Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), // Shadow color
              spreadRadius: 1, // Spread radius
              blurRadius: 20, // Blur radius
              offset: Offset(0, 3), // Offset in x and y directions
            ),
          ],
        ),
        child: CustomIconButton(
          height: 200,
          width: 200,
          child: CustomImageView(imagePath: ImageConstant.sopraLogo),
        ),
      ),
      SizedBox(height: 25.v),
      Text("msg_welcome_to_soprahr".tr, style: theme.textTheme.titleMedium),
      SizedBox(height: 10.v),
      Text(
        "msg_sign_in_to_continue".tr,
        style: theme.textTheme.bodySmall
            ?.copyWith(color: Color.fromARGB(255, 67, 67, 67), fontSize: 14),
      )
    ]);
  }

  /// Section Widget
  Widget _buildOrLine(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(top: 10.v, bottom: 9.v),
          child: SizedBox(width: 134.h, child: Divider())),
      Text("lbl_or".tr, style: CustomTextStyles.titleSmallBluegray300_1),
      Padding(
          padding: EdgeInsets.only(top: 10.v, bottom: 9.v),
          child: SizedBox(width: 137.h, child: Divider()))
    ]);
  }

  /// Section Widget
  Widget _buildSocialAuthentication(BuildContext context) {
    return Column(children: [
      CustomOutlinedButton(
          text: "msg_login_with_google".tr,
          leftIcon: Container(
              margin: EdgeInsets.only(right: 30.h),
              child: CustomImageView(
                  imagePath: ImageConstant.imgGoogleIcon,
                  height: 24.adaptSize,
                  width: 24.adaptSize)),
          onPressed: () {
            onTapLoginWithGoogle(context);
          }),
      SizedBox(height: 8.v),
      CustomOutlinedButton(
          text: "msg_login_with_facebook".tr,
          leftIcon: Container(
              margin: EdgeInsets.only(right: 30.h),
              child: CustomImageView(
                  imagePath: ImageConstant.imgFacebookIcon,
                  height: 24.adaptSize,
                  width: 24.adaptSize)),
          onPressed: () {
            onTapLoginWithFacebook(context);
          })
    ]);
  }

  /// Navigates to the dashboardContainerScreen when the action is triggered.
  onTapSignIn(BuildContext context) {
    // Access the bloc instance
    final loginBloc = context.read<LoginBloc>();

    // Retrieve email and password from text controllers
    final email = loginBloc.state.emailController?.text ?? '';
    final password = loginBloc.state.passwordController?.text ?? '';
    print(email);
    print(password);
    // Dispatch the LoginSubmitEvent to the bloc

    loginBloc.add(LoginSubmitEvent(email: email, password: password));
  }

  /// Performs a Google sign-in and returns a [GoogleUser] object.
  ///
  /// If the sign-in is successful, the [onSuccess] callback will be called with
  /// a TODO comment needed to be modified by you.
  /// If the sign-in fails, the [onError] callback will be called with the error message.
  ///
  /// Throws an exception if the Google sign-in process fails.
  onTapLoginWithGoogle(BuildContext context) async {
    await GoogleAuthHelper().googleSignInProcess().then((googleUser) {
      if (googleUser != null) {
        //TODO Actions to be performed after signin
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('user data is empty')));
      }
    }).catchError((onError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(onError.toString())));
    });
  }

  /// Performs a Facebook sign-in and returns a [FacebookUser] object.
  ///
  /// If the sign-in is successful, the [onSuccess] callback will be called with
  /// a TODO comment needed to be modified by you.
  /// If the sign-in fails, the [onError] callback will be called with the error message.
  ///
  /// Throws an exception if the Facebook sign-in process fails.
  onTapLoginWithFacebook(BuildContext context) async {
    await FacebookAuthHelper().facebookSignInProcess().then((facebookUser) {
      //TODO Actions to be performed after signin
    }).catchError((onError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(onError.toString())));
    });
  }

  /// Navigates to the registerScreen when the action is triggered.
  onTapTxtDonthaveanaccount(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.forgetPassword,
    );
  }
}
