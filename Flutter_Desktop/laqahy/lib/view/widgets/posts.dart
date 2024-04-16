import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
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
            ),
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
                          'عنـوان المنشـور',
                          style: MyTextStyles.font16BlackBold,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        myTextField(
                          hintText: 'عنوان المنشور',
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          width: 500,
                          maxLength: 150,
                          prefixIcon: Icons.label_outlined,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'صـورة المنشـور',
                          style: MyTextStyles.font16BlackBold,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        myTextField(
                          hintText: 'اختر صورة المنشور',
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          readOnly: true,
                          width: 200,
                          prefixIcon: Icons.photo_size_select_actual_outlined,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'وصـف المنشـور',
                      style: MyTextStyles.font16BlackBold,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    myTextField(
                      hintText: 'وصف المنشور',
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      width: 500,
                      maxLines: 5,
                      prefixIcon: Icons.description_outlined,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    myButton(
                      onPressed: () {},
                      text: 'إضــافــة',
                      textStyle: MyTextStyles.font16WhiteBold,
                      width: 130,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    myButton(
                      onPressed: () {},
                      text: 'إلغـاء الأمـر',
                      textStyle: MyTextStyles.font16WhiteBold,
                      width: 130,
                      backgroundColor: MyColors.greyColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return myPostsCard();
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 20,
                    );
                  },
                  itemCount: 5,
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
