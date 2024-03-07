import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/ui/pages/properties/bloc/property_bloc.dart';
import 'package:smart_rent/ui/pages/properties/widgets/property_item_widget.dart';
import 'package:smart_rent/ui/pages/root/bloc/nav_bar_bloc.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/app_search_textfield.dart';
import 'package:smart_rent/utilities/extra.dart';

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    propertiesScrollController.addListener(() {
      if (propertiesScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (context.read<NavBarBloc>().state.isVisible != false) {
          context.read<NavBarBloc>().add(ChangeNavBarVisibility(
              false, context.read<NavBarBloc>().state.idSelected));
        }
      } else {
        if (context.read<NavBarBloc>().state.isVisible != true) {
          context.read<NavBarBloc>().add(ChangeNavBarVisibility(
              true, context.read<NavBarBloc>().state.idSelected));
        }
      }
    });

    return BlocBuilder<PropertyBloc, PropertyState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppTheme.appBgColor,
          appBar: AppBar(
            title: _buildAppTitle(),
            backgroundColor: AppTheme.appBgColor,
          ),
          body: ListView.builder(
            controller: propertiesScrollController,
            padding: const EdgeInsets.only(top: 10),
            itemBuilder: (context, index) => PropertyItemWidget(
              property: state.properties![index],
              onTap: () => Navigator.pushNamed(
                context,
                "/property_details",
                arguments: state.properties![index],
              ),
            ),
            itemCount: state.properties!.length,
          ),
        );
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
          hintText: 'Search properties, tenants, units',
          obscureText: false,
          function: () {},
          fillColor: AppTheme.textBoxColor,
        ),
      ),
    );
  }
}
