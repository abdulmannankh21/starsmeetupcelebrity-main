import 'package:flutter/material.dart';

import '../../GlobalWidgets/button_widget.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_text_styles.dart';

class AudioCallingScreen extends StatefulWidget {
  const AudioCallingScreen({super.key});

  @override
  State<AudioCallingScreen> createState() => _AudioCallingScreenState();
}

class _AudioCallingScreenState extends State<AudioCallingScreen> {
  bool callJoined = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: purpleGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/celebrityImage.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      offset: const Offset(0, 0),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
              callJoined
                  ? const SizedBox(
                      height: 40,
                    )
                  : const SizedBox(
                      height: 120,
                    ),
              callJoined
                  ? Column(
                      children: [
                        Text(
                          "00 : 05",
                          style: eighteen400TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Faizan Azhar",
                          style: twentyFive700TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        showIncomingPersonPopUp();
                      },
                      child: Text(
                        "You're the only one here",
                        style: twentyTwo700TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                            "assets/speakerIcon.png",
                            width: 25,
                            height: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Speaker",
                        style: twelve400TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: redColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            offset: const Offset(0, 0),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/endCallIcon.png",
                          width: 45,
                          height: 45,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Column(
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
                            "assets/muteIcon.png",
                            width: 25,
                            height: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Mute",
                        style: twelve400TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 120,
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
