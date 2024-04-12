import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myCircleAvatar(
              radius: 40,
              icon: Icons.people,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'إجمالي عدد الحالات',
              style: MyTextStyles.font16BlackBold,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '150',
              style: MyTextStyles.font18BlackBold,
            ),
          ],
        ),
      ),
    );
  }
}
