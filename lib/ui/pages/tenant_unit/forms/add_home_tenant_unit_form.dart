import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:smart_rent/data_layer/models/currency/currency_model.dart';
import 'package:smart_rent/data_layer/models/period/period_model.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/data_layer/models/tenant/tenant_model.dart';
import 'package:smart_rent/data_layer/models/unit/unit_model.dart';
import 'package:smart_rent/ui/pages/currency/bloc/currency_bloc.dart';
import 'package:smart_rent/ui/pages/period/bloc/period_bloc.dart';
import 'package:smart_rent/ui/pages/properties/bloc/property_bloc.dart';
import 'package:smart_rent/ui/pages/properties/widgets/loading_widget.dart';
import 'package:smart_rent/ui/pages/tenant_unit/bloc/form/tenant_unit_form_bloc.dart';
import 'package:smart_rent/ui/pages/tenants/bloc/tenant_bloc.dart';
import 'package:smart_rent/ui/pages/units/bloc/unit_bloc.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/amount_text_field.dart';
import 'package:smart_rent/ui/widgets/app_drop_downs.dart';
import 'package:smart_rent/ui/widgets/auth_textfield.dart';
import 'package:smart_rent/ui/widgets/custom_accordion.dart';
import 'package:smart_rent/ui/widgets/custom_textbox.dart';
import 'package:smart_rent/ui/widgets/form_title_widget.dart';
import 'package:smart_rent/utilities/app_init.dart';
import 'package:smart_rent/utilities/extra.dart';

class AddHomeTenantUnitForm extends StatefulWidget {
  final String addButtonText;
  final bool isUpdate;

  AddHomeTenantUnitForm({
    super.key,
    required this.addButtonText,
    required this.isUpdate,
  });

  @override
  State<AddHomeTenantUnitForm> createState() => _AddHomeTenantUnitFormState();
}

class _AddHomeTenantUnitFormState extends State<AddHomeTenantUnitForm> {
  TextEditingController durationController = TextEditingController();

  TextEditingController unitAmountController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController discountedAmountController = TextEditingController();

  TextEditingController startDateController = TextEditingController();

  TextEditingController endDateController = TextEditingController();

  TenantModel tenant = TenantModel();

  UnitModel unit = UnitModel();

  PeriodModel period = PeriodModel();

  CurrencyModel currency = CurrencyModel();
  var numberFormat = NumberFormat("###,###,###,###,###");

  late SingleValueDropDownController _propertyModelCont;
  int selectedPropertyId = 0;

  late SingleValueDropDownController unitController;

  CurrencyModel? currencyModel;

  int selectedCurrency = 0;

