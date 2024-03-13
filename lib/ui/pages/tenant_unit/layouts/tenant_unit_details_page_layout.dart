import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/data_layer/models/tenant_unit/tenant_unit_model.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/appbar_content.dart';

class TenantUnitDetailsPageLayout extends StatelessWidget {
  final TenantUnitModel tenantUnitModel;
  const TenantUnitDetailsPageLayout({super.key, required this.tenantUnitModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appBgColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: const TitleBarImageHolder(),
        foregroundColor: AppTheme.whiteColor,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),

            Card(
              elevation: 8,
              surfaceTintColor: AppTheme.whiteColor,
              clipBehavior: Clip.antiAlias,
              color: AppTheme.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Tenant:', style: AppTheme.appTitle7,),
                        SizedBox(width: 5,),
                        Text(tenantUnitModel.tenant!.getName(), style: AppTheme.blueAppTitle3,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Container(
                         child: Row(
                           children: [
                             Text('Unit:', style: AppTheme.appTitle7,),
                             SizedBox(width: 5,),
                             Text(tenantUnitModel.unit!.name.toString(), style: AppTheme.blueAppTitle3,)
                           ],
                         ),
                       ),
                        Container(
                          child: Row(
                            children: [
                              Text('Currency:', style: AppTheme.appTitle7,),
                              SizedBox(width: 5,),
                              Text(tenantUnitModel.currencyModel!.code.toString(), style: AppTheme.blueAppTitle3,)
                            ],
                          ),
                        ),
                      ],
                    ),

                    Divider(),

                    Text('Tenancy Details', style: AppTheme.subText,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Text('Period:', style: AppTheme.appTitle7,),
                              SizedBox(width: 5,),
                              Text(tenantUnitModel.period!.name.toString(), style: AppTheme.blueAppTitle3,)
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text('Number:', style: AppTheme.appTitle7,),
                              SizedBox(width: 5,),
                              Text(tenantUnitModel.paymentScheduleModel!.length.toString(), style: AppTheme.blueAppTitle3,)
                            ],
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Text('Start:', style: AppTheme.appTitle7,),
                              SizedBox(width: 5,),
                              Text(DateFormat('d MMM, yy').format(tenantUnitModel.fromDate!), style: AppTheme.blueAppTitle3,)
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text('End:', style: AppTheme.appTitle7,),
                              SizedBox(width: 5,),
                              Text(DateFormat('d MMM, yy').format(tenantUnitModel.toDate!), style: AppTheme.blueAppTitle3,)
                            ],
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text('Breakdown', style: AppTheme.subText,),
            SizedBox(height: 10,),



          ],
        ),
      ),

    );
  }
}
