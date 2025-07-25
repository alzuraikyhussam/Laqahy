import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/vaccine_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
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
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return FutureBuilder(
                  future: vc.fetchDataFuture.value,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        width: Get.width,
                        height: 300,
                        child: Center(
                          child: myLoadingIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: ApiExceptionWidgets().mySnapshotError(
                            snapshot.error, onPressedRefresh: () {
                          vc.fetchVaccinesQuantity();
                        }),
                      );
                    } else {
                      if (vc.vaccines.isEmpty) {
                        return Center(
                          child: ApiExceptionWidgets().myDataNotFound(
                            onPressedRefresh: () {
                              vc.fetchVaccinesQuantity();
                            },
                          ),
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
                            mainAxisExtent: 120,
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
          ),
        ),
      ],
    );
  }
}
