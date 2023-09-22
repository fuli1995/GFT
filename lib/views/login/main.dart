import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/data/controller/user.dart';
import '/components/primary_button.dart';
import '/components/basic/loading.dart';
import '/utilities/toast.dart';
import '/config/color.dart';

class LoginInput extends StatelessWidget {
  final TextEditingController inputController;
  final IconData icon;
  final String? hintText;
  final bool? obscureText;
  final IconButton? suffixIcon;
  final void Function(String)? onChanged;

  const LoginInput(
      {super.key,
      required this.inputController,
      required this.icon,
      this.hintText,
      this.obscureText,
      this.onChanged,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon, color: Colors.grey),
            ),
            Expanded(
              child: TextField(
                controller: inputController,
                onChanged: onChanged,
                obscureText: obscureText ?? false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: suffixIcon,
                ),
              ),
            ),
          ],
        ));
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController usernameController =
      TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final UserController userController = Get.find();

  final RxString username = ''.obs;
  final RxString password = ''.obs;
  final RxBool disabled = true.obs;

  void updateDisabled(v) {
    disabled.value = username.value == '' || password.value == '';
  }

  @override
  void initState() {
    super.initState();

    usernameController.text = userController.account.value;
    username.value = userController.account.value;
    passwordController.text = userController.password.value;
    password.value = userController.password.value;
    updateDisabled('');
    everAll([password, username], updateDisabled);
  }

  @override
  Widget build(BuildContext context) {
    RxBool obscureText = true.obs;

    // 当键盘弹出式，隐藏logo来解决布局溢出问题。为避免太过频繁的赋值，将高度100作为边界条件，且只有当值需要改变时才赋值
    final bool isKeyboardVisible =
        MediaQuery.of(context).viewInsets.bottom > 100;
    if (userController.isFocusedOnInput.value != isKeyboardVisible) {
      userController.isFocusedOnInput.value = isKeyboardVisible;
    }
    return Obx(() => userController.isLoading.value
        ? Container(color: C.white, child: const Loading())
        : Material(
            child: Flex(direction: Axis.vertical, children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                color: C.red,
                image: const DecorationImage(
                  image: AssetImage('assets/icons/top_visual.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: C.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    transform: Matrix4.translationValues(0, -20, 0),
                    child: Column(
                      children: <Widget>[
                        if (userController.isFocusedOnInput.value == false)
                          const Image(
                            image: AssetImage('assets/icons/text_logo.png'),
                            width: 150,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        if (userController.isFocusedOnInput.value == false)
                          const SizedBox(height: 20),
                        Column(
                          children: [
                            LoginInput(
                                inputController: usernameController,
                                onChanged: (v) {
                                  username.value = v;
                                },
                                icon: Icons.account_circle_outlined,
                                hintText: 'accountHint'.tr),
                            const SizedBox(height: 20),
                            Obx(
                              () => LoginInput(
                                  inputController: passwordController,
                                  onChanged: (v) {
                                    password.value = v;
                                  },
                                  icon: Icons.lock_outlined,
                                  obscureText: obscureText.value,
                                  hintText: 'passwordHint'.tr,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscureText.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: obscureText.value
                                          ? Colors.grey
                                          : Colors.blue,
                                    ),
                                    onPressed: () {
                                      obscureText.value = !obscureText.value;
                                    },
                                  )),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: userController.rememberAccount.value,
                                  onChanged: (value) {
                                    userController.rememberAccount.value =
                                        value ?? false;
                                  },
                                ),
                                Text('rememberAccount'.tr,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                        SafeArea(
                            child: SizedBox(
                                width: double.infinity,
                                child: PrimaryButton(
                                  text: 'login'.tr,
                                  size: 'large',
                                  disabled: disabled.value,
                                  onTap: () async {
                                    var res = await userController.login(
                                        usernameController.value.text,
                                        passwordController.value.text);
                                    if (res) {
                                      Toast.success('loginSuccessful'.tr);
                                      Get.offNamed('/');
                                    }
                                  },
                                )))
                      ],
                    )))
          ])));
  }
}
