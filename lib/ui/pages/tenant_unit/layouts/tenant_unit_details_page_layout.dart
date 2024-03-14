import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/data_layer/models/payment/payment_schedules_model.dart';

import 'package:smart_rent/data_layer/models/tenant_unit/tenant_unit_model.dart';
import 'package:smart_rent/ui/pages/tenant_unit/layouts/search_tenant_unit_payment_schedule_screen_layout.dart';
import 'package:smart_rent/ui/pages/tenant_unit/layouts/test.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/appbar_content.dart';
import 'package:smart_rent/utilities/extra.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';


class TenantUnitDetailsPageLayout extends StatefulWidget {
  final TenantUnitModel tenantUnitModel;
  const TenantUnitDetailsPageLayout({super.key, required this.tenantUnitModel});

  @override
  State<TenantUnitDetailsPageLayout> createState() => _TenantUnitDetailsPageLayoutState();
}

class _TenantUnitDetailsPageLayoutState extends State<TenantUnitDetailsPageLayout> {

  late TenantUnitPaymentScheduleDataSource tenantUnitPaymentScheduleDataSource;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tenantUnitPaymentScheduleDataSource = TenantUnitPaymentScheduleDataSource(paymentData: widget.tenantUnitModel.paymentScheduleModel!);
  }


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
                        delegate: TenantUnitPaymentScheduleTableSearch(widget.tenantUnitModel.paymentScheduleModel!, widget.tenantUnitModel),
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

                : Expanded(child: _buildDataTable(tenantUnitPaymentScheduleDataSource)),
                // : Expanded(child: MyDataTable(tenantUnitModel: widget.tenantUnitModel)),

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


Widget _buildDataTable(TenantUnitPaymentScheduleDataSource tenantUnitPaymentScheduleDataSource) {
  return SfDataGridTheme(
    data: SfDataGridThemeData(
      headerColor: AppTheme.gray.withOpacity(.2),
      headerHoverColor: AppTheme.gray.withOpacity(.3),
    ),
    child: SfDataGrid(
      // allowSorting: true,
      // allowFiltering: true,
      allowSwiping: false,
      allowTriStateSorting: true,
      source: tenantUnitPaymentScheduleDataSource,
      columnWidthMode: ColumnWidthMode.fill,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      columns: _getColumns(),
    ),
  );
}



class TenantUnitPaymentScheduleDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  TenantUnitPaymentScheduleDataSource({required List<PaymentSchedulesModel> paymentData}) {
    _paymentData = paymentData
        .map<DataGridRow>((schedule) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'period', value: '${DateFormat('d MMM, yy').format(schedule.fromDate!)}\n${DateFormat('d MMM, yy').format(schedule.toDate!)}'),
      DataGridCell<String>(columnName: 'amount', value: amountFormatter.format(schedule.discountAmount.toString())),
      DataGridCell<String>(columnName: 'paid', value: amountFormatter.format(schedule.paid.toString())),
      DataGridCell<String>(columnName: 'balance', value: amountFormatter.format(schedule.balance.toString()))
    ]))
        .toList();
  }

  List<DataGridRow> _paymentData = [];

  @override
  List<DataGridRow> get rows => _paymentData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}


List<GridColumn> _getColumns() {
  return <GridColumn>[
    GridColumn(
        columnName: 'period',
        label: Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: const Text(
              'Period',
            ))),
    GridColumn(
        columnName: 'amount',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Amount'))),
    GridColumn(
        columnName: 'paid',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'Paid',
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'balance',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'Balance',
              overflow: TextOverflow.ellipsis,
            ))),
  ];
}