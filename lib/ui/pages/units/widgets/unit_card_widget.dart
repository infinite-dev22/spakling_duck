import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/data_layer/models/unit/unit_model.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/app_button.dart';
import 'package:smart_rent/utilities/extra.dart';


class UnitCardWidget extends StatefulWidget {

  final UnitModel unitModel;
  final int index;

  const UnitCardWidget(
      {super.key,
      required this.unitModel,
      required this.index,
  });

  @override
  State<UnitCardWidget> createState() => _UnitCardWidgetState();
}

class _UnitCardWidgetState extends State<UnitCardWidget> {
  String imageError = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        // width: width,
        // height: height,
        decoration: BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: .1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ListTile(
            tileColor: AppTheme.itemBgColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.unitModel.name}',
                  style: AppTheme.subTextBold,
                ),
                SizedBox(
                  width: 1,
                ),
                Text(
                    '${widget.unitModel.currencyModel!.code} ${amountFormatter.format(widget.unitModel.amount.toString())}/=',
                    style: AppTheme.appTitle3),
                PopupMenuButton(
                  onSelected: (value) async {
                    if (value == 1) {

                    } else {

                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.edit),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.delete),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.unitModel.unitTypeModel!.name}',
                  style: AppTheme.subText,
                ),

                Text(
                  '${widget.unitModel.floorModel!.name}',
                  style: AppTheme.subText,
                ),

                Text(
                  '${widget.unitModel.periodModel!.name}',
                  style: AppTheme.subText,
                ),

                GestureDetector(
                  onTap: () async {
                    if (widget.unitModel.isAvailable == false) {
                      Get.defaultDialog(
                          title: 'Change Availability',
                          middleText:
                              'Make Room ${widget.unitModel.name} available',
                          barrierDismissible: true,
                          titleStyle: AppTheme.appTitle7,
                          cancel: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                  width: 30,
                                  child: AppButton(
                                      title: 'Cancel',
                                      color: Colors.black,
                                      function: () {
                                        Get.back();
                                      })),
                              SizedBox(
                                  width: 30,
                                  child: AppButton(
                                        title: 'Yes',
                                        color: AppTheme.primaryColor,
                                        function: () async {}),),
                            ],
                          ),
                          // confirm: SizedBox(
                          //     width: 40.w,
                          //     child: AppButton(title: 'Yes', color: AppTheme.primaryColor, function: (){})),
                          middleTextStyle: AppTheme.subTextBold1);
                    } else {}
                  },
                  child: Card(
                      color: widget.unitModel.isAvailable == 1
                          ? Colors.green
                          : Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.unitModel.isAvailable == 1
                              ? 'available'
                              : 'occupied',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
