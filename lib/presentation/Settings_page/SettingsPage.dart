import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sopraflutter/presentation/BottomNavBar/BottomNavBar.dart';
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bgme.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
            child: Center(
                child: Column(
          children: [
//Logo
            SizedBox(
              height: 60,
            ),
            Image.asset(
              'assets/images/settings.png',
              height: 300,
            ),
            My_Button_Setting(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                text: 'General Settings',
                icon: Icons.arrow_forward_ios_rounded),
            Divider(
              color: Colors.grey[300],
              height: 0,
              thickness: 2,
            ),
            Row(
              children: [
                Visibility(
                  visible: isVisible,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(22.0),
                            child: Text(
                              'Dark mode',
                              style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 118, 115, 115),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 200),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    iconBool = !iconBool;

                                    //print(icondark.IconDL);
                                  });
                                },
                                icon: Icon(iconBool ? _iconDark : _iconLight)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Visibility(
                  visible: isVisible,
                  maintainAnimation: true,
                  maintainState: true,
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 250),
                        child: Padding(
                          padding: EdgeInsets.only(left: 22),
                          child: Text(
                            'Version',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 118, 115, 115),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '1.0.1',
                        style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 118, 115, 115),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            My_Button_terms(
                onTap: () {
                  setState(() {
                    isVisible2 = !isVisible2;
                  });
                },
                text: 'Terms And Conditions',
                icon: Icons.arrow_forward_ios_rounded),
            Divider(
              color: Colors.grey[300],
              height: 0,
              thickness: 2,
            ),
            Row(
              children: [
                Visibility(
                  visible: isVisible2,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/images/terms.png',
                                    height: 100,
                                    width: 100, // Adjust width as necessary
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Image.asset(
                                    'assets/images/soprahr.png',
                                    height: 100,
                                    width: 100, // Adjust width as necessary
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 80.0),
                                child: Text(
                                  "TERMS AND CONDITIONS",
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Color.fromARGB(235, 255, 2, 2),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set container width to screen width
                                padding: const EdgeInsets.all(
                                    19.0), // Add padding for better readability
                                child: const Text(
                                  "Welcome to Plateau Manager & Recruitment Assistant. These Terms and Conditions govern your use of the Application provided by Sopra HR . By using the Application, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use the Application.",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(235, 255, 2, 2)),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set container width to screen width
                                padding: const EdgeInsets.only(
                                    left:
                                        15), // Add padding for better readability
                                child: const Text(
                                  'Definitions ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set container width to screen width
                                padding: const EdgeInsets.only(
                                    left: 15,
                                    right:
                                        15), // Add padding for better readability
                                child: const Text(
                                    'User" refers to any individual or entity using the Application. "Application" means the software platform provided by Sopra HR for managing workspaces and optimizing recruitment processes. "Content" includes all text, information, data, software, graphics, and other materials provided within the Application.'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set container width to screen width
                                padding: const EdgeInsets.only(
                                    left:
                                        15), // Add padding for better readability
                                child: const Text(
                                  'Prohibited Uses ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, // Set container width to screen width
                                  padding: const EdgeInsets.only(
                                      left: 15,
                                      right:
                                          15), // Add padding for better readability
                                  child: const Text(
                                      'You agree not to use the Application for any unlawful purpose, interfere with the operation of the Application or the servers hosting it, reverse engineer, decompile, or disassemble any part of the Application, or share your account details with unauthorized third parties.')),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set container width to screen width
                                padding: const EdgeInsets.only(
                                    left:
                                        15), // Add padding for better readability
                                child: const Text(
                                  'Account Security',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, // Set container width to screen width
                                  padding: const EdgeInsets.only(
                                      left: 15,
                                      right:
                                          15), // Add padding for better readability
                                  child: const Text(
                                      'You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. Notify us immediately of any unauthorized use of your account.')),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set container width to screen width
                                padding: const EdgeInsets.only(
                                    left:
                                        15), // Add padding for better readability
                                child: const Text(
                                  'Data Security',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, // Set container width to screen width
                                  padding: const EdgeInsets.only(
                                      left: 15,
                                      right:
                                          15), // Add padding for better readability
                                  child: const Text(
                                      'We implement measures to protect the security of your data, including authentication, authorization, and encryption. However, we cannot guarantee absolute security and are not liable for any breaches of data security.')),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set container width to screen width
                                padding: const EdgeInsets.only(
                                    left:
                                        15), // Add padding for better readability
                                child: const Text(
                                  'Modifications to the Terms',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, // Set container width to screen width
                                  padding: const EdgeInsets.only(
                                      left: 15,
                                      right:
                                          15), // Add padding for better readability
                                  child: const Text(
                                      'We may modify these Terms at any time. We will notify you of any changes by posting the new Terms on our website or through the Application. Your continued use of the Application after such modifications constitutes your acceptance of the new Terms.')),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set container width to screen width
                                padding: const EdgeInsets.only(
                                    left:
                                        15), // Add padding for better readability
                                child: const Text(
                                  'Contact Us',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, // Set container width to screen width
                                  padding: const EdgeInsets.only(
                                      left: 15,
                                      right:
                                          15), // Add padding for better readability
                                  child: const Text(
                                      'If you have any questions about these terms and conditions, please contact us at mezen.bayounes@esprit.tn.')),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 260),
            Divider(
              color: const Color.fromARGB(255, 255, 255, 255),
              height: 0,
              thickness: 2,
            ),
            LogOutButton(onTap: visible, text: 'Log Out', icon: Icons.logout)
          ],
        ))),
      ),
      bottomNavigationBar: Container(child: BottomNavBarV2(index: 2,)),
    );
  }
}
