import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:smart_rent/data_layer/models/currency/currency_model.dart';
import 'package:smart_rent/data_layer/models/floor/floor_model.dart';
import 'package:smart_rent/data_layer/models/period/period_model.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/data_layer/models/unit/unit_type_model.dart';
import 'package:smart_rent/ui/pages/currency/bloc/currency_bloc.dart';
import 'package:smart_rent/ui/pages/floors/bloc/floor_bloc.dart';
import 'package:smart_rent/ui/pages/period/bloc/period_bloc.dart';
import 'package:smart_rent/ui/pages/units/bloc/unit_bloc.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/app_drop_downs.dart';
import 'package:smart_rent/ui/widgets/app_max_textfield.dart';
import 'package:smart_rent/ui/widgets/auth_textfield.dart';
import 'package:smart_rent/ui/widgets/form_title_widget.dart';
import 'package:smart_rent/utilities/app_init.dart';

class AddUnitForm extends StatefulWidget {
  final String addButtonText;
  final bool isUpdate;
  final Property property;

  const AddUnitForm(
      {super.key,
      required this.addButtonText,
      required this.isUpdate,
      required this.property});

  @override
  State<AddUnitForm> createState() => _AddUnitFormState();
}

class _AddUnitFormState extends State<AddUnitForm> {
  final TextEditingController roomNameController = TextEditingController();
  final TextEditingController roomNumberController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController unitNumberController = TextEditingController();

  bool isTitleElevated = false;
  String? floorName;
  int selectedPropertyId = 0;

  int selectedUnitTypeId = 0;
  int selectedFloorId = 0;
  int selectedDurationId = 0;
  int selectedCurrency = 0;

