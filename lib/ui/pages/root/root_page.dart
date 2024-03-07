import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_picker/full_picker.dart';
import 'package:smart_rent/data_layer/models/smart_model.dart';
import 'package:smart_rent/ui/pages/dashboard/dashboard_page.dart';
import 'package:smart_rent/ui/pages/employees/employees_page.dart';
import 'package:smart_rent/ui/pages/explorer/explorer_page.dart';
import 'package:smart_rent/ui/pages/profile/profile_page.dart';
import 'package:smart_rent/ui/pages/properties/forms/add_property_form.dart';
import 'package:smart_rent/ui/pages/properties/widgets/success_widget.dart';
import 'package:smart_rent/ui/pages/property_categories/bloc/property_category_bloc.dart';
import 'package:smart_rent/ui/pages/property_types/bloc/property_type_bloc.dart';
import 'package:smart_rent/ui/pages/root/bloc/nav_bar_bloc.dart';
import 'package:smart_rent/ui/pages/root/widgets/bottom_nav_bar.dart';
import 'package:smart_rent/ui/pages/root/widgets/screen.dart';
import 'package:smart_rent/ui/pages/settings/settings_page.dart';
import 'package:smart_rent/ui/pages/tenants/tenants_page.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/app_drop_downs.dart';
import 'package:smart_rent/ui/widgets/app_max_textfield.dart';
import 'package:smart_rent/ui/widgets/auth_textfield.dart';
import 'package:smart_rent/ui/widgets/form_title_widget.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  File? propertyPic;
  String? propertyImagePath;
  String? propertyImageExtension;
  String? propertyFileName;
  Uint8List? propertyBytes;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController sqmController = TextEditingController();

  List<String> searchableList = ['Orange', 'Watermelon', 'Banana'];

  int selectedPropertyTypeId = 0;
  int selectedPropertyCategoryId = 0;

  final ScrollController scrollController = ScrollController();

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
                    onPressed: () {
                      Navigator.pop(context);
                   addPropertyForm('add', () { }, true, true);
                      // addPropertyForm(context,  'add', () { }, true, true);
                    },
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
                    onPressed: () {

                    },
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

   addPropertyForm(String addButtonText,
      VoidCallback submitFormData, bool isTitleElevated, bool isUpdate){

    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context, builder: (context){

      return  Padding(
              padding: const EdgeInsets.only(bottom: 20)
                  .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  FormTitle(
                    name: '${isUpdate ? "Edit" : "New"}  Property',
                    addButtonText: isUpdate ? "Update" : "Add",
                    onSave: submitFormData,
                    isElevated: isTitleElevated,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollController.position.userScrollDirection ==
                              ScrollDirection.reverse) {
                            setState(() {
                              isTitleElevated = true;
                            });
                          } else if (scrollController.position.userScrollDirection ==
                              ScrollDirection.forward) {
                            if (scrollController.position.pixels ==
                                scrollController.position.maxScrollExtent) {
                              setState(() {
                                isTitleElevated = false;
                              });
                            }
                          }
                          return true;
                        },
                        child: ListView(
                          controller: scrollController,
                          padding: const EdgeInsets.all(8),
                          children: [
                            LayoutBuilder(builder: (context, constraints) {
                              return Form(
                                child: Column(
                                  children: [

                                    AuthTextField(
                                      controller: titleController,
                                      hintText: 'Property title',
                                      obscureText: false,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 175,
                                          child: BlocBuilder<PropertyTypeBloc,
                                              PropertyTypeState>(
                                            builder: (context, state) {
                                              if(state.status == PropertyTypeStatus.initial){
                                                context.read<PropertyTypeBloc>().add(LoadAllPropertyTypesEvent());
                                              }
                                              return CustomApiGenericDropdown<
                                                  SmartModel>(
                                                hintText: 'Type',
                                                menuItems: state.propertyTypes == null
                                                    ? []
                                                    : state.propertyTypes!,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedPropertyTypeId =
                                                        value!.getId();
                                                  });
                                                  print(value!.getId());
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 175,
                                          child: BlocBuilder<PropertyCategoryBloc,
                                              PropertyCategoryState>(
                                            builder: (context, state) {
                                              return CustomApiGenericDropdown<
                                                  SmartModel>(
                                                hintText: 'Category',
                                                menuItems:
                                                state.propertyCategories == null
                                                    ? []
                                                    : state.propertyCategories!,
                                                onChanged: (value) {
                                                  print(value!.getId());
                                                  setState(() {
                                                    selectedPropertyCategoryId =
                                                        value.getId();
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 175,
                                          child: AuthTextField(
                                            controller: locationController,
                                            hintText: 'Location',
                                            obscureText: false,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 175,
                                          child: AuthTextField(
                                            controller: sqmController,
                                            hintText: 'sqm',
                                            obscureText: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AppMaxTextField(
                                      controller: descriptionController,
                                      hintText: 'Description',
                                      obscureText: false,
                                      fillColor: AppTheme.itemBgColor,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        FullPicker(
                                          prefixName: 'add property',
                                          context: context,
                                          image: true,
                                          imageCamera: kDebugMode,
                                          imageCropper: true,
                                          onError: (int value) {
                                            print(" ----  onError ----=$value");
                                          },
                                          onSelected: (value) async {
                                            print(" ----  onSelected ----");

                                            setState(() {
                                              propertyPic = value.file.first;
                                              propertyImagePath =
                                                  value.file.first!.path;
                                              propertyImageExtension = value
                                                  .file.first!.path
                                                  .split('.')
                                                  .last;
                                              propertyFileName = value
                                                  .file.first!.path
                                                  .split('/')
                                                  .last;
                                            });
                                            propertyBytes =
                                            await propertyPic!.readAsBytes();
                                            print('MY PIC == $propertyPic');
                                            print('MY path == $propertyImagePath');
                                            print('MY bytes == $propertyBytes');
                                            print(
                                                'MY extension == $propertyImageExtension');
                                            print(
                                                'MY FILE NAME == $propertyFileName');
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: 175,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            color: AppTheme.itemBgColor,
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: FileImage(
                                                    propertyPic ?? File('')),
                                                fit: BoxFit.cover)),
                                        child: propertyPic == null ||
                                            propertyPic!.path.isEmpty
                                            ? Center(
                                          child: Text('Upload Property Pic'),
                                        )
                                            : null,
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }

}
