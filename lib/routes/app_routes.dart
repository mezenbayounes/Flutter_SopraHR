import 'package:flutter/material.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/presentation/Add_TT/add_tt_screen.dart';
import 'package:sopraflutter/presentation/News_page/screens/home_screen.dart';
import 'package:sopraflutter/presentation/Settings_page/SettingsPage.dart';
import 'package:sopraflutter/presentation/add_conge_admin/home_add_screen.dart';
import 'package:sopraflutter/presentation/consulterAdmin/screens/home_screenConsulterAdmin.dart';
import 'package:sopraflutter/presentation/consulterRequestAdmin/screens/home_screenConsulterAdmin.dart';
import 'package:sopraflutter/presentation/consulterRequestEmployee/screens/home_screenConsulterAdmin.dart';
import 'package:sopraflutter/presentation/forget_password/forget_password_screen.dart';
import 'package:sopraflutter/presentation/notification_page/screens/notification_screen_page.dart';
import 'package:sopraflutter/presentation/splash_screen/splash_screen.dart';
import 'package:sopraflutter/presentation/login_screen/login_screen.dart';
import 'package:sopraflutter/presentation/register_screen/register_screen.dart';
import 'package:sopraflutter/presentation/dashboard_container_screen/dashboard_container_screen.dart';
import 'package:sopraflutter/presentation/super_flash_sale_screen/super_flash_sale_screen.dart';
import 'package:sopraflutter/presentation/favorite_product_screen/favorite_product_screen.dart';
import 'package:sopraflutter/presentation/product_detail_screen/product_detail_screen.dart';
import 'package:sopraflutter/presentation/review_product_screen/review_product_screen.dart';
import 'package:sopraflutter/presentation/write_review_fill_screen/write_review_fill_screen.dart';
import 'package:sopraflutter/presentation/notification_screen/notification_screen.dart';
import 'package:sopraflutter/presentation/notification_offer_screen/notification_offer_screen.dart';
import 'package:sopraflutter/presentation/notification_feed_screen/notification_feed_screen.dart';
import 'package:sopraflutter/presentation/notification_activity_screen/notification_activity_screen.dart';
import 'package:sopraflutter/presentation/search_screen/search_screen.dart';
import 'package:sopraflutter/presentation/search_result_screen/search_result_screen.dart';
import 'package:sopraflutter/presentation/search_result_no_data_found_screen/search_result_no_data_found_screen.dart';
import 'package:sopraflutter/presentation/list_category_screen/list_category_screen.dart';
import 'package:sopraflutter/presentation/sort_by_screen/sort_by_screen.dart';
import 'package:sopraflutter/presentation/filter_screen/filter_screen.dart';
import 'package:sopraflutter/presentation/ship_to_screen/ship_to_screen.dart';
import 'package:sopraflutter/presentation/payment_method_screen/payment_method_screen.dart';
import 'package:sopraflutter/presentation/choose_credit_or_debit_card_screen/choose_credit_or_debit_card_screen.dart';
import 'package:sopraflutter/presentation/success_screen/success_screen.dart';
import 'package:sopraflutter/presentation/profile_screen/profile_screen.dart';
import 'package:sopraflutter/presentation/change_password_screen/change_password_screen.dart';
import 'package:sopraflutter/presentation/order_screen/order_screen.dart';
import 'package:sopraflutter/presentation/order_details_screen/order_details_screen.dart';
import 'package:sopraflutter/presentation/add_address_screen/add_address_screen.dart';
import 'package:sopraflutter/presentation/address_screen/address_screen.dart';
import 'package:sopraflutter/presentation/add_payment_screen/add_payment_screen.dart';
import 'package:sopraflutter/presentation/credit_card_and_debit_screen/credit_card_and_debit_screen.dart';
import 'package:sopraflutter/presentation/add_card_screen/add_card_screen.dart';
import 'package:sopraflutter/presentation/Add_Conge/add_conge_screen.dart';
import 'package:sopraflutter/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:sopraflutter/presentation/add_tt_conge/home_add_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String loginScreen = '/login_screen';

  static const String homeADD = '/home_add';
  static const String homeScreenConsluterAdmin = '/homeScreenConsluter';
  static const String homeScreenConsulterRequestEmployee =
      '/homeScreenConsulterRequestEmployee';
       static const String homeScreenConsulterRequestAdmin =
      '/homeScreenConsulterRequestAdmin';

  static const String notificationScreenPage = '/notificationScreenPage';

  static const String settingsPage = '/Settings_Page';

  static const String homeADDAdmin = '/home_add_admin';

  static const String homeScreenNews = '/home_screen_news';

  static const String registerScreen = '/register_screen';

  static const String forgetPassword = '/forget_password';

  static const String dashboardPage = '/dashboard_page';

  static const String dashboardContainerScreen = '/dashboard_container_screen';

  static const String superFlashSaleScreen = '/super_flash_sale_screen';

  static const String favoriteProductScreen = '/favorite_product_screen';

  static const String productDetailScreen = '/product_detail_screen';

  static const String reviewProductScreen = '/review_product_screen';

  static const String writeReviewFillScreen = '/write_review_fill_screen';

  static const String notificationScreen = '/notification_screen';

  static const String notificationOfferScreen = '/notification_offer_screen';

  static const String notificationFeedScreen = '/notification_feed_screen';

  static const String notificationActivityScreen =
      '/notification_activity_screen';

  static const String explorePage = '/explore_page';

  static const String searchScreen = '/search_screen';

  static const String searchResultScreen = '/search_result_screen';

  static const String searchResultNoDataFoundScreen =
      '/search_result_no_data_found_screen';

  static const String listCategoryScreen = '/list_category_screen';

  static const String sortByScreen = '/sort_by_screen';

  static const String filterScreen = '/filter_screen';

  static const String cartPage = '/cart_page';

  static const String shipToScreen = '/ship_to_screen';

  static const String paymentMethodScreen = '/payment_method_screen';

  static const String chooseCreditOrDebitCardScreen =
      '/choose_credit_or_debit_card_screen';

  static const String successScreen = '/success_screen';

  static const String offerScreenPage = '/offer_screen_page';

  static const String accountPage = '/account_page';

  static const String profileScreen = '/profile_screen';

  static const String changePasswordScreen = '/change_password_screen';

  static const String orderScreen = '/order_screen';

  static const String orderDetailsScreen = '/order_details_screen';

  static const String addAddressScreen = '/add_address_screen';

  static const String addressScreen = '/address_screen';

  static const String addPaymentScreen = '/add_payment_screen';

  static const String creditCardAndDebitScreen =
      '/credit_card_and_debit_screen';

  static const String addCardScreen = '/add_card_screen';

  static const String addCongeScreen = '/addCongeScreen';
    static const String addTTScreen = '/addTTScreen';


  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
        splashScreen: SplashScreen.builder,
        loginScreen: LoginScreen.builder,
        homeADD: homeAdd.builder,
        homeADDAdmin: homeAddAdmin.builder,
        homeScreenConsluterAdmin: HomeScreenConsluterAdmin.builder,
        homeScreenConsulterRequestEmployee:
            HomeScreenConsulterRequestEmployee.builder,
