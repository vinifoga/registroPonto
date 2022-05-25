import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registroponto/components/icon_button_text.dart';

import '../models/user.dart';

class SickNote extends StatefulWidget {
  final User user;
  const SickNote({Key? key, required this.user}) : super(key: key);

  @override
  State<SickNote> createState() => _SickNoteState();
}

class _SickNoteState extends State<SickNote> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  bool uploading = false;
  double total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(
        appBarTitle: uploading ? '${total.round()}% enviado' : 'Enviar Arquivo',
        showImage: false,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _showImageOptions(context);
              },
              child: const Card(
                child: ListTile(
                  title: Text('Enviar'),
                  trailing: Icon(Icons.arrow_upward),
                ),
              ),
            ),
            // GestureDetector(
            //   child: Card(
            //     child: ListTile(
            //       title: Text('Data: 02/05/2020'),
            //       trailing: Icon(Icons.remove_red_eye),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _showImageOptions(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButtonText(
                      icon: const Icon(Icons.image),
                      text: "Galeria",
                      function: () async {
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        pickAndUploadImage(image);
                        Navigator.pop(context);
                      },
                    ),
                    IconButtonText(
                      icon: const Icon(Icons.camera_alt),
                      text: "Camera",
                      function: () async {
                        final XFile? image =
                            await _picker.pickImage(source: ImageSource.camera);
                        pickAndUploadImage(image);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            onClosing: () {},
          );
        });
  }

  pickAndUploadImage(XFile? image) async {
    XFile? file = image;
    if(file != null){
      UploadTask task = await upload(file.path);
      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if(snapshot.state == TaskState.running){
          setState(() {
            uploading = true;
            total = (snapshot.bytesTransferred/snapshot.totalBytes) * 100;
          });
        } else  if(snapshot.state == TaskState.running){
          setState(() => uploading = false);
        }
      });
    }
  }

  Future<UploadTask> upload(String path) async {
    File file = File(path);
    try{
      String ref = 'images/img-${widget.user.nome.toString()}-${DateTime.now().toString()}.jpg';
      return storage.ref(ref).putFile(file);
    } on FirebaseException catch(e){
      throw Exception('Erro no upload: ${e.code}');
    }
  }
}
