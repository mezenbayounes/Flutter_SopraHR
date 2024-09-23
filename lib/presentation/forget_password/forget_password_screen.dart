import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sopraflutter/presentation/change_password_screen/change_password_screen.dart';
import 'package:sopraflutter/presentation/forget_password/bloc/forget_password_bloc.dart';
import 'package:sopraflutter/presentation/forget_password/models/forget_password_model.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/core/utils/validation_functions.dart';
import 'package:sopraflutter/widgets/custom_elevated_button.dart';
import 'package:sopraflutter/widgets/custom_icon_button.dart';
import 'package:sopraflutter/widgets/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<ForgetPasswordBloc>(
      create: (context) => ForgetPasswordBloc(
          ForgetPasswordState(forgetPasswordModel: ForgetPasswordModel()))
        ..add(ForgetPasswordInitialEvent()),
      child: ForgetPasswordScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset:
            true, // Set to true to avoid the keyboard covering the content
        body: Stack(
          children: [
            // Background image with opacity
            Opacity(
              opacity: 0.6, // Adjust opacity as needed
              child: Image.asset(
                bg, // Replace with your image path
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            // Main content of the screen
            SingleChildScrollView(
              // Wrap the content with SingleChildScrollView
              child: Padding(
                padding: EdgeInsets.only(left: 16.h, top: 80.v, right: 16.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildPageHeader(context),
                      SizedBox(height: 28.v),
                      BlocSelector<ForgetPasswordBloc, ForgetPasswordState,
                          TextEditingController?>(
                        selector: (state) => state.emailController,
                        builder: (context, emailController) {
                          return CustomTextFormField(
                            controller: emailController,
                            hintText: "lbl_your_email".tr,
                            textInputType: TextInputType.emailAddress,
                            prefix: Container(
                              margin:
                                  EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgMail,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                              ),
                            ),
                            prefixConstraints: BoxConstraints(maxHeight: 48.v),
                            validator: (value) {
                              if (value == null ||
                                  !isValidEmail(value, isRequired: true)) {
                                return "err_msg_please_enter_valid_email".tr;
                              }
                              return null;
                            },
                            contentPadding: EdgeInsets.only(
                                top: 15.v, right: 20.h, bottom: 15.v),
                          );
                        },
                      ),
                      SizedBox(height: 20.v),
                      SizedBox(height: 30.v),
                      BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return CircularProgressIndicator();
                          } else {
                            return CustomElevatedButton(
                              text: "lbl_send_otp".tr,
                              onPressed: () {
                                onTapSignIn(context);
                              },
                            );
                          }
                        },
                      ),
                      SizedBox(height: 100.v),
                      BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                        builder: (context, state) {
                          if (state.errorMessage != null) {
                            return Text(
                              state.errorMessage!,
                              style: TextStyle(color: Colors.red),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    return Column(
      children: [
        CustomIconButton(
          height: 300,
          width: 400,
          child: CustomImageView(imagePath: ImageConstant.forgetPassword),
        ),
        SizedBox(height: 30.v),
        Text("msg_forget_password".tr, style: theme.textTheme.titleMedium),
        SizedBox(height: 10.v),
        Text("msg_please_enter_your_email".tr,
            style: theme.textTheme.bodySmall),
      ],
    );
  }

  void onTapSignIn(BuildContext context) {
    final forgetPasswordBloc = context.read<ForgetPasswordBloc>();
    final email = forgetPasswordBloc.state.emailController?.text ?? '';
    forgetPasswordBloc.add(ForgetPasswordSubmitEvent(email: email));
  }
}
