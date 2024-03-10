import 'package:SmartCase/ui/themes/app_theme.dart';
import 'package:SmartCase/ui/widgets/custom_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsSuccessScreen extends StatelessWidget {
  const DetailsSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        const CustomImage(
          "assets/images/property_image.jpg",
          isNetwork: false,
          radius: 0,
          height: 300,
          width: double.infinity,
        ),
        Container(
          margin: EdgeInsets.only(top: screenHeight * .328),
          child: _buildInfo(),
        ),
      ],
    );
  }

  Widget _buildInfo() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      decoration: const BoxDecoration(
        color: AppTheme.appBgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _buildPropertyDetails(),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyDetails() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Text(
                "Property Name",
                softWrap: true,
                overflow: TextOverflow.clip,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 18,
                  color: AppTheme.darker,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_half_sharp,
                    color: Colors.grey,
                    size: 16,
                  ),
                  Text(
                    "P-23453453546545",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.tag,
                        color: Colors.grey,
                        size: 16,
                      ),
                      Text(
                        "Commercial",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                    size: 16,
                  ),
                  Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.rulerCombined,
                        color: Colors.grey,
                        size: 16,
                      ),
                      Text(
                        "5,000 SQM",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.sparkles,
                    color: Colors.grey,
                    size: 16,
                  ),
                  Text(
                    "Mall",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  if (true)
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.calendar,
                          color: Colors.grey,
                          size: 16,
                        ),
                        Text(
                          "01/01/2000",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
