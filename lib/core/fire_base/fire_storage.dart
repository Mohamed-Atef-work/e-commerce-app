import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageService {
  Future<Reference> uploadFile({
    required File file,
    required String collectionName,
  });
  Future<String> downloadUrl(Reference reference);
}

class StorageServiceImpl implements StorageService {
  final FirebaseStorage storage;

  StorageServiceImpl(this.storage);
  @override
  Future<Reference> uploadFile({
    required File file,
    required String collectionName,
  }) async {
    final fileLastSegment = Uri.file(file.path).pathSegments.last;
    final Reference storageReference =
        storage.ref().child("$collectionName$fileLastSegment");
    await storageReference.putFile(file);
    return storageReference;
  }

  @override
  Future<String> downloadUrl(Reference reference) async {
    return await reference.getDownloadURL();
  }
}
