import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/data_layer/models/payment/payment_schedules_model.dart';
import 'package:smart_rent/data_layer/models/tenant_unit/tenant_unit_model.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/utilities/extra.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';







class TenantUnitPaymentScheduleTableSearch extends SearchDelegate<String> {
  final TenantUnitModel tenantUnitModel;
  final List<PaymentSchedulesModel> data;

  TenantUnitPaymentScheduleTableSearch(this.data, this.tenantUnitModel);

  late TenantUnitPaymentScheduleDataSource tenantUnitPaymentScheduleDataSource;


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<PaymentSchedulesModel> searchData = query.isEmpty
        ? data
        : data.where((element) => DateFormat('d MMM, yy').format(element.fromDate!).toString().toLowerCase().contains(query) || DateFormat('d MMM, yy').format(element.fromDate!).toLowerCase().contains(query)).toList();
    tenantUnitPaymentScheduleDataSource = TenantUnitPaymentScheduleDataSource(paymentData: searchData);

    return _buildDataTable(tenantUnitPaymentScheduleDataSource);

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<PaymentSchedulesModel> suggestionList = query.isEmpty
        ? data
        : data.where((element) => DateFormat('d MMM, yy').format(element.fromDate!).toLowerCase().contains(query) || DateFormat('d MMM, yy').format(element.toDate!).toLowerCase().contains(query)).toList();
    tenantUnitPaymentScheduleDataSource = TenantUnitPaymentScheduleDataSource(paymentData: suggestionList);


    return _buildDataTable(tenantUnitPaymentScheduleDataSource);


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


// appBar: AppBar(
//   automaticallyImplyLeading: false,
//   title: Text('Search Payment Schedules'),
//   actions: [
//     IconButton(
//       icon: Icon(Icons.search),
//       onPressed: () {
//         showSearch(
//           context: context,
//           delegate: DataTableSearch(tenantUnitModel.paymentScheduleModel!, tenantUnitModel),
//         );
//       },
//     ),
//   ],
// ),