import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:smart_rent/data_layer/models/tenant_unit/tenant_unit_model.dart';
import 'package:smart_rent/ui/pages/tenant_unit/layouts/test.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/appbar_content.dart';
import 'package:smart_rent/utilities/extra.dart';

class TenantUnitDetailsPageLayout extends StatefulWidget {
  final TenantUnitModel tenantUnitModel;
  const TenantUnitDetailsPageLayout({super.key, required this.tenantUnitModel});

  @override
  State<TenantUnitDetailsPageLayout> createState() => _TenantUnitDetailsPageLayoutState();
}

class _TenantUnitDetailsPageLayoutState extends State<TenantUnitDetailsPageLayout> {


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
                        Text(widget.tenantUnitModel.tenant!.getName(), style: AppTheme.blueAppTitle3,),
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
                             Text(widget.tenantUnitModel.unit!.name.toString(), style: AppTheme.blueAppTitle3,)
                           ],
                         ),
                       ),
                        Container(
                          child: Row(
                            children: [
                              Text('Currency:', style: AppTheme.appTitle7,),
                              SizedBox(width: 5,),
                              Text(widget.tenantUnitModel.currencyModel!.code.toString(), style: AppTheme.blueAppTitle3,)
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
                              Text(widget.tenantUnitModel.period!.name.toString(), style: AppTheme.blueAppTitle3,)
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text('Number:', style: AppTheme.appTitle7,),
                              SizedBox(width: 5,),
                              Text(widget.tenantUnitModel.paymentScheduleModel!.length.toString(), style: AppTheme.blueAppTitle3,)
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
                              Text(DateFormat('d MMM, yy').format(widget.tenantUnitModel.fromDate!), style: AppTheme.blueAppTitle3,)
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text('End:', style: AppTheme.appTitle7,),
                              SizedBox(width: 5,),
                              Text(DateFormat('d MMM, yy').format(widget.tenantUnitModel.toDate!), style: AppTheme.blueAppTitle3,)
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Breakdown', style: AppTheme.subText,),
                  GestureDetector(
                    onTap: (){
                      showSearch(
                        context: context,
                        delegate: DataTableSearch(widget.tenantUnitModel.paymentScheduleModel!, widget.tenantUnitModel),
                      );
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          Text('search schedule', style: AppTheme.blueSubText,),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),

            widget.tenantUnitModel.paymentScheduleModel!.isEmpty
                ? Center(child: Text('No Payment Schedules', style: AppTheme.blueAppTitle3,),)

                : Expanded(child: MyDataTable(tenantUnitModel: widget.tenantUnitModel)),

            // widget.tenantUnitModel.paymentScheduleModel!.isEmpty
            //     ? Center(child: Text('No Payment Schedules', style: AppTheme.blueAppTitle3,),)
            //
            //     : Expanded(
            //       child: SingleChildScrollView(
            //         child: DataTable(
            //                         showBottomBorder: true,
            //                         headingTextStyle: AppTheme.appTitle7,
            //                         columnSpacing: 20,
            //                         columns: [
            //         DataColumn(label: Text('Period')),
            //         DataColumn(label: Text('Amount')),
            //         DataColumn(label: Text('Paid')),
            //         DataColumn(label: Text('Balance')),
            //
            //                         ],
            //         rows:  widget.tenantUnitModel.paymentScheduleModel!.map((schedule) {
            //           return DataRow(
            //               cells: [
            //             DataCell(Text('${DateFormat('d MMM, yy').format(schedule.fromDate!)}\n${DateFormat('d MMM, yy').format(schedule.toDate!)}')),
            //             DataCell(Text(amountFormatter.format(schedule.discountAmount.toString()))),
            //             DataCell(Text(amountFormatter.format(schedule.paid.toString()))),
            //             DataCell(Text(amountFormatter.format(schedule.balance.toString()))),
            //           ]);
            //         }).toList(),
            //                       ),
            //       ),
            //     ),


          ],
        ),
      ),

    );
  }
}
