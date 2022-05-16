import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poll_dashboard/app/core/widget/CustomTextFormField.dart';
import 'package:poll_dashboard/app/core/widget/loading_button.dart';
import 'package:poll_dashboard/app/modules/login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                fit: BoxFit.fill,
                opacity: .3,
                image: AssetImage(
                  'assets/flag_of_pakistan.png',
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 50,
                      ),
                      child: Image.asset(
                        'assets/logo.jpg',
                        height: 150,
                        width: 150,
                      ),
                    ),
                    Obx(() => CustomTextFormFiled(
                          label: 'Username'.tr,
                          prefixIcon: const Icon(Icons.person),
                          onChange: (v) => controller.username = v,
                          keyboardType: TextInputType.name,
                          errorText: controller.isUsernameError
                              ? 'The Username is not enough.'.tr
                              : null,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    ValueBuilder<bool?>(
                      initialValue: true,
                      builder: (value, update) => Obx(
                        () => CustomTextFormFiled(
                          label: 'Password'.tr,
                          obscureText: value!,
                          onChange: (v) => controller.password = v,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: const Icon(Icons.lock),
                          errorText: controller.isPasswordError
                              ? 'The password is not enough.'.tr
                              : null,
                          suffixIcon: IconButton(
                            icon: value == false
                                ? const Icon(Icons.remove_red_eye)
                                : const Icon(Icons.visibility_off_outlined),
                            onPressed: () => update(!value),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Obx(
                      () => LoadingButton(
                          text: 'Login'.tr,
                          onClick: controller.login,
                          isLoading: controller.isLoading),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
