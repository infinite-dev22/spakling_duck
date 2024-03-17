import 'dart:io';
import 'dart:typed_data';

import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:smart_rent/data_layer/models/currency/currency_model.dart';
import 'package:smart_rent/data_layer/models/floor/floor_model.dart';
import 'package:smart_rent/data_layer/models/payment/payment_account_model.dart';
import 'package:smart_rent/data_layer/models/payment/payment_mode_model.dart';
import 'package:smart_rent/data_layer/models/payment/payment_tenant_unit_schedule_model.dart';
import 'package:smart_rent/data_layer/models/period/period_model.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/data_layer/models/tenant_unit/tenant_unit_model.dart';
import 'package:smart_rent/data_layer/models/unit/unit_type_model.dart';
import 'package:smart_rent/ui/pages/currency/bloc/currency_bloc.dart';
import 'package:smart_rent/ui/pages/floors/bloc/floor_bloc.dart';
import 'package:smart_rent/ui/pages/payment_account/bloc/payment_account_bloc.dart';
import 'package:smart_rent/ui/pages/payment_mode/bloc/payment_mode_bloc.dart';
import 'package:smart_rent/ui/pages/payment_schedules/bloc/payment_schedules_bloc.dart';
import 'package:smart_rent/ui/pages/payments/bloc/payment_bloc.dart';
import 'package:smart_rent/ui/pages/period/bloc/period_bloc.dart';
import 'package:smart_rent/ui/pages/properties/bloc/property_bloc.dart';
import 'package:smart_rent/ui/pages/tenant_unit/bloc/tenant_unit_bloc.dart';
import 'package:smart_rent/ui/pages/units/bloc/unit_bloc.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/amount_text_field.dart';
import 'package:smart_rent/ui/widgets/app_drop_downs.dart';
import 'package:smart_rent/ui/widgets/app_max_textfield.dart';
import 'package:smart_rent/ui/widgets/auth_textfield.dart';
import 'package:smart_rent/ui/widgets/custom_textbox.dart';
import 'package:smart_rent/ui/widgets/form_title_widget.dart';
import 'package:smart_rent/ui/widgets/text_field_label_widget.dart';
import 'package:smart_rent/utilities/app_init.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:full_picker/full_picker.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:smart_rent/utilities/extra.dart';



class AddHomePaymentForm extends StatefulWidget {
  final String addButtonText;
  final bool isUpdate;

  const AddHomePaymentForm(
      {super.key, required this.addButtonText, required this.isUpdate,});

  @override
  State<AddHomePaymentForm> createState() => _AddHomePaymentFormState();
}

class _AddHomePaymentFormState extends State<AddHomePaymentForm> {
  File? paymentPic;
  String? paymentImagePath;
  String? paymentImageExtension;
  String? paymentFileName;
  Uint8List? paymentBytes;

  var myPaymentSchedules = [];
  var myBalances = [];
  var myPaymentScheduleIDs = [];
  final MultiSelectController myPaymentSchedulesController = MultiSelectController();

  final TextEditingController descriptionController = TextEditingController();

  var unitBalance = 0;

  final TextEditingController paidController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  late TextEditingController paymentDateController;

  TextEditingController date1Controller = TextEditingController();
  TextEditingController date2Controller = TextEditingController();

  final Rx<DateTime> selectedDate1 = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> selectedDate2 = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> selectedDate3 = Rx<DateTime>(DateTime.now());

  final TextEditingController searchController = TextEditingController();

  late SingleValueDropDownController tenantUnitsDropdownCont;
  late SingleValueDropDownController _unitCont;
  late SingleValueDropDownController _tenantUnitScheduleCont;

  final MultiSelectController _controller = MultiSelectController();

  final Rx<DateTime> paymentDate = Rx<DateTime>(DateTime.now());

  final Rx<String> fitUnit = Rx<String>('');
  final Rx<int> fitValue = Rx<int>(0);

  var initialBalance = 0;

