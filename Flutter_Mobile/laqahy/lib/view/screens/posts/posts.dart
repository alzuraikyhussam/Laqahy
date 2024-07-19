import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/post_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  PostController pc = Get.put(PostController());

  @override
  void initState() {
    pc.fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              // start: 15,
              // end: 15,
              bottom: 20,
              top: 10,
            ),
            child: Column(
              children: [
                Obx(() {
                  return FutureBuilder(
                    future: pc.fetchDataFuture.value,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          width: Get.width,
                          height: 200,
                          child: Center(
                            child: myLoadingIndicator(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: ApiExceptionWidgets().mySnapshotError(
                              snapshot.error, onPressedRefresh: () {
                            pc.fetchPosts();
                          }),
                        );
                      } else {
                        if (pc.posts.isEmpty) {
                          return ApiExceptionWidgets().myDataNotFound(
                            onPressedRefresh: () {
                              pc.fetchPosts();
                            },
                          );
                        } else {
                          return myPostsCarouselSlider(post: pc.posts);
                        }
                      }
                    },
                  );
                }),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 5,
                        height: Get.height,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              MyColors.primaryColor,
                              MyColors.secondaryColor,
                            ],
                            begin: AlignmentDirectional.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                          ),
                          borderRadius: const BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(10),
                            topEnd: Radius.circular(10),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        height: 45,
                        width: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              MyColors.primaryColor,
                              MyColors.secondaryColor,
                            ],
                            begin: AlignmentDirectional.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                          ),
                          borderRadius: const BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(10),
                            topEnd: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          'آخـر المنشورات',
                          style: MyTextStyles.font16WhiteBold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 15,
                    end: 15,
                  ),
                  child: Obx(() {
                    return FutureBuilder(
                      future: pc.fetchDataFuture.value,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            width: Get.width,
                            height: 200,
                            child: Center(
                              child: myLoadingIndicator(),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: ApiExceptionWidgets().mySnapshotError(
                                snapshot.error, onPressedRefresh: () {
                              pc.fetchPosts();
                            }),
                          );
                        } else {
                          if (pc.posts.isEmpty) {
                            return ApiExceptionWidgets().myDataNotFound(
                              onPressedRefresh: () {
                                pc.fetchPosts();
                              },
                            );
                          } else {
                            return myPostsListView(
                              post: pc.posts,
                            );
                          }
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
