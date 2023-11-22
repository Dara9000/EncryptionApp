import 'dart:io';
import 'package:file_cryptor/file_cryptor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

class EncryptionConfig extends ChangeNotifier {
  final String defaultPath = '/storage/emulated/0/Enc&Dec';
  String selectedRootFolderPath = '/storage/emulated/0/Enc&Dec';
  bool saveToDefaultPath = true;
  bool doneNotification = false;
  TextEditingController tec = TextEditingController(text: '');
  bool tecEmpty = true;
  String chosenFilePath = '';
  String chosenFilePathName = '';
  bool errorOccured = false;

  tecFalse() {
    tecEmpty = false;
    notifyListeners();
  }

  tecTrue() {
    tecEmpty = true;
    notifyListeners();
  }

  doneNotificationTrue() {
    doneNotification = true;
    notifyListeners();
  }

  doneNotificationFalse() {
    doneNotification = false;
    notifyListeners();
  }

  changeSaveToDefaultPath(bool value) {
    if (value) {
      selectedRootFolderPath = defaultPath;
      saveToDefaultPath = true;
    } else {
      selectRootFolder();
      saveToDefaultPath = false;
    }
    notifyListeners();
  }

  Future<bool> requestPermission() async {
    await Permission.storage.request();
    bool tempo = await Permission.storage.status.isGranted;
    return tempo;
  }

  selectRootFolder() async {
    // Making a default Folder just in case!
    await Directory(defaultPath).create(recursive: true);
    // Getting the necessary permission in term of Storage reachability
    await requestPermission().toString();
    // Selecting the path of the folder user wants:
    try {
      String? folderPickerPath = await FilePicker.platform
          .getDirectoryPath(dialogTitle: 'Select the Root Folder');
      String mainFolderPath =
          folderPickerPath!.isEmpty ? defaultPath : folderPickerPath.toString();
      await Directory(mainFolderPath).create(recursive: true);
      selectedRootFolderPath = mainFolderPath.toString();
      debugPrint(selectedRootFolderPath);
      // EyeCheck.value = false;
    } catch (catcho) {
      selectedRootFolderPath = defaultPath;
      debugPrint(selectedRootFolderPath);
    }
  }

  decrypt({
    required String password,
  }) async {
    await requestPermission();
    if (chosenFilePath != null) {
      Directory parentFolder = File(chosenFilePath).parent;
      File file = File(chosenFilePath);
      String fileName = basename(file.path);
      FileCryptor fileCryptor = await FileCryptor(
        key: password,
        iv: 16,
        dir: parentFolder.path,
      );
      String outputEncryptedFile = selectedRootFolderPath.isEmpty
          ? "$defaultPath/$fileName.crt"
          : '$selectedRootFolderPath/$fileName';
      outputEncryptedFile =
          outputEncryptedFile.replaceAll('.crt', '').replaceAll(' ', '');
      try {
        File decryptedFile = await fileCryptor.decrypt(
            inputFile: chosenFilePath, outputFile: outputEncryptedFile);
      } catch (e) {
        errorOccured = true;
      }
    } else {
      // User canceled the picker
    }
    doneNotification = true;
    notifyListeners();
  }

  pickFile() async {
    // await selectRootFolder();
    await requestPermission();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String filePath = result.paths.first.toString();
      Directory parentFolder = File(filePath).parent;
      PlatformFile file = result.files.first;
      chosenFilePath = result.files.first.path.toString();
      chosenFilePathName = result.files.first.name.toString();
      debugPrint(result.files.first.path.toString());
    } else {
      // User canceled the picker
    }
  }

  encrypt({
    required String password,
  }) async {
    await requestPermission();
    if (chosenFilePath.isNotEmpty) {
      Directory parentFolder = File(chosenFilePath).parent;
      File file = File(chosenFilePath);
      String fileName = basename(file.path);
      FileCryptor fileCryptor = FileCryptor(
        key: password,
        iv: 16,
        dir: parentFolder.path,
      );
      String outputEncryptedFile = selectedRootFolderPath.isEmpty
          ? "$defaultPath/$fileName .crt"
          : '$selectedRootFolderPath/$fileName.crt';
      try {
        File encryptedFile = await fileCryptor.encrypt(
          inputFile: chosenFilePath,
          outputFile: outputEncryptedFile,
        );
      } catch (e) {
        errorOccured = true;
      }
    } else {
      // User canceled the picker
    }
    doneNotification = true;
    notifyListeners();
  }
}
