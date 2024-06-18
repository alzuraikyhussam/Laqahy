import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/models/home_model.dart';
import 'package:laqahy/view/widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/icons/my_flutter_app_icons.dart';

class Constants {
  AudioPlayer audioPlayer = AudioPlayer();

  successAudio() {
    audioPlayer.play(AssetSource('sounds/success.mp3'));
  }

  errorAudio() {
    // audioPlayer.play(AssetSource('sounds/joke-error.m4a'));
    audioPlayer.play(AssetSource('sounds/error.mp3'));
  }

  static List adminHomeLayoutItems = [
    HomeLayoutListItem(
      imageName: 'assets/icons/home-gr.png',
      label: 'الرئيسية',
      imageNameFocused: 'assets/icons/home-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/emp-gr.png',
      label: 'المستخدمين',
      imageNameFocused: 'assets/icons/emp-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/centers-accounts-gr.png',
      label: 'حسابات المراكز',
      imageNameFocused: 'assets/icons/centers-accounts-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/vaccines-gr.png',
      label: 'اللقاحات',
      imageNameFocused: 'assets/icons/vaccines-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/order-gr.png',
      label: 'الطلبات',
      imageNameFocused: 'assets/icons/order-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/posts-gr.png',
      label: 'الإعلانات',
      imageNameFocused: 'assets/icons/posts-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/reports-gr.png',
      label: 'التقارير',
      imageNameFocused: 'assets/icons/reports-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/info-gr.png',
      label: 'حول النظام',
      imageNameFocused: 'assets/icons/info-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/support-gr.png',
      label: 'الدعم الفني',
      imageNameFocused: 'assets/icons/support-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/logout.png',
      label: 'تسجيل الخروج',
      imageNameFocused: 'assets/icons/logout.png',
    ),
  ];

  static List userHomeLayoutItems = [
    HomeLayoutListItem(
      imageName: 'assets/icons/home-gr.png',
      label: 'الرئيسية',
      imageNameFocused: 'assets/icons/home-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/order-gr.png',
      label: 'الطلبات',
      imageNameFocused: 'assets/icons/order-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/posts-gr.png',
      label: 'الإعلانات',
      imageNameFocused: 'assets/icons/posts-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/info-gr.png',
      label: 'حول النظام',
      imageNameFocused: 'assets/icons/info-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/support-gr.png',
      label: 'الدعم الفني',
      imageNameFocused: 'assets/icons/support-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/logout.png',
      label: 'تسجيل الخروج',
      imageNameFocused: 'assets/icons/logout.png',
    ),
  ];

  /////////////
  String? cityValidator(value) {
    if (value == null) {
      return 'قم باختيار المحافظة';
    }
    return null;
  }

//////////
  String? directorateValidator(value) {
    if (value == null) {
      return 'قم باختيار المديرية';
    }
    return null;
  }

  /////////////
  String? genderValidator(value) {
    if (value == null) {
      return 'قم باختيار الجنس';
    }
    return null;
  }

  /////////////

  String? permissionValidator(value) {
    if (value == null) {
      return 'قم باختيار نوع الصلاحية';
    }
    return null;
  }

  final TextEditingController directoratesSearchController =
      TextEditingController();
  final TextEditingController citySearchController = TextEditingController();
  final TextEditingController permissionSearchController =
      TextEditingController();
  final TextEditingController genderSearchController = TextEditingController();
  final TextEditingController officeSearchController = TextEditingController();

