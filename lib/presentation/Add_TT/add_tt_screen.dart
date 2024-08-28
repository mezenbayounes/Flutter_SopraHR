import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/select_drop_list.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/add_tt_bloc.dart';
import 'models/add_tt_model.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/widgets/app_bar/appbar_leading_image.dart';
import 'package:sopraflutter/widgets/app_bar/appbar_subtitle.dart';
import 'package:sopraflutter/widgets/app_bar/custom_app_bar.dart';
import 'package:sopraflutter/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class AddTTScreen extends StatefulWidget {
  const AddTTScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<AddTTBloc>(
        create: (context) =>
            AddTTBloc(AddTTState(lailyfaFebrinaCardModelObj: AddTTModel()))
              ..add(AddTTInitialEvent()),
        child: AddTTScreen());
  }

  @override
  State<AddTTScreen> createState() => _AddTTScreenState();
}

class _AddTTScreenState extends State<AddTTScreen> {
  late DateTime dateDebutG;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            // Positioned.fill to make the background image fill the entire screen
            Positioned.fill(
              child: Opacity(
                opacity: 0.5, // Adjust opacity here (0.0 to 1.0)
                child: Image.asset(
                  bg, // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // CustomScrollView with your content
            CustomScrollView(
              slivers: [
                // Sliver for the card
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.h, vertical: 20.v),
                    child: _buildCard(context),
                  ),
                ),
                // Sliver for the shadowed container with other content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 15.h,
                      right: 15.h,
                      bottom: 5.v,
                      top: 15.v,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.3), // Shadow color
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0, 4), // Position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(
                            12), // Adjust corner radius as needed
                        color:
                            Colors.white, // Background color of the container
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.all(16.h), // Adjust padding as needed
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 23.v),
                            _buildDateRemote(context),
                            SizedBox(height: 60.v),
                            _buildSave(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftBlueGray300,
            margin: EdgeInsets.only(left: 16.h, top: 14.v, bottom: 15.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarSubtitle(
            text: "demande_de_tt".tr, margin: EdgeInsets.only(left: 12.h)));
  }

  /// Section Widget
  Widget _buildCard(BuildContext context) {
    // Use MediaQuery to get the device's screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;

    // Define proportional padding and font sizes based on the screen width
    double horizontalPadding = screenWidth * 0.05; // 5% of screen width
    double verticalPadding = 20; // Fixed vertical padding
    double fontSizeTitle = 0.09 * screenWidth; // 10% of screen width
    double fontSizeSubtitle = 0.04 * screenWidth; // 5% of screen width

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.orange],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Rules".tr, // Updated title
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeTitle,
                ),
              ),
            ),
            SizedBox(height: verticalPadding),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "• You can work remotely up to 2 days per week.".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSubtitle,
                    ),
                  ),
                  SizedBox(height: 8), // Added spacing between rules
                  Text(
                    "• Remote days cannot be consecutive.".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSubtitle,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "• The workspace must maintain 60% occupancy.".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSubtitle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildDateRemote(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Remote Date".tr, style: theme.textTheme.titleSmall),
      SizedBox(height: 11.v),
      EasyDateTimeLine(
        initialDate: DateTime.now(),
        onDateChange: (selectedDate) {
          dateDebutG = selectedDate;
        },
        headerProps: const EasyHeaderProps(
          monthPickerType: MonthPickerType.switcher,
          dateFormatter: DateFormatter.fullDateDMY(),
        ),
        dayProps: const EasyDayProps(
          dayStructure: DayStructure.dayStrDayNum,
          activeDayStyle: DayStyle(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.red,
                  Colors.orange,
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }

  /// Section Widget

  /// Section Widget
  Widget _buildSave(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_save".tr,
      margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 8.v, top: 5),
      onPressed: () async {
        // Validate inputs
        if (_validateInputs()) {
          // Show the confirmation dialog and wait for user response
          final bool? confirmed = await _showConfirmationDialog(context);

          // If user confirms, proceed with onTapSave and show a SnackBar
          if (confirmed == true) {
            // Call the save method
            onTapSave(context);

            // Show the SnackBar
          } else {
            // Optionally, show a different SnackBar if the action was canceled
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Save action canceled"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      },
    );
  }

  /// Navigates to the previous screen.
  onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }

  /// Navigates to the creditCardAndDebitScreen when the action is triggered.
  onTapSave(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt('userID') ?? 0;

    final AskBloc = context.read<AddTTBloc>();

    print(userID);

    print(dateDebutG.toString());

    AskBloc.add(AskEvent(
      id: userID.toString(),
      date_debut: dateDebutG.toString(),
    ));
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 8.0,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 5), // changes the position of the shadow
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                  size: 50.0,
                ),
                SizedBox(height: 15.0),
                Text(
                  'Are you sure?',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Do you really want to pass this request?',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromARGB(255, 111, 120, 127),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromARGB(255, 111, 120, 127),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _validateInputs() {
    if (dateDebutG == null) {
      _showErrorDialog("Les dates sont obligatoires.");
      return false;
    }
    if (dateDebutG.isBefore(DateTime.now())) {
      _showErrorDialog(
          "La date de début ne peut pas être antérieure à aujourd'hui.");
      return false;
    }

    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Rounded corners
          ),
          backgroundColor: Colors.white, // Background color for the dialog
          title: Center(
            child: Icon(
              Icons.error_outline,
              color: Colors.redAccent,
              size: 48.0, // Increased icon size
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center, // Centering the text
            style: TextStyle(
              color: const Color.fromARGB(221, 90, 89, 89), // Text color
              fontSize: 18.0, // Font size
              fontWeight: FontWeight.normal, // Font weight
              fontFamily: 'Roboto', // Custom font family (if needed)
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.redAccent, // Button text color
                    fontWeight: FontWeight.bold, // Bold font for emphasis
                    fontSize: 16.0, // Button font size
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
