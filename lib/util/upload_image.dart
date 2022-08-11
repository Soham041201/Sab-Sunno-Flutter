import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

FirebaseStorage _storage = FirebaseStorage.instance;

Future<XFile?> uploadPic() async {
  final file = await ImagePicker().pickImage(source: ImageSource.gallery);
  return Future<XFile?>.value(file);
}

Future<String> uploadFile() async {
  XFile? file = await uploadPic();

  UploadTask uploadTask;

  // Create a Reference to the file
  Reference ref = FirebaseStorage.instance
      .ref()
      .child('/images')
      .child(file?.name ?? 'image.jpg');

  final metadata = SettableMetadata(
    contentType: 'image/jpeg',
    customMetadata: {'picked-file-path': file!.path},
  );

  await ref.putFile(File(file.path), metadata);

  return ref.getDownloadURL();
}
