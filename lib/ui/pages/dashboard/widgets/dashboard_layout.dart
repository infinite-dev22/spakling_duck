import 'package:smart_rent/ui/pages/dashboard/widgets/occupancy_widget.dart';
import 'package:smart_rent/ui/pages/dashboard/widgets/payments_widget.dart';
import 'package:smart_rent/ui/pages/dashboard/widgets/unpaid_widget.dart';
import 'package:smart_rent/ui/pages/properties/properties_page.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/appbar_content.dart';
import 'package:flutter/material.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primary,
          title: const TitleBarImageHolder(),
          bottom: _buildAppTitle(),
          centerTitle: true,
          foregroundColor: AppTheme.whiteColor,
        ),
        body: const TabBarView(
          children: [
            PropertiesPage(),
            PaymentsWidget(),
            UnpaidWidget(),
            OccupancyWidget(),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildAppTitle() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Column(
        children: [
          const Text(
            "Your properties in your hands",
            style: TextStyle(color: AppTheme.whiteColor),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: const BoxDecoration(color: AppTheme.primaryDarker),
            child: const TabBar(
              indicatorColor: Color(0xFF2D80E3),
              // enableFeedback: true,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 5,
                    color: Color(0xFF2D80E3),
                  ),
                ),
              ),
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(
                  child: Text(
                    "Properties",
                    style: TextStyle(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Payments",
                    style: TextStyle(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Unpaid",
                    style: TextStyle(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Occupancy",
                    style: TextStyle(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
