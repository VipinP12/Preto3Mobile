import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DounloadPDF {
  final progressNotifier = ValueNotifier<double?>(0);
  File? file;
  Future<void> startDownloading(String url) async {
    progressNotifier.value = null;
    final request = Request('GET', Uri.parse(url));
    final StreamedResponse response = await Client().send(request);

    final contentLength = response.contentLength;

    progressNotifier.value = 0;

    List<int> bytes = [];

    file = await _getFile(url.substring(url.lastIndexOf("/") + 1));
    response.stream.listen(
      (List<int> newBytes) {
        bytes.addAll(newBytes);
        final downloadedLength = bytes.length;
        progressNotifier.value = downloadedLength / contentLength!;
      },
      onDone: () async {
        progressNotifier.value = 0;
        await file?.writeAsBytes(bytes);
      },
      onError: (e) {
        debugPrint(e);
      },
      cancelOnError: true,
    );
  }

  Future<File> startDownloadingInCommunication(String url) async {
    progressNotifier.value = null;
    final request = Request('GET', Uri.parse(url));
    final StreamedResponse response = await Client().send(request);

    final contentLength = response.contentLength;

    progressNotifier.value = 0;

    List<int> bytes = [];

    file = await _getFile(url.substring(url.lastIndexOf("/") + 1));
    response.stream.listen(
      (List<int> newBytes) {
        bytes.addAll(newBytes);
        final downloadedLength = bytes.length;
        progressNotifier.value = downloadedLength / contentLength!;
      },
      onDone: () async {
        progressNotifier.value = 0;
        await file?.writeAsBytes(bytes);
      },
      onError: (e) {
        debugPrint(e);
      },
      cancelOnError: true,
    );
    return file!;
  }

  Future<File?> _getFile(String filename) async {
    File? file;
    if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      file = File('${dir.path}/$filename');
    }
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        const downloadsFolderPath = '/storage/emulated/0/Download/';
        Directory dir = Directory(downloadsFolderPath);
        file = File('${dir.path}/$filename');
      }
    }
    return file;
  }

  Future<bool> isCommunicationDownloadFileExist(String filename) async {
    File? file;
    if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      file = File('${dir.path}/$filename');
    }
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        const downloadsFolderPath = '/storage/emulated/0/Download/';
        Directory dir = Directory(downloadsFolderPath);
        file = File('${dir.path}/$filename');
      }
    }
    if (file == null) {
      return false;
    }
    bool flag = file.existsSync();
    return flag;
  }
}
