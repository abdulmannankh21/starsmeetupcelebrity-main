import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Utilities/app_colors.dart';
import '../Utilities/app_text_styles.dart';

class ReviewsAppointmentWidget extends StatefulWidget {
  final int count;
  const ReviewsAppointmentWidget({
    super.key,
    required this.count,
  });

  @override
  State<ReviewsAppointmentWidget> createState() =>
      _ReviewsAppointmentWidgetState();
}

class _ReviewsAppointmentWidgetState extends State<ReviewsAppointmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            for (int i = 0; i < widget.count; i++)
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: const DecorationImage(
                              image: AssetImage(
                                "assets/celebrityImage.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Faizan Azhar",
                                  style: eighteen700TextStyle(
                                    color: purpleColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "January 10, 24",
                                      style: fourteen400TextStyle(),
                                    ),
                                    Text(
                                      i % 2 == 0
                                          ? "Audio Meeting"
                                          : "Video Meeting",
                                      style: fourteen600TextStyle(
                                        color:
                                            i % 2 == 0 ? redColor : greenColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "09:30 PM",
                                      style: fourteen400TextStyle(),
                                    ),
                                    RatingBar.builder(
                                      initialRating: 3,
                                      itemSize: 20,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      glowColor: purpleColor,
                                      updateOnDrag: false,
                                      unratedColor: Colors.grey[700],
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Text(
                      "This is the dummy review for the user and this will be counted in the reviews.",
                      style: fourteen400TextStyle(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
