import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starsmeetupcelebrity/Apis/holiday_mode_apis.dart';

import '../../GlobalWidgets/button_widget.dart';
import '../../GlobalWidgets/text_field_dark_widget.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_text_styles.dart';
import '../../Utilities/validator.dart';
import '../../models/holiday_mode_model.dart';

class HolidayModeScreen extends StatefulWidget {
  const HolidayModeScreen({super.key});

  @override
  State<HolidayModeScreen> createState() => _HolidayModeScreenState();
}

class _HolidayModeScreenState extends State<HolidayModeScreen> {
  final formKey = GlobalKey<FormState>();
  var startingDateController = TextEditingController();
  var endingDateController = TextEditingController();
  bool isAdded = false;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  HolidayMode? holidayMode;

  @override
  void initState() {
    getHolidayMode();
    super.initState();
  }

  Future<void> getHolidayMode() async {
    try {
      HolidayMode? holidays = await HolidayModeService().getHolidayMode();
      setState(() {
        holidayMode = holidays;
        if (holidayMode != null) {
          startingDateController.text =
              DateFormat('d MMMM yyyy').format(holidayMode!.startDate);
          endingDateController.text =
              DateFormat('d MMMM yyyy').format(holidayMode!.endDate);
          isAdded = true;
        } else {
          isAdded = false;
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error loading holiday mode: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  Text(
                    "Settings",
                    style: twentyTwo700TextStyle(color: purpleColor),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Holiday Mode",
                style: twentyTwo600TextStyle(color: purpleColor),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldDarkWidget(
                hintText: "Starting Date",
                labelText: "Date",
                textFieldController: startingDateController,
                validator: Validator.validateTextField,
                readOnly: true,
                onTap: () => selectDate(context, true),
                suffixIcon: const Icon(
                  CupertinoIcons.calendar_today,
                  color: purpleColor,
                  size: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldDarkWidget(
                hintText: "Ending Date",
                labelText: "Date",
                textFieldController: endingDateController,
                validator: Validator.validateTextField,
                readOnly: true,
                onTap: () => selectDate(context, false),
                suffixIcon: const Icon(
                  CupertinoIcons.calendar_today,
                  color: purpleColor,
                  size: 30,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              BigButton(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                color: isAdded == false ? purpleColor : redColor,
                text: isAdded == false ? "Save" : "Remove",
                onTap: isAdded == false
                    ? () async {
                        await HolidayModeService()
                            .saveHoliday(startDate, endDate);
                        setState(() {
                          isAdded = true;
                        });
                        getHolidayMode();
                      }
                    : () async {
                        await HolidayModeService().removeHoliday();

                        setState(() {
                          isAdded = false;
                          startingDateController.clear();
                          endingDateController.clear();
                        });
                        getHolidayMode();
                      },
                textStyle: twentyTwo700TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context, bool isStartDate) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: isStartDate ? startDate : endDate,
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(DateTime.now().year + 10),
    ))!;
    if (picked != (isStartDate ? startDate : endDate)) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          startingDateController.text =
              DateFormat('d MMMM yyyy').format(picked);
        } else {
          endDate = picked;
          endingDateController.text = DateFormat('d MMMM yyyy').format(picked);
        }
      });
    }
  }
}
