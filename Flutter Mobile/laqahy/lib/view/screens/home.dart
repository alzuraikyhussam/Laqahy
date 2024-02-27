import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/color.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width,
        title: Text(
          'لقاحي',
          style: TextStyle(
            // fontSize: 18,
            fontWeight: FontWeight.bold,
            color: MyColors.whiteColor,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsetsDirectional.all(15),
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            MyColors.primaryColor,
            MyColors.secondaryColor,
          ],
          begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd
          ),
        ),
      ),
    );
  }
}
