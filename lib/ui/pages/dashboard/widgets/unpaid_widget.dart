import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:smart_rent/data_layer/models/payment/payments_model.dart';
import 'package:smart_rent/ui/pages/payments/bloc/payment_bloc.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UnpaidWidget extends StatelessWidget {
  const UnpaidWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<PaymentsModel> payments = <PaymentsModel>[];
    late PaymentDataSource paymentDataSource;

    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        payments = getPaymentData(context);
        paymentDataSource = PaymentDataSource(paymentData: payments);
        // if (state.status.isInitial) {
        //   context.read<PaymentBloc>().add(LoadPayments());
        // }
        // if (state.status.isSuccess) {
        //   payments = getPaymentData(context);
        //   paymentDataSource = PaymentDataSource(paymentData: payments);
        //   return _buildBody(context, state, paymentDataSource);
        // }
        // if (state.status.isLoading) {
        //   return const LoadingWidget();
        // }
        // if (state.status.isError) {
        //   return SmartErrorWidget(
        //     message: 'Error loading payments table',
        //     onPressed: () {
        //       context.read<PaymentBloc>().add(LoadPayments());
        //     },
        //   );
        // }
        // if (state.status.isEmpty) {
        //   return NoDataWidget(
        //     message: "No payments available",
        //     onPressed: () {
        //       context.read<PaymentBloc>().add(LoadPayments());
        //     },
        //   );
        // }
        // return const SmartWidget();
        return _buildBody(context, state, paymentDataSource);
      },
    );
  }

  Widget _buildBody(BuildContext context, PaymentState state,
      PaymentDataSource paymentDataSource) {
    return Column(
      children: [
        _buildHeader(context),
        const Divider(
          color: AppTheme.inActiveColor,
        ),
        Expanded(child: _buildDataTable(paymentDataSource)),
        const SizedBox(height: 90),
      ],
    );
  }

  Widget _buildDataTable(PaymentDataSource paymentDataSource) {
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        headerColor: AppTheme.gray.withOpacity(.2),
        headerHoverColor: AppTheme.gray.withOpacity(.3),
      ),
      child: SfDataGrid(
        onQueryRowHeight: (details) {
          if (details.rowIndex == 0) {
            return 30;
          }
          return details.getIntrinsicRowHeight(details.rowIndex);
        },
        // allowSorting: true,
        // allowFiltering: true,
        allowSwiping: false,
        // allowTriStateSorting: true,
        source: paymentDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        columns: _getColumns(),
      ),
    );
  }

  List<GridColumn> _getColumns() {
    return <GridColumn>[
      GridColumn(
          columnName: 'tenant',
          label: Container(
              alignment: Alignment.center,
              child: const Text(
                'Tenant',
              ))),
      GridColumn(
          columnName: 'period',
          label: Container(
              alignment: Alignment.center, child: const Text('Period'))),
      GridColumn(
          columnName: 'amount',
          label: Container(
              alignment: Alignment.center,
              child: const Text(
                'Amount',
                overflow: TextOverflow.ellipsis,
              ))),
    ];
  }

  List<PaymentsModel> getPaymentData(BuildContext context) {
    // return context.read<PaymentBloc>().state.payments!;
    return [
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
      PaymentsModel(
          date: Jiffy.parse('12/09/2024', pattern: 'dd/MM/yyyy')
              .toLocal()
              .dateTime,
          property: Property(name: 'Louisie Meramane'),
          amount: 100000000),
    ];
  }

  // Widget _buildDataTable() {
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 30,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.primary),
              ),
              child: const Text("Filter"),
            ),
          ),
          // DropdownButtonHideUnderline(
          //   child: DropdownButton2<String>(
          //     isExpanded: true,
          //     hint: Text(
          //       'Select period',
          //       style: TextStyle(
          //         fontSize: 14,
          //         color: Theme.of(context).hintColor,
          //       ),
          //     ),
          //     items: items
          //         .map((String item) => DropdownMenuItem<String>(
          //               value: item,
          //               child: Text(
          //                 item,
          //                 style: const TextStyle(
          //                   fontSize: 14,
          //                 ),
          //               ),
          //             ))
          //         .toList(),
          //     value: selectedValue,
          //     onChanged: (String? value) {
          //       // TODO: Add state management here later.
          //     },
          //     buttonStyleData: const ButtonStyleData(
          //       padding: EdgeInsets.symmetric(horizontal: 16),
          //       height: 40,
          //       width: 140,
          //     ),
          //     menuItemStyleData: const MenuItemStyleData(
          //       height: 40,
          //     ),
          //   ),
          // ),
          const Text("Total: USD 5,910"),
        ],
      ),
    );
  }
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class PaymentDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  PaymentDataSource({required List<PaymentsModel> paymentData}) {
    _paymentData = paymentData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'tenant', value: e.property!.name),
              DataGridCell<DateTime>(columnName: 'period', value: e.date),
              DataGridCell<int>(columnName: 'amount', value: e.amount)
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
