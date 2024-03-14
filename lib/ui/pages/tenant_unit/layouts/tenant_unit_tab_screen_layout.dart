import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/ui/pages/currency/bloc/currency_bloc.dart';
import 'package:smart_rent/ui/pages/period/bloc/period_bloc.dart';
import 'package:smart_rent/ui/pages/properties/widgets/loading_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/no_data_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/not_found_widget.dart';
import 'package:smart_rent/ui/pages/tenant_unit/bloc/tenant_unit_bloc.dart';
import 'package:smart_rent/ui/pages/tenant_unit/forms/tenant_unit_form.dart';
import 'package:smart_rent/ui/pages/tenant_unit/layouts/tenant_unit_details_page_layout.dart';
import 'package:smart_rent/ui/pages/tenant_unit/layouts/test.dart';
import 'package:smart_rent/ui/pages/tenants/bloc/tenant_bloc.dart';
import 'package:smart_rent/ui/pages/units/bloc/unit_bloc.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/app_search_textfield.dart';
import 'package:smart_rent/ui/widgets/smart_error_widget.dart';
import 'package:smart_rent/ui/widgets/smart_widget.dart';
import 'package:smart_rent/utilities/extra.dart';

class TenantUnitTabScreenLayout extends StatelessWidget {
  final Property property;

  const TenantUnitTabScreenLayout({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => TenantUnitBloc(),
      child: BlocConsumer<TenantUnitBloc, TenantUnitState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state.status == TenantUnitStatus.initial) {
            context
                .read<TenantUnitBloc>()
                .add(LoadTenantUnitsEvent(property.id!));
          }
          if (state.status == TenantUnitStatus.loading) {
            return const LoadingWidget();
          }
          if (state.status == TenantUnitStatus.accessDenied) {
            return const NotFoundWidget();
          }
          if (state.status == TenantUnitStatus.empty) {
            return Scaffold(
              backgroundColor: AppTheme.appBgColor,
              appBar: _buildAppTitle(),
              floatingActionButton: FloatingActionButton(
                heroTag: "add_tenant_unit",
                onPressed: () => showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return MultiBlocListener(
                        listeners: [
                          BlocProvider(create: (context) => TenantBloc()),
                          BlocProvider(create: (context) => UnitBloc()),
                          BlocProvider(create: (context) => PeriodBloc()),
                          BlocProvider(create: (context) => CurrencyBloc()),
                        ],
                        child: TenantUnitForm(
                          addButtonText: 'Add Tenant',
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
              body: NoDataWidget(
                message: "No tenant units",
                onPressed: () {
                  context
                      .read<TenantUnitBloc>()
                      .add(LoadTenantUnitsEvent(property.id!));
                },
              ),
            );
          }
          if (state.status == TenantUnitStatus.error) {
            return SmartErrorWidget(
              message: 'Error loading tenant units',
              onPressed: () {
                context
                    .read<TenantUnitBloc>()
                    .add(LoadTenantUnitsEvent(property.id!));
              },);
          }
          if (state.status == TenantUnitStatus.success) {
            Timer.run(() async {
              context.read<TenantUnitBloc>().add(RefreshTenantUnitsEvent(property.id!));
            });
            return Scaffold(
              backgroundColor: AppTheme.appBgColor,
              appBar: _buildAppTitle(),
              floatingActionButton: FloatingActionButton(
                heroTag: "add_tenant_unit",
                onPressed: () => showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return MultiBlocListener(
                        listeners: [
                          BlocProvider(create: (context) => TenantBloc()),
                          BlocProvider(create: (context) => UnitBloc()),
                          BlocProvider(create: (context) => PeriodBloc()),
                          BlocProvider(create: (context) => CurrencyBloc()),
                        ],
                        child: TenantUnitForm(
                          addButtonText: 'Add Tenant',
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
                controller: tenantUnitsScrollController,
                padding: const EdgeInsets.only(top: 10),
                itemBuilder: (context, index) {
                  var tenantUnit = state.tenantUnits![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> TenantUnitDetailsPageLayout(tenantUnitModel: tenantUnit,)));
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> MyDataTable(tenantUnitModel: tenantUnit,)));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
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
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ListTile(

                        leading: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage('https://img.freepik.com/free-photo/real-estate-broker-agent-presenting-consult-customer-decision-making-sign-insurance-form-agreement_1150-15023.jpg?w=996&t=st=1708346770~exp=1708347370~hmac=d7c8476699ac83e0dbb2375a511e548c2d78c4e1b2d69da7cc5ce31d4c915c90'),
                            ),
                          ],
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tenantUnit.tenant!.clientTypeId == 1
                                  ? '${tenantUnit.tenant!.clientProfiles!.first.firstName} ${tenantUnit.tenant!.clientProfiles!.first.lastName}'
                                  : '${tenantUnit.tenant!.clientProfiles!.first.companyName}',
                              style: AppTheme.blueAppTitle3,
                            ),
                            Text(
                              tenantUnit.unit!.name.toString(),
                              style: AppTheme.blueAppTitle3,
                            )
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'start: ${DateFormat('dd-MM-yy').format(tenantUnit.fromDate!)} to: ${DateFormat('dd-MM-yy').format(tenantUnit.toDate!)}',
                              style: AppTheme.subText,
                            ),
                            Text(
                              '@${tenantUnit.currencyModel!.code} ${amountFormatter.format(tenantUnit.amount.toString())} ${tenantUnit.period!.name}',
                              style: AppTheme.subText,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: state.tenantUnits!.length,
              ),
            );
          }
          return const SmartWidget();
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
          hintText: 'Search tenant units',
          obscureText: false,
          function: () {},
          fillColor: AppTheme.textBoxColor,
        ),
      ),
    );
  }
}
