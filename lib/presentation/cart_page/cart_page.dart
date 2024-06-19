import '../cart_page/widgets/cartlist_item_widget.dart';
import 'bloc/cart_bloc.dart';
import 'models/cart_model.dart';
import 'models/cartlist_item_model.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/widgets/app_bar/appbar_title.dart';
import 'package:sopraflutter/widgets/app_bar/appbar_trailing_image.dart';
import 'package:sopraflutter/widgets/app_bar/custom_app_bar.dart';
import 'package:sopraflutter/widgets/custom_elevated_button.dart';
import 'package:sopraflutter/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<CartBloc>(
        create: (context) => CartBloc(CartState(cartModelObj: CartModel()))
          ..add(CartInitialEvent()),
        child: CartPage());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 7.v),
                child: Column(children: [
                  _buildCartList(context),
                  SizedBox(height: 52.v),
                  _buildCouponCodeRow(context),
                  SizedBox(height: 16.v),
                  _buildTotalPriceDetailsColumn(context),
                  SizedBox(height: 16.v),
                  CustomElevatedButton(
                      text: "lbl_check_out".tr,
                      onPressed: () {
                        onTapCheckOut(context);
                      }),
                  SizedBox(height: 8.v)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        title: AppbarTitle(
            text: "lbl_your_cart".tr, margin: EdgeInsets.only(left: 16.h)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgNotificationIcon,
              margin: EdgeInsets.fromLTRB(13.h, 15.v, 13.h, 16.v),
              onTap: () {
                onTapNotificationIcon(context);
              })
        ]);
  }

  /// Section Widget
  Widget _buildCartList(BuildContext context) {
    return BlocSelector<CartBloc, CartState, CartModel?>(
        selector: (state) => state.cartModelObj,
        builder: (context, cartModelObj) {
          return ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(height: 16.v);
              },
              itemCount: cartModelObj?.cartlistItemList.length ?? 0,
              itemBuilder: (context, index) {
                CartlistItemModel model =
                    cartModelObj?.cartlistItemList[index] ??
                        CartlistItemModel();
                return CartlistItemWidget(model);
              });
        });
  }

  /// Section Widget
  Widget _buildCouponCodeRow(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
          child: BlocSelector<CartBloc, CartState, TextEditingController?>(
              selector: (state) => state.cuponCodeController,
              builder: (context, cuponCodeController) {
                return CustomTextFormField(
                    controller: cuponCodeController,
                    hintText: "msg_enter_cupon_code".tr,
                    textInputAction: TextInputAction.done,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12.h, vertical: 19.v));
              })),
      CustomElevatedButton(
          width: 87.h,
          text: "lbl_apply".tr,
          buttonStyle: CustomButtonStyles.fillPrimary,
          buttonTextStyle: CustomTextStyles.labelLargeOnPrimaryContainer)
    ]);
  }

  /// Section Widget
  Widget _buildTotalPriceDetailsColumn(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15.h),
        decoration: AppDecoration.outlineBlue50
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildShoppingPrice(context,
                  shippingLabel: "lbl_items_3".tr, priceLabel: "lbl_598_86".tr),
              SizedBox(height: 16.v),
              _buildShoppingPrice(context,
                  shippingLabel: "lbl_shipping".tr, priceLabel: "lbl_40_00".tr),
              SizedBox(height: 14.v),
              _buildShoppingPrice(context,
                  shippingLabel: "lbl_import_charges".tr,
                  priceLabel: "lbl_128_00".tr),
              SizedBox(height: 12.v),
              Divider(),
              SizedBox(height: 10.v),
              _buildShoppingPrice(context,
                  shippingLabel: "lbl_total_price".tr,
                  priceLabel: "lbl_766_86".tr)
            ]));
  }

  /// Common widget
  Widget _buildShoppingPrice(
    BuildContext context, {
    required String shippingLabel,
    required String priceLabel,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(top: 1.v),
          child: Text(shippingLabel,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: appTheme.blueGray300))),
      Text(priceLabel,
          style: CustomTextStyles.bodySmallOnPrimary
              .copyWith(color: theme.colorScheme.onPrimary.withOpacity(1)))
    ]);
  }

  /// Navigates to the notificationScreen when the action is triggered.
  onTapNotificationIcon(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.notificationScreen,
    );
  }

  /// Navigates to the shipToScreen when the action is triggered.
  onTapCheckOut(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.shipToScreen,
    );
  }
}
