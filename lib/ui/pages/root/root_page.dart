import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/ui/pages/dashboard/dashboard_page.dart';
import 'package:smart_rent/ui/pages/employees/employees_page.dart';
import 'package:smart_rent/ui/pages/root/bloc/nav_bar_bloc.dart';
import 'package:smart_rent/ui/pages/root/widgets/bottom_nav_bar.dart';
import 'package:smart_rent/ui/pages/root/widgets/screen.dart';
import 'package:smart_rent/ui/pages/settings/settings_page.dart';
import 'package:smart_rent/ui/pages/tenants/tenants_page.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      floatingActionButton: BottomNavBar(
        screens: _screens(),
        onFabTap: _buildAddWidget,
      ),
      body: BlocBuilder<NavBarBloc, NavBarState>(
        builder: (context, state) {
          return _buildRootViewStack();
        },
      ),
    );
  }

  List<Screen> _screens() {
    return [
      const Screen(
        index: 0,
        name: "Home",
        icon: Icons.home,
        widget: DashboardPage(),
      ),
      const Screen(
        index: 1,
        name: "Employees",
        icon: Icons.people,
        widget: EmployeesPage(),
      ),
      const Screen(),
      const Screen(
        index: 3,
        name: "Tenants",
        icon: Icons.people_outline_rounded,
        widget: TenantsPage(),
      ),
      const Screen(
        index: 4,
        name: "Settings",
        icon: Icons.settings,
        widget: SettingsPage(),
      ),
    ];
  }

  Widget _buildRootViewStack() {
    return IndexedStack(
      index: context.read<NavBarBloc>().state.idSelected,
      children: List.generate(
        _screens().length,
        (index) => _screens()[index].widget ?? Container(),
      ),
    );
  }

  _buildAddWidget() {
    return showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      showDragHandle: true,
      builder: (context) => SizedBox(
        width: double.infinity,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  IconButton.outlined(
                    style: const ButtonStyle(
                      iconColor: MaterialStatePropertyAll(
                        AppTheme.inActiveColor,
                      ),
                      side: MaterialStatePropertyAll(
                        BorderSide(
                          color: AppTheme.inActiveColor,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.person),
                    iconSize: 45,
                  ),
                  const Text(
                    "Add Tenant",
                    style: TextStyle(
                      color: AppTheme.inActiveColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton.outlined(
                    style: const ButtonStyle(
                      iconColor: MaterialStatePropertyAll(
                        AppTheme.inActiveColor,
                      ),
                      side: MaterialStatePropertyAll(
                        BorderSide(
                          color: AppTheme.inActiveColor,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.house),
                    iconSize: 45,
                  ),
                  const Text(
                    "Add Property",
                    style: TextStyle(
                      color: AppTheme.inActiveColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton.outlined(
                    style: const ButtonStyle(
                      iconColor: MaterialStatePropertyAll(
                        AppTheme.inActiveColor,
                      ),
                      side: MaterialStatePropertyAll(
                        BorderSide(
                          color: AppTheme.inActiveColor,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.bed),
                    iconSize: 45,
                  ),
                  const Text(
                    "Add Floor",
                    style: TextStyle(
                      color: AppTheme.inActiveColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
