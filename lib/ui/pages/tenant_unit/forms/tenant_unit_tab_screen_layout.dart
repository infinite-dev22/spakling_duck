import 'package:intl/intl.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/ui/pages/floors/bloc/floor_bloc.dart';
import 'package:smart_rent/ui/pages/properties/widgets/loading_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/no_data_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/not_found_widget.dart';
import 'package:smart_rent/ui/pages/property_details/forms/floor/add_property_floor_form.dart';
import 'package:smart_rent/ui/pages/tenant_unit/bloc/tenant_unit_bloc.dart';
import 'package:smart_rent/ui/pages/units/bloc/unit_bloc.dart';
import 'package:smart_rent/ui/pages/units/forms/add_unit_form.dart';
import 'package:smart_rent/ui/pages/units/widgets/unit_card_widget.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/app_search_textfield.dart';
import 'package:smart_rent/ui/widgets/smart_error_widget.dart';
import 'package:smart_rent/ui/widgets/smart_widget.dart';
import 'package:smart_rent/utilities/extra.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TenantUnitTabScreenLayout extends StatelessWidget {
  final Property property;

  const TenantUnitTabScreenLayout({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return BlocConsumer<TenantUnitBloc, TenantUnitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.status == TenantUnitStatus.initial) {
          context.read<TenantUnitBloc>().add(LoadTenantUnitsEvent(property.id!));
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
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              onPressed: () {},
              backgroundColor: AppTheme.primary,
            ),
            body: const NoDataWidget(),
          );
        }
        if (state.status == TenantUnitStatus.error) {
          return const SmartErrorWidget();
        }
        if (state.status == TenantUnitStatus.success) {
          return Scaffold(
            backgroundColor: AppTheme.appBgColor,
            appBar: _buildAppTitle(),
            floatingActionButton: FloatingActionButton(
              heroTag: "add_tenant_unit",
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              onPressed: () {},
              backgroundColor: AppTheme.primary,
            ),
            body: ListView.builder(
              controller: tenantUnitsScrollController,
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) {
                var tenantUnit = state.tenantUnits![index];
                return  GestureDetector(
                  onTap: (){
                    // Get.to(() => TenantDetailsScreen(
                    //   tenantController: tenantController,
                    //   tenantId: entry.tenantId!,
                    //   tenantModel: entry.tenantModel!,
                    // ));
                  },
                  child: Container(
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
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://img.freepik.com/free-photo/real-estate-broker-agent-presenting-consult-customer-decision-making-sign-insurance-form-agreement_1150-15023.jpg?w=996&t=st=1708346770~exp=1708347370~hmac=d7c8476699ac83e0dbb2375a511e548c2d78c4e1b2d69da7cc5ce31d4c915c90',
                            fit: BoxFit.cover,
                          )
                      ),
                      title: Text(tenantUnit.unit!.name.toString(),
                        style: AppTheme.appTitle3,
                      ),
                      subtitle: Text(
                        'from: ${DateFormat('MMM d yyyy').format(tenantUnit.fromDate!)} to: ${DateFormat('MMM d yyyy').format(tenantUnit.toDate!)} @${amountFormatter.format(tenantUnit.discountAmount.toString())}',
                        style: AppTheme.subText,
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
