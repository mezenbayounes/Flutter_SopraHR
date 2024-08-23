import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/select_drop_list.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/lailyfa_febrina_card_bloc.dart';
import 'models/lailyfa_febrina_card_model.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/widgets/app_bar/appbar_leading_image.dart';
import 'package:sopraflutter/widgets/app_bar/appbar_subtitle.dart';
import 'package:sopraflutter/widgets/app_bar/custom_app_bar.dart';
import 'package:sopraflutter/widgets/custom_elevated_button.dart';
import 'package:sopraflutter/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LailyfaFebrinaCardScreen extends StatefulWidget {
  const LailyfaFebrinaCardScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<LailyfaFebrinaCardBloc>(
        create: (context) => LailyfaFebrinaCardBloc(LailyfaFebrinaCardState(
            lailyfaFebrinaCardModelObj: LailyfaFebrinaCardModel()))
          ..add(LailyfaFebrinaCardInitialEvent()),
        child: LailyfaFebrinaCardScreen());
  }

  @override
  State<LailyfaFebrinaCardScreen> createState() =>
      _LailyfaFebrinaCardScreenState();
}

class _LailyfaFebrinaCardScreenState extends State<LailyfaFebrinaCardScreen> {
  String causeG = "";
  String typeG = "";
  String scDebutG = "";
  String scFinG = "";
  late DateTime dateDebutG;
  late DateTime dateFinG;
  TextEditingController _causeController = TextEditingController();
  @override
  void dispose() {
    _causeController.dispose();
    super.dispose();
  }