  List<ValueItem<dynamic>> availableOptions = []; // Maintain a list of available options
  List<ValueItem<dynamic>> selectedOptions = [];

  Future<int> setPaymentScheduleId(int id) async {
    setState(() {
      selectedTenantUnitId = id;
    });

    print('SELECTED TENANT UNIT ID== $selectedTenantUnitId');

    return id;
  }



  Future<void> _selectPaymentDate(BuildContext context) async {
    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: myDateOfBirth.value,
    //   firstDate: DateTime(1900),
    //   lastDate: DateTime.now(),
    // );

    final DateTime? picked = await showDatePickerDialog(
      context: context,
      initialDate: DateTime.now(),
      minDate: DateTime(1900),
      maxDate: DateTime.now(),
    );

    if (picked != null) {
      paymentDate(picked);
      // paymentDateController.text =
      //     '${DateFormat('MM/dd/yyyy').format(paymentDate.value)}';
      var formatedDate1 = "${paymentDate.value.year}-${paymentDate.value.month}-${paymentDate.value.day}";
      print('formatedFromDate1 $formatedDate1');
      paymentDateController.text = formatedDate1;

    }
  }

  int selectedTenantUnitId = 0;
  int selectedPaymentScheduleId = 0;
  int selectedPaymentModeId = 0;
  int selectedPaymentAccountId = 0;
  int totalPaid = 0;
  int totalAmountDue = 0;
  int totalBalance = 0;

  PaymentModeModel? paymentModeModel;
  PaymentAccountsModel? paymentAccountsModel;

  late bool isTitleElevated = false;


  final ScrollController scrollController = ScrollController();

  List<PaymentTenantUnitScheduleModel> selectedSchedules = [];
  late int sumBalances;

