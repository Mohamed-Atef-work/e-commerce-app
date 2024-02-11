import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageService {
  Future<String> downloadUrl(Reference reference);
  Future<Reference> uploadFile(
      {required File file, required String collectionName});
}

class StorageServiceImpl implements StorageService {
  final FirebaseStorage storage;

  StorageServiceImpl(this.storage);
  @override
  Future<Reference> uploadFile({
    required String collectionName,
    required File file,
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
