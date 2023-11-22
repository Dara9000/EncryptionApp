// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/eyeShape.dart';
import '../model/okayProceedButton.dart';
import 'encryptConfig.dart';

pickAFileFun(BuildContext context) async {
  final globalKey = GlobalKey();
  await Provider.of<EncryptionConfig>(context, listen: false).pickFile();
  bool chosenFilePath = Provider.of<EncryptionConfig>(context, listen: false)
      .chosenFilePath
      .isNotEmpty;
  if (chosenFilePath) {
    showDialog(
      context: context,
      builder: (cont) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(2),
          content: EyeShape(
            backGround: Colors.black54,
            borderColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const ChosenFileName(),
                    const DividerTransparent(), // Divider
                    const PasswordTextEditField(),
                    const DividerTransparent(), // Divider
                    SaveFilePath(globalKey: globalKey),
                    const DividerTransparent(), // Divider
                    okayProceedButton(context: context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  // await consumer.pickFile();
}

class DividerTransparent extends StatelessWidget {
  const DividerTransparent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.transparent,
    );
  }
}

class SaveFilePath extends StatelessWidget {
  const SaveFilePath({
    Key? key,
    required this.globalKey,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> globalKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        width: double.infinity,
        child: EyeShape(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Save to original Folder ',
                    style: TextStyle(color: Colors.green),
                  ),
                  Consumer<EncryptionConfig>(
                    builder: (context, consumer, child) => Checkbox(
                        side: const BorderSide(color: Colors.green),
                        activeColor: Colors.transparent,
                        checkColor: Colors.green,
                        value: consumer.saveToDefaultPath,
                        onChanged: (va) {
                          consumer.changeSaveToDefaultPath(va!);
                        }),
                  ),
                  const Text(
                    ' | ',
                    style: TextStyle(color: Colors.green),
                  ),
                  IconButton(
                      key: globalKey,
                      onPressed: () {
                        final renderBox = globalKey.currentContext!
                            .findRenderObject() as RenderBox;
                        final position = renderBox.localToGlobal(Offset.zero);
                        showMenu(
                            elevation: 0,
                            color: Colors.transparent,
                            context: context,
                            position: RelativeRect.fromLTRB(
                                position.dx, position.dy, 0, 0),
                            items: [
                              PopupMenuItem(
                                  value: '',
                                  child: EyeShape(
                                    backGround: Colors.black45,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const Icon(
                                                Icons
                                                    .download_for_offline_outlined,
                                                color: Colors.green,
                                              ),
                                              Text(
                                                  style: const TextStyle(
                                                      color: Colors.green),
                                                  ' ${Provider.of<EncryptionConfig>(context, listen: false).selectedRootFolderPath.toString()}'),
                                            ],
                                          ),
                                        )),
                                  )),
                            ]);
                      },
                      icon: const Icon(
                        Icons.info_outline,
                        color: Colors.green,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordTextEditField extends StatelessWidget {
  const PasswordTextEditField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: EyeShape(
        child: Consumer<EncryptionConfig>(
          builder: (BuildContext context, consumer, Widget? child) {
            return TextField(
              controller: consumer.tec,
              cursorColor: Colors.green,
              style: const TextStyle(color: Colors.green),
              onChanged: (value) {
                if (value.toString().isNotEmpty) {
                  consumer.tecTrue();
                }
              },
              decoration: InputDecoration(
                hintText:
                    consumer.tecEmpty ? 'Password here!' : 'must be filled in!',
                hintStyle: consumer.tecEmpty
                    ? const TextStyle(color: Colors.green)
                    : const TextStyle(color: Colors.red),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                suffixIcon: !consumer.tecEmpty
                    ? const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.pending_outlined,
                        color: Colors.green,
                      ),
                prefixText: 'Psword: ',
                prefixStyle: const TextStyle(color: Colors.green),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChosenFileName extends StatelessWidget {
  const ChosenFileName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        width: double.infinity,
        child: EyeShape(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                Provider.of<EncryptionConfig>(context).chosenFilePathName,
                style: const TextStyle(color: Colors.green),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