  CurrencyModel? currencyModel;
  PeriodModel? periodModel;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    roomNumberController.dispose();
    roomNameController.dispose();
    sizeController.dispose();
    amountController.dispose();
    descriptionController.dispose();
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
            BlocListener<UnitBloc, UnitState>(
              listener: (context, state) {
                if (state.status == UnitStatus.successAdd) {
                  Fluttertoast.showToast(
                      msg: 'Unit Added Successfully',
                      backgroundColor: Colors.green,
                      gravity: ToastGravity.TOP);
                  selectedFloorId == 0;
                  selectedCurrency == 0;
                  selectedUnitTypeId == 0;
                  selectedDurationId == 0;
                  sizeController.clear();
                  roomNumberController.clear();
                  amountController.clear();
                  descriptionController.clear();
                  roomNameController.clear();
                  unitNumberController.clear();
            context.read<UnitBloc>().add(LoadAllUnitsEvent(widget.property.id!));
                  Navigator.pop(context);
                }
                if (state.status == UnitStatus.accessDeniedAdd) {
                  Fluttertoast.showToast(
                      msg: state.message.toString(), gravity: ToastGravity.TOP);
                }
                if (state.status == UnitStatus.errorAdd) {
                  Fluttertoast.showToast(
                      msg: state.message.toString(), gravity: ToastGravity.TOP);
                }
              },
              child: FormTitle(
                name: '${widget.isUpdate ? "Edit" : "New"}  Unit',
                addButtonText: widget.isUpdate ? "Update" : "Add",
                onSave: () {

                  if (selectedUnitTypeId == 0) {
                    Fluttertoast.showToast(
                        msg: 'please select a unit type',
                        gravity: ToastGravity.TOP);
                  }  else if (selectedFloorId == 0) {
                    Fluttertoast.showToast(
                        msg: 'please select a floor',
                        gravity: ToastGravity.TOP);
                  } else if (roomNumberController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'unit name required', gravity: ToastGravity.TOP);
                  } else if (roomNumberController.text.length <= 1) {
                    Fluttertoast.showToast(
                        msg: 'unit name too short', gravity: ToastGravity.TOP);
                  } else if (amountController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'amount required', gravity: ToastGravity.TOP);
                  } else {
                    context.read<UnitBloc>().add(AddUnitEvent(
                          currentUserToken.toString(),
                          selectedUnitTypeId,
                          selectedFloorId,
                          roomNumberController.text.trim().toString(),
                          sizeController.text.trim().toString(),
                      selectedDurationId == 0 ? periodModel!.id!.toInt() : selectedDurationId,
                      selectedCurrency == 0 ? currencyModel!.id!.toInt() : selectedCurrency,
                          int.parse(amountController.text
                              .trim()
                              .toString()
                              .replaceAll(',', '')),
                          descriptionController.text.trim().toString(),
                          widget.property.id!,
                        ));
                  }
                },
                isElevated: true,
                onCancel: () {
                  selectedFloorId == 0;
                  selectedCurrency == 0;
                  selectedUnitTypeId == 0;
                  selectedDurationId == 0;
                  selectedPropertyId == 0;
                  sizeController.clear();
                  roomNumberController.clear();
                  amountController.clear();
                  descriptionController.clear();
                  roomNameController.clear();
                  unitNumberController.clear();
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
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 190,
                                    child: BlocBuilder<UnitBloc, UnitState>(
                                      builder: (context, state) {
                                        if (state.status ==
                                            UnitStatus.initial) {
                                          context.read<UnitBloc>().add(
                                              LoadUnitTypesEvent(
                                                  widget.property.id!));
                                        }
                                        return CustomApiGenericDropdown<
                                            UnitTypeModel>(
                                          hintText: 'Unit Type',
                                          menuItems: state.unitTypes == null
                                              ? []
                                              : state.unitTypes!,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedUnitTypeId = value!.id!;
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 190,
                                    child: BlocBuilder<FloorBloc, FloorState>(
                                      builder: (context, state) {
                                        if (state.status ==
                                            FloorStatus.initial) {
                                          context.read<FloorBloc>().add(
                                              LoadAllFloorsEvent(
                                                  widget.property.id!));
                                        }
                                        return CustomApiGenericDropdown<
                                            FloorModel>(
                                          hintText: 'Floor',
                                          menuItems: state.floors == null
                                              ? []
                                              : state.floors!,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedFloorId = value!.id!;
                                            });
                                            print(
                                                'My floor ${selectedFloorId}');
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 190,
                                    child: AuthTextField(
                                      controller: roomNumberController,
                                      hintText: 'Unit Name/Number',
                                      obscureText: false,
                                      keyBoardType: TextInputType.text,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 190,
                                    child: AuthTextField(
                                      controller: sizeController,
                                      hintText: 'Square Meters',
                                      obscureText: false,
                                      keyBoardType: TextInputType.text,
                                    ),
                                  ),
                                ],
                              ),

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //
                              //     // SizedBox(
                              //     //   width: 42.5.w,
                              //     //   child: AppTextField(
                              //     //     controller: sizeController,
                              //     //     hintText: 'Square Meters',
                              //     //     obscureText: false,
                              //     //   ),
                              //     // ),
                              //
                              //     // SizedBox(
                              //     //   width: 42.5.w,
                              //     //   child: Obx(() {
                              //     //     return CustomApiGenericDropdown<
                              //     //         PaymentScheduleModel>(
                              //     //       hintText: 'Per Month',
                              //     //       menuItems: unitController.paymentList.value,
                              //     //       onChanged: (value) {
                              //     //         unitController.setPaymentScheduleId(value!.id);
                              //     //       },
                              //     //     );
                              //     //   }),
                              //     // ),
                              //
                              //     // SizedBox(
                              //     //   width: 42.5.w,
                              //     //   child: Obx(() {
                              //     //     return CustomPeriodApiGenericDropdown<PaymentScheduleModel>(
                              //     //       hintText: 'Per Month',
                              //     //       menuItems: unitController.paymentList.value,
                              //     //       onChanged: (value) {
                              //     //         unitController.setPaymentScheduleId(value!.id);
                              //     //       },
                              //     //     );
                              //     //   }),
                              //     // ),
                              //
                              //   ],
                              // ),

                              const SizedBox(
                                height: 10,
                              ),

                              BlocBuilder<PeriodBloc, PeriodState>(
                                builder: (context, state) {
                                  if (state.status == PeriodStatus.initial) {
                                    context.read<PeriodBloc>().add(
                                        LoadAllPeriodsEvent(
                                            widget.property.id!));
                                  }
                                  if (state.status == PeriodStatus.success) {
                                    periodModel = state.periods!.firstWhere(
                                      (period) => period.code == 'MONTHLY',
                                      // orElse: () => null as CurrencyModel,
                                    );
                                  }
                                  return CustomApiGenericDropdown<PeriodModel>(
                                    hintText: 'Period',
                                    menuItems: state.periods == null
                                        ? []
                                        : state.periods!,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedDurationId = value!.id!;
                                      });
                                    },
                                    defaultValue: periodModel,
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //
                              //     SizedBox(
                              //       width: 42.5.w,
                              //       child: Obx(() {
                              //         return CustomApiCurrencyDropdown<
                              //             CurrencyModel>(
                              //           hintText: 'Currency',
                              //           menuItems: unitController.currencyList.value,
                              //           onChanged: (value) {
                              //             unitController.setCurrencyId(value!.id);
                              //           },
                              //         );
                              //       }),
                              //     ),
                              //
                              //     SizedBox(
                              //       child: AppTextField(
                              //         controller: amountController,
                              //         hintText: 'Amount',
                              //         obscureText: false,
                              //         keyBoardType: TextInputType.number,
                              //       ),
                              //       width: 42.5.w,
                              //     ),
                              //
                              //
                              //   ],
                              // ),

                              BlocBuilder<CurrencyBloc, CurrencyState>(
                                builder: (context, state) {
                                  if (state.status == CurrencyStatus.initial) {
                                    context.read<CurrencyBloc>().add(
                                        LoadAllCurrenciesEvent(
                                            widget.property.id!));
                                  }
                                  if (state.status == CurrencyStatus.success) {
                                    currencyModel =
                                        state.currencies!.firstWhere(
                                      (currency) => currency.code == 'UGX',
                                      // orElse: () => null as CurrencyModel,
                                    );
                                  }
                                  return CustomApiGenericDropdown<
                                      CurrencyModel>(
                                    hintText: 'Currency',
                                    menuItems: state.currencies == null
                                        ? []
                                        : state.currencies!,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCurrency = value!.id!;
                                      });
                                    },
                                    defaultValue: currencyModel,
                                  );
                                },
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              AuthTextField(
                                controller: amountController,
                                hintText: 'Amount',
                                obscureText: false,
                                keyBoardType: TextInputType.number,
                                inputFormatters: [
                                  ThousandsFormatter(),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              AppMaxTextField(
                                controller: descriptionController,
                                hintText: 'Description',
                                obscureText: false,
                                fillColor: AppTheme.itemBgColor,
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
