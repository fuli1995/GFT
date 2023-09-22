import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sentry/sentry.dart';
import '/components/primary_button.dart';
import '/components/basic/loading.dart';
import '/utilities/toast.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<StatefulWidget> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController feedbackController =
      TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController nameController = TextEditingController(text: '');
  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('feedback'.tr),
        ),
        body: Obx(() => isLoading.value
            ? const Loading()
            : Column(children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                              controller: feedbackController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'feedback'.tr,
                              )),
                          const SizedBox(height: 24),
                          TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'email'.tr,
                              )),
                          const SizedBox(height: 24),
                          TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'name'.tr,
                              )),
                        ],
                      ),
                    ],
                  )),
                )),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                          spreadRadius: 0.2,
                        ),
                      ],
                    ),
                    child: SafeArea(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                          Expanded(
                            flex: 1,
                            child: PrimaryButton(
                              onTap: () async {
                                isLoading.value = true;
                                try {
                                  DateTime now = DateTime.now();
                                  String formattedDateTime =
                                      DateFormat('yyyy-MM-dd HH:mm:ss')
                                          .format(now);
                                  SentryId sentryId =
                                      await Sentry.captureMessage(
                                          "feedback-$formattedDateTime");

                                  final userFeedback = SentryUserFeedback(
                                    eventId: sentryId,
                                    comments: feedbackController.value.text,
                                    email: emailController.value.text,
                                    name: nameController.value.text,
                                  );

                                  Sentry.captureUserFeedback(userFeedback);
                                } catch (e) {
                                  isLoading.value = false;
                                  Toast.error('failed'.tr);
                                }

                                isLoading.value = false;

                                Toast.success('updateSuccessful'.tr);

                                Future.delayed(const Duration(seconds: 2))
                                    .then((_) {
                                  Get.back();
                                  // back与snackbar无法同时执行，所以这里延迟3s再返回
                                });
                              },
                              text: 'confirm'.tr,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: PrimaryButton(
                              onTap: () {
                                Get.back();
                              },
                              text: 'cancel'.tr,
                              isWhite: true,
                            ),
                          ),
                        ])))
              ])));
  }
}
