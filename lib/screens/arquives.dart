import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registroponto/components/icon_button_text.dart';
import 'dart:io';
import 'dart:async';

import '../models/user.dart';

class Arquives extends StatefulWidget {
  const Arquives({Key? key}) : super(key: key);

  @override
  State<Arquives> createState() => _ArquivesState();
}

class _ArquivesState extends State<Arquives> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  bool uploading = false;
  double total = 0;
  List<Reference> refs = [];
  List<String> arqs = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImages();
  }

  loadImages() async{
    refs = (await storage.ref('images').listAll()).items;
    for(var ref in refs){
      arqs.add(await ref.getDownloadURL());
    }
    setState(() {
      loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(
        appBarTitle: uploading ? '${total.round()}% enviado' : 'Enviar Arquivo',
        showImage: false,
        showBackArrow: true,
      ),
      body: loading ? const Center(child: CircularProgressIndicator(),) :
          Padding(padding: const EdgeInsets.all(24),
          child: arqs.isEmpty ? const Center(child: Text('Não há imagens!'),) : 
          ListView.builder(itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
              background: Container(
                color: Colors.red,
                child: const Align(
                  alignment: Alignment(-0.9, 0.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                setState(() async {
                  await deleteImage(index);
                });
              },
              child: GestureDetector(
                child: ListTile(
                  leading: SizedBox(
                    width: 60,
                    height: 40,
                    child: Image.network(arqs[index],
                    fit: BoxFit.cover,),
                  ),
                  title: Text(refs[index].fullPath),
                  trailing: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () => downloadImage(refs[index]),
                  ),
                ),
              ),
            );
          },
          itemCount: arqs.length,
          ),),


    );
  }

  deleteImage(int index) async {
    await storage.ref(refs[index].fullPath).delete();
    arqs.removeAt(index);
    refs.removeAt(index);
    setState(() {});
  }

  downloadImage(Reference ref) async {
    final url = await ref.getDownloadURL();
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    await Dio().download(url, path);
    await GallerySaver.saveImage(path, toDcim: true);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Download concluído: ${ref.name}')));
  }

}
