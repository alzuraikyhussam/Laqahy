import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laqahy/controllers/post_controller.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/models/post_model.dart';
import 'package:laqahy/services/api/api_exception_alert.dart';
import 'package:laqahy/view/widgets/api_error_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:loading_indicator/loading_indicator.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  HomeLayoutController hlc = Get.put(HomeLayoutController());
  PostController cpc = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          bottom: 0,
          top: 0,
          child: SvgPicture.asset(
            'assets/images/posts-image.svg',
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              end: 30,
              start: 5,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: cpc.createPostFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'عنـوان الإعــلان',
                                style: MyTextStyles.font16BlackBold,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              myTextField(
                                controller: cpc.titleController,
                                validator: cpc.titleValidator,
                                hintText: 'عنوان الإعــلان',
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                                width: 500,
                                maxLength: 100,
                                prefixIcon: Icons.label_outlined,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'صـورة الإعــلان',
                                style: MyTextStyles.font16BlackBold,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              myTextField(
                                controller: cpc.pictureController,
                                validator: cpc.pictureValidator,
                                hintText: 'اختر صورة الإعــلان',
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                                onTap: () async {
                                  await cpc.pickImage(ImageSource.gallery);
                                },
                                readOnly: true,
                                width: 200,
                                prefixIcon:
                                    Icons.photo_size_select_actual_outlined,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'وصـف الإعــلان',
                            style: MyTextStyles.font16BlackBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          myTextField(
                            hintText: 'وصف الإعــلان',
                            controller: cpc.descController,
                            validator: cpc.descValidator,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            width: 500,
                            maxLines: 5,
                            heightFactor: 4.8,
                            prefixIcon: Icons.description_outlined,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Obx(() {
                            return cpc.isLoading.value
                                ? myLoadingIndicator()
                                : myButton(
                                    onPressed: cpc.isLoading.value
                                        ? null
                                        : () {
                                            if (cpc
                                                .createPostFormKey.currentState!
                                                .validate()) {
                                              cpc.addPost(
                                                cpc.titleController.text,
                                                cpc.descController.text,
                                              );
                                            }
                                          },
                                    text: 'إضــافــة',
                                    textStyle: MyTextStyles.font16WhiteBold,
                                    width: 130,
                                  );
                          }),
                          const SizedBox(
                            width: 15,
                          ),
                          myButton(
                            onPressed: () {
                              hlc.changeChoose(
                                'الرئيسية',
                              );
                            },
                            text: 'خـــروج',
                            textStyle: MyTextStyles.font16WhiteBold,
                            width: 130,
                            backgroundColor: MyColors.greyColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 70,
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
                        height: 50,
                        width: 200,
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
                          'كافــة المنشــورات',
                          style: MyTextStyles.font18WhiteBold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(() {
                  return FutureBuilder(
                    future: cpc.fetchDataFuture.value,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: myLoadingIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: ApiExceptionAlert().mySnapshotError(
                              snapshot.error, onPressedRefresh: () {
                            cpc.fetchPosts();
                          }),
                        );
                      } else {
                        if (cpc.posts.isEmpty) {
                          return ApiExceptionAlert().myDataNotFound(
                            onPressedRefresh: () {
                              cpc.fetchPosts();
                            },
                          );
                        } else {
                          return ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return myPostsCard(
                                context: context,
                                postId: cpc.posts[index].id,
                                title: cpc.posts[index].postTitle,
                                desc: cpc.posts[index].postDescription,
                                image: cpc.posts[index].postImage,
                                publishAt: cpc.posts[index].postPublishDate,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: cpc.posts.length,
                          );
                        }
                      }
                    },
                  );
                }),
                // Obx(() {
                //   if (cpc.isFetchPostsLoading.value) {
                //     return Center(
                //       child: myLoadingIndicator(),
                //     );
                //   } else {
                //     return FutureBuilder<List<Post>?>(
                //       future: cpc.posts.value,
                //       builder: (context, snapshot) {
                //         if (snapshot.connectionState ==
                //             ConnectionState.waiting) {
                //           return Center(
                //             child: myLoadingIndicator(),
                //           );
                //         } else if (snapshot.hasError) {
                //           return Center(
                //             child: Text(
                //               'لقد حدث خطأ ما...!\n${snapshot.error}',
                //               style: MyTextStyles.font16RedBold,
                //               maxLines: 2,
                //             ),
                //           );
                //         } else if (snapshot.hasData) {
                //           return ListView.separated(
                //             shrinkWrap: true,
                //             itemBuilder: (context, index) {
                //               return myPostsCard(
                //                 context: context,
                //                 postId: snapshot.data![index].id,
                //                 title: snapshot.data![index].postTitle,
                //                 desc: snapshot.data![index].postDescription,
                //                 image: snapshot.data![index].postImage,
                //                 publishAt:
                //                     snapshot.data![index].postPublishDate,
                //               );
                //             },
                //             separatorBuilder: (context, index) {
                //               return const SizedBox(
                //                 height: 20,
                //               );
                //             },
                //             itemCount: snapshot.data!.length,
                //           );
                //         } else if (!snapshot.hasData || snapshot.data == null) {
                //           return Center(
                //             child: Column(
                //               children: [
                //                 Text(
                //                   'لا تـــــــــوجـد بيــــــانات',
                //                   style: MyTextStyles.font16GreyBold,
                //                 ),
                //                 SizedBox(
                //                   height: 15,
                //                 ),
                //                 myButton(
                //                   onPressed: () async {
                //                     await cpc.posts(cpc.fetchPosts());
                //                   },
                //                   text: 'تحـديـــث',
                //                   textStyle: MyTextStyles.font14WhiteBold,
                //                 ),
                //               ],
                //             ),
                //           );
                //         } else {
                //           return Center(
                //             child: Column(
                //               children: [
                //                 Text(
                //                   'لا تـــــــــوجـد بيــــــانات',
                //                   style: MyTextStyles.font16GreyBold,
                //                 ),
                //                 SizedBox(
                //                   height: 15,
                //                 ),
                //                 myButton(
                //                   onPressed: () async {
                //                     await cpc.posts(cpc.fetchPosts());
                //                   },
                //                   text: 'تحـديـــث',
                //                   textStyle: MyTextStyles.font14WhiteBold,
                //                 ),
                //               ],
                //             ),
                //           );
                //         }
                //       },
                //     );
                //   }
                // }),
                Obx(() => SizedBox(
                      height: cpc.posts.isEmpty ? 30 : 100,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
