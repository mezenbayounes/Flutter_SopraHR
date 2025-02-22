import 'bloc/payment_method_bloc.dart';
import 'models/payment_method_model.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/widgets/app_bar/appbar_leading_image.dart';
import 'package:sopraflutter/widgets/app_bar/appbar_subtitle.dart';
import 'package:sopraflutter/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<PaymentMethodBloc>(
        create: (context) => PaymentMethodBloc(
            PaymentMethodState(paymentMethodModelObj: PaymentMethodModel()))
          ..add(PaymentMethodInitialEvent()),
        child: PaymentMethodScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
        builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              appBar: _buildAppBar(context),
              body: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 10.v),
                  child: Column(children: [
                    _buildPaymentOption(context,
                        paypalIcon: ImageConstant.imgCreditCardIcon,
                        paypalLabel: "msg_credit_card_or_debit".tr,
                        onTapPaymentOption: () {
                      onTapPaymentOption(context);
                    }),
                    _buildPaymentOption(context,
                        paypalIcon: ImageConstant.imgPaypalIcon,
                        paypalLabel: "lbl_paypal".tr),
                    SizedBox(height: 5.v),
                    _buildPaymentOption(context,
                        paypalIcon: ImageConstant.imgAirplanePrimary,
                        paypalLabel: "lbl_bank_transfer".tr)
                  ]))));
    });
  }

  /// Section Widget
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
            text: "lbl_payment".tr, margin: EdgeInsets.only(left: 12.h)));
  }

  /// Common widget
  Widget _buildPaymentOption(
    BuildContext context, {
    required String paypalIcon,
    required String paypalLabel,
    Function? onTapPaymentOption,
  }) {
    return GestureDetector(
        onTap: () {
          onTapPaymentOption!.call();
        },
        child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(16.h),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Row(children: [
              CustomImageView(
                  imagePath: paypalIcon,
                  height: 24.adaptSize,
                  width: 24.adaptSize),
              Padding(
                  padding: EdgeInsets.only(left: 16.h, top: 4.v),
                  child: Text(paypalLabel,
                      style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(1))))
            ])));
  }

  /// Navigates to the previous screen.
  onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }

  /// Navigates to the chooseCreditOrDebitCardScreen when the action is triggered.
  onTapPaymentOption(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.chooseCreditOrDebitCardScreen,
    );
  }
}
