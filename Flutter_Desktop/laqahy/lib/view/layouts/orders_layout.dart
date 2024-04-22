import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/orders_layout_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/add_order.dart';

class OrdersLayout extends StatefulWidget {
  const OrdersLayout({super.key});

  @override
  State<OrdersLayout> createState() => _OrdersLayoutState();
}

class _OrdersLayoutState extends State<OrdersLayout> {
  OrdersLayoutController olc = Get.put(OrdersLayoutController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          bottom: 0,
          child: Image.asset(
            'assets/images/orders-image.png',
          ),
        ),
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: MyColors.greyColor.withOpacity(0.1)),
                ),
                width: double.infinity,
                height: 60,
                padding: EdgeInsetsDirectional.all(3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(() {
                      return InkWell(
                        onTap: () {
                          olc.onChangeOrder('add');
                        },
                        child: Container(
                          width: 100,
                          decoration: olc.orderChange.value == 'add'
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MyColors.secondaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          MyColors.greyColor.withOpacity(0.3),
                                      blurRadius: 10,
                                    ),
                                  ],
                                )
                              : null,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: olc.orderChange.value == 'add'
                                  ? MyColors.whiteColor
                                  : MyColors.secondaryColor,
                              size: 30,
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(() {
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            olc.onChangeOrder('export');
                          },
                          child: Container(
                            decoration: olc.orderChange.value == 'export'
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors.secondaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            MyColors.greyColor.withOpacity(0.3),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  )
                                : null,
                            child: Center(
                              child: Text(
                                'الصــــادرة',
                                style: olc.orderChange.value == 'export'
                                    ? MyTextStyles.font16WhiteBold
                                    : MyTextStyles.font16SecondaryBold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(() {
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            olc.onChangeOrder('waiting');
                          },
                          child: Container(
                            decoration: olc.orderChange.value == 'waiting'
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors.secondaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            MyColors.greyColor.withOpacity(0.3),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  )
                                : null,
                            child: Center(
                              child: Text(
                                'قيـــد التــسليـــم',
                                style: olc.orderChange.value == 'waiting'
                                    ? MyTextStyles.font16WhiteBold
                                    : MyTextStyles.font16SecondaryBold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(() {
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            olc.onChangeOrder('success');
                          },
                          child: Container(
                            decoration: olc.orderChange.value == 'success'
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors.secondaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            MyColors.greyColor.withOpacity(0.3),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  )
                                : null,
                            child: Center(
                              child: Text(
                                'تـــم التــسليـــم',
                                style: olc.orderChange.value == 'success'
                                    ? MyTextStyles.font16WhiteBold
                                    : MyTextStyles.font16SecondaryBold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(() {
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            olc.onChangeOrder('canceled');
                          },
                          child: Container(
                            decoration: olc.orderChange.value == 'canceled'
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors.secondaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            MyColors.greyColor.withOpacity(0.3),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  )
                                : null,
                            child: Center(
                              child: Text(
                                'الــملـغـيـــة',
                                style: olc.orderChange.value == 'canceled'
                                    ? MyTextStyles.font16WhiteBold
                                    : MyTextStyles.font16SecondaryBold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Obx(() {
                return Column(
                  children: [
                    olc.orderChange.value == 'add'
                        ? AddOrder()
                        : olc.orderChange.value == 'export'
                            ? SizedBox()
                            : olc.orderChange.value == 'waiting'
                                ? SizedBox()
                                : olc.orderChange.value == 'success'
                                    ? SizedBox()
                                    : olc.orderChange.value == 'canceled'
                                        ? SizedBox()
                                        : SizedBox(),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
