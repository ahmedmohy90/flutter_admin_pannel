import 'dart:io';
import 'dart:typed_data';

import 'package:admin_pannel/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String filename;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

  final DropzoneFileInterface? file;
  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;

  ImageModel(
      {this.id = '',
      this.mediaCategory = '',
      this.sizeBytes,
      this.fullPath,
      this.createdAt,
      this.updatedAt,
      this.contentType,
      this.file,
      required this.url,
      required this.folder,
      required this.filename,
      this.localImageToDisplay});

  static ImageModel empty() => ImageModel(
      contentType: "",
      file: null,
      url: "",
      folder: "",
      filename: "",
      localImageToDisplay: Uint8List(0));

  String get createdAtFormatted => TFormatter.formatDate(createdAt);

  String get updatedAtFormatted => TFormatter.formatDate(updatedAt);

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'folder': folder,
      'sizeBytes': sizeBytes,
      'mediaCategory': mediaCategory,
      'filename': filename,
      'fullPath': fullPath,
      'createdAt': createdAt,
      'contentType': contentType,
    };
  }

  factory ImageModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;
      return ImageModel(
        id: doc.id,
        url: data['url'] ?? "",
        folder: data['folder'] ?? "",
        sizeBytes: data['sizeBytes'] ?? 0,
        mediaCategory: data['mediaCategory'],
        filename: data['filename'] ?? "",
        fullPath: data['fullPath'] ?? "",
        createdAt: data['createdAt'] is Timestamp
            ? (data['createdAt'] as Timestamp).toDate()
            : null,
        updatedAt: data['updatedAt'] is Timestamp
            ? (data['updatedAt'] as Timestamp).toDate()
            : null,
        contentType: data['contentType'] ?? "",
      );
    } else {
      return ImageModel.empty();
    }
  }

  factory ImageModel.fromFirebaseMetaData(FullMetadata metadata, String folder,
      String filename, String downloadUrl) {
    return ImageModel(
      url: downloadUrl,
      folder: folder,
      filename: filename,
      sizeBytes: metadata.size,
      updatedAt: metadata.updated,
      fullPath: metadata.fullPath,
      createdAt: metadata.timeCreated,
      contentType: metadata.contentType!,
    );
  }
}
