import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hamdiappps/screen/profil.dart';
import 'dart:io';

class NewPostPage extends StatefulWidget {
  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController _captionController = TextEditingController();
  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
// User canceled the picker
      }
    });
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Post'),
        backgroundColor: Colors.white,
        leading: IconButton(
// Tambahkan leading untuk tombol back
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
// Menggunakan pushReplacement agar tidak menumpuk halaman
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: Stack(
// menggunakanWrap body with Stack
        children: <Widget>[
// memanggil Background Image
          Image.asset(
            'assets/images/white.jpg', // masukan gambar
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _getImage,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _image == null
                        ? Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.grey,
                            ),
                          )
                        : Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _captionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Write a caption...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
// disini untuk menulis backend proses
                  },
                  child: Text('Post'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