  void _updateCause() {
    setState(() {
      // Update your local state with the value from the text field
      causeG = _causeController.text;
      // Do something with the cause
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: CustomScrollView(
          slivers: [
            // Sliver for the card
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 8.v),
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
                        color: Colors.black.withOpacity(0.3), // Shadow color
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 4), // Position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(
                        12), // Adjust corner radius as needed
                    color: Colors.white, // Background color of the container
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.h), // Adjust padding as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDropDwonTypeConge(context),
                        SizedBox(height: 24.v),
                        _buildTextFieldCause(context),
                        SizedBox(height: 29.v),
                        _buildDateDebut(context),
                        SizedBox(height: 23.v),
                        _buildScDebut(context),
                        SizedBox(height: 23.v),
                        _buildDateFin(context),
                        SizedBox(height: 23.v),
                        _buildScFin(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildSave(context),
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
            text: "demande_de_conge".tr, margin: EdgeInsets.only(left: 12.h)));
  }

  /// Section Widget
  Widget _buildCard(BuildContext context) {
    // Use MediaQuery to get the device's screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;

    // Define proportional padding and font sizes based on the screen width
    double horizontalPadding = screenWidth * 0.05; // 5% of screen width
    double verticalPadding = 20; // Fixed vertical padding
    double fontSizeTitle = 0.1 * screenWidth; // 10% of screen width
    double fontSizeSubtitle = 0.05 * screenWidth; // 5% of screen width

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
                "il_vous_rest".tr,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Congés Payés".tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeSubtitle,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "22",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeSubtitle - 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05), // 5% of screen width
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Congés Maladie".tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeSubtitle,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "5",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeSubtitle - 3,
                          ),
                        ),
                      ],
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
  Widget _buildDropDwonTypeConge(BuildContext context) {
    DropListModel dropListModel = DropListModel([
      OptionItem(id: "1", title: "Congé_payé".tr, data: 'Congé_payé'),
      OptionItem(id: "2", title: "Congé_Maladie".tr, data: 'Congé_Maladie'),
      OptionItem(id: "3", title: "Congé_non_payé".tr, data: 'Congé_non_payé'),
    ]);
    OptionItem optionItemSelected = OptionItem(title: "choisi_type_conge".tr);

    TextEditingController controller = TextEditingController();
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("type_de_conge".tr, style: theme.textTheme.titleSmall),
          SelectDropList(
            itemSelected: optionItemSelected,
            dropListModel: dropListModel,
            showIcon: false,
            showArrowIcon: true,
            showBorder: true,
            enable: true,
            paddingTop: 0,
            paddingDropItem:
                const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
            suffixIcon: Icons.arrow_drop_down,
            containerPadding: const EdgeInsets.all(10),
            icon: const Icon(Icons.person, color: Colors.black),
            onOptionSelected: (optionItem) {
              optionItemSelected = optionItem;
              print(optionItemSelected.title);
              setState(() {
                optionItemSelected = optionItem;
                typeG = optionItem.title;
              });
            },
          ),
        ]);
  }

  /// Section Widget
  Widget _buildTextFieldCause(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 2.h),
          child: Text(
            "Cause".tr,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SizedBox(height: 11.v),
        Padding(
          padding: EdgeInsets.only(left: 2.h),
          child: BlocSelector<LailyfaFebrinaCardBloc, LailyfaFebrinaCardState,
              TextEditingController?>(
            selector: (state) => state.expirationDateController,
            builder: (context, expirationDateController) {
              return TextFormField(
                controller: _causeController,
                decoration: InputDecoration(
                  hintText: "enter_cause".tr,
                  hintStyle: CustomTextStyles.labelLargeBluegray300SemiBold,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.h, vertical: 15.v),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                maxLength: 200, // Maximum length of 200 characters
                onChanged: (text) {
                  // Optionally, you can call setState here if you need to update immediately
                  _updateCause();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildDateDebut(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("date_debut".tr, style: theme.textTheme.titleSmall),
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
  Widget _buildScDebut(BuildContext context) {
    DropListModel dropListModel = DropListModel([
      OptionItem(id: "1", title: "matin".tr, data: 'matin'),
      OptionItem(id: "2", title: "apres_midi".tr, data: 'apres_midi'),
    ]);
    OptionItem optionItemSelected = OptionItem(title: "choisi_sc_debut".tr);

    TextEditingController controller = TextEditingController();
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("sc_debut".tr, style: theme.textTheme.titleSmall),
          SelectDropList(
            itemSelected: optionItemSelected,
            dropListModel: dropListModel,
            showIcon: false,
            showArrowIcon: true,
            showBorder: true,
            enable: true,
            paddingTop: 0,
            paddingDropItem:
                const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
            suffixIcon: Icons.arrow_drop_down,
            containerPadding: const EdgeInsets.all(10),
            icon: const Icon(Icons.person, color: Colors.black),
            onOptionSelected: (optionItem) {
              optionItemSelected = optionItem;
              print(optionItemSelected.title);
              setState(() {
                optionItemSelected = optionItem;
                scDebutG = optionItem.title;
              });
            },
          ),
        ]);
  }

  Widget _buildDateFin(BuildContext context) {
    DateTime date;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("date_fin".tr, style: theme.textTheme.titleSmall),
      SizedBox(height: 11.v),
      EasyDateTimeLine(
        initialDate: DateTime.now(),
        onDateChange: (selectedDate) {
          dateFinG = selectedDate;
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

  Widget _buildScFin(BuildContext context) {
    DropListModel dropListModel = DropListModel([
      OptionItem(id: "1", title: "matin".tr, data: 'matin'),
      OptionItem(id: "2", title: "apres_midi".tr, data: 'apres_midi'),
    ]);
    OptionItem optionItemSelected = OptionItem(title: "choisi_sc_fin".tr);

    TextEditingController controller = TextEditingController();
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("sc_fin".tr, style: theme.textTheme.titleSmall),
          SelectDropList(
            itemSelected: optionItemSelected,
            dropListModel: dropListModel,
            showIcon: false,
            showArrowIcon: true,
            showBorder: false,
            enable: true,
            paddingTop: 0,
            paddingDropItem:
                const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
            suffixIcon: Icons.arrow_drop_down,
            containerPadding: const EdgeInsets.all(10),
            icon: const Icon(Icons.person, color: Colors.black),
            onOptionSelected: (optionItem) {
              optionItemSelected = optionItem;
              print(optionItemSelected.title);
              setState(() {
                optionItemSelected = optionItem;
                scFinG = optionItem.title;
              });
            },
          ),
        ]);
  }

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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Save action confirmed"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
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

    final AskBloc = context.read<LailyfaFebrinaCardBloc>();

    print(userID);
    print(typeG);
    print(causeG);
    print(dateDebutG);
    print(scDebutG);
    print(dateFinG);
    print(scFinG);
    AskBloc.add(AskEvent(
        id: userID.toString(),
        type: typeG,
        cause: causeG,
        date_debut: dateDebutG.toString(),
        date_fin: dateFinG.toString(),
        sc_debut: scDebutG,
        sc_fin: scFinG));
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
    if (causeG.isEmpty) {
      _showErrorDialog("La cause est obligatoire.");
      return false;
    }
    if (typeG.isEmpty) {
      _showErrorDialog("Le type de congé est obligatoire.");
      return false;
    }
    if (scDebutG.isEmpty) {
      _showErrorDialog("Le début du congé est obligatoire.");
      return false;
    }
    if (scFinG.isEmpty) {
      _showErrorDialog("La fin du congé est obligatoire.");
      return false;
    }
    if (dateDebutG == null || dateFinG == null) {
      _showErrorDialog("Les dates sont obligatoires.");
      return false;
    }
    if (dateDebutG.isBefore(DateTime.now())) {
      _showErrorDialog(
          "La date de début ne peut pas être antérieure à aujourd'hui.");
      return false;
    }
    if (dateFinG.isBefore(dateDebutG)) {
      _showErrorDialog(
          "La date de fin ne peut pas être antérieure à la date de début.");
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
