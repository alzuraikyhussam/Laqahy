import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/notifications_controller.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/core/shared/styles/style.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NotificationsController nc = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    // final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: myAppBar(
        text: 'الإشعارات',
      ),
      // body: Column(
      //   children: [
      //     Text('${message.notification!.title}'),
      //     Text('${message.notification!.body}'),
      //     Text('${message.data}'),
      //   ],
      // ),

      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/screen-background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(() {
          return FutureBuilder(
            future: nc.fetchDataFuture.value,
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
                  child: ApiExceptionWidgets().mySnapshotError(snapshot.error,
                      onPressedRefresh: () {
                    nc.fetchNotifications();
                  }),
                );
              } else {
                if (nc.notifications.isEmpty) {
                  return ApiExceptionWidgets().myDataNotFound(
                    text: 'لم يتم العثور على إشعارات واردة',
                    onPressedRefresh: () {
                      nc.fetchNotifications();
                    },
                  );
                } else {
                  return myNotificationsListView(
                    notification: nc.notifications,
                  );
                }
              }
            },
          );
        }),
      ),
    );
  }
}