  late SingleValueDropDownController _propertyModelCont;
  int selectedPropertyId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tenantUnitsDropdownCont = SingleValueDropDownController();
    paymentDateController = TextEditingController(text: "${paymentDate.value.year}-${paymentDate.value.month}-${paymentDate.value.day}");
    _propertyModelCont =  SingleValueDropDownController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    tenantUnitsDropdownCont.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20)
            .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            MultiBlocListener(
              listeners: [
                BlocListener<PaymentBloc, PaymentState>(
                  listener: (context, state) {
                if (state.status == PaymentStatus.successAdd) {
                  selectedDate1.value = DateTime.now();
                  selectedDate2.value = DateTime.now();
                  amountController.clear();
                  paidController.clear();
                  balanceController.clear();
                  initialBalance = 0;
                  selectedTenantUnitId = 0;
                  selectedPaymentScheduleId = 0;
                  selectedPaymentModeId = 0;
                  selectedPaymentAccountId = 0;
                  Fluttertoast.showToast(
                      msg: state.message.toString(),
                      backgroundColor: Colors.green,
                      gravity: ToastGravity.TOP);

                  context.read<PaymentBloc>().add(LoadAllPayments(selectedPropertyId));
                  context.read<PaymentSchedulesBloc>().add(
                      LoadAllPaymentSchedulesEvent(
                          selectedTenantUnitId, selectedPropertyId));
                  _controller.options.clear();
                  Navigator.pop(context);

                }
                if (state.status == PaymentStatus.accessDeniedAdd) {
                  Fluttertoast.showToast(
                      msg: state.message.toString(), gravity: ToastGravity.TOP);
                }
                if (state.status == PaymentStatus.errorAdd) {
                  Fluttertoast.showToast(
                      msg: state.message.toString(), gravity: ToastGravity.TOP);
                }
              },
                ),
                BlocListener<PaymentSchedulesBloc, PaymentSchedulesState>(
                  listener: (context, state) {

                  },
                ),
              ],
              child: FormTitle(
                name: '${widget.isUpdate ? "Edit" : "New"}  Payment',
                addButtonText: widget.isUpdate ? "Update" : "Add",
                onSave: () {
                  if (paidController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'paid amount required', gravity: ToastGravity.TOP);
                  } else if (balanceController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'balance amount required', gravity: ToastGravity.TOP);
                  } else if (paymentDateController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'payment date required', gravity: ToastGravity.TOP);
                  } else if (amountController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'amount required', gravity: ToastGravity.TOP);
                  }else if (selectedTenantUnitId == 0) {
                    Fluttertoast.showToast(
                        msg: 'please select a tenant unit',
                        gravity: ToastGravity.TOP);
                  } else if (int.parse(paidController.text.trim().replaceAll(',', '').toString()) > int.parse(amountController.text.trim().replaceAll(',', '').toString())) {
                    Fluttertoast.showToast(
                        msg: 'paid amount exceeds balance',
                        gravity: ToastGravity.TOP);
                  } else {
                    print('MY INITIAL BALANCE IS == $initialBalance');
                    var postedBalance =  initialBalance - int.parse(paidController.text.trim().replaceAll(',', '').toString());

                    List<String> stringScheduleList = myPaymentSchedules.map((item) => item.id.toString()).toList();

                    print('MY Posted Balance == $postedBalance');
                    print('MY Cont options = ${_controller.options}');
                    print('amount = ${amountController.text}');
                    print('paid = $paidController');
                    print('balance = $balanceController');
                    print('selectedTenantUnitId = $selectedTenantUnitId');
                    print('selectedPaymentAccountId = $selectedPaymentAccountId');
                    print('selectedPaymentModeId = $selectedPaymentModeId');
                    print('paymentModeModelID = ${paymentModeModel!.id!.toInt()}');
                    print('basedSelectedpaymentModeModelID = ${selectedPaymentModeId == 0 ? paymentModeModel!.id!.toInt() : selectedPaymentModeId}');
                    print('stringScheduleList = $stringScheduleList');

                    context.read<PaymentBloc>().add(AddPaymentsEvent(
                      currentUserToken.toString(),
                      paidController.text.trim().replaceAll(',', '').toString(),
                      amountController.text.trim().replaceAll(',', '').toString(),
                      paymentDateController.text.trim(),
                      selectedTenantUnitId,
                      selectedPaymentAccountId == 0 ? paymentAccountsModel!.id!.toInt() : selectedPaymentModeId,
                      selectedPaymentModeId == 0 ? paymentModeModel!.id!.toInt() : selectedPaymentModeId,
                      selectedPropertyId,
                      stringScheduleList,
                    ));
                  }
                },
                isElevated: true,
                onCancel: () {
                  selectedDate1.value = DateTime.now();
                  selectedDate2.value = DateTime.now();
                  amountController.clear();
                  paidController.clear();
                  balanceController.clear();
                  initialBalance = 0;
                  Navigator.pop(context);
                },
              ),
      ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // FocusManager.instance.primaryFocus?.unfocus();
                },
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollController.position.userScrollDirection ==
                        ScrollDirection.reverse) {
                      setState(() {
                        isTitleElevated = true;
                      });
                    } else if (scrollController.position.userScrollDirection ==
                        ScrollDirection.forward) {
                      if (scrollController.position.pixels ==
                          scrollController.position.maxScrollExtent) {
                        setState(() {
                          isTitleElevated = false;
                        });
                      }
                    }
                    return true;
                  },
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(8),
                    children: [
                      LayoutBuilder(builder: (context, constraints) {
                        return Form(
                          child: Column(
                            children: [

                              TextFieldLabelWidget(label: 'Date'),
                              AuthTextField(
                                controller: paymentDateController,
                                hintText: 'Payment Date',
                                obscureText: false,
                                onTap: () {
                                  _selectPaymentDate(context);
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              TextFieldLabelWidget(label: 'Property'),
                              BlocBuilder<PropertyBloc, PropertyState>(
                                builder: (context, state) {
                                  if (state.status == PropertyStatus.initial) {
                                    context
                                        .read<PropertyBloc>()
                                        .add(LoadPropertiesEvent());
                                  }
                                  if (state.status == PropertyStatus.empty) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: AuthTextField(
                                        hintText: 'No Properties',
                                        obscureText: false,
                                        enabled: false,),
                                    );
                                  }
                                  if (state.status == PropertyStatus.error) {
                                    return Center(
                                      child: Text('An Error Occurred'),
                                    );
                                  }
                                  return SearchablePropertyModelListDropDown<
                                      Property>(
                                    hintText: 'Property',
                                    menuItems: state.properties == null
                                        ? []
                                        : state.properties!,
                                    controller: _propertyModelCont,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedPropertyId = value.value.id;
                                      });
                                      context.read<TenantUnitBloc>().add(LoadTenantUnitsEvent(selectedPropertyId));
                                      print('Property is $selectedPropertyId}');
                                    },
                                  );
                                },
                              ),
                              // const SizedBox(
                              //   height: 10,
                              // ),

                              TextFieldLabelWidget(label: 'Tenant/ Unit'),
                              BlocListener<PaymentSchedulesBloc,
                                  PaymentSchedulesState>(
                                listener: (context, state) {
                                  if (state.status ==
                                      PaymentSchedulesStatus.initial) {
                                    context.read<PaymentSchedulesBloc>().add(
                                        LoadAllPaymentSchedulesEvent(
                                            selectedTenantUnitId, selectedPropertyId));

                                  }
                                },
                                child:
                                BlocBuilder<TenantUnitBloc, TenantUnitState>(
                                  builder: (context, state) {
                                    if (state.status ==
                                        TenantUnitStatus.initial) {
                                      context
                                          .read<TenantUnitBloc>()
                                          .add(LoadTenantUnitsEvent(selectedPropertyId));
                                    } else if (state.status ==
                                        TenantUnitStatus.loading) {
                                      return SmartCaseTextField(
                                        hint: 'Loading tenant units',
                                        controller: TextEditingController(),
                                        readOnly: true,
                                      );
                                    }
                                    return SearchableTenantUnitDropDown<
                                        TenantUnitModel>(
                                      hintText: 'Tenant Unit',
                                      menuItems: state.tenantUnits == null
                                          ? []
                                          : state.tenantUnits!,
                                      controller: tenantUnitsDropdownCont,
                                      onChanged: (value) {
                                        print(value.value.id);

                                        print('My Amounts = ${value.value.getAmount()}');
                                        setPaymentScheduleId(value.value.id)
                                            .then((newValue) {
                                          print(
                                              'My Selected TENANT UNIT ID IS ++ $newValue');
                                          context
                                              .read<PaymentSchedulesBloc>()
                                              .add(LoadAllPaymentSchedulesEvent(
                                              selectedTenantUnitId, selectedPropertyId));
                                        });

                                        paidController.clear();
                                        amountController.clear();
                                        balanceController.clear();

                                      },
                                    );
                                  },
                                ),
                              ),


                              TextFieldLabelWidget(label: 'Period'),
                              BlocBuilder<PaymentSchedulesBloc,
                                  PaymentSchedulesState>(
                                builder: (context, state) {
                                  if(state.status == PaymentSchedulesStatus.initial){
                                    context.read<PaymentSchedulesBloc>().add(LoadAllPaymentSchedulesEvent(selectedTenantUnitId, selectedPropertyId));

                                  }
                                  if (state.status ==
                                      PaymentSchedulesStatus.success) {
                                    print("ITEMS: ${state.paymentSchedules}");

                                    return MultiSelectDialogField<PaymentTenantUnitScheduleModel>(
                                      searchable: true,
                                      searchHint: 'search for schedule',
                                      backgroundColor: AppTheme.appBgColor,
                                      title: Text('Payment Schedules', style: AppTheme.appTitle7,),
                                      items: state.paymentSchedules == null
                                            ? []
                                            : state.paymentSchedules!.map((schedule) => MultiSelectItem(schedule, '${schedule.fromdate}-${schedule.todate} || ${schedule.balance}')).toList(),
                                      listType: MultiSelectListType.CHIP,
                                      decoration: BoxDecoration(
                                          color: AppTheme.itemBgColor,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      onConfirm: (values) {
                                        selectedSchedules = values;

                                        if(selectedSchedules.isEmpty){
                                          paidController.clear();
                                          amountController.clear();
                                          balanceController.clear();

                                        } else {

                                          print('My Total balance = $sumBalances');
                                          amountController.text = amountFormatter.format(sumBalances.toString());
                                          paidController.text = amountFormatter.format(sumBalances.toString());
                                          balanceController.text = (int.parse(amountController.text.trim()) - int.parse(paidController.text.trim())).toString();



                                        }

                                        print('My New selected schedules= $selectedSchedules');
                                      },



                                      onSelectionChanged: (options){

                                            for (var element in options) {
                                              print('My selected element = $element');

                                              myPaymentSchedules = options
                                                  .map((e) => e)
                                                  .toList();
                                              print(
                                                  'My Options selected schedules = $myPaymentSchedules');

                                              myBalances = options
                                                  .map((e) => e)
                                                  .toList();
                                              myPaymentScheduleIDs = options
                                                  .map((e) => e)
                                                  .toList();


                                              print('My selected balances = ${myBalances.map((e) => e.balance).toList()}');
                                              print('My selected ps ids = ${myPaymentScheduleIDs.map((e) => e.id).toList()}');

                                               sumBalances = myBalances.map((e) => int.parse(e.balance.replaceAll(',',''))).toList().reduce((value, element) => value + element);
                                              // int sumBalances = myBalances.map((e) => e.balance).toList().reduce((value, element) => value + element);


                                            }

                                      },
                                      isDismissible: false,
                                    );
                                  }

                                  return AuthTextField(
                                    hintText: 'No Schedule',
                                    obscureText: false,
                                    enabled: false,);
                                },
                              ),



                              const SizedBox(
                                height: 10,
                              ),

                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [

                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         TextFieldLabelWidget(label: 'Amount Due'),
                         SizedBox(
                             width: 190,
                             child: AmountTextField(
                               inputFormatters: [
                                 ThousandsFormatter(),
                               ],
                               controller: amountController,
                               hintText: 'Amount Due',
                               obscureText: false,
                               keyBoardType: TextInputType.number,
                               enabled: false,
                               // suffix: fitValue.value == 0
                               //     ? ''
                               //     : '$fitValue $fitUnit',
                             ),
                           ),
                       ],
                     ),

                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         TextFieldLabelWidget(label: 'Paid Amount'),
                         SizedBox(
                           width: 190,
                           child: AuthTextField(
                             inputFormatters: [
                               ThousandsFormatter(),
                             ],
                             controller: paidController,
                             hintText: 'Paid',
                             obscureText: false,
                             keyBoardType: TextInputType.number,
                             onChanged: (value) {
                               balanceController.text = (int.parse(
                                   amountController.text
                                       .trim()
                                       .toString()
                                       .replaceAll(',', '')) -
                                   int.parse(
                                       paidController.text.isEmpty
                                           ? '0'
                                           : paidController.text
                                           .trim()
                                           .replaceAll(',', '')))
                                   .toString()
                                   .replaceAll(',', '');
                               print(
                                   'MY Balance == ${balanceController.text}');
                             },
                           ),
                         ),
                       ],
                     ),


                   ],
                 ),

                              const SizedBox(
                                height: 10,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextFieldLabelWidget(label: 'Payment Mode'),
                                      SizedBox(
                                        child: BlocBuilder<PaymentModeBloc,
                                            PaymentModeState>(
                                          builder: (context, state) {
                                            if (state.status ==
                                                PaymentModeStatus.initial) {
                                              context
                                                  .read<PaymentModeBloc>()
                                                  .add(LoadAllPaymentModesEvent(selectedPropertyId));
                                            }
                                            if (state.status ==
                                                PaymentModeStatus.success) {
                                              paymentModeModel =
                                                  state.paymentModes!.firstWhere(
                                                        (payments) => payments.code == 'CASH',
                                                    // orElse: () => null as CurrencyModel,
                                                  );
                                            }
                                            return CustomApiGenericDropdown<
                                                PaymentModeModel>(
                                              hintText: 'Payment Mode',
                                              menuItems: state.paymentModes == null
                                                  ? []
                                                  : state.paymentModes!,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedPaymentModeId = value!.id!;
                                                });
                                              },
                                              defaultValue: paymentModeModel,
                                            );
                                          },
                                        ),
                                        width: 190,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextFieldLabelWidget(label: 'Credited Account'),
                                      SizedBox(
                                          width: 190,
                                          child: BlocBuilder<PaymentAccountBloc,
                                              PaymentAccountState>(
                                            builder: (context, state) {
                                              if (state.status ==
                                                  PaymentAccountStatus.initial) {
                                                context.read<PaymentAccountBloc>().add(
                                                    LoadAllPaymentAccountsEvent(selectedPropertyId));
                                              }   if (state.status ==
                                                  PaymentAccountStatus.success) {
                                                paymentAccountsModel =
                                                    state.paymentAccounts!.firstWhere(
                                                          (accounts) => accounts.number == 'PETTYCASH',
                                                      // orElse: () => null as CurrencyModel,
                                                    );
                                              }
                                              return CustomApiGenericDropdown<
                                                  PaymentAccountsModel>(
                                                hintText: 'Credited Account',
                                                menuItems:
                                                state.paymentAccounts == null
                                                    ? []
                                                    : state.paymentAccounts!,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedPaymentAccountId =
                                                    value!.id!;
                                                  });
                                                },
                                                defaultValue: paymentAccountsModel,
                                              );
                                            },
                                          )),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldLabelWidget(label: 'Description', showIcon: false,),
                              AppMaxTextField(
                                  controller: descriptionController,
                                  hintText: 'Description',
                                  obscureText: false,
                                fillColor: AppTheme.itemBgColor,
                              ),

                              TextFieldLabelWidget(label: 'Upload Payment Pic', showIcon: false,),
                              GestureDetector(
                                onTap: () {
                                  FullPicker(
                                    context: context,
                                    file: true,
                                    image: true,
                                    video: true,
                                    videoCamera: true,
                                    imageCamera: true,
                                    voiceRecorder: true,
                                    videoCompressor: false,
                                    imageCropper: false,
                                    multiFile: true,
                                    url: true,
                                    onError: (int value) {
                                      print(" ----  onError ----=$value");
                                    },
                                    onSelected: (value) async {
                                      print(" ----  onSelected ----");

                                      setState(() {
                                        paymentPic = value.file.first;
                                        paymentImagePath = value.file.first!.path;
                                        paymentImageExtension = value
                                            .file.first!.path
                                            .split('.')
                                            .last;
                                        paymentFileName = value.file.first!.path
                                            .split('/')
                                            .last;
                                      });
                                      paymentBytes =
                                      await paymentPic!.readAsBytes();
                                      print('MY PIC == $paymentPic');
                                      print('MY path == $paymentImagePath');
                                      print('MY bytes == $paymentBytes');
                                      print(
                                          'MY extension == $paymentImageExtension');
                                      print('MY FILE NAME == $paymentFileName');
                                    },
                                  );
                                },
                                child: Container(
                                  width: 175,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      color: AppTheme.itemBgColor,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image:
                                          FileImage(paymentPic ?? File('')),
                                          fit: BoxFit.cover)),
                                  child: paymentPic == null
                                      ? const Center(
                                    child: Text('Upload payment pic'),
                                  )
                                      : null,
                                ),
                              ),

                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