homeScreenConsulterRequestAdmin:
            HomeScreenConsulterRequestAdmin.builder,
            
                    notificationScreenPage: NotificationScreenPage.builder,

        homeScreenNews: HomeScreen.builder,
        settingsPage: SettingsPage.builder,
        registerScreen: RegisterScreen.builder,
        forgetPassword: ForgetPasswordScreen.builder,
        dashboardContainerScreen: DashboardContainerScreen.builder,
        superFlashSaleScreen: SuperFlashSaleScreen.builder,
        favoriteProductScreen: FavoriteProductScreen.builder,
        productDetailScreen: ProductDetailScreen.builder,
        reviewProductScreen: ReviewProductScreen.builder,
        writeReviewFillScreen: WriteReviewFillScreen.builder,
        notificationScreen: NotificationScreen.builder,
        notificationOfferScreen: NotificationOfferScreen.builder,
        notificationFeedScreen: NotificationFeedScreen.builder,
        notificationActivityScreen: NotificationActivityScreen.builder,
        searchScreen: SearchScreen.builder,
        searchResultScreen: SearchResultScreen.builder,
        searchResultNoDataFoundScreen: SearchResultNoDataFoundScreen.builder,
        listCategoryScreen: ListCategoryScreen.builder,
        sortByScreen: SortByScreen.builder,
        filterScreen: FilterScreen.builder,
        shipToScreen: ShipToScreen.builder,
        paymentMethodScreen: PaymentMethodScreen.builder,
        chooseCreditOrDebitCardScreen: ChooseCreditOrDebitCardScreen.builder,
        successScreen: SuccessScreen.builder,
        profileScreen: ProfileScreen.builder,
        changePasswordScreen: ChangePasswordScreen.builder,
        orderScreen: OrderScreen.builder,
        orderDetailsScreen: OrderDetailsScreen.builder,
        addAddressScreen: AddAddressScreen.builder,
        addressScreen: AddressScreen.builder,
        addPaymentScreen: AddPaymentScreen.builder,
        creditCardAndDebitScreen: CreditCardAndDebitScreen.builder,
        addCardScreen: AddCardScreen.builder,
        addCongeScreen: AddCongeScreen.builder,
        addTTScreen: AddTTScreen.builder,

        appNavigationScreen: AppNavigationScreen.builder,
        initialRoute: SplashScreen.builder
      };
}