  Widget gendersDropdownMenu() {
    final StaticDataController controller = Get.find<StaticDataController>();

    return Obx(() {
      if (controller.isGenderLoading.value) {
        return myDropDownMenuButton2(
          hintText: 'الجنــس',
          items: [
            DropdownMenuItem<String>(
              child: Center(
                child: myLoadingIndicator(),
              ),
            ),
          ],
          onChanged: null,
          searchController: null,
          selectedValue: null,
          validator: genderValidator,
        );
      }

      if (controller.genderErrorMsg.isNotEmpty) {
        return InkWell(
          onTap: () {
            Constants().errorAudio();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'حدث خطأ ما',
                  description: controller.genderErrorMsg.value,
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    controller.fetchGenders();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'الجنــس',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: genderValidator,
          ),
        );
      }

      if (controller.genders.isEmpty) {
        return InkWell(
          onTap: () {
            Constants().errorAudio();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'لا تـــوجد بيـــانات',
                  description: 'عذرا، لم يتم العثور على بيانات',
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    controller.fetchGenders();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'الجنــس',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: genderValidator,
          ),
        );
      }

      return myDropDownMenuButton2(
        hintText: 'الجنــس',
        validator: genderValidator,
        items: controller.genders.map((element) {
          return DropdownMenuItem(
            value: element.id.toString(),
            child: Text(
              element.type,
              style: MyTextStyles.font16BlackMedium,
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            controller.selectedGenderId.value = int.tryParse(value);
          } else {
            controller.selectedGenderId.value = null;
          }
        },
        searchController: genderSearchController,
        selectedValue: controller.selectedGenderId.value?.toString(),
      );
    });
  }

  Widget permissionsDropdownMenu() {
    final StaticDataController controller = Get.find<StaticDataController>();

    return Obx(() {
      if (controller.isPermissionLoading.value) {
        return myDropDownMenuButton2(
          hintText: 'نوع الصلاحية',
          items: [
            DropdownMenuItem<String>(
              child: Center(
                child: myLoadingIndicator(),
              ),
            ),
          ],
          onChanged: null,
          searchController: null,
          selectedValue: null,
          validator: permissionValidator,
        );
      }

      if (controller.permissionErrorMsg.isNotEmpty) {
        return InkWell(
          onTap: () {
            Constants().errorAudio();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'حدث خطأ ما',
                  description: controller.permissionErrorMsg.value,
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    controller.fetchPermissions();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'نوع الصلاحية',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: permissionValidator,
          ),
        );
      }

      if (controller.permissions.isEmpty) {
        return InkWell(
          onTap: () {
            Constants().errorAudio();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'لا تـــوجد بيـــانات',
                  description: 'عذرا، لم يتم العثور على بيانات',
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    controller.fetchPermissions();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'نوع الصلاحية',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: permissionValidator,
          ),
        );
      }

      return myDropDownMenuButton2(
        hintText: 'نوع الصلاحية',
        validator: permissionValidator,
        items: controller.permissions.map((element) {
          return DropdownMenuItem(
            value: element.id.toString(),
            child: Text(
              element.permissionType,
              style: MyTextStyles.font16BlackMedium,
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            controller.selectedPermissionId.value = int.tryParse(value);
          } else {
            controller.selectedPermissionId.value = null;
          }
        },
        searchController: permissionSearchController,
        selectedValue: controller.selectedPermissionId.value?.toString(),
      );
    });
  }

  Widget citiesDropdownMenu() {
    final StaticDataController controller = Get.find<StaticDataController>();

    return Obx(() {
      if (controller.isCityLoading.value) {
        return myDropDownMenuButton2(
          hintText: 'المحافظة',
          items: [
            DropdownMenuItem<String>(
              child: Center(
                child: myLoadingIndicator(),
              ),
            ),
          ],
          onChanged: null,
          searchController: null,
          validator: cityValidator,
          selectedValue: null,
        );
      }

      if (controller.cityErrorMsg.isNotEmpty) {
        return InkWell(
          onTap: () {
            Constants().errorAudio();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'حدث خطأ ما',
                  description: controller.cityErrorMsg.value,
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    controller.fetchCities();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'المحافظة',
            items: null,
            onChanged: null,
            searchController: null,
            validator: cityValidator,
            selectedValue: null,
          ),
        );
      }

      if (controller.cities.isEmpty) {
        return InkWell(
          onTap: () {
            Constants().errorAudio();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'لا تـــوجد بيـــانات',
                  description: 'عذرا، لم يتم العثور على بيانات',
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    controller.fetchCities();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'المحافظة',
            items: null,
            onChanged: null,
            validator: cityValidator,
            searchController: null,
            selectedValue: null,
          ),
        );
      }

      return myDropDownMenuButton2(
        hintText: 'المحافظة',
        validator: cityValidator,
        items: controller.cities.map((element) {
          return DropdownMenuItem(
            value: element.id.toString(),
            child: Text(
              element.name,
              style: MyTextStyles.font16BlackMedium,
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            controller.selectedCityId.value = int.tryParse(value);
            controller.fetchDirectorates(controller.selectedCityId.value!);
            controller.selectedDirectorateId.value = null;
          } else {
            controller.selectedCityId.value = null;
          }
        },
        searchController: citySearchController,
        selectedValue: controller.selectedCityId.value?.toString(),
      );
    });
  }

  Widget directoratesDropdownMenu() {
    final StaticDataController controller = Get.find<StaticDataController>();

    return Obx(() {
      if (controller.selectedCityId.value == null) {
        return InkWell(
          onTap: () {
            Constants().errorAudio();

            myShowDialog(
              context: Get.context!,
              widgetName: ApiExceptionAlert(
                title: 'تنبيــه',
                description: 'من فضلك، قم باختيار المحافظة أولاً',
                height: 280,
              ),
            );
          },
          child: myDropDownMenuButton2(
            hintText: 'المديرية',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: directorateValidator,
          ),
        );
      } else if (controller.isDirectorateLoading.value) {
        return myDropDownMenuButton2(
          hintText: 'المديرية',
          items: [
            DropdownMenuItem<String>(
              child: Center(
                child: myLoadingIndicator(),
              ),
            ),
          ],
          onChanged: null,
          searchController: null,
          selectedValue: null,
          validator: directorateValidator,
        );
      } else if (controller.directorateErrorMsg.isNotEmpty) {
        return InkWell(
          onTap: () {
            Constants().errorAudio();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'حدث خطأ ما',
                  description: controller.directorateErrorMsg.value,
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    controller
                        .fetchDirectorates(controller.selectedCityId.value!);
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'المديرية',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: directorateValidator,
          ),
        );
      } else if (controller.directorates.isEmpty) {
        return InkWell(
          onTap: () {
            Constants().errorAudio();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'لا تـــوجد بيـــانات',
                  description: 'عذرا، لم يتم العثور على بيانات',
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    controller
                        .fetchDirectorates(controller.selectedCityId.value!);
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'المديرية',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: directorateValidator,
          ),
        );
      } else {
        return myDropDownMenuButton2(
          hintText: 'المديرية',
          validator: directorateValidator,
          items: controller.directorates.map((element) {
            return DropdownMenuItem(
              value: element.id.toString(),
              child: Text(
                element.name,
                style: MyTextStyles.font16BlackMedium,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              controller.selectedDirectorateId.value = int.tryParse(value);
            } else {
              controller.selectedCityId.value = null;
            }
          },
          searchController: directoratesSearchController,
          selectedValue: controller.selectedDirectorateId.value?.toString(),
        );
      }
    });
  }
}
