import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/color.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width,
        title: Row(
          children: [
            Text(
              'لقـــــــــــــاحــــي   |   ',
              style: TextStyle(
                // fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyColors.whiteColor,
              ),
            ),
            Text(
              'LAQAHY',
              style: TextStyle(
                letterSpacing: 5,
                // fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsetsDirectional.all(20),
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              MyColors.primaryColor,
              MyColors.secondaryColor,
            ],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ),
        ),
      ),
    );
  }
}
