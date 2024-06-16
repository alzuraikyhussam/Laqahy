import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/orders/cancelled_order.dart';
import 'package:laqahy/view/widgets/orders/incoming_order.dart';
import 'package:laqahy/view/widgets/orders/delivered_order.dart';
import 'package:laqahy/view/widgets/orders/in_delivery_order.dart';

class OrdersLayout extends StatefulWidget {
  const OrdersLayout({super.key});

  @override
  State<OrdersLayout> createState() => _OrdersLayoutState();
}

class _OrdersLayoutState extends State<OrdersLayout> {
  OrdersController olc = Get.put(OrdersController());

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
          height: double.infinity,
          padding: EdgeInsetsDirectional.only(
            start: 5,
          ),
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
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            olc.onChangeOrder('incoming');
                          },
                          child: Container(
                            decoration: olc.orderTapChange.value == 'incoming'
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
                                'الــــواردة',
                                style: olc.orderTapChange.value == 'incoming'
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
                            olc.onChangeOrder('in_delivery');
                          },
                          child: Container(
                            decoration: olc.orderTapChange.value ==
                                    'in_delivery'
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
                                style: olc.orderTapChange.value == 'in_delivery'
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
                            olc.onChangeOrder('delivered');
                          },
                          child: Container(
                            decoration: olc.orderTapChange.value == 'delivered'
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
                                style: olc.orderTapChange.value == 'delivered'
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
                            olc.onChangeOrder('cancelled');
                          },
                          child: Container(
                            decoration: olc.orderTapChange.value == 'cancelled'
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
                                style: olc.orderTapChange.value == 'cancelled'
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
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: AlignmentDirectional.centerEnd,
                child: myIconButton(
                  icon: Icons.refresh_rounded,
                  onTap: () async {
                    olc.fetchIncomingOrders();
                    olc.fetchInDeliveryOrders();
                    olc.fetchDeliveredOrders();
                    olc.fetchCancelledOrders();
                  },
                  gradientColors: [
                    MyColors.primaryColor,
                    MyColors.secondaryColor,
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return Expanded(
                  child: olc.orderTapChange.value == 'incoming'
                      ? IncomingOrder()
                      : olc.orderTapChange.value == 'in_delivery'
                          ? InDeliveryOrder()
                          : olc.orderTapChange.value == 'delivered'
                              ? DeliveredOrder()
                              : olc.orderTapChange.value == 'cancelled'
                                  ? CancelledOrder()
                                  : SizedBox(),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
