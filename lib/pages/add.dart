//import 'package:instag/services/auth.dart';
import 'dart:io';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagra/models/object.dart';
//import 'package:instag/models/post.dart';
//import 'package:instag/models/post.dart';
import 'package:instagra/services/database.dart';
import 'package:instagra/shared/loading.dart';
//import 'package:path/path.dart';
import 'package:provider/provider.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final imagePicker = ImagePicker();
  File _image;
  TextEditingController _captionInputController = TextEditingController();
  bool _isUploading = false;
  bool _isUploadCompleted = false;
  double _uploadProgress = 0;
  String basename(String path) => (path);

  //firebase
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  //final FirebaseFirestore _db = FirebaseFirestore.instance;
  //final FirebaseStorage _storage = FirebaseStorage.instance;
  //final AuthService _auth = AuthService();
  //firebase

  pickFromCamera() async {
    var image = await imagePicker.getImage(source: ImageSource.camera);
    cropImage(image);
  }

  pickFromPhone() async {
    var image = await imagePicker.getImage(source: ImageSource.gallery);
    //var file = File(image.path);
    cropImage(image);
  }

  cropImage(image) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: image.path,
      compressQuality: 40,
    );
    setState(() {
      _image = croppedImage;
    });
  }

  upLoadImage() async {
    try {
      if (_image != null) {
        setState(() {
          _isUploading = true;
          _uploadProgress = 0;
        });
        // String fileName = basename(_imageFile.path);
        // StorageReference firebaseStorageRef =
        //    FirebaseStorage.instance.ref().child('uploads/$fileName');
        //StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
        // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
        // taskSnapshot.ref.getDownloadURL().then(
        //      (value) => print("Done: $value"),
        //    );
        //UserData user = await _auth.currentUser();
        // String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
        //    basename(_image.path);
        // final  storageReference =
        //   _storage.ref().child("posts").child(user.uid).child(fileName);
        //  String filePath = 'images/${DateTime.now()}.png';

        //  setState(() {
        // _uploadTask = _storage.ref().child(filePath).putFile(_image);
        // });

        // final StorageUploadTask uploadTask = storageReference.putFile(_image);
        //  final StreamSubscription<StorageEvent> streamSubscription =
        //    _uploadTask.snapshotEvents.listen((event) {
        //  var totalBytes = event.snapshot.totalByteCount;
        // var transferred = event.snapshot.bytesTransferred;
        // double progress = ((transferred * 100) / totalBytes) / 100;

        // setState(() {
        //  _uploadProgress = progress;
        // });
        // });

        // StorageTaskSnapshot onComplete = await UploadTask.onComplete;
        // String postImage = await onComplete.ref.getDownloadURL();
        // _db.collection('posts').add({
        //'postImage': postImage,
        //'username': AutofillHints.username,
        //'caption': _captionInputController.text,
        // 'date': DateTime.now(),
        // 'uploadedBy': user.uid,
        // });
        // when completed
        setState(() {
          _isUploading = false;
          _isUploadCompleted = true;
        });
        // streamSubscription.cancel();
        Navigator.pop(this.context);
      } else {
        showDialog(
            context: this.context,
            builder: (context) {
              return AlertDialog(
                content: Text("Please select image!"),
                title: Text("Alert"),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              );
            });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //String basename(String path) => context.basename(path);
    final user = Provider.of<Object>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                  title: Text("Select Image"),
                  actions: [
                    // select image from camera
                    IconButton(
                      tooltip: "Take from camera",
                      icon: Icon(
                        Icons.add_a_photo,
                      ),
                      onPressed: () {
                        pickFromCamera();
                      },
                    ),
                    // select image from gallery
                    IconButton(
                      tooltip: "Select from phone",
                      icon: Icon(
                        Icons.add_photo_alternate,
                      ),
                      onPressed: () {
                        pickFromPhone();
                      },
                    ),
                  ],
                ),
                body: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _image != null
                            ? Image.file(_image)
                            : Image(
                                image: AssetImage('assets/placeholder.png'),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        _isUploading
                            ? LinearProgressIndicator(
                                value: _uploadProgress,
                                backgroundColor: Colors.grey,
                              )
                            : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _captionInputController,
                            decoration: InputDecoration(
                              hintText: userData.caption,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          child: Text("Done"),
                          onPressed: () {
                            upLoadImage();
                          },
                        ),
                      ],
                    ),
                  ),
                ));
          } else {
            return Loading();
          }
        });
  }
}
