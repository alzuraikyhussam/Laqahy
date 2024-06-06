import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laqahy/models/post_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_exception_alert.dart';
import 'package:laqahy/view/widgets/api_error_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class PostController extends GetxController {
  // var posts = Rx<Future<List<Post>?>?>(Future.value([]));
  var posts = <Post>[].obs;
  var fetchDataFuture = Future<void>.value().obs;

  @override
  onInit() {
    fetchPosts();
    super.onInit();
  }

  GlobalKey<FormState> createPostFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> updatePostFormKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  String? titleValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال عنوان الإعلان';
    }
    return null;
  }

  /////////////////
  TextEditingController pictureController = TextEditingController();

  String? pictureValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى اختيار صورة الإعلان';
    }
    return null;
  }

  /////////////////
  TextEditingController descController = TextEditingController();

  String? descValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال وصف للإعلان';
    } else if (!GetUtils.isLengthGreaterOrEqual(value, 150)) {
      return 'يجب أن يحتوي على 150 حرف على الأقل';
    }
    return null;
  }

  var isLoading = false.obs;
  var isFetchPostsLoading = false.obs;
  var isUpdatePostsLoading = false.obs;
  var isDeletePostsLoading = false.obs;
  var image = Rx<File?>(null);
  var updatedImage = Rx<File?>(null);

  isValidExtension(String path) {
    final extension = path.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png'].contains(extension);
  }

  void clearTextFormFields() {
    titleController.clear();
    descController.clear();
    pictureController.clear();
  }

  Future<void> pickImage(ImageSource source, {String type = 'add'}) async {
    try {
      final pickImage = await ImagePicker().pickImage(source: source);

      if (pickImage != null) {
        // image(File(pickImage.path));
        // pictureController.text = pickImage.name;
        final File imageFile = File(pickImage.path);
        final size = await imageFile.length();
        final fileSize = size / (1024 * 1024);
        if (fileSize <= 2) {
          if (isValidExtension(pickImage.path)) {
            image(File(pickImage.path));
            type == 'add'
                ? pictureController.text = pickImage.name
                : updatedImage.value = image.value;
          } else {
            myShowDialog(
              context: Get.context!,
              widgetName: ApiErrorAlert(
                title: 'خطــــــــأ',
                description: 'يجب اختيار صورة من نوع\n[ JPG او PNG او JPEG ]',
              ),
            );
          }
        } else {
          myShowDialog(
            context: Get.context!,
            widgetName: ApiErrorAlert(
              height: 280,
              title: 'خطــــــــأ',
              description: 'يجب ألا يزيد حجم الصورة عن 2 ميجابايت',
            ),
          );
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Error picking file $e');
      myShowDialog(
        context: Get.context!,
        widgetName: ApiErrorAlert(
          title: 'خطــــــــأ',
          description:
              'عذرا، لقد حدث خطأ ما اثناء عملية جلب الصورة من الجهاز\nحاول مرة أخرى',
        ),
      );
    }
  }

  Future addPost(String postTitle, String postDescription) async {
    if (image.value == null) {
      myShowDialog(
        context: Get.context!,
        widgetName: ApiErrorAlert(
          height: 280,
          title: 'خطــــــــأ',
          description: 'يجب اختيار صورة الإعلان',
        ),
      );
      return;
    } else {
      isLoading(true);
      var post = Post(
        postTitle: postTitle,
        postDescription: postDescription,
        postImage: image.value,
      );
      try {
        var request =
            http.MultipartRequest('POST', Uri.parse(ApiEndpoints.addPost))
              ..fields['post_title'] = post.postTitle
              ..fields['post_description'] = post.postDescription;

        if (post.postImage != null) {
          request.files.add(await http.MultipartFile.fromPath(
              'post_image', post.postImage!.path));
        }
        var response = await request.send();
        if (response.statusCode == 201) {
          isLoading(false);
          await fetchPosts();
          clearTextFormFields();
          ApiExceptionAlert().myAddedDataSuccessAlert();

          return;
        } else {
          isLoading(false);

          ApiExceptionAlert()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } on SocketException catch (_) {
        isLoading(false);
        ApiExceptionAlert().mySocketExceptionAlert();
        return null;
      } catch (e) {
        isLoading(false);
        ApiExceptionAlert().myUnknownExceptionAlert(error: e.toString());
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> fetchPosts() async {
    fetchDataFuture.value = Future<void>(() async {
      try {
        isFetchPostsLoading(true);
        final response = await http.get(
          Uri.parse(ApiEndpoints.getPosts),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isFetchPostsLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          List<Post> fetchedPost =
              jsonData.map((e) => Post.fromJson(e)).toList();
          posts.assignAll(fetchedPost);
        } else if (response.statusCode == 500) {
          isFetchPostsLoading(false);
          ApiExceptionAlert().myFetchDataExceptionAlert(response.statusCode);
        } else {
          isFetchPostsLoading(false);
          ApiExceptionAlert()
              .myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } on SocketException catch (_) {
        isFetchPostsLoading(false);
        ApiExceptionAlert().mySocketExceptionAlert();
      } catch (e) {
        isFetchPostsLoading(false);
        ApiExceptionAlert().myUnknownExceptionAlert(error: e.toString());
      } finally {
        isFetchPostsLoading(false);
      }
    });
  }

  Future<void> updatePost(
      int postId, String postTitle, String postDescription) async {
    isUpdatePostsLoading(true);
    var post = Post(
      postTitle: postTitle,
      postDescription: postDescription,
      postImage: updatedImage.value,
    );
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiEndpoints.updatePost}/$postId'));
      request.fields['_method'] = 'PATCH';
      request.fields['post_title'] = post.postTitle;
      request.fields['post_description'] = post.postDescription;

      if (post.postImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'post_image', post.postImage!.path));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        isUpdatePostsLoading(false);
        updatedImage.value = null;
        Get.back();
        await fetchPosts();
        ApiExceptionAlert().myUpdateDataSuccessAlert();

        return;
      } else {
        isUpdatePostsLoading(false);
        ApiExceptionAlert().myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isUpdatePostsLoading(false);
      ApiExceptionAlert().mySocketExceptionAlert();
      return;
    } catch (e) {
      isUpdatePostsLoading(false);
      ApiExceptionAlert().myUnknownExceptionAlert(error: e.toString());
      return;
    } finally {
      isUpdatePostsLoading(false);
    }
  }

  Future<void> deletePost(int postId) async {
    isDeletePostsLoading(true);

    try {
      var request =
          await http.delete(Uri.parse('${ApiEndpoints.deletePost}/$postId'));

      if (request.statusCode == 200) {
        isDeletePostsLoading(false);
        Get.back();
        await fetchPosts();
        ApiExceptionAlert().myDeleteDataSuccessAlert();

        return;
      } else {
        isDeletePostsLoading(false);
        ApiExceptionAlert().myAccessDatabaseExceptionAlert(request.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isDeletePostsLoading(false);
      ApiExceptionAlert().mySocketExceptionAlert();
      return;
    } catch (e) {
      isDeletePostsLoading(false);
      ApiExceptionAlert().myUnknownExceptionAlert(error: e.toString());
      return;
    } finally {
      isDeletePostsLoading(false);
    }
  }
}
