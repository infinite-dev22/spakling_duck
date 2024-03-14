import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/data_layer/models/payment/payment_schedules_model.dart';
import 'package:smart_rent/data_layer/models/tenant_unit/tenant_unit_model.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/utilities/extra.dart';

class DataTableSearch extends SearchDelegate<String> {
  final TenantUnitModel tenantUnitModel;
  final List<PaymentSchedulesModel> data;

  DataTableSearch(this.data, this.tenantUnitModel);

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

    return DataTable(
      showBottomBorder: true,
      headingTextStyle: AppTheme.appTitle7,
      columnSpacing: 20,
      columns: [
        DataColumn(label: Text('Period')),
        DataColumn(label: Text('Amount')),
        DataColumn(label: Text('Paid')),
        DataColumn(label: Text('Balance')),

      ],
      rows:  searchData.map((schedule) {
        return DataRow(
            cells: [
              DataCell(Text('${DateFormat('d MMM, yy').format(schedule.fromDate!)}\n${DateFormat('d MMM, yy').format(schedule.toDate!)}')),
              DataCell(Text(amountFormatter.format(schedule.discountAmount.toString()))),
              DataCell(Text(amountFormatter.format(schedule.paid.toString()))),
              DataCell(Text(amountFormatter.format(schedule.balance.toString()))),
            ]);
      }).toList(),
    );

    // return ListView.builder(
    //   itemCount: searchData.length,
    //   itemBuilder: (context, index) => ListTile(
    //     title: Text(searchData[index]),
    //     onTap: () {
    //       // Handle tap on search result
    //     },
    //   ),
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<PaymentSchedulesModel> suggestionList = query.isEmpty
        ? data
        : data.where((element) => DateFormat('d MMM, yy').format(element.fromDate!).toLowerCase().contains(query) || DateFormat('d MMM, yy').format(element.toDate!).toLowerCase().contains(query)).toList();

    return DataTable(
      showBottomBorder: true,
      headingTextStyle: AppTheme.appTitle7,
      columnSpacing: 20,
      columns: [
        DataColumn(label: Text('Period')),
        DataColumn(label: Text('Amount')),
        DataColumn(label: Text('Paid')),
        DataColumn(label: Text('Balance')),

      ],
      rows:  suggestionList.map((schedule) {
        return DataRow(
            cells: [
              DataCell(Text('${DateFormat('d MMM, yy').format(schedule.fromDate!)}\n${DateFormat('d MMM, yy').format(schedule.toDate!)}')),
              DataCell(Text(amountFormatter.format(schedule.discountAmount.toString()))),
              DataCell(Text(amountFormatter.format(schedule.paid.toString()))),
              DataCell(Text(amountFormatter.format(schedule.balance.toString()))),
            ]);
      }).toList(),
    );

    // return ListView.builder(
    //   itemCount: suggestionList.length,
    //   itemBuilder: (context, index) => ListTile(
    //     title: Text(suggestionList[index]),
    //     onTap: () {
    //       query = suggestionList[index];
    //       showResults(context);
    //     },
    //   ),
    // );
  }
}




class MyDataTable extends StatelessWidget {
  final TenantUnitModel tenantUnitModel;
   MyDataTable({super.key, required this.tenantUnitModel});
  final List<String> data = [
    'Apple',
    'Banana',
    'Orange',
    'Pineapple',
    'Grapes',
    'Strawberry',
  ];

  @override
  Widget build(BuildContext context) {
    return  Card(
        elevation: 8,
        surfaceTintColor: AppTheme.whiteColor,
        clipBehavior: Clip.antiAlias,
        color: AppTheme.whiteColor,
        child: DataTable(
          showBottomBorder: true,
          headingTextStyle: AppTheme.appTitle7,
          columnSpacing: 20,
          columns: [
            DataColumn(label: Text('Period')),
            DataColumn(label: Text('Amount')),
            DataColumn(label: Text('Paid')),
            DataColumn(label: Text('Balance')),
        
          ],
          rows:  tenantUnitModel.paymentScheduleModel!.map((schedule) {
            return DataRow(
                cells: [
                  DataCell(Text('${DateFormat('d MMM, yy').format(schedule.fromDate!)}\n${DateFormat('d MMM, yy').format(schedule.toDate!)}')),
                  DataCell(Text(amountFormatter.format(schedule.discountAmount.toString()))),
                  DataCell(Text(amountFormatter.format(schedule.paid.toString()))),
                  DataCell(Text(amountFormatter.format(schedule.balance.toString()))),
                ]);
          }).toList(),
        ),
      );

      // body: DataTable(
      //   columns: [
      //     DataColumn(label: Text('Fruits')),
      //   ],
      //   rows: data
      //       .map(
      //         (fruit) => DataRow(
      //       cells: [
      //         DataCell(Text(fruit)),
      //       ],
      //     ),
      //   )
      //       .toList(),
      // ),


  }
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