  @override
  void initState() {
    super.initState();
    startDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    endDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _propertyModelCont = SingleValueDropDownController();
    unitController = SingleValueDropDownController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20)
          .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BlocConsumer<TenantUnitFormBloc, TenantUnitFormState>(
        builder: (context, state) {
          return _buildBody(context, state);
        },
        listener: (context, state) {
          if (state.status.isLoading) {
            const LoadingWidget();
          }
          if (state.status.isSuccess) {
            Navigator.pop(context);
          }
          if (state.status.isError) {
            Fluttertoast.showToast(
                msg: state.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, TenantUnitFormState state) {
    return ListView(
      children: [
        FormTitle(
          name: '${widget.isUpdate ? "Edit" : "New"}  Tenant',
          addButtonText: widget.isUpdate ? "Update" : "Add",
          onSave: () {
            if (selectedPropertyId == 0) {
              Fluttertoast.showToast(
                  msg: 'please select property', gravity: ToastGravity.TOP);
            } else {
              context.read<TenantUnitFormBloc>().add(
                    AddTenantUnitEvent(
                      currentUserToken.toString(),
                      tenant.id!,
                      unit.id!,
                      period.id!,
                      durationController.text,
                      DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy')
                          .parse(startDateController.text)),
                      DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy')
                          .parse(endDateController.text)),
                      unitAmountController.text,
                      currency.id!,
                      discountedAmountController.text,
                      descriptionController.text,
                      selectedPropertyId,
                    ),
                  );
            }
          },
          isElevated: true,
          onCancel: () {
            Navigator.pop(context);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            children: [
              BlocBuilder<PropertyBloc, PropertyState>(
                builder: (context, state) {
                  if (state.status == PropertyStatus.initial) {
                    context.read<PropertyBloc>().add(LoadPropertiesEvent());
                  }
                  if (state.status == PropertyStatus.empty) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: AuthTextField(
                        hintText: 'No Properties',
                        obscureText: false,
                        enabled: false,
                      ),
                    );
                  }
                  if (state.status == PropertyStatus.error) {
                    return Center(
                      child: Text('An Error Occurred'),
                    );
                  }
                  return SearchablePropertyModelListDropDown<Property>(
                    hintText: 'Property',
                    menuItems:
                        state.properties == null ? [] : state.properties!,
                    controller: _propertyModelCont,
                    onChanged: (value) {
                      setState(() {
                        selectedPropertyId = value.value.id;
                      });
                      context
                          .read<UnitBloc>()
                          .add(LoadAllUnitsEvent(selectedPropertyId));
                      print('Property is $selectedPropertyId}');
                    },
                  );
                },
              ),

              BlocBuilder<TenantBloc, TenantState>(
                builder: (context, state) {
                  if (state.status.isInitial) {
                    context.read<TenantBloc>().add(LoadAllTenantsEvent());
                  }
                  if (state.status.isSuccess) {
                    return Column(
                      children: [
                        CustomApiGenericTenantModelDropdown<TenantModel>(
                          hintText: 'Select tenant',
                          menuItems: state.tenants!,
                          onChanged: (value) {
                            if (value != null) {
                              tenant = value;
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  if (state.status.isLoading) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  if (state.status.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Text("No tenants available"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  return const SizedBox(height: 10);
                },
              ),
              BlocBuilder<UnitBloc, UnitState>(
                builder: (context, state) {
                  if (state.status.isInitial) {
                    context
                        .read<UnitBloc>()
                        .add(LoadAllUnitsEvent(selectedPropertyId));
                  }
                  if (state.status.isSuccess) {
                    return SearchableUnitDropDown<UnitModel>(
                      hintText: 'Select unit name/number',
                      menuItems: state.units
                          .where((unit) => unit.isAvailable == 1)
                          .toList(),
                      controller: unitController,
                      onChanged: (value) {
                        if (value != null) {
                          unit = value.value;
                          unitAmountController.text = amountFormatter
                              .format(value.value.amount.toString());
                          discountedAmountController.text = amountFormatter
                              .format(value.value.amount.toString());
                        }

                        print('My Amount = ${value.value.amount.toString()}');
                      },
                    );

                    // return TenantUnitDropdown<UnitModel>(
                    //   hintText: 'Select unit name/number',
                    //   menuItems: state.units.where((unit) => unit.isAvailable == 1 ).toList(),
                    //   onChanged: (value) {
                    //     if (value != null) {
                    //       unit = value;
                    //       unitAmountController.text =
                    //           numberFormat.format(value.amount);
                    //       discountedAmountController.text =
                    //           numberFormat.format(value.amount);
                    //     }
                    //   },
                    // );
                  }
                  if (state.status.isLoading) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  if (state.status.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child:
                                const Center(child: Text("No units available")),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  return const SizedBox(height: 10);
                },
              ),
              BlocBuilder<PeriodBloc, PeriodState>(
                builder: (context, state) {
                  if (state.status.isInitial) {
                    context
                        .read<PeriodBloc>()
                        .add(LoadAllPeriodsEvent(selectedPropertyId));
                  }
                  if (state.status.isSuccess ||
                      state.status.isDurationSelected) {
                    return Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomApiGenericDropdown<PeriodModel>(
                                    hintText: 'Select period',
                                    menuItems: state.periods,
                                    onChanged: (value) {
                                      period = value!;
                                      context
                                          .read<PeriodBloc>()
                                          .add(SelectPeriodEvent(value.id!));
                                    },
                                  ),
                                ),
                                if (state.status.isDurationSelected)
                                  const SizedBox(width: 10),
                                if (state.status.isDurationSelected)
                                  Expanded(
                                    child: SmartCaseTextField(
                                      hint: _placeHolder(
                                          state.durationIdSelected!),
                                      maxLength: 50,
                                      minLines: 1,
                                      maxLines: 1,
                                      controller: durationController,
                                      onChanged: (value) {
                                        String duration;
                                        if (value.isEmpty) {
                                          duration = "0";
                                        } else {
                                          duration = value;
                                        }
                                        _durationCalc(state.durationIdSelected!,
                                            int.parse(duration));
                                      },
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                        DateAccordion(
                          dateController: startDateController,
                          title: "From",
                          onChanged: () {
                            _durationCalc(
                              state.durationIdSelected!,
                              int.parse(
                                durationController.text,
                              ),
                            );
                            setState(() {});
                          },
                        ),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.only(left: 15),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("To"),
                              SizedBox(
                                width: 120,
                                child: SmartCaseTextField(
                                  hint: "To",
                                  maxLength: 50,
                                  minLines: 1,
                                  maxLines: 1,
                                  readOnly: true,
                                  controller: endDateController,
                                  addBottomMargin: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  if (state.status.isLoading) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  return const SizedBox(height: 10);
                },
              ),
              AmountTextField(
                inputFormatters: [
                  ThousandsFormatter(),
                ],
                controller: unitAmountController,
                hintText: 'Unit amount',
                obscureText: false,
                keyBoardType: TextInputType.number,
                enabled: false,
              ),

              // SmartCaseTextField(
              //   hint: 'Unit amount',
              //   maxLength: 50,
              //   minLines: 1,
              //   maxLines: 1,
              //   controller: unitAmountController,
              //   readOnly: true,
              // ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Agreed Amount",
                    style: TextStyle(
                      color: AppTheme.primaryDarker,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: AppTheme.primaryDarker,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              BlocBuilder<CurrencyBloc, CurrencyState>(
                builder: (context, state) {
                  if (state.status.isInitial) {
                    context
                        .read<CurrencyBloc>()
                        .add(LoadAllCurrenciesEvent(selectedPropertyId));
                  }
                  if (state.status.isSuccess) {
                    currencyModel = state.currencies.firstWhere(
                      (currency) => currency.code == 'UGX',
                      // orElse: () => null as CurrencyModel,
                    );
                    return Row(
                      children: [
                        Expanded(
                          child: CustomApiGenericDropdown<CurrencyModel>(
                            hintText: 'Select currency',
                            menuItems: state.currencies == null
                                ? []
                                : state.currencies!,
                            onChanged: (value) {
                              setState(() {
                                selectedCurrency = value!.id!;
                              });
                              // if (value != null) {
                              //   currency = value;
                              // }
                            },
                            defaultValue: currencyModel,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AmountTextField(
                            inputFormatters: [
                              ThousandsFormatter(),
                            ],
                            controller: discountedAmountController,
                            hintText: 'Discounted amount',
                            obscureText: false,
                            keyBoardType: TextInputType.number,
                          ),
                        ),
                      ],
                    );
                  }
                  if (state.status.isLoading) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  return const SizedBox(height: 10);
                },
              ),
              const SizedBox(height: 10),
              CustomTextArea(
                  hint: 'Description', controller: descriptionController),
            ],
          ),
        )
      ],
    );
  }

  _placeHolder(int selectedDurationId) {
    switch (selectedDurationId) {
      case 1:
        return 'Enter No. Of Days';
      case 2:
        return 'Enter No. Of Weeks';
      case 3:
        return 'Enter No. Of Months';
      case 4:
        return 'Enter No. Of Years';
      default:
        return 'Enter duration';
    }
  }

  _durationCalc(int selectedDurationId, int duration) {
    DateTime date = DateTime.now();
    print("SELECTED ID: ${selectedDurationId}");
    switch (selectedDurationId) {
      case 1:
        date = Jiffy.parse(startDateController.text, pattern: 'dd/MM/yyyy')
            .add(days: duration)
            .dateTime;
        break;
      case 2:
        date = Jiffy.parse(startDateController.text, pattern: 'dd/MM/yyyy')
            .add(weeks: duration)
            .dateTime;
        break;
      case 3:
        date = Jiffy.parse(startDateController.text, pattern: 'dd/MM/yyyy')
            .add(months: duration)
            .dateTime;
        break;
      case 4:
        date = Jiffy.parse(startDateController.text, pattern: 'dd/MM/yyyy')
            .add(years: duration)
            .dateTime;
        break;
    }
    endDateController.text = DateFormat('dd/MM/yyyy').format(date);
    print("Date: ${endDateController.text}");
  }
}
