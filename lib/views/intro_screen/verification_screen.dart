import 'package:chat_app/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../const/strings.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    var controller = Get.put(AuthController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: "Lets Connect".text.size(19).bold.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your username";
                        } else if (value.length < 6) {
                          return "Username cannot be less than 6 characters";
                        }
                        return null;
                      },
                      controller: controller.usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Vx.gray400,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Vx.gray400,
                            )),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 9, 97, 221),
                        ),
                        labelText: "Username",
                        hintText: "Enter your Username",
                        labelStyle: const TextStyle(
                          color: Vx.gray600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    10.heightBox,
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Number";
                        } else if (value.length < 10) {
                          return "Number should be of 10 digits";
                        }
                        return null;
                      },
                      controller: controller.phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Vx.gray400,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Vx.gray400,
                            )),
                        prefixIcon: const Icon(
                          Icons.phone_android_outlined,
                          color: Color.fromARGB(255, 9, 97, 221),
                        ),
                        labelText: "Phone Number",
                        prefixText: "+91",
                        hintText: "Enter your phone number",
                        labelStyle: const TextStyle(
                          color: Vx.gray600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              10.heightBox,
              otp.text.size(12).make(),
              Obx(
                () => Visibility(
                  visible: controller.isOtpSent.value,
                  child: SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          6,
                          (index) => SizedBox(
                                width: 56,
                                child: TextField(
                                  controller: controller.otpcontroller[index],
                                  maxLength: 1,
                                  onChanged: (value) {
                                    if (value.length == 1 && index < 5)
                                      node.nextFocus();
                                    else if (value.isEmpty && index > 0)
                                      node.previousFocus();
                                  },
                                  cursorColor: Vx.purple600,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Vx.gray800,
                                  ),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Vx.gray800,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Vx.gray800,
                                      ),
                                    ),
                                    hintText: "*",
                                  ),
                                ),
                              )),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: context.screenWidth - 80,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[400],
                        textStyle: const TextStyle()),
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        if (controller.isOtpSent.value == false) {
                          controller.isOtpSent.value = true;
                          await controller.sendOtp();
                        } else {
                          await controller.verifyOtp(context);
                        }
                      }

                      // Get.to(() => const HomeScreen(),
                      //     transition: Transition.downToUp);
                    },
                    child: continueText.text
                        .color(Colors.white)
                        .size(16)
                        .semiBold
                        .make()),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
