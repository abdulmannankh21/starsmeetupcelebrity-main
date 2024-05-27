// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// import '../GlobalWidgets/button_widget.dart';
// import '../GlobalWidgets/text_field_widget.dart';
// import '../Utilities/app_colors.dart';
// import '../Utilities/app_routes.dart';
// import '../Utilities/app_text_styles.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   bool agreed = false;
//   String selectedValue = '';
//   var countryCode = "+961";
//   var countryEmoji = "🇵🇰";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: const BoxDecoration(
//           gradient: purpleGradient,
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 50,
//                   width: MediaQuery.of(context).size.width,
//                 ),
//                 Center(
//                   child: Text(
//                     "Sign up",
//                     style: thirtyFour800TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const TextFieldWidget(
//                   hintText: "Your Name",
//                   labelText: "Name",
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const TextFieldWidget(
//                   hintText: "Enter your Email",
//                   labelText: "Email",
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const TextFieldWidget(
//                   hintText: "at least 8 character",
//                   suffixIcon: Icon(
//                     CupertinoIcons.eye_slash,
//                     color: Colors.white,
//                   ),
//                   labelText: "Password",
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const TextFieldWidget(
//                   hintText: "at least 8 character",
//                   suffixIcon: Icon(
//                     CupertinoIcons.eye_slash,
//                     color: Colors.white,
//                   ),
//                   labelText: "Repeat Password",
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Text(
//                   "Category",
//                   style: eighteen800TextStyle(color: Colors.white),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   height: 55,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.grey[300]!,
//                     ),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   padding: const EdgeInsets.all(10.0),
//                   child: DropdownButton<String>(
//                     hint: Text(
//                       "Select Category",
//                       style: sixteen400TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                     isExpanded: true,
//                     dropdownColor: darkPurpleColor,
//                     value: selectedValue.isNotEmpty ? selectedValue : null,
//                     icon: const Icon(
//                       Icons.keyboard_arrow_down,
//                       color: Colors.white,
//                     ), // Arrow icon
//                     iconSize: 24,
//                     elevation: 16,
//                     style: sixteen400TextStyle(
//                       color: Colors.white,
//                     ),
//                     underline: Container(),
//                     onChanged: (newValue) {
//                       setState(() {
//                         selectedValue = newValue!;
//                       });
//                     },
//                     items: <String>[
//                       'Option 1',
//                       'Option 2',
//                       'Option 3',
//                       'Option 4'
//                     ].map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 TextFieldWidget(
//                   hintText: "at least 8 character",
//                   prefixIcon: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             countryEmoji,
//                             style: twentyTwo400TextStyle(
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               showCountryPicker(
//                                 context: context,
//                                 showPhoneCode: true,
//                                 onSelect: (Country country) {
//                                   countryCode = "+${country.phoneCode}";
//                                   countryEmoji = country.flagEmoji;
//                                   if (kDebugMode) {
//                                     print(country.flagEmoji);
//                                   }
//                                   setState(() {});
//                                   if (kDebugMode) {
//                                     print(
//                                         'Select country: ${country.phoneCode}');
//                                   }
//                                 },
//                               );
//                             },
//                             child: Text(
//                               countryCode,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   labelText: "Mobile Number",
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         agreed = !agreed;
//                         setState(() {});
//                       },
//                       child: Container(
//                         width: 23,
//                         height: 23,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: agreed ? Colors.transparent : Colors.white,
//                           ),
//                           borderRadius: BorderRadius.circular(5.0),
//                           color: !agreed ? Colors.transparent : Colors.white,
//                         ),
//                         child: Center(
//                           child: Icon(
//                             Icons.check,
//                             size: 20,
//                             color: !agreed ? Colors.transparent : purpleColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: Text(
//                         "By signing up, i agree with Terms of use and privacy policy",
//                         style: sixteen700TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 BigButton(
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   height: 55,
//                   color: Colors.white,
//                   text: "Sign up",
//                   onTap: () {
//                     Navigator.pushNamed(context, homeScreenRoute);
//                   },
//                   textStyle: twentyTwo700TextStyle(color: purpleColor),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Already have an account?",
//                       style: eighteen500TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushNamed(context, loginScreenRoute);
//                       },
//                       child: Text(
//                         "Login",
//                         style: eighteen800TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 50,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
