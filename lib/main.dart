import 'package:smart_rent/ui/pages/auth_pages/login_page/bloc/auth/auth_bloc.dart';
import 'package:smart_rent/ui/pages/auth_pages/login_page/bloc/login_bloc.dart';
import 'package:smart_rent/ui/pages/auth_pages/login_page/login_page.dart';
import 'package:smart_rent/ui/pages/currency/bloc/currency_bloc.dart';
import 'package:smart_rent/ui/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:smart_rent/ui/pages/floors/bloc/floor_bloc.dart';
import 'package:smart_rent/ui/pages/payment_account/bloc/payment_account_bloc.dart';
import 'package:smart_rent/ui/pages/payment_mode/bloc/payment_mode_bloc.dart';
import 'package:smart_rent/ui/pages/payment_schedules/bloc/payment_schedules_bloc.dart';
import 'package:smart_rent/ui/pages/payments/bloc/payment_bloc.dart';
import 'package:smart_rent/ui/pages/period/bloc/period_bloc.dart';
import 'package:smart_rent/ui/pages/properties/bloc/property_bloc.dart';
import 'package:smart_rent/ui/pages/property_categories/bloc/property_category_bloc.dart';
import 'package:smart_rent/ui/pages/property_details/property_details_page.dart';
import 'package:smart_rent/ui/pages/property_types/bloc/property_type_bloc.dart';
import 'package:smart_rent/ui/pages/root/bloc/nav_bar_bloc.dart';
import 'package:smart_rent/ui/pages/root/root_page.dart';
import 'package:smart_rent/ui/pages/tenant_unit/bloc/tenant_unit_bloc.dart';
import 'package:smart_rent/ui/pages/units/bloc/unit_bloc.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/profile_pic_widget/bloc/profile_pic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavBarBloc()),
        BlocProvider(create: (context) => DashboardBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ProfilePicBloc()),
        BlocProvider(create: (context) => PropertyBloc()),
        BlocProvider(create: (context) => PropertyTypeBloc()),
        BlocProvider(create: (context) => PropertyCategoryBloc()),
        BlocProvider(create: (context) => FloorBloc()),
        BlocProvider(create: (context) => CurrencyBloc()),
        BlocProvider(create: (context) => PeriodBloc()),
        BlocProvider(create: (context) => PaymentBloc()),
        BlocProvider(create: (context) => PaymentAccountBloc()),
        BlocProvider(create: (context) => PaymentModeBloc()),
        BlocProvider(create: (context) => PeriodBloc()),
        BlocProvider(create: (context) => PaymentSchedulesBloc()),
        BlocProvider(create: (context) => TenantUnitBloc()),
        BlocProvider(create: (context) => UnitBloc()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartRent Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.primary),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.light,
      routes: {
        '/': (context) => const LoginPage(),
        '/root': (context) => const RootPage(),
        '/property_details': (context) => const PropertyDetailsPage(),
      },
    );
  }
}
