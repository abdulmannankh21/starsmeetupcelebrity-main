import 'package:flutter/material.dart';
import 'package:starsmeetupcelebrity/GlobalWidgets/side_menu_widget.dart';

import '../Apis/auth_controller.dart';
import '../LocalStorage/shared_preferences.dart';
import '../Utilities/app_colors.dart';
import '../Utilities/app_routes.dart';
import '../Utilities/app_text_styles.dart';
import 'button_widget.dart';

class DrawerWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const DrawerWidget({
    super.key,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkPurpleColor.withOpacity(0.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          MyPreferences.instance.user!.profilePicture != null
              ? Container(
                  width: 80,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        MyPreferences.instance.user!.profilePicture!,
                      ),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                )
              : Container(
                  width: 80,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
          const SizedBox(
            height: 10,
          ),
          Text(
            MyPreferences.instance.user!.name ?? "Loading...",
            style: twentyTwo700TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            height: 1,
            color: Colors.white,
            thickness: 1,
          ),
          const SizedBox(
            height: 15,
          ),
          SideDrawerWidget(
            image: "assets/profileIcon.png",
            onTap: () {
              scaffoldKey.currentState!.closeDrawer();
              Navigator.pushNamed(context, profileScreenRoute);
            },
            text: "Profile",
          ),
          const SizedBox(
            height: 30,
          ),
          SideDrawerWidget(
            image: "assets/appointmentIcon.png",
            onTap: () {
              Navigator.pushNamed(context, appointmentScreenRoute);
            },
            text: "Appointments",
          ),
          const SizedBox(
            height: 30,
          ),
          SideDrawerWidget(
            image: "assets/appointmentIcon.png",
            onTap: () {
              Navigator.pushNamed(context, cancelledAppointmentScreenRoute);
            },
            text: "Cancelled",
          ),
          const SizedBox(
            height: 30,
          ),
          SideDrawerWidget(
            image: "assets/reviewsIcon.png",
            onTap: () {
              Navigator.pushNamed(context, reviewsScreenRoute);
            },
            text: "Reviews",
          ),
          const SizedBox(
            height: 30,
          ),
          SideDrawerWidget(
            image: "assets/settingsIcon.png",
            onTap: () {
              Navigator.pushNamed(context, settingsScreenRoute);
            },
            text: "Settings",
          ),
          const SizedBox(
            height: 35,
          ),
          SideDrawerWidget(
            image: "assets/helpIcon.png",
            onTap: () {
              Navigator.pushNamed(context, helpScreenRoute);
            },
            text: "Help",
          ),
          const SizedBox(
            height: 35,
          ),
          SideDrawerWidget(
            image: "assets/sendIcon.png",
            onTap: () {},
            text: "Share",
          ),
          const Spacer(),
          const Divider(
            height: 1,
            color: Colors.white,
            thickness: 1,
          ),
          const SizedBox(
            height: 20,
          ),
          SideDrawerWidget(
            image: "assets/logoutIcon.png",
            onTap: () {
              logoutPopUp(context);
            },
            text: "Logout",
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 4; i++)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        i == 0
                            ? "assets/facebookIcon.png"
                            : i == 1
                                ? "assets/instagramIcon.png"
                                : i == 2
                                    ? "assets/youtubeIcon.png"
                                    : "assets/tiktokIcon.png",
                        width: 20,
                        height: 20,
                        color: purpleColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  logoutPopUp(context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      transitionDuration: const Duration(seconds: 0),
      barrierDismissible: true,
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Are you sure\nyou want to logout?",
                        style: twentyTwo700TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: BigButton(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 50,
                        color: purpleColor,
                        text: "Logout",
                        onTap: () {
                          MyPreferences.instance.clearPreferences();
                          Authentication().signOut();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            loginScreenRoute,
                            (route) => false,
                          );
                        },
                        borderRadius: 5.0,
                        textStyle: eighteen700TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: eighteen600TextStyle(
                          color: purpleColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
