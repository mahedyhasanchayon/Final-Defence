import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surjomukhi/views/landing/components/nav_pages.dart';
import '../config/config.dart';
import '../controller/login_controller.dart';
import '../login_screen.dart';
import '../ticketbook/adminPage.dart';

class ProfilePageOption extends StatelessWidget {
  const ProfilePageOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
        shadowColor: Color.fromARGB(50, 184, 208, 249),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {}, icon: SvgPicture.asset("assets/images/menu.svg")),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.0,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/user.png"),
                    ),
                    SizedBox(height: 16),
                    Text(
                      userStudentName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      userStudentId,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Student',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(
                      thickness: 1,
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.orangeAccent,
                      indent: 60.0,
                      endIndent: 60.0,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    // ListTile(
                    //   leading: Icon(Icons.event),
                    //   title: Text('Ticket'),
                    //   onTap: () {
                    //     // Handle Ticket option tap
                    //   },
                    // ),
                    // Divider(
                    //   thickness: 1,
                    // ),
                    ListTile(
                      leading: Icon(Icons.admin_panel_settings_outlined),
                      title: Text('Admin'),
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AdminPage())),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                        leading: Icon(Icons.schedule),
                        title: Text('Bus Schedule'),
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => pages[3]))),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Icon(Icons.help),
                      title: Text('Support'),
                      onTap: () {
                        // Handle Support option tap
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                                'We are here to help so please get in touch with us.'),
                            actions: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage("assets/images/dp.png"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                        child: Icon(Icons.person_4)),
                                    title: Text("Mahedy Hasan"),
                                  ),
                                  ListTile(
                                    leading:
                                        CircleAvatar(child: Icon(Icons.call)),
                                    title: Text("Phone Number"),
                                    subtitle: Text("+8801639305679"),
                                  ),
                                  ListTile(
                                    leading:
                                        CircleAvatar(child: Icon(Icons.email)),
                                    title: Text("Gmail"),
                                    subtitle: Text("mahedy15-3004@diu.edu.bd"),
                                  )
                                ],
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Log Out'),
                      onTap: () async {
                        // Call the logout method to clear login information
                        LoginController loginController = LoginController();
                        await loginController.logout();
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.clear();
                        // After logout, navigate back to LoginScreen
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
