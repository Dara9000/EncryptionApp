import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'encryptConfig.dart';

okayProceedButtonFun({required BuildContext context}) {
  TextEditingController? tec =
      Provider.of<EncryptionConfig>(context, listen: false).tec;

  if (tec.text.isNotEmpty) {
    var bytes = utf8.encode(tec.text.toString()); // data being hashed
    var digest = sha1.convert(bytes);
    Navigator.pop(context);
    String tempPassword = digest.toString().substring(0, 32);
    debugPrint(tempPassword);

    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Consumer<EncryptionConfig>(
          builder: (BuildContext context, consumer, Widget? child) {
            return AlertDialog(
              backgroundColor: Colors.black45,
              content: !consumer.doneNotification
                  ? AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          ' Processing!',
                          textStyle: const TextStyle(color: Colors.green),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      onNextBeforePause: (p0, p1) async {
                        consumer.errorOccured = false;
                        if (consumer.chosenFilePath.contains('.crt')) {
                          consumer.decrypt(password: tempPassword.toString());
                        } else {
                          consumer.encrypt(password: tempPassword.toString());
                        }
                      },
                      totalRepeatCount: 1,
                    )
                  : !consumer.errorOccured
                      ? TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            consumer.doneNotificationFalse();
                          },
                          icon: const Icon(Icons.verified_user_outlined,
                              color: Colors.green),
                          label: const Text(
                            'Completed!',
                            style: TextStyle(color: Colors.green),
                          ))
                      : TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            consumer.doneNotificationFalse();
                          },
                          icon: const Icon(Icons.error_outline,
                              color: Colors.red),
                          label: const Text(
                            'Unfortunately! try again',
                            style: TextStyle(color: Colors.red),
                          )),
            );
          },
        );
      },
    );
  } else {
    debugPrint('Empty');
    Provider.of<EncryptionConfig>(context, listen: false).tecFalse();
  }
}
