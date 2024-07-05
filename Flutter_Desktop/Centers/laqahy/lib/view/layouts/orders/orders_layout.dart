import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/layouts/orders/body_side.dart';
import 'package:laqahy/view/layouts/orders/tab_bar_side.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class OrdersLayout extends StatefulWidget {
  const OrdersLayout({super.key});

  @override
  State<OrdersLayout> createState() => _OrdersLayoutState();
}

class _OrdersLayoutState extends State<OrdersLayout> {
  OrdersController oc = Get.put(OrdersController());

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
          padding: const EdgeInsetsDirectional.only(
            start: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OrderTabBarSide(),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: AlignmentDirectional.centerEnd,
                child: myIconButton(
                  icon: Icons.refresh_rounded,
                  onTap: () async {
                    oc.fetchOutgoingOrders();
                    oc.fetchInDeliveryOrders();
                    oc.fetchDeliveredOrders();
                    oc.fetchRejectedOrders();
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
              const OrderBodySide(),
            ],
          ),
        ),
      ],
    );
  }
}
