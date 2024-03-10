import 'dart:io';
import 'dart:typed_data';

import 'package:SmartCase/data_layer/models/currency/currency_model.dart';
import 'package:SmartCase/data_layer/models/floor/floor_model.dart';
import 'package:SmartCase/data_layer/models/payment/payment_account_model.dart';
import 'package:SmartCase/data_layer/models/payment/payment_mode_model.dart';
import 'package:SmartCase/data_layer/models/period/period_model.dart';
import 'package:SmartCase/data_layer/models/property/property_response_model.dart';
import 'package:SmartCase/data_layer/models/tenant_unit/tenant_unit_model.dart';
import 'package:SmartCase/data_layer/models/unit/unit_type_model.dart';
import 'package:SmartCase/ui/pages/currency/bloc/currency_bloc.dart';
import 'package:SmartCase/ui/pages/floors/bloc/floor_bloc.dart';
import 'package:SmartCase/ui/pages/payment_account/bloc/payment_account_bloc.dart';
import 'package:SmartCase/ui/pages/payment_mode/bloc/payment_mode_bloc.dart';
import 'package:SmartCase/ui/pages/payment_schedules/bloc/payment_schedules_bloc.dart';
import 'package:SmartCase/ui/pages/payments/bloc/payment_bloc.dart';
import 'package:SmartCase/ui/pages/period/bloc/period_bloc.dart';
import 'package:SmartCase/ui/pages/tenant_unit/bloc/tenant_unit_bloc.dart';
import 'package:SmartCase/ui/pages/units/bloc/unit_bloc.dart';
import 'package:SmartCase/ui/themes/app_theme.dart';
import 'package:SmartCase/ui/widgets/amount_text_field.dart';
import 'package:SmartCase/ui/widgets/app_drop_downs.dart';
import 'package:SmartCase/ui/widgets/app_max_textfield.dart';
import 'package:SmartCase/ui/widgets/auth_textfield.dart';
import 'package:SmartCase/ui/widgets/form_title_widget.dart';
import 'package:SmartCase/utilities/app_init.dart';
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



class AddPaymentForm extends StatefulWidget {
  final String addButtonText;
  final bool isUpdate;
  final Property property;

  const AddPaymentForm(
      {super.key, required this.addButtonText, required this.isUpdate, required this.property});

  @override
  State<AddPaymentForm> createState() => _AddPaymentFormState();
}

class _AddPaymentFormState extends State<AddPaymentForm> {
  File? paymentPic;
  String? paymentImagePath;
  String? paymentImageExtension;
  String? paymentFileName;
  Uint8List? paymentBytes;

  var myPaymentSchedules = [];
  var myBalances = [];
  final MultiSelectController myPaymentSchedulesController = MultiSelectController();

  var unitBalance = 0;

  final TextEditingController paidController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController paymentDateController = TextEditingController();

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

  Future<int> setPaymentScheduleId(int id) async {
    setState(() {
      selectedPaymentScheduleId = id;
    });

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
      initialDate: paymentDate.value,
      minDate: DateTime(1900),
      maxDate: DateTime.now(),
    );

