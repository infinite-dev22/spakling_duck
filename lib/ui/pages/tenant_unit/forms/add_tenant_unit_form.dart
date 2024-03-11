// import 'dart:io';
//
// import 'package:smart_rent/data_layer/models/currency/currency_model.dart';
// import 'package:smart_rent/data_layer/models/floor/floor_model.dart';
// import 'package:smart_rent/data_layer/models/payment/payment_schedules_model.dart';
// import 'package:smart_rent/data_layer/models/period/period_model.dart';
// import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
// import 'package:smart_rent/data_layer/models/tenant/tenant_model.dart';
// import 'package:smart_rent/data_layer/models/unit/unit_model.dart';
// import 'package:smart_rent/data_layer/models/unit/unit_type_model.dart';
// import 'package:smart_rent/ui/pages/currency/bloc/currency_bloc.dart';
// import 'package:smart_rent/ui/pages/floors/bloc/floor_bloc.dart';
// import 'package:smart_rent/ui/pages/period/bloc/period_bloc.dart';
// import 'package:smart_rent/ui/pages/tenants/bloc/tenant_bloc.dart';
// import 'package:smart_rent/ui/pages/units/bloc/unit_bloc.dart';
// import 'package:smart_rent/ui/themes/app_theme.dart';
// import 'package:smart_rent/ui/widgets/app_drop_downs.dart';
// import 'package:smart_rent/ui/widgets/app_max_textfield.dart';
// import 'package:smart_rent/ui/widgets/auth_textfield.dart';
// import 'package:smart_rent/ui/widgets/date_text_field.dart';
// import 'package:smart_rent/ui/widgets/form_title_widget.dart';
// import 'package:smart_rent/utilities/app_init.dart';
// import 'package:smart_rent/utilities/extra.dart';
// import 'package:date_picker_plus/date_picker_plus.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:pattern_formatter/pattern_formatter.dart';
//
//
//
// class AddUnitForm extends StatefulWidget {
//   final String addButtonText;
//   final bool isUpdate;
//   final Property property;
//
//   const AddUnitForm(
//       {super.key, required this.addButtonText, required this.isUpdate, required this.property});
//
//   @override
//   State<AddUnitForm> createState() => _AddUnitFormState();
// }
//
// class _AddUnitFormState extends State<AddUnitForm> {
//   File? tenantPic;
//   String? tenantImagePath;
//   String? tenantImageExtension;
//   String? tenantFileName;
//   Uint8List? tenantBytes;
//
//   // PlatformFile? tenantFile;
//   // PlatformFile? tenantFile1;
//
//   // pickAddTenantFile() async {
//   //   FilePickerResult? result = await FilePicker.platform.pickFiles();
//   //
//   //   if (result != null) {
//   //     File file = File(result.files.single.path!);
//   //
//   //     var tempFile = File(file.path);
//   //     setState(() {
//   //       tenantFile = result.files.first;
//   //       tempFile = file;
//   //     });
//   //
//   //     print(tenantFile!.path);
//   //     print(tenantFile!.name);
//   //     print(tempFile.path);
//   //   } else {
//   //     // User canceled the picker
//   //   }
//   // }
//
//   String imageError = '';
//
//   // final ImagePicker _picker = ImagePicker();
//   late File _image;
//
//   // Future pickImage() async {
//   //   try {
//   //     final image = await _picker.pickImage(source: ImageSource.gallery);
//   //     if (image == null) return;
//   //
//   //     File? img = File(image.path);
//   //     setState(() {
//   //       // newFile = img;
//   //       _image = img;
//   //     });
//   //   } on PlatformException catch (e) {
//   //     print(e);
//   //   }
//   // }
//
//   final listSample = [
//     {'first': 'vincent', 'last': 'west', 'amount': 50000},
//     {'first': 'mark', 'last': 'jonathan', 'amount': 130000},
//     {'first': 'ryan', 'last': 'jupiter', 'amount': 45000},
//   ];
//
//   final TextEditingController discountController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   late TextEditingController date1Controller;
//   final TextEditingController date2Controller = TextEditingController();
//
//   final TextEditingController dailyController = TextEditingController();
//   final TextEditingController weeklyController = TextEditingController();
//   final TextEditingController monthlyController = TextEditingController();
//   final TextEditingController yearlyController = TextEditingController();
//   final TextEditingController lumpSumController = TextEditingController();
//
//   final TextEditingController searchController = TextEditingController();
//
//   final Rx<DateTime> selectedDate1 = Rx<DateTime>(DateTime.now());
//   final Rx<DateTime> selectedDate2 = Rx<DateTime>(DateTime.now());
//   final Rx<DateTime> selectedDate3 = Rx<DateTime>(DateTime.now());
//
//   final TenantController tenantController = Get.put(TenantController());
//   final _formKey = GlobalKey<FormState>();
//
//   late SingleValueDropDownController _cnt;
//   late SingleValueDropDownController _unitCont;
//
//   Future<void> _selectDate1(BuildContext context) async {
//     // final DateTime? picked = await showDatePicker(
//     //   context: context,
//     //   initialDate: selectedDate1.value,
//     //   firstDate: DateTime(2000),
//     //   lastDate: DateTime(2101),
//     // );
//
//     final DateTime? picked = await showDatePickerDialog(
//       context: context,
//       initialDate: selectedDate1.value,
//       minDate: DateTime(2000),
//       maxDate: DateTime(2101),
//     );
//
//     if (picked != null) {
//       selectedDate1(picked);
//       date1Controller.text =
//       '${DateFormat('MM/dd/yyyy').format(selectedDate1.value)}';
//       // date2Controller.text =
//       //     '${DateFormat('E, d MMM yyyy').format(selectedDate1.value.add(Duration(days: 30)))}';
//
//       if (tenantController.paymentScheduleId.value == 1) {
//         var myDays = dailyController.text.isEmpty
//             ? 1 * 1
//             : int.tryParse(dailyController.text)! * 1;
//
//         if (dailyController.text.toString() == '0') {
//           Fluttertoast.showToast(
//               msg: 'Enter Right Day', gravity: ToastGravity.TOP);
//         } else {
//           print('MY myDays are == ${dailyController.text.toString()}');
//           print('Count myDays ' + myDays.toString());
//           selectedDate2.value = DateTime(selectedDate1.value.year,
//               selectedDate1.value.month, selectedDate1.value.day + myDays);
//           date2Controller.text =
//           '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myDays))}';
//           print('my seelected date ${selectedDate2.value}');
//           print('my date date ${date2Controller.text}');
//         }
//       } else if (tenantController.paymentScheduleId.value == 2) {
//         var myWeeks = weeklyController.text.isEmpty
//             ? 1 * 7
//             : int.tryParse(weeklyController.text)! * 7;
//
//         if (weeklyController.text.toString() == '0') {
//           Fluttertoast.showToast(
//               msg: 'Enter Right week', gravity: ToastGravity.TOP);
//         } else {
//           print('MY WEEKs are == ${weeklyController.text.toString()}');
//           print('Count Weeks ' + myWeeks.toString());
//           selectedDate2.value = (DateTime(selectedDate1.value.year,
//               selectedDate1.value.month, selectedDate1.value.day + myWeeks));
//           date2Controller.text =
//           '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myWeeks))}';
//         }
//       } else if (tenantController.paymentScheduleId.value == 3) {
//         var myMonths = monthlyController.text.isEmpty
//             ? 1 * 1
//             : int.tryParse(monthlyController.text)! * 1;
//
//         if (monthlyController.text.toString() == '0') {
//           Fluttertoast.showToast(
//               msg: 'Enter Right Month', gravity: ToastGravity.TOP);
//         } else {
//           print('MY myMonths are == ${monthlyController.text.toString()}');
//           print('Count myMonths ' + myMonths.toString());
//           selectedDate2.value = (DateTime(selectedDate1.value.year,
//               selectedDate1.value.month + myMonths, selectedDate1.value.day));
//           date2Controller.text =
//           '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month + myMonths, selectedDate1.value.day))}';
//         }
//       } else if (tenantController.paymentScheduleId.value == 4) {
//         var myYears = yearlyController.text.isEmpty
//             ? 1 * 1
//             : int.tryParse(yearlyController.text)! * 1;
//
//         if (yearlyController.text.toString() == '0') {
//           Fluttertoast.showToast(
//               msg: 'Enter Right years', gravity: ToastGravity.TOP);
//         } else {
//           print('MY myYears are == ${yearlyController.text.toString()}');
//           print('Count myYears ' + myYears.toString());
//           selectedDate2.value = DateTime(selectedDate1.value.year + myYears,
//               selectedDate1.value.month, selectedDate1.value.day);
//           date2Controller.text =
//           '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year + myYears, selectedDate1.value.month, selectedDate1.value.day))}';
//         }
//       } else {
//         // date2Controller.text = '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day))}';
//       }
//     }
//   }
//
//
//   int selectedTenantId = 0;
//   int selectedUnitId = 0;
//   int selectedPeriodId = 0;
//   int selectedCurrencyId = 0;
//
//
//   Future<void> _selectDate2(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate2.value,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//
//     if (picked != null && picked != selectedDate1.value) {
//       selectedDate2(picked);
//       date2Controller.text =
//       '${DateFormat('MM/dd/yyyy').format(selectedDate2.value)}';
//     }
//   }
//
//   final ScrollController scrollController = ScrollController();
//
//   CurrencyModel? currencyModel;
//   PeriodModel? periodModel;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//
//     amountController.dispose();
//     descriptionController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//       return Padding(
//         padding: const EdgeInsets.only(bottom: 20)
//             .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: Column(
//           children: [
//
//             SizedBox(
//               height: 10,
//             ),
//
//
//             BlocBuilder<TenantBloc, TenantState>(builder: (context, state) {
//
//               if (state.status == TenantStatus.initial) {
//                 context
//                     .read<TenantBloc>()
//                     .add(LoadAllTenantsEvent());
//               }
//
//               return SearchableTenantDropDown<TenantModel>(
//                 hintText: 'Tenant',
//                 menuItems: state.tenants == null
//                     ? []
//                     : state.tenants!,
//                 controller: _cnt,
//                 onChanged: (value) {
//                   print(value.value.id);
//                   setState((){
//                     selectedTenantId = value.value.id;
//                   });
//                   print(
//                       'MY TEnant is $selectedTenantId');
//                 },
//               );
//             },
//             ),
//
//
//             BlocBuilder<UnitBloc, UnitState>(
//               builder: (context, state) {
//                 if(state.status == UnitStatus.initial){
//                   context.read<UnitBloc>().add(LoadAllUnitsEvent(widget.property.id!));
//                 }
//                 return SearchableUnitDropDown<UnitModel>(
//                   hintText: 'Unit Name / Number',
//                   menuItems: state.units == null ? [] : state.units!,
//                   controller: _unitCont,
//                   onChanged: (value) {
//                     print(value.value.id);
//
//                     setState((){
//                       selectedUnitId = value.value.id;
//                     });
//
//                     // tenantController
//                     //     .setSpecificUnitId(value.value.id);
//                     // tenantController
//                     //     .setUnitAmount(value.value.amount);
//                     amountController.text = amountFormatter
//                         .format(value.value.amount.toString());
//                     discountController.text = amountFormatter
//                         .format(value.value.amount.toString());
//                     print(
//                         'MY Unit is ${tenantController.specificUnitId.value}');
//                     print(
//                         'MY Amount is ${tenantController.unitAmount.value}');
//                   },
//                 );
//               },),
//
//
// //                               Row(
// //                                 mainAxisAlignment:
// //                                 MainAxisAlignment.spaceBetween,
// //                                 crossAxisAlignment: CrossAxisAlignment.center,
// //                                 children: [
// //                                   BlocBuilder<PeriodBloc, PeriodState>(
// //                                     builder: (context, state) {
// //                                       if(state.status == PeriodStatus.initial){
// //                                         context.read<PeriodBloc>().add(LoadAllPeriodsEvent());
// //                                       }
// //                                       return SizedBox(
// //                                     width: 42.5.w,
// //                                     child: CustomPeriodApiGenericDropdown<
// //                                           PeriodModel>(
// //                                         hintText: 'Period',
// //                                         menuItems: state.periods == null ? [] : state.periods!,
// //                                         onChanged: (value) {
// //                                           setState((){
// //                                             selectedPeriodId = value!.id!;
// //                                           });
// //                                           print('My newest period ID is $selectedPeriodId');
// //                                           print('My newest list ID is ${tenantController.paymentList.value}');
// //                                           // tenantController
// //                                           //     .setPaymentScheduleId(value!.id!);
// //
// //                                           if (tenantController
// //                                               .paymentScheduleId.value ==
// //                                               1) {
// //                                             var myDays = dailyController
// //                                                 .text.isEmpty
// //                                                 ? 1 * 1
// //                                                 : int.tryParse(
// //                                                 dailyController.text)! *
// //                                                 1;
// //
// //                                             if (dailyController.text
// //                                                 .toString() ==
// //                                                 '0') {
// //                                               Fluttertoast.showToast(
// //                                                   msg: 'Enter Right Day',
// //                                                   gravity: ToastGravity.TOP);
// //                                             } else {
// //                                               print(
// //                                                   'MY myDays are == ${dailyController.text.toString()}');
// //                                               print('Count myDays ' +
// //                                                   myDays.toString());
// //                                               selectedDate2.value = DateTime(
// //                                                   selectedDate1.value.year,
// //                                                   selectedDate1.value.month,
// //                                                   selectedDate1.value.day +
// //                                                       myDays);
// //                                               date2Controller.text =
// //                                               '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myDays))}';
// //                                               print(
// //                                                   'my seelected date ${selectedDate2.value}');
// //                                               print(
// //                                                   'my date date ${date2Controller.text}');
// //                                             }
// //                                           } else if (tenantController
// //                                               .paymentScheduleId.value ==
// //                                               2) {
// //                                             var myWeeks = weeklyController
// //                                                 .text.isEmpty
// //                                                 ? 1 * 7
// //                                                 : int.tryParse(weeklyController
// //                                                 .text)! *
// //                                                 7;
// //
// //                                             if (weeklyController.text
// //                                                 .toString() ==
// //                                                 '0') {
// //                                               Fluttertoast.showToast(
// //                                                   msg: 'Enter Right week',
// //                                                   gravity: ToastGravity.TOP);
// //                                             } else {
// //                                               print(
// //                                                   'MY WEEKs are == ${weeklyController.text.toString()}');
// //                                               print('Count Weeks ' +
// //                                                   myWeeks.toString());
// //                                               selectedDate2.value = DateTime(
// //                                                   selectedDate1.value.year,
// //                                                   selectedDate1.value.month,
// //                                                   selectedDate1.value.day +
// //                                                       myWeeks);
// //                                               date2Controller.text =
// //                                               '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myWeeks))}';
// //                                             }
// //                                           } else if (tenantController
// //                                               .paymentScheduleId.value ==
// //                                               3) {
// //                                             var myMonths = monthlyController
// //                                                 .text.isEmpty
// //                                                 ? 1 * 1
// //                                                 : int.tryParse(monthlyController
// //                                                 .text)! *
// //                                                 1;
// //
// //                                             if (monthlyController.text
// //                                                 .toString() ==
// //                                                 '0') {
// //                                               Fluttertoast.showToast(
// //                                                   msg: 'Enter Right Month',
// //                                                   gravity: ToastGravity.TOP);
// //                                             } else {
// //                                               print(
// //                                                   'MY myMonths are == ${monthlyController.text.toString()}');
// //                                               print('Count myMonths ' +
// //                                                   myMonths.toString());
// //                                               selectedDate2.value = DateTime(
// //                                                   selectedDate1.value.year,
// //                                                   selectedDate1.value.month +
// //                                                       myMonths,
// //                                                   selectedDate1.value.day);
// //                                               date2Controller.text =
// //                                               '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month + myMonths, selectedDate1.value.day))}';
// //                                             }
// //                                           } else if (tenantController
// //                                               .paymentScheduleId.value ==
// //                                               4) {
// //                                             var myYears = yearlyController
// //                                                 .text.isEmpty
// //                                                 ? 1 * 1
// //                                                 : int.tryParse(yearlyController
// //                                                 .text)! *
// //                                                 1;
// //
// //                                             if (yearlyController.text
// //                                                 .toString() ==
// //                                                 '0') {
// //                                               Fluttertoast.showToast(
// //                                                   msg: 'Enter Right years',
// //                                                   gravity: ToastGravity.TOP);
// //                                             } else {
// //                                               print(
// //                                                   'MY myYears are == ${yearlyController.text.toString()}');
// //                                               print('Count myYears ' +
// //                                                   myYears.toString());
// //                                               selectedDate2.value = DateTime(
// //                                                   selectedDate1.value.year +
// //                                                       myYears,
// //                                                   selectedDate1.value.month,
// //                                                   selectedDate1.value.day);
// //                                               date2Controller.text =
// //                                               '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year + myYears, selectedDate1.value.month, selectedDate1.value.day))}';
// //                                             }
// //                                           } else {
// //                                             // date2Controller.text = '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day))}';
// //                                           }
// //                                         },
// //                                       ),
// //                                   );
// //   },
// // ),
// //                                   tenantController.paymentScheduleId.value == 10
// //                                       ? SizedBox(
// //                                     child: AuthTextField(
// //                                         controller: tenantController
// //                                             .paymentScheduleId
// //                                             .value ==
// //                                             10
// //                                             ? lumpSumController
// //                                             : TextEditingController(
// //                                             text: null),
// //                                         hintText: 'Enter LumpSum',
// //                                         obscureText: false,
// //                                       ),
// //                                     width: 42.5.w,
// //                                   )
// //                                       : Container(),
// //                                   SizedBox(
// //                                     child: AuthTextField(
// //                                         controller: tenantController
// //                                             .paymentScheduleId.value ==
// //                                             1
// //                                             ? dailyController
// //                                             : tenantController.paymentScheduleId
// //                                             .value ==
// //                                             2
// //                                             ? weeklyController
// //                                             : tenantController
// //                                             .paymentScheduleId
// //                                             .value ==
// //                                             3
// //                                             ? monthlyController
// //                                             : tenantController
// //                                             .paymentScheduleId
// //                                             .value ==
// //                                             4
// //                                             ? yearlyController
// //                                             : TextEditingController(
// //                                             text: null),
// //                                         hintText: tenantController
// //                                             .paymentScheduleId.value ==
// //                                             1
// //                                             ? 'Enter No. Of Days'
// //                                             : tenantController.paymentScheduleId
// //                                             .value ==
// //                                             2
// //                                             ? 'Enter No. Of Weeks'
// //                                             : tenantController
// //                                             .paymentScheduleId
// //                                             .value ==
// //                                             3
// //                                             ? 'Enter No. Of Months'
// //                                             : tenantController
// //                                             .paymentScheduleId
// //                                             .value ==
// //                                             4
// //                                             ? 'Enter No. Of Years'
// //                                             : 'Duration',
// //                                         obscureText: false,
// //                                         keyBoardType: TextInputType.number,
// //                                         onChanged: (value) {
// //                                           if (tenantController
// //                                               .paymentScheduleId.value ==
// //                                               1) {
// //                                             var myDays = dailyController
// //                                                 .text.isEmpty
// //                                                 ? 1 * 1
// //                                                 : int.tryParse(
// //                                                 dailyController.text)! *
// //                                                 1;
// //
// //                                             if (dailyController.text
// //                                                 .toString() ==
// //                                                 '0') {
// //                                               Fluttertoast.showToast(
// //                                                   msg: 'Enter Right Day',
// //                                                   gravity: ToastGravity.TOP);
// //                                             } else {
// //                                               print(
// //                                                   'MY myDays are == ${dailyController.text.toString()}');
// //                                               print('Count myDays ' +
// //                                                   myDays.toString());
// //                                               selectedDate2.value = DateTime(
// //                                                   selectedDate1.value.year,
// //                                                   selectedDate1.value.month,
// //                                                   selectedDate1.value.day +
// //                                                       myDays);
// //                                               date2Controller.text =
// //                                               '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myDays))}';
// //                                               print(
// //                                                   'my seelected date ${selectedDate2.value}');
// //                                               print(
// //                                                   'my date date ${date2Controller.text}');
// //                                             }
// //                                           } else if (tenantController
// //                                               .paymentScheduleId.value ==
// //                                               2) {
// //                                             var myWeeks = weeklyController
// //                                                 .text.isEmpty
// //                                                 ? 1 * 7
// //                                                 : int.tryParse(weeklyController
// //                                                 .text)! *
// //                                                 7;
// //
// //                                             if (weeklyController.text
// //                                                 .toString() ==
// //                                                 '0') {
// //                                               Fluttertoast.showToast(
// //                                                   msg: 'Enter Right week',
// //                                                   gravity: ToastGravity.TOP);
// //                                             } else {
// //                                               print(
// //                                                   'MY WEEKs are == ${weeklyController.text.toString()}');
// //                                               print('Count Weeks ' +
// //                                                   myWeeks.toString());
// //                                               selectedDate2.value = DateTime(
// //                                                   selectedDate1.value.year,
// //                                                   selectedDate1.value.month,
// //                                                   selectedDate1.value.day +
// //                                                       myWeeks);
// //                                               date2Controller.text =
// //                                               '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myWeeks))}';
// //                                             }
// //                                           } else if (tenantController
// //                                               .paymentScheduleId.value ==
// //                                               3) {
// //                                             var myMonths = monthlyController
// //                                                 .text.isEmpty
// //                                                 ? 1 * 1
// //                                                 : int.tryParse(monthlyController
// //                                                 .text)! *
// //                                                 1;
// //
// //                                             if (monthlyController.text
// //                                                 .toString() ==
// //                                                 '0') {
// //                                               Fluttertoast.showToast(
// //                                                   msg: 'Enter Right Month',
// //                                                   gravity: ToastGravity.TOP);
// //                                             } else {
// //                                               print(
// //                                                   'MY myMonths are == ${monthlyController.text.toString()}');
// //                                               print('Count myMonths ' +
// //                                                   myMonths.toString());
// //                                               selectedDate2.value = DateTime(
// //                                                   selectedDate1.value.year,
// //                                                   selectedDate1.value.month +
// //                                                       myMonths,
// //                                                   selectedDate1.value.day);
// //                                               date2Controller.text =
// //                                               '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month + myMonths, selectedDate1.value.day))}';
// //                                             }
// //                                           } else if (tenantController
// //                                               .paymentScheduleId.value ==
// //                                               4) {
// //                                             var myYears = yearlyController
// //                                                 .text.isEmpty
// //                                                 ? 1 * 1
// //                                                 : int.tryParse(yearlyController
// //                                                 .text)! *
// //                                                 1;
// //
// //                                             if (yearlyController.text
// //                                                 .toString() ==
// //                                                 '0') {
// //                                               Fluttertoast.showToast(
// //                                                   msg: 'Enter Right years',
// //                                                   gravity: ToastGravity.TOP);
// //                                             } else {
// //                                               print(
// //                                                   'MY myYears are == ${yearlyController.text.toString()}');
// //                                               print('Count myYears ' +
// //                                                   myYears.toString());
// //                                               selectedDate2.value = DateTime(
// //                                                   selectedDate1.value.year +
// //                                                       myYears,
// //                                                   selectedDate1.value.month,
// //                                                   selectedDate1.value.day);
// //                                               date2Controller.text =
// //                                               '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year + myYears, selectedDate1.value.month, selectedDate1.value.day))}';
// //                                             }
// //                                           } else {
// //                                             // date2Controller.text = '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day))}';
// //                                           }
// //                                         },
// //                                       ),
// //                                     width: 42.5.w,
// //                                   ),
// //                                 ],
// //                               ),
//
//
//
//             Row(
//               mainAxisAlignment:
//               MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: 190,
//                   child: Obx(() {
//                     return CustomPeriodApiGenericDropdown<
//                         PaymentSchedulesModel>(
//                       hintText: 'Period',
//                       menuItems:
//                       tenantController.paymentList.value,
//                       onChanged: (value) {
//                         tenantController
//                             .setPaymentScheduleId(value!.id!);
//
//                         if (tenantController
//                             .paymentScheduleId.value ==
//                             1) {
//                           var myDays = dailyController
//                               .text.isEmpty
//                               ? 1 * 1
//                               : int.tryParse(
//                               dailyController.text)! *
//                               1;
//
//                           if (dailyController.text
//                               .toString() ==
//                               '0') {
//                             Fluttertoast.showToast(
//                                 msg: 'Enter Right Day',
//                                 gravity: ToastGravity.TOP);
//                           } else {
//                             print(
//                                 'MY myDays are == ${dailyController.text.toString()}');
//                             print('Count myDays ' +
//                                 myDays.toString());
//                             selectedDate2.value = DateTime(
//                                 selectedDate1.value.year,
//                                 selectedDate1.value.month,
//                                 selectedDate1.value.day +
//                                     myDays);
//                             date2Controller.text =
//                             '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myDays))}';
//                             print(
//                                 'my seelected date ${selectedDate2.value}');
//                             print(
//                                 'my date date ${date2Controller.text}');
//                           }
//                         } else if (tenantController
//                             .paymentScheduleId.value ==
//                             2) {
//                           var myWeeks = weeklyController
//                               .text.isEmpty
//                               ? 1 * 7
//                               : int.tryParse(weeklyController
//                               .text)! *
//                               7;
//
//                           if (weeklyController.text
//                               .toString() ==
//                               '0') {
//                             Fluttertoast.showToast(
//                                 msg: 'Enter Right week',
//                                 gravity: ToastGravity.TOP);
//                           } else {
//                             print(
//                                 'MY WEEKs are == ${weeklyController.text.toString()}');
//                             print('Count Weeks ' +
//                                 myWeeks.toString());
//                             selectedDate2.value = DateTime(
//                                 selectedDate1.value.year,
//                                 selectedDate1.value.month,
//                                 selectedDate1.value.day +
//                                     myWeeks);
//                             date2Controller.text =
//                             '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myWeeks))}';
//                           }
//                         } else if (tenantController
//                             .paymentScheduleId.value ==
//                             3) {
//                           var myMonths = monthlyController
//                               .text.isEmpty
//                               ? 1 * 1
//                               : int.tryParse(monthlyController
//                               .text)! *
//                               1;
//
//                           if (monthlyController.text
//                               .toString() ==
//                               '0') {
//                             Fluttertoast.showToast(
//                                 msg: 'Enter Right Month',
//                                 gravity: ToastGravity.TOP);
//                           } else {
//                             print(
//                                 'MY myMonths are == ${monthlyController.text.toString()}');
//                             print('Count myMonths ' +
//                                 myMonths.toString());
//                             selectedDate2.value = DateTime(
//                                 selectedDate1.value.year,
//                                 selectedDate1.value.month +
//                                     myMonths,
//                                 selectedDate1.value.day);
//                             date2Controller.text =
//                             '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month + myMonths, selectedDate1.value.day))}';
//                           }
//                         } else if (tenantController
//                             .paymentScheduleId.value ==
//                             4) {
//                           var myYears = yearlyController
//                               .text.isEmpty
//                               ? 1 * 1
//                               : int.tryParse(yearlyController
//                               .text)! *
//                               1;
//
//                           if (yearlyController.text
//                               .toString() ==
//                               '0') {
//                             Fluttertoast.showToast(
//                                 msg: 'Enter Right years',
//                                 gravity: ToastGravity.TOP);
//                           } else {
//                             print(
//                                 'MY myYears are == ${yearlyController.text.toString()}');
//                             print('Count myYears ' +
//                                 myYears.toString());
//                             selectedDate2.value = DateTime(
//                                 selectedDate1.value.year +
//                                     myYears,
//                                 selectedDate1.value.month,
//                                 selectedDate1.value.day);
//                             date2Controller.text =
//                             '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year + myYears, selectedDate1.value.month, selectedDate1.value.day))}';
//                           }
//                         } else {
//                           // date2Controller.text = '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day))}';
//                         }
//                       },
//                     );
//                   }),
//                 ),
//
//                 SizedBox(
//                   child: Obx(() {
//                     return AuthTextField(
//                       controller: tenantController
//                           .paymentScheduleId.value ==
//                           1
//                           ? dailyController
//                           : tenantController.paymentScheduleId
//                           .value ==
//                           2
//                           ? weeklyController
//                           : tenantController
//                           .paymentScheduleId
//                           .value ==
//                           3
//                           ? monthlyController
//                           : tenantController
//                           .paymentScheduleId
//                           .value ==
//                           4
//                           ? yearlyController
//                           : TextEditingController(
//                           text: null),
//                       hintText: tenantController
//                           .paymentScheduleId.value ==
//                           1
//                           ? 'Enter No. Of Days'
//                           : tenantController.paymentScheduleId
//                           .value ==
//                           2
//                           ? 'Enter No. Of Weeks'
//                           : tenantController
//                           .paymentScheduleId
//                           .value ==
//                           3
//                           ? 'Enter No. Of Months'
//                           : tenantController
//                           .paymentScheduleId
//                           .value ==
//                           4
//                           ? 'Enter No. Of Years'
//                           : 'Duration',
//                       obscureText: false,
//                       keyBoardType: TextInputType.number,
//                       onChanged: (value) {
//                         if (tenantController
//                             .paymentScheduleId.value ==
//                             1) {
//                           var myDays = dailyController
//                               .text.isEmpty
//                               ? 1 * 1
//                               : int.tryParse(
//                               dailyController.text)! *
//                               1;
//
//                           if (dailyController.text
//                               .toString() ==
//                               '0') {
//                             Fluttertoast.showToast(
//                                 msg: 'Enter Right Day',
//                                 gravity: ToastGravity.TOP);
//                           } else {
//                             print(
//                                 'MY myDays are == ${dailyController.text.toString()}');
//                             print('Count myDays ' +
//                                 myDays.toString());
//                             selectedDate2.value = DateTime(
//                                 selectedDate1.value.year,
//                                 selectedDate1.value.month,
//                                 selectedDate1.value.day +
//                                     myDays);
//                             date2Controller.text =
//                             '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myDays))}';
//                             print(
//                                 'my seelected date ${selectedDate2.value}');
//                             print(
//                                 'my date date ${date2Controller.text}');
//                           }
//                         } else if (tenantController
//                             .paymentScheduleId.value ==
//                             2) {
//                           var myWeeks = weeklyController
//                               .text.isEmpty
//                               ? 1 * 7
//                               : int.tryParse(weeklyController
//                               .text)! *
//                               7;
//
//                           if (weeklyController.text
//                               .toString() ==
//                               '0') {
//                             Fluttertoast.showToast(
//                                 msg: 'Enter Right week',
//                                 gravity: ToastGravity.TOP);
//                           } else {
//                             print(
//                                 'MY WEEKs are == ${weeklyController.text.toString()}');
//                             print('Count Weeks ' +
//                                 myWeeks.toString());
//                             selectedDate2.value = DateTime(
//                                 selectedDate1.value.year,
//                                 selectedDate1.value.month,
//                                 selectedDate1.value.day +
//                                     myWeeks);
//                             date2Controller.text =
//                             '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myWeeks))}';
//                           }
//                         } else if (tenantController
//                             .paymentScheduleId.value ==
//                             3) {
//                           var myMonths = monthlyController
//                               .text.isEmpty
//                               ? 1 * 1
//                               : int.tryParse(monthlyController
//                               .text)! *
//                               1;
//
//                           if (monthlyController.text
//                               .toString() ==
//                               '0') {
//                             Fluttertoast.showToast(
//                                 msg: 'Enter Right Month',
//                                 gravity: ToastGravity.TOP);
//                           } else {
//                             print(
//                                 'MY myMonths are == ${monthlyController.text.toString()}');
//                             print('Count myMonths ' +
//                                 myMonths.toString());
//                             selectedDate2.value = DateTime(
//                                 selectedDate1.value.year,
//                                 selectedDate1.value.month +
//                                     myMonths,
//                                 selectedDate1.value.day);
//                             date2Controller.text =
//                             '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month + myMonths, selectedDate1.value.day))}';
//                           }
//                         } else if (tenantController
//                             .paymentScheduleId.value ==
//                             4) {
//                           var myYears = yearlyController
//                               .text.isEmpty
//                               ? 1 * 1
//                               : int.tryParse(yearlyController
//                               .text)! *
//                               1;
//
//                           if (yearlyController.text
//                               .toString() ==
//                               '0') {
//                             Fluttertoast.showToast(
//                                 msg: 'Enter Right years',
//                                 gravity: ToastGravity.TOP);
//                           } else {
//                             print(
//                                 'MY myYears are == ${yearlyController.text.toString()}');
//                             print('Count myYears ' +
//                                 myYears.toString());
//                             selectedDate2.value = DateTime(
//                                 selectedDate1.value.year +
//                                     myYears,
//                                 selectedDate1.value.month,
//                                 selectedDate1.value.day);
//                             date2Controller.text =
//                             '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year + myYears, selectedDate1.value.month, selectedDate1.value.day))}';
//                           }
//                         } else {
//                           // date2Controller.text = '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day))}';
//                         }
//                       },
//                     );
//                   }),
//                   width: 190,
//                 ),
//               ],
//             ),
//
//
//             SizedBox(
//               height: 10,
//             ),
//
//
//
//             DateTextField(
//               style: TextStyle(color: Colors.transparent),
//               onTap: () {
//                 _selectDate1(context);
//               },
//               controller: date1Controller,
//               hintText: "From",
//               obscureText: false,
//             ),
//
//             SizedBox(
//               height: 10,
//             ),
//
//             DateTextField(
//               style: TextStyle(color: Colors.transparent),
//               onTap: () {
//                 _selectDate2(context);
//               },
//               controller: date2Controller,
//               hintText: "To",
//               obscureText: false,
//               enabled: false,
//             ),
//
//             SizedBox(
//               height: 10,
//             ),
//
//             AuthTextField(
//               controller: amountController,
//               hintText: 'Unit Amount',
//               obscureText: false,
//               keyBoardType: TextInputType.number,
//               enabled: false,
//               inputFormatters: [
//                 ThousandsFormatter(),
//               ],
//             ),
//
//             SizedBox(
//               height: 10,
//             ),
//
//             Text(
//               'Agreed Amount',
//               style: AppTheme.blueSubText,
//             ),
//
//             Row(
//               mainAxisAlignment:
//               MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 BlocBuilder<CurrencyBloc, CurrencyState>(
//                   builder: (context, state) {
//                     if (state.status ==
//                         CurrencyStatus.initial) {
//                       context
//                           .read<CurrencyBloc>()
//                           .add(LoadAllCurrenciesEvent(widget.property.id!));
//                     } if (state.status == CurrencyStatus.success) {
//                       currencyModel = state.currencies!.firstWhere(
//                             (currency) => currency.code == 'UGX',
//                         // orElse: () => null as CurrencyModel,
//                       );
//                     }
//                     return SizedBox(
//                       width: 190,
//                       child: CustomApiGenericDropdown<
//                           CurrencyModel>(
//                         hintText: 'Currency',
//                         menuItems: state.currencies == null
//                             ? []
//                             : state.currencies!,
//                         onChanged: (value) {
//                           setState((){
//                             selectedCurrencyId = value!.id!;
//                           });
//                         },
//                         defaultValue: currencyModel,
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(
//                   child: AuthTextField(
//                     controller: discountController,
//                     hintText: 'Discounted Amount',
//                     obscureText: false,
//                     keyBoardType: TextInputType.number,
//                     inputFormatters: [
//                       ThousandsFormatter(),
//                       LengthLimitingTextInputFormatter(17)
//                     ],
//                   ),
//                   width: 190,
//                 ),
//               ],
//             ),
//
//             SizedBox(
//               height: 20,
//             ),
//
//             AppMaxTextField(
//               controller: descriptionController,
//               hintText: 'Description',
//               obscureText: false,
//               fillColor: AppTheme.itemBgColor,
//             ),
//
//             SizedBox(
//               height: 20,
//             ),
//
//
//
//           ],
//         ),
//       );
//     });
//   }
// }
