import 'dart:io';

import 'package:smart_rent/data_layer/models/smart_model.dart';
import 'package:smart_rent/ui/pages/properties/bloc/property_bloc.dart';
import 'package:smart_rent/ui/pages/property_categories/bloc/property_category_bloc.dart';
import 'package:smart_rent/ui/pages/property_types/bloc/property_type_bloc.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/app_drop_downs.dart';
import 'package:smart_rent/ui/widgets/app_max_textfield.dart';
import 'package:smart_rent/ui/widgets/auth_textfield.dart';
import 'package:smart_rent/ui/widgets/form_title_widget.dart';
import 'package:smart_rent/utilities/app_init.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:full_picker/full_picker.dart';


class AddPropertyForm extends StatefulWidget {
  final String addButtonText;
  final bool isUpdate;

  const AddPropertyForm(
      {super.key, required this.addButtonText, required this.isUpdate});

  @override
  State<AddPropertyForm> createState() => _AddPropertyFormState();
}

class _AddPropertyFormState extends State<AddPropertyForm> {
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

  int selectedPropertyTypeId = 0;
  int selectedPropertyCategoryId = 0;
  bool isTitleElevated = false;

  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    sqmController.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20)
            .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            BlocListener<PropertyBloc, PropertyState>(
              listener: (context, state) {
                if (state.status == PropertyStatus.successAdd) {
                  Fluttertoast.showToast(
                      msg: 'Property Added Successfully',
                      backgroundColor: Colors.green,
                      gravity: ToastGravity.TOP);
                  titleController.clear();
                  locationController.clear();
                  descriptionController.clear();
                  sqmController.clear();
                  selectedPropertyTypeId = 0;
                  selectedPropertyCategoryId = 0;
                  propertyPic = File('');
                  print('Pic = ${propertyPic!.path}');
                  Navigator.pop(context);
                }
                if (state.status == PropertyStatus.accessDeniedAdd) {
                  Fluttertoast.showToast(
                      msg: state.message.toString(), gravity: ToastGravity.TOP);
                }
                if (state.status == PropertyStatus.errorAdd) {
                  Fluttertoast.showToast(
                      msg: state.message.toString(), gravity: ToastGravity.TOP);
                }
              },
              child: FormTitle(
                name: '${widget.isUpdate ? "Edit" : "New"}  Property',
                addButtonText: widget.isUpdate ? "Update" : "Add",
                onSave: () {
                  if (titleController.text.isEmpty ||
                          locationController.text.isEmpty ||
                          sqmController.text.isEmpty
                      // propertyPic == null
                      ) {
                    Fluttertoast.showToast(
                        msg: 'fill in all fields', gravity: ToastGravity.TOP);
                  } else if (selectedPropertyTypeId == 0) {
                    Fluttertoast.showToast(
                        msg: 'select property type id',
                        gravity: ToastGravity.TOP);
                  } else if (selectedPropertyCategoryId == 0) {
                    Fluttertoast.showToast(
                        msg: 'select property category id',
                        gravity: ToastGravity.TOP);
                  } else {
                    context.read<PropertyBloc>().add(AddPropertyEvent(
                          currentUserToken.toString(),
                          titleController.text.trim().toString(),
                          locationController.text.trim().toString(),
                          sqmController.text.trim().toString(),
                          descriptionController.text.trim().toString(),
                          selectedPropertyTypeId,
                          selectedPropertyCategoryId,
                        ));
                  }
                },
                isElevated: true,
                onCancel: () {
                  titleController.clear();
                  locationController.clear();
                  descriptionController.clear();
                  sqmController.clear();
                  selectedPropertyTypeId = 0;
                  selectedPropertyCategoryId = 0;
                  propertyPic = File('');
                  print('Pic = ${propertyPic!.path}');
                  Navigator.pop(context);
                },
              ),
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
                                    width: 190,
                                    child: BlocBuilder<PropertyTypeBloc,
                                        PropertyTypeState>(
                                      builder: (context, state) {
                                        if (state.status ==
                                            PropertyTypeStatus.initial) {
                                          context
                                              .read<PropertyTypeBloc>()
                                              .add(LoadAllPropertyTypesEvent());
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
                                    width: 190,
                                    child: BlocBuilder<PropertyCategoryBloc,
                                        PropertyCategoryState>(
                                      builder: (context, state) {
                                        if (state.status ==
                                            PropertyCategoryStatus.initial) {
                                          context.read<PropertyCategoryBloc>().add(
                                              LoadAllPropertyCategoriesEvent());
                                        }
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
                                    width: 190,
                                    child: AuthTextField(
                                      controller: locationController,
                                      hintText: 'Location',
                                      obscureText: false,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 190,
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
                                      borderRadius: BorderRadius.circular(15),
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

//
// addPropertyForm(BuildContext context, String addButtonText,
//     VoidCallback submitFormData, bool isTitleElevated, bool isUpdate){
//
//   showModalBottomSheet(
//       useSafeArea: true,
//       isScrollControlled: true,
//       context: context, builder: (context){
//
//     return  StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//           File? propertyPic;
//           String? propertyImagePath;
//           String? propertyImageExtension;
//           String? propertyFileName;
//           Uint8List? propertyBytes;
//
//           final TextEditingController titleController = TextEditingController();
//           final TextEditingController addressController = TextEditingController();
//           final TextEditingController descriptionController = TextEditingController();
//           final TextEditingController locationController = TextEditingController();
//           final TextEditingController sqmController = TextEditingController();
//
//           List<String> searchableList = ['Orange', 'Watermelon', 'Banana'];
//
//           int selectedPropertyTypeId = 0;
//           int selectedPropertyCategoryId = 0;
//
//           final ScrollController scrollController = ScrollController();
//
//
//
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 20)
//                 .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Column(
//               children: [
//                 FormTitle(
//                   name: '${isUpdate ? "Edit" : "New"}  Property',
//                   addButtonText: isUpdate ? "Update" : "Add",
//                   onSave: submitFormData,
//                   isElevated: true,
//                 ),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       // FocusManager.instance.primaryFocus?.unfocus();
//                     },
//                     child: NotificationListener<ScrollNotification>(
//                       onNotification: (scrollNotification) {
//                         if (scrollController.position.userScrollDirection ==
//                             ScrollDirection.reverse) {
//                           setState(() {
//                             isTitleElevated = true;
//                           });
//                         } else if (scrollController.position.userScrollDirection ==
//                             ScrollDirection.forward) {
//                           if (scrollController.position.pixels ==
//                               scrollController.position.maxScrollExtent) {
//                             setState(() {
//                               isTitleElevated = false;
//                             });
//                           }
//                         }
//                         return true;
//                       },
//                       child: ListView(
//                         controller: scrollController,
//                         padding: const EdgeInsets.all(8),
//                         children: [
//                           LayoutBuilder(builder: (context, constraints) {
//                             return Form(
//                               child: Column(
//                                 children: [
//
//                                   AuthTextField(
//                                     controller: titleController,
//                                     hintText: 'Property title',
//                                     obscureText: false,
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       SizedBox(
//                                         width: 175,
//                                         child: BlocBuilder<PropertyTypeBloc,
//                                             PropertyTypeState>(
//                                           builder: (context, state) {
//                                             if(state.status == PropertyTypeStatus.initial){
//                                               context.read<PropertyTypeBloc>().add(LoadAllPropertyTypesEvent());
//                                             }
//                                             return CustomApiGenericDropdown<
//                                                 SmartModel>(
//                                               hintText: 'Type',
//                                               menuItems: state.propertyTypes == null
//                                                   ? []
//                                                   : state.propertyTypes!,
//                                               onChanged: (value) {
//                                                 setState(() {
//                                                   selectedPropertyTypeId =
//                                                       value!.getId();
//                                                 });
//                                                 print(value!.getId());
//                                               },
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 175,
//                                         child: BlocBuilder<PropertyCategoryBloc,
//                                             PropertyCategoryState>(
//                                           builder: (context, state) {
//                                             if(state.status == PropertyCategoryStatus.initial){
//                                               context.read<PropertyCategoryBloc>().add(LoadAllPropertyCategoriesEvent());
//                                             }
//                                             return CustomApiGenericDropdown<
//                                                 SmartModel>(
//                                               hintText: 'Category',
//                                               menuItems:
//                                               state.propertyCategories == null
//                                                   ? []
//                                                   : state.propertyCategories!,
//                                               onChanged: (value) {
//                                                 print(value!.getId());
//                                                 setState(() {
//                                                   selectedPropertyCategoryId =
//                                                       value.getId();
//                                                 });
//                                               },
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: 175,
//                                         child: AuthTextField(
//                                           controller: locationController,
//                                           hintText: 'Location',
//                                           obscureText: false,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 175,
//                                         child: AuthTextField(
//                                           controller: sqmController,
//                                           hintText: 'sqm',
//                                           obscureText: false,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   AppMaxTextField(
//                                     controller: descriptionController,
//                                     hintText: 'Description',
//                                     obscureText: false,
//                                     fillColor: AppTheme.itemBgColor,
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       FullPicker(
//                                         prefixName: 'add property',
//                                         context: context,
//                                         image: true,
//                                         imageCamera: kDebugMode,
//                                         imageCropper: true,
//                                         onError: (int value) {
//                                           print(" ----  onError ----=$value");
//                                         },
//                                         onSelected: (value) async {
//                                           print(" ----  onSelected ----");
//
//                                           setState(() {
//                                             propertyPic = value.file.first;
//                                             propertyImagePath =
//                                                 value.file.first!.path;
//                                             propertyImageExtension = value
//                                                 .file.first!.path
//                                                 .split('.')
//                                                 .last;
//                                             propertyFileName = value
//                                                 .file.first!.path
//                                                 .split('/')
//                                                 .last;
//                                           });
//                                           propertyBytes =
//                                           await propertyPic!.readAsBytes();
//                                           print('MY PIC == $propertyPic');
//                                           print('MY path == $propertyImagePath');
//                                           print('MY bytes == $propertyBytes');
//                                           print(
//                                               'MY extension == $propertyImageExtension');
//                                           print(
//                                               'MY FILE NAME == $propertyFileName');
//                                         },
//                                       );
//                                     },
//                                     child: Container(
//                                       width: 175,
//                                       height: 200,
//                                       decoration: BoxDecoration(
//                                           color: AppTheme.itemBgColor,
//                                           borderRadius:
//                                           BorderRadius.circular(15),
//                                           image: DecorationImage(
//                                               image: FileImage(
//                                                   propertyPic ?? File('')),
//                                               fit: BoxFit.cover)),
//                                       child: propertyPic == null ||
//                                           propertyPic!.path.isEmpty
//                                           ? Center(
//                                         child: Text('Upload Property Pic'),
//                                       )
//                                           : null,
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                             );
//                           }),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//     );
//   });
// }
