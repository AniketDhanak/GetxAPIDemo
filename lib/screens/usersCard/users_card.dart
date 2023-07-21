import 'package:flutter/material.dart';
import 'package:getx_api_demo_mvc/constants/app_colors.dart';
import 'package:getx_api_demo_mvc/constants/style_constants.dart';
import 'package:getx_api_demo_mvc/model/network/users_model.dart';

class UsersCard extends StatelessWidget {
  final Datum datum;
  final int index;

  const UsersCard({super.key, required this.datum, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sr.No: ${index + 1}",
                style: StyleConstants.h614PxStyleMedium(color: AppColors.black),
              ),
              Text(
                "Name: ${datum.userName}",
                style: StyleConstants.h614PxStyleMedium(color: AppColors.black),
              ),
              Text(
                "Email: ${datum.email}",
                style: StyleConstants.h614PxStyleMedium(color: AppColors.black),
              ),
              Text(
                "ID: ${datum.userId}",
                style: StyleConstants.h614PxStyleMedium(color: AppColors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
