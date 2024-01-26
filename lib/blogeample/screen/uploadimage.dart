import 'dart:io';

import 'package:blogapp/blogeample/components/round_button.dart';
import 'package:blogapp/blogeample/components/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final postref = FirebaseDatabase.instance.ref().child('Post');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final discriptionController = TextEditingController();
  File? image;
  final picker = ImagePicker();
  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('no pick any file');
      }
    });
  }

  Future getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('no pick any file');
      }
    });
  }

  void dialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getCameraImage();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      title: Text("Camera"),
                      leading: Icon(Icons.camera),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getGalleryImage();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      title: Text("Gallery"),
                      leading: Icon(Icons.browse_gallery),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text("Upload Image"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    dialog();
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 130,
                        width: 400,
                        child: image != null
                            ? ClipRect(
                                child: Image.file(
                                  image!.absolute,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade200),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Title"),
                    hintText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter title';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: 5,
                  controller: discriptionController,
                  decoration: InputDecoration(
                      label: Text("Enter Discription"),
                      hintText: 'Discription',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                RoundButton(
                    title: "Upload Image",
                    onPressed: () async {
                      try {
                        int date = DateTime.now().microsecondsSinceEpoch;
                        firebase_storage.Reference ref = firebase_storage
                            .FirebaseStorage.instance
                            .ref('/blogapp$date');
                        UploadTask uploadTask = ref.putFile(image!.absolute);
                        await Future.value(uploadTask);
                        var newUrl = await ref.getDownloadURL();
                        final user = auth.currentUser;
                        postref.child('Post List').child(date.toString()).set({
                          'pid': date.toString(),
                          'pUrl': newUrl.toString(),
                          'ptitle': titleController.text.toString(),
                          'pdiscription': discriptionController.text.toString(),
                          'pEmail': user!.email.toString()
                        }).then((value) {
                          Util().toastMessage('Upload Successful');
                        }).onError((error, stackTrace) {
                          Util().toastMessage(error.toString());
                        });
                      } catch (e) {
                        Util().toastMessage(e.toString());
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
