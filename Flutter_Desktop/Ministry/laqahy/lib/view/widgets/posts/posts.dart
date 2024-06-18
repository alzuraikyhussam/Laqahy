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
import 'package:laqahy/services/api/api_exception.dart';
import 'package:laqahy/view/widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:loading_indicator/loading_indicator.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  HomeLayoutController hlc = Get.put(HomeLayoutController());
  PostController pc = Get.put(PostController());

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
                  key: pc.createPostFormKey,
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
                                controller: pc.titleController,
                                validator: pc.titleValidator,
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
                                controller: pc.pictureController,
                                validator: pc.pictureValidator,
                                hintText: 'اختر صورة الإعــلان',
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                                onTap: () async {
                                  await pc.pickImage(ImageSource.gallery);
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
                            controller: pc.descController,
                            validator: pc.descValidator,
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
                            return pc.isLoading.value
                                ? myLoadingIndicator()
                                : myButton(
                                    onPressed: pc.isLoading.value
                                        ? null
                                        : () {
                                            if (pc
                                                .createPostFormKey.currentState!
                                                .validate()) {
                                              pc.addPost(
                                                pc.titleController.text,
                                                pc.descController.text,
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
                      Spacer(),
                      Container(
                        alignment: AlignmentDirectional.centerEnd,
                        child: myIconButton(
                          icon: Icons.refresh_rounded,
                          onTap: () {
                            pc.fetchPosts();
                          },
                          gradientColors: [
                            MyColors.primaryColor,
                            MyColors.secondaryColor,
                          ],
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
                    future: pc.fetchDataFuture.value,
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
                          child: ApiException().mySnapshotError(snapshot.error,
                              onPressedRefresh: () {
                            pc.fetchPosts();
                          }),
                        );
                      } else {
                        if (pc.posts.isEmpty) {
                          return ApiException().myDataNotFound(
                            onPressedRefresh: () {
                              pc.fetchPosts();
                            },
                          );
                        } else {
                          return ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return myPostsCard(
                                context: context,
                                postId: pc.posts[index].id,
                                title: pc.posts[index].postTitle,
                                desc: pc.posts[index].postDescription,
                                image: pc.posts[index].postImage,
                                publishAt: pc.posts[index].postPublishDate,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: pc.posts.length,
                          );
                        }
                      }
                    },
                  );
                }),
                Obx(() => SizedBox(
                      height: pc.posts.isEmpty ? 50 : 100,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
