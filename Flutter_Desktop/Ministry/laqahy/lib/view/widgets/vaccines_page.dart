import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/vaccines_card.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class VaccinesScreen extends StatefulWidget {
  const VaccinesScreen({super.key});

  @override
  State<VaccinesScreen> createState() => _VaccinesScreenState();
}

class _VaccinesScreenState extends State<VaccinesScreen> {
  VaccinesCard hc = Get.put(VaccinesCard());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          bottom: 0,
          child: Image.asset('assets/images/vaccines-background.png'),
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: hc.vaccinesCardItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            mainAxisExtent: 110,
          ),
          itemBuilder: (context, index) {
            return myVaccineCards(
              imageName: hc.vaccinesCardItems[index].imageName,
              icon: hc.vaccinesCardItems[index].icon,
              title: hc.vaccinesCardItems[index].title,
              value: hc.vaccinesCardItems[index].value,
            );
          },
        ),
      ],
    );
  }
}
