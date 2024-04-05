import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laqahy/core/shared/styles/style.dart';

import '../../../core/shared/styles/color.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              image: const DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                  decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.greyColor.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  width: 200,
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.group_outlined,
                          color: MyColors.secondaryColor,
                        ),
                      ),
                      Text(
                        'أجمالي عدد الحالات',
                        style: MyTextStyles.font14BlackBold,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '153',
                        style: MyTextStyles.font14BlackBold,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                  decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.greyColor.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  width: 200,
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.group_outlined,
                          color: MyColors.secondaryColor,
                        ),
                      ),
                      Text(
                        'أجمالي عدد الأمهات',
                        style: MyTextStyles.font14BlackBold,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '153',
                        style: MyTextStyles.font14BlackBold,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                  decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.greyColor.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  width: 200,
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.group_outlined,
                          color: MyColors.secondaryColor,
                        ),
                      ),
                      Text(
                        'أجمالي عدد الأطفال',
                        style: MyTextStyles.font14BlackBold,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '153',
                        style: MyTextStyles.font14BlackBold,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                  decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.greyColor.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  width: 200,
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.group_outlined,
                          color: MyColors.secondaryColor,
                        ),
                      ),
                      Text(
                        'أجمالي عدد المراكز الصحية',
                        style: MyTextStyles.font14BlackBold,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '153',
                        style: MyTextStyles.font14BlackBold,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
