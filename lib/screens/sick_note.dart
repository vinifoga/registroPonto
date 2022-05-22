import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registroponto/components/icon_button_text.dart';

class SickNote extends StatefulWidget {
  const SickNote({Key? key}) : super(key: key);

  @override
  State<SickNote> createState() => _SickNoteState();
}

class _SickNoteState extends State<SickNote> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRp(
        appBarTitle: 'Últimos Enviados',
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
      await upload(file.path);
    }
  }

  Future<void> upload(String path) async {
    File file = File(path);
    try{
      String ref = 'images/img-${DateTime.now().toString()}.jpg';
      await storage.ref(ref).putFile(file);
    } on FirebaseException catch(e){
      throw Exception('Erro no upload: ${e.code}');
    }
  }
}
