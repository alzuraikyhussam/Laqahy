import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/vaccine_controller.dart';
import 'package:laqahy/services/api/api_exception.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class VaccinesScreen extends StatefulWidget {
  const VaccinesScreen({super.key});

  @override
  State<VaccinesScreen> createState() => _VaccinesScreenState();
}

class _VaccinesScreenState extends State<VaccinesScreen> {
  VaccineController vc = Get.put(VaccineController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          bottom: 0,
          child: Image.asset('assets/images/vaccines-background.png'),
        ),
        Obx(() {
          return FutureBuilder(
            future: vc.fetchDataFuture.value,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: myLoadingIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: ApiException().mySnapshotError(snapshot.error,
                      onPressedRefresh: () {
                    vc.fetchVaccines();
                  }),
                );
              } else {
                if (vc.vaccines.isEmpty) {
                  return ApiException().myDataNotFound(
                    onPressedRefresh: () {
                      vc.fetchVaccines();
                    },
                  );
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: vc.vaccines.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      mainAxisExtent: 110,
                    ),
                    itemBuilder: (context, index) {
                      return myVaccineCards(
                        id: vc.vaccines[index].vaccineTypeId!,
                        title: vc.vaccines[index].vaccineType!,
                        quantity: vc.vaccines[index].quantity!,
                      );
                    },
                  );
                }
              }
            },
          );
        }),
      ],
    );
  }
}
