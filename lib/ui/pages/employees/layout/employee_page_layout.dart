import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/appbar_content.dart';
import 'package:smart_rent/ui/widgets/user_card_widget.dart';

class EmployeePageLayout extends StatelessWidget {
  const EmployeePageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return _employeePageLayout();
  }

  Widget _employeePageLayout() {
    return Scaffold(
      appBar: AppBar(
        title: TitleBarImageHolder(),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) {
            return Slidable(
                // Specify a key if the Slidable is dismissible.
                key: const ValueKey(0),

                // The start action pane is the one at the left or the top side.
                startActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),

                  // A pane can dismiss the Slidable.
                  dismissible: DismissiblePane(onDismissed: () {}),

                  // All actions are defined in the children parameter.
                  children: [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                      onPressed: makeCall1(),
                      icon: Icons.delete,
                      label: 'Delete',
                      foregroundColor: Colors.red,
                    ),
                    SlidableAction(
                      onPressed: makeCall2(),
                      icon: Icons.share,
                      label: 'Share',
                      foregroundColor: Colors.green,
                    ),
                  ],
                ),

                // The end action pane is the one at the right or the bottom side.
                child: UserCardWidget());
          }),
    );
  }

  makeCall1() {}

  makeCall2() {}

  makeCall3() {}

  makeCall4() {}
}
