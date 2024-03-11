import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:smart_rent/data_layer/models/currency/currency_model.dart';
import 'package:smart_rent/data_layer/models/period/period_model.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/data_layer/models/tenant/tenant_model.dart';
import 'package:smart_rent/data_layer/models/unit/unit_model.dart';
import 'package:smart_rent/ui/pages/currency/bloc/currency_bloc.dart';
import 'package:smart_rent/ui/pages/period/bloc/period_bloc.dart';
import 'package:smart_rent/ui/pages/properties/widgets/loading_widget.dart';
import 'package:smart_rent/ui/pages/tenant_unit/bloc/tenant_unit_bloc.dart';
import 'package:smart_rent/ui/pages/tenants/bloc/tenant_bloc.dart';
import 'package:smart_rent/ui/pages/units/bloc/unit_bloc.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/app_drop_downs.dart';
import 'package:smart_rent/ui/widgets/custom_accordion.dart';
import 'package:smart_rent/ui/widgets/custom_textbox.dart';
import 'package:smart_rent/ui/widgets/form_title_widget.dart';
import 'package:smart_rent/utilities/app_init.dart';

class TenantUnitForm extends StatelessWidget {
  final String addButtonText;
  final bool isUpdate;
  final Property property;

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

  TenantUnitForm(
      {super.key,
      required this.addButtonText,
      required this.isUpdate,
      required this.property});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TenantUnitBloc, TenantUnitState>(
      builder: (context, state) {
        return _buildBody(context, state);
      },
      listener: (context, state) {
        if (state.status.isLoadingAdd) {
          const LoadingWidget();
        }
        if (state.status.isSuccessAdd) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state.status.isErrorAdd) {
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
    );
  }

  Widget _buildBody(BuildContext context, TenantUnitState state) {
    startDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    endDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    var numberFormat = NumberFormat("###,###,###,###,###");
    return ListView(
      children: [
        FormTitle(
          name: '${isUpdate ? "Edit" : "New"}  Tenant',
          addButtonText: isUpdate ? "Update" : "Add",
          onSave: () {
            context.read<TenantUnitBloc>().add(
                  AddTenantUnitEvent(
                    currentUserToken.toString(),
                    tenant.id!,
                    unit.id!,
                    period.id!,
                    durationController.text,
                    DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(startDateController.text)),
                    DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(endDateController.text)),
                    unitAmountController.text,
                    currency.id!,
                    discountedAmountController.text,
                    descriptionController.text,
                    property.id!,
                  ),
                );
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
                        .add(LoadAllUnitsEvent(property.id!));
                  }
                  if (state.status.isSuccess) {
                    return TenantUnitDropdown<UnitModel>(
                      hintText: 'Select unit name/number',
                      menuItems: state.units,
                      onChanged: (value) {
                        if (value != null) {
                          unit = value;
                          unitAmountController.text =
                              numberFormat.format(value.amount);
                          discountedAmountController.text =
                              numberFormat.format(value.amount);
                        }
                      },
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
                        .add(LoadAllPeriodsEvent(property.id!));
                  }
                  if (state.status.isSuccess ||
                      state.status.isDurationSelected) {
                    return Column(
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
                                  hint: _placeHolder(state.durationIdSelected!),
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
                        DateAccordion(
                          dateController: startDateController,
                          title: "From",
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
              SmartCaseTextField(
                hint: 'Unit amount',
                maxLength: 50,
                minLines: 1,
                maxLines: 1,
                controller: unitAmountController,
              ),
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
                        .add(LoadAllCurrenciesEvent(property.id!));
                  }
                  if (state.status.isSuccess) {
                    return Row(
                      children: [
                        Expanded(
                          child: CustomApiGenericDropdown<CurrencyModel>(
                            hintText: 'Select currency',
                            menuItems: state.currencies,
                            onChanged: (value) {
                              if (value != null) {
                                currency = value;
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SmartCaseTextField(
                            hint: 'Discounted amount',
                            maxLength: 50,
                            minLines: 1,
                            maxLines: 1,
                            controller: discountedAmountController,
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
