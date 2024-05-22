import 'package:flutter/material.dart';

import '../../GlobalWidgets/button_widget.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_text_styles.dart';

class VideoCallingScreen extends StatefulWidget {
  const VideoCallingScreen({super.key});

  @override
  State<VideoCallingScreen> createState() => _VideoCallingScreenState();
}

class _VideoCallingScreenState extends State<VideoCallingScreen> {
  bool callJoined = false;
  bool isFullScreen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          isFullScreen = !isFullScreen;
          setState(() {});
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: purpleGradient,
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5 - 1.5,
                decoration: callJoined
                    ? const BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/celebrityImage.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      )
                    : const BoxDecoration(
                        color: purpleColor,
                      ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isFullScreen == true
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey[800]!.withOpacity(0.8),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/rotateCameraIcon.png",
                                    width: 25,
                                    height: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    callJoined == false
                        ? GestureDetector(
                            onTap: () {
                              showIncomingPersonPopUp();
                            },
                            child: Text(
                              "You're the only one here",
                              style: twentyTwo700TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 3,
                color: purpleColor,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5 - 1.5,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/celebrityImage.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isFullScreen == false
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/muteIcon.png",
                                      width: 25,
                                      height: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800]!,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/speakerIcon.png",
                                      width: 25,
                                      height: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/screenshotIcon.png",
                                      width: 25,
                                      height: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/videoCallIcon.png",
                                      width: 25,
                                      height: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: redColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/endCallIcon.png",
                                        width: 25,
                                        height: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showIncomingPersonPopUp() {
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
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Faizan Azhar want to join this meeting",
                      style: eighteen700TextStyle(color: purpleColor),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BigButton(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 50,
                          color: redColor,
                          text: "Decline",
                          onTap: () {},
                          borderRadius: 5.0,
                          textStyle: eighteen700TextStyle(color: Colors.white),
                        ),
                        BigButton(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 50,
                          color: greenColor,
                          text: "Approve",
                          onTap: () {
                            callJoined = true;
                            Navigator.pop(context);
                            setState(() {});
                          },
                          borderRadius: 5.0,
                          textStyle: eighteen700TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
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
