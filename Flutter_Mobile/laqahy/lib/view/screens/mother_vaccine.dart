import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class MotherVaccine extends StatelessWidget {
  const MotherVaccine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(text: 'لقــاحـــات ألام'),
      body: Column(
        children: [
          Container(
            height: 300,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: MyColors.secondaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30)),
                      width: 330,
                      height: 130,
                    ),
                  ],
                ),
                Positioned(
                  right: 50,
                  top: 70,
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.whiteColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30)),
                    width: 100,
                    height: 110,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
