import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/ui/pages/payment_schedules/bloc/payment_schedules_bloc.dart';
import 'package:smart_rent/ui/pages/payments/bloc/payment_bloc.dart';
import 'package:smart_rent/ui/pages/payments/forms/add_payment_form.dart';
import 'package:smart_rent/ui/pages/properties/widgets/loading_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/no_data_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/not_found_widget.dart';
import 'package:smart_rent/ui/pages/tenant_unit/bloc/tenant_unit_bloc.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/app_search_textfield.dart';
import 'package:smart_rent/ui/widgets/smart_error_widget.dart';
import 'package:smart_rent/ui/widgets/smart_widget.dart';
import 'package:smart_rent/utilities/extra.dart';

class PaymentTabScreenLayout extends StatelessWidget {
  final Property property;

  const PaymentTabScreenLayout({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == PaymentStatus.initial) {
            context.read<PaymentBloc>().add(LoadAllPayments(property.id!));
          }
          if (state.status == PaymentStatus.loading) {
            return const LoadingWidget();
          }
          if (state.status == PaymentStatus.accessDenied) {
            return const NotFoundWidget();
          }
          if (state.status == PaymentStatus.empty) {
            return _buildEmptyBody(context, state);
          }
          if (state.status == PaymentStatus.error) {
            return SmartErrorWidget(
              message: 'Error loading payments',
              onPressed: () {
                context.read<PaymentBloc>().add(LoadAllPayments(property.id!));
              },
            );
          }
          if (state.status == PaymentStatus.success) {
            return _buildSuccessBody(context, state);
          }
          return const SmartWidget();
        },
      ),
    );
  }

  Widget _buildSuccessBody(BuildContext parentContext, PaymentState state) {
    return Scaffold(
      backgroundColor: AppTheme.appBgColor,
      appBar: _buildAppTitle(),
      floatingActionButton: FloatingActionButton(
        heroTag: "add_payment",
        onPressed: () => showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
            context: parentContext,
            builder: (context) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => PaymentSchedulesBloc()),
                  BlocProvider(create: (context) => TenantUnitBloc()),
                  BlocProvider(create: (context) => PaymentFormBloc()),
                ],
                child: AddPaymentForm(
                  parentContext: parentContext,
                  addButtonText: 'Add',
                  isUpdate: false,
                  property: property,
                ),
              );
            }),
        backgroundColor: AppTheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
      body: ListView.builder(
        controller: floorsScrollController,
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (context, index) {
          var balanceAmount =
              int.parse(state.payments![index].amountDue.toString()) -
                  int.parse(state.payments![index].amount.toString());
          return Container(
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            // width: width,
            // height: height,
            decoration: BoxDecoration(
              color: AppTheme.whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.shadowColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: .1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${state.payments![index].tenantUnitModel!.tenant!.clientTypeId == 1 ? '${state.payments![index].tenantUnitModel!.tenant!.clientProfiles!.first.firstName} ${state.payments![index].tenantUnitModel!.tenant!.clientProfiles!.first.lastName}' : '${state.payments![index].tenantUnitModel!.tenant!.clientProfiles!.first.companyName}'} - ${state.payments![index].tenantUnitModel!.unit!.name}',
                        style: AppTheme.blueAppTitle3,
                      ),
                      Text(
                        '${DateFormat('d MMM, yy').format(DateTime.parse(state.payments![index].date.toString()))}',
                        style: AppTheme.subText,
                      )
                    ],
                  ),
                  // Text('Periods ${state.payments![index].paymentScheduleModel!.map((schedule) => schedule.fromDate.toString())}')
                  Wrap(
                    spacing: 10,
                    children: state
                        .payments![index].tenantUnitModel!.paymentScheduleModel!
                        .map((schedule) => Text(
                            '(${DateFormat('d MMM, yy').format(schedule.fromDate! as DateTime)} - ${DateFormat('d MMM, yy').format(schedule.toDate! as DateTime)}),'))
                        .toList(),
                  )
                ],
              ),
              subtitle: Wrap(
                spacing: 10,
                children: [
                  Text(
                    'Amount Due: ${amountFormatter.format(state.payments![index].amountDue.toString())}/= ,',
                    style: AppTheme.subTextBold,
                  ),
                  Text(
                    'Paid: ${amountFormatter.format(state.payments![index].amount.toString())}/= ,',
                    style: AppTheme.subTextBold,
                  ),
                  Text(
                    'Balance: ${amountFormatter.format(balanceAmount.toString())}/= ',
                    style: AppTheme.subTextBold,
                  ),
                ],
              ),
              // trailing: Text('on ${DateFormat('dd.MM.yy').format(DateTime.parse(state.payments![index].date.toString()))}'),
            ),
          );
        },
        itemCount: state.payments!.length,
      ),
    );
  }

  Widget _buildEmptyBody(BuildContext parentContext, PaymentState state) {
    return Scaffold(
      backgroundColor: AppTheme.appBgColor,
      appBar: _buildAppTitle(),
      floatingActionButton: FloatingActionButton(
        heroTag: "add_floor",
        onPressed: () => showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
            context: parentContext,
            builder: (context) {
              return MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => PaymentSchedulesBloc()),
                    BlocProvider(create: (context) => TenantUnitBloc()),
                    BlocProvider(create: (context) => PaymentFormBloc()),
                  ],
                  child: AddPaymentForm(
                    parentContext: parentContext,
                    addButtonText: 'Add',
                    isUpdate: false,
                    property: property,
                  ));
              // return MultiBlocProvider(
              //   providers: [
              //     BlocProvider(
              //         create: (context) => PaymentSchedulesBloc()),
              //     BlocProvider(create: (context) => TenantUnitBloc()),
              //   ],
              //   child: AddPaymentForm(
              //     addButtonText: 'Add',
              //     isUpdate: false,
              //     property: property,
              //   ),
              // );
            }),
        backgroundColor: AppTheme.primary,
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
      body: NoDataWidget(
        message: "No payments",
        onPressed: () {
          parentContext.read<PaymentBloc>().add(LoadAllPayments(property.id!));
        },
      ),
    );
  }

  PreferredSize _buildAppTitle() {
    TextEditingController searchController = TextEditingController();
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: Container(
        padding: const EdgeInsets.only(
          top: 15,
          left: 10,
          right: 10,
          bottom: 15,
        ),
        decoration: const BoxDecoration(color: Colors.transparent),
        child: AppSearchTextField(
          controller: searchController,
          hintText: 'Search payments',
          obscureText: false,
          function: () {},
          fillColor: AppTheme.textBoxColor,
        ),
      ),
    );
  }
}