    if (picked != null) {
      paymentDate(picked);
      // paymentDateController.text =
      //     '${DateFormat('MM/dd/yyyy').format(paymentDate.value)}';
      var formatedDate1 = "${paymentDate.value.year}-${paymentDate.value.day}-${paymentDate.value.month}";
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

  late bool isTitleElevated = false;


  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tenantUnitsDropdownCont = SingleValueDropDownController();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

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
            BlocListener<PaymentBloc, PaymentState>(
              listener: (context, state) {
                if (state.status == PaymentStatus.successAdd) {
                  Fluttertoast.showToast(
                      msg: 'Payment Added Successfully',
                      backgroundColor: Colors.green,
                      gravity: ToastGravity.TOP);
                  selectedDate1.value = DateTime.now();
                  selectedDate2.value = DateTime.now();
                  amountController.clear();
                  paidController.clear();
                  balanceController.clear();
                  initialBalance = 0;
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
                  } else if (selectedPaymentAccountId == 0) {
                    Fluttertoast.showToast(
                        msg: 'please select payment account',
                        gravity: ToastGravity.TOP);
                  } else if (selectedPaymentModeId == 0) {
                    Fluttertoast.showToast(
                        msg: 'please select a payment mode',
                        gravity: ToastGravity.TOP);
                  } else if (int.parse(paidController.text.trim().replaceAll(',', '').toString()) > int.parse(amountController.text.trim().replaceAll(',', '').toString())) {
                    Fluttertoast.showToast(
                        msg: 'paid amount exceeds balance',
                        gravity: ToastGravity.TOP);
                  } else {
                    print('MY INITIAL BALANCE IS == $initialBalance');
                    var postedBalance =  initialBalance - int.parse(paidController.text.trim().replaceAll(',', '').toString());
                    print('MY Posted Balance == $postedBalance');
                    print('MY Cont options = ${_controller.options}');
                    print('amount = $amountController');
                    print('paid = $paidController');
                    print('balance = $balanceController');

                    List<String> stringScheduleList = myPaymentSchedules.map((item) => item.toString()).toList();

                    context.read<PaymentBloc>().add(AddPaymentsEvent(
                      currentUserToken.toString(),
                      paidController.text.trim().replaceAll(',', '').toString(),
                      balanceController.text.trim().replaceAll(',', '').toString(),
                      paymentDateController.text.trim(),
                      selectedTenantUnitId,
                      selectedPaymentAccountId,
                      selectedPaymentModeId,
                      widget.property.id!,
                      stringScheduleList,
                    ));
                  }
                },
                isElevated: isTitleElevated,
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


                              AuthTextField(
                                controller: paymentDateController,
                                hintText: 'Payment Date',
                                obscureText: false,
                                onTap: () {
                                  _selectPaymentDate(context);
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              BlocListener<PaymentSchedulesBloc,
                                  PaymentSchedulesState>(
                                listener: (context, state) {
                                  if (state.status ==
                                      PaymentSchedulesStatus.initial) {
                                    context.read<PaymentSchedulesBloc>().add(
                                        LoadAllPaymentSchedulesEvent(
                                            selectedPaymentScheduleId, widget.property.id!));
                                  }
                                },
                                child:
                                BlocBuilder<TenantUnitBloc, TenantUnitState>(
                                  builder: (context, state) {
                                    if (state.status ==
                                        TenantUnitStatus.initial) {
                                      context
                                          .read<TenantUnitBloc>()
                                          .add(LoadTenantUnitsEvent(widget.property.id!));
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

                                        // setState((){
                                        //   selectedTenantUnitId = value.value.id;
                                        // });
                                        print('My Amounts = ${value.value.getAmount()}');
                                        setPaymentScheduleId(value.value.id)
                                            .then((newValue) {
                                          print(
                                              'My Selected TENANT UNIT ID IS ++ $newValue');
                                          context
                                              .read<PaymentSchedulesBloc>()
                                              .add(LoadAllPaymentSchedulesEvent(
                                              newValue, widget.property.id!));
                                        });

                                      },
                                    );
                                  },
                                ),
                              ),

                              BlocBuilder<PaymentSchedulesBloc,
                                  PaymentSchedulesState>(
                                builder: (context, state) {
                                  // if(state.status == PaymentSchedulesStatus.initial){
                                  //   context.read<PaymentSchedulesBloc>().add(LoadAllPaymentSchedulesEvent(selectedPaymentScheduleId));
                                  // }
                                  if (state.status ==
                                      PaymentSchedulesStatus.success) {
                                    return MultiSelectDropDown(
                                      controller: _controller,
                                      inputDecoration: BoxDecoration(
                                        color: AppTheme.itemBgColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      clearIcon: Icon(Icons.clear),
                                      // showClearIcon: true,
                                      hint: 'Select Payment Schedule',
                                      hintStyle: TextStyle(
                                        color: AppTheme.inActiveColor,
                                        fontSize: 16,
                                      ),

                                      onOptionSelected: (options) {
                                        for (var element in options) {
                                          print('My selected element = $element');

                                          myPaymentSchedules = options
                                              .map((e) => e.value)
                                              .toList();
                                          print(
                                              'My Options selected schedules = $myPaymentSchedules');

                                          myBalances = options
                                              .map((e) => e.value)
                                              .toList();

                                          print('My selected balances = ${myBalances.map((e) => e.balance).toList()}');

                                          int sumBalances = myBalances.map((e) => int.parse(e.balance.replaceAll(',',''))).toList().reduce((value, element) => value + element);

                                          print('My Toatal balance = $sumBalances');
                                          amountController.text = sumBalances.toString();
                                          paidController.text = sumBalances.toString();
                                          // balanceController.text = int.parse(tenantController.specificPaymentBalance.value.toString()) as String;

                                        }
                                      },
                                      options: state.paymentSchedules == null
                                          ? []
                                          : state.paymentSchedules!
                                          .map((schedule) {
                                        // initialBalance = schedule.balance!;
                                        return ValueItem(
                                          label:
                                          '${schedule.fromDate}-${schedule.toDate} || ${schedule.balance}',
                                          value: schedule,
                                          // '${schedule.units!
                                          //     .unitNumber}|${schedule.balance}'
                                        );
                                      }).toList(),
                                      selectionType: SelectionType.multi,
                                      chipConfig: const ChipConfig(
                                        wrapType: WrapType.wrap,
                                      ),
                                      borderColor: Colors.white,
                                      optionTextStyle:
                                      const TextStyle(fontSize: 16),
                                      selectedOptionIcon:
                                      const Icon(Icons.check_circle),
                                    );
                                  }
                                  return Container();
                                },
                              ),


                              SizedBox(
                                height: 10,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: BlocBuilder<PaymentModeBloc,
                                        PaymentModeState>(
                                      builder: (context, state) {
                                        if (state.status ==
                                            PaymentModeStatus.initial) {
                                          context
                                              .read<PaymentModeBloc>()
                                              .add(LoadAllPaymentModesEvent(widget.property.id!));
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
                                  SizedBox(
                                      width: 190,
                                      child: BlocBuilder<PaymentAccountBloc,
                                          PaymentAccountState>(
                                        builder: (context, state) {
                                          if (state.status ==
                                              PaymentAccountStatus.initial) {
                                            context.read<PaymentAccountBloc>().add(
                                                LoadAllPaymentAccountsEvent(widget.property.id!));
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
                                          );
                                        },
                                      )),
                                ],
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Obx(() {
                                return AmountTextField(
                                  inputFormatters: [
                                    ThousandsFormatter(),
                                  ],
                                  controller: amountController,
                                  hintText: 'Amount',
                                  obscureText: false,
                                  keyBoardType: TextInputType.number,
                                  enabled: false,
                                  suffix: fitValue.value == 0
                                      ? ''
                                      : '$fitValue $fitUnit',
                                );
                              }),

                              SizedBox(
                                height: 10,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
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
                                    width: 190,
                                  ),
                                  SizedBox(
                                    width: 190,
                                    child: AuthTextField(
                                      inputFormatters: [
                                        ThousandsFormatter(),
                                      ],
                                      controller: balanceController,
                                      hintText: 'Balance',
                                      obscureText: false,
                                      keyBoardType: TextInputType.number,
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 10,
                              ),
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
                                      ? Center(
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
