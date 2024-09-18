import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/presentation/BottomNavBar/BottomNavBar.dart';
import 'package:sopraflutter/presentation/Settings_page/LocaleBloc.dart';
import 'package:sopraflutter/presentation/Settings_page/components/Logout_Button.dart';
import 'package:sopraflutter/presentation/Settings_page/components/My_Button_Settings.dart';
import 'package:sopraflutter/presentation/Settings_page/components/My_button_terms.dart';

class SettingsPage extends StatefulWidget {
  static WidgetBuilder get builder => (BuildContext context) => SettingsPage();

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void visible() {}
  bool isVisible = false;
  bool isVisible2 = false;

  final IconData _iconLight = Icons.wb_sunny;
  final IconData _iconDark = Icons.nights_stay;
  bool iconBool = true;

  @override
  Widget build(BuildContext context) {
    const moonIcon = CupertinoIcons.moon_stars;
    bool getresult() {
      return iconBool;
    }

    return Scaffold(
      backgroundColor:
          Colors.transparent, // Ensure Scaffold background is transparent
      body: Stack(
        fit: StackFit.expand, // Ensure Stack covers the entire screen
        children: [
          // Background image
          Positioned.fill(
            child: Opacity(
              opacity: .9,
              child: Image.asset(
                bg,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 60),
                  LayoutBuilder(builder: (context, constraints) {
                    double imageHeight = constraints.maxWidth < 600 ? 250 : 300;
                    return Image.asset(
                      'assets/images/settings.png',
                      height: imageHeight,
                    );
                  }),
                  SizedBox(height: 40),
                  My_Button_Setting(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    text: 'General Settings',
                    icon: Icons.arrow_forward_ios_rounded,
                  ),
                  Divider(
                    color: Colors.grey[300],
                    height: 0,
                    thickness: 2,
                  ),
                  Visibility(
                    visible: isVisible,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(22.0),
                              child: Text(
                                'Version',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 118, 115, 115),
                                ),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    '1.0.1',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  My_Button_terms(
                    onTap: () {
                      setState(() {
                        isVisible2 = !isVisible2;
                      });
                    },
                    text: 'Terms And Conditions',
                    icon: Icons.arrow_forward_ios_rounded,
                  ),
                  Divider(
                    color: Colors.grey[300],
                    height: 0,
                    thickness: 2,
                  ),
                  Visibility(
                    visible: isVisible2,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Column(
                      children: [
                        LayoutBuilder(builder: (context, constraints) {
                          double imageWidth =
                              constraints.maxWidth < 600 ? 50 : 100;
                          double padding = constraints.maxWidth < 600 ? 10 : 50;
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/terms.png',
                                height: imageWidth,
                                width: imageWidth,
                              ),
                              SizedBox(width: padding),
                              Image.asset(
                                'assets/images/soprahr.png',
                                height: imageWidth,
                                width: imageWidth,
                              ),
                            ],
                          );
                        }),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            "TERMS AND CONDITIONS",
                            style: TextStyle(
                              fontSize: 19,
                              color: Color.fromARGB(235, 255, 2, 2),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(19.0),
                          child: const Text(
                            "Welcome to Plateau Manager & Recruitment Assistant. These Terms and Conditions govern your use of the Application provided by Sopra HR . By using the Application, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use the Application.",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(235, 255, 2, 2),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15),
                          child: const Text(
                            'Definitions ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: const Text(
                            'User" refers to any individual or entity using the Application. "Application" means the software platform provided by Sopra HR for managing workspaces and optimizing recruitment processes. "Content" includes all text, information, data, software, graphics, and other materials provided within the Application.',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15),
                          child: const Text(
                            'Prohibited Uses ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: const Text(
                            'You agree not to use the Application for any unlawful purpose, interfere with the operation of the Application or the servers hosting it, reverse engineer, decompile, or disassemble any part of the Application, or share your account details with unauthorized third parties.',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15),
                          child: const Text(
                            'Account Security',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: const Text(
                            'You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. Notify us immediately of any unauthorized use of your account.',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15),
                          child: const Text(
                            'Data Security',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: const Text(
                            'We implement measures to protect the security of your data, including authentication, authorization, and encryption. However, we cannot guarantee absolute security and are not liable for any breaches of data security.',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15),
                          child: const Text(
                            'Modifications to the Terms',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: const Text(
                            'We reserve the right to modify these Terms at any time. Any changes will be effective upon posting on the Application. Your continued use of the Application after such modifications constitutes your acceptance of the new Terms.',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15),
                          child: const Text(
                            'Contact Us',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: const Text(
                            'If you have any questions about these terms and conditions, please contact us at mezen.bayounes@esprit.tn.',
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Divider(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      height: 0,
                      thickness: 2,
                    ),
                  ),
                  LogOutButton(
                    onTap: visible,
                    text: 'Log Out',
                    icon: Icons.logout,
                    buttonColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: BottomNavBarV2(
          index: 3,
        ),
      ),
    );
  }
}
