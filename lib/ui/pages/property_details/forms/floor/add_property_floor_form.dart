import 'package:SmartCase/configs/app_configs.dart';
import 'package:SmartCase/data_layer/models/property/property_response_model.dart';
import 'package:SmartCase/ui/pages/floors/bloc/floor_bloc.dart';
import 'package:SmartCase/ui/themes/app_theme.dart';
import 'package:SmartCase/ui/widgets/app_max_textfield.dart';
import 'package:SmartCase/ui/widgets/auth_textfield.dart';
import 'package:SmartCase/ui/widgets/form_title_widget.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AddPropertyFloorForm extends StatefulWidget {
  final String addButtonText;
  final bool isUpdate;
  final Property property;

  const AddPropertyFloorForm(
      {super.key, required this.addButtonText, required this.isUpdate, required this.property});

  @override
  State<AddPropertyFloorForm> createState() => _AddPropertyFloorFormState();
}

class _AddPropertyFloorFormState extends State<AddPropertyFloorForm> {
  final TextEditingController floorController = TextEditingController();
  final TextEditingController floorDescriptionController =
      TextEditingController();

  late SingleValueDropDownController _propertyModelCont;

  bool isTitleElevated = false;
  String? floorName;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _propertyModelCont = SingleValueDropDownController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    floorController.dispose();
    floorDescriptionController.dispose();
    _propertyModelCont.dispose();
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
            BlocListener<FloorBloc, FloorState>(
              listener: (context, state) {
                if (state.status == FloorStatus.successAdd) {
                  Fluttertoast.showToast(
                      msg: 'Floor Added Successfully',
                      backgroundColor: Colors.green,
                      gravity: ToastGravity.TOP);
                  floorController.clear();
                  floorDescriptionController.clear();
                  _propertyModelCont.clearDropDown();
                  Navigator.pop(context);
                }
                if (state.status == FloorStatus.accessDeniedAdd) {
                  Fluttertoast.showToast(
                      msg: state.message.toString(), gravity: ToastGravity.TOP);
                }
                if (state.status == FloorStatus.errorAdd) {
                  Fluttertoast.showToast(
                      msg: state.message.toString(), gravity: ToastGravity.TOP);
                }
              },
              child: FormTitle(
                name: '${widget.isUpdate ? "Edit" : "New"}  Floor',
                addButtonText: widget.isUpdate ? "Update" : "Add",
                onSave: () {
                  if (floorController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'floor name required', gravity: ToastGravity.TOP);
                  } else if (floorController.text.length <= 1) {
                    Fluttertoast.showToast(
                        msg: 'floor name too short', gravity: ToastGravity.TOP);
                  } else {
                    context.read<FloorBloc>().add(AddFloorEvent(
                          appUrl.toString(),
                          widget.property.id!,
                          floorController.text.trim().toString(),
                          floorDescriptionController.text.trim().toString(),
                        ));
                  }
                },
                isElevated: isTitleElevated,
                onCancel: () {
                  floorController.clear();
                  floorDescriptionController.clear();
                  _propertyModelCont.clearDropDown();
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
                              SizedBox(
                                height: 10,
                              ),
                              AuthTextField(
                                controller: floorController,
                                hintText: 'Floor Name.',
                                obscureText: false,
                                onChanged: (value) {
                                  floorName = floorController.text.trim();
                                  print(floorName.toString());
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AppMaxTextField(
                                controller: floorDescriptionController,
                                hintText: 'Description',
                                obscureText: false,
                                fillColor: AppTheme.itemBgColor,
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
//                   isElevated: isTitleElevated,
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
