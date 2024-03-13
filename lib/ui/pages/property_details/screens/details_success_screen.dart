import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/custom_image.dart';

class DetailsSuccessScreen extends StatelessWidget {
  final Property property;

  const DetailsSuccessScreen({super.key, required this.property});

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property.getName(),
                softWrap: true,
                overflow: TextOverflow.clip,
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppTheme.darker,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_half_sharp,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    property.getNumber(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  if (property.propertyCategoryModel != null)
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.tag,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          property.getPropertyCategoryName(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    property.getLocation(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.rulerCombined,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${property.getSquareMeters()} SQM",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.sparkles,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    property.propertyType!.getName(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  if (true)
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.calendar,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          DateFormat("dd/MM/yyyy").format(property.createdAt!),
                          style: const TextStyle(
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
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
