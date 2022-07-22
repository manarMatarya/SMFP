import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:smfp/admin/logic/controller/admin_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/custom_button.dart';
import 'package:smfp/view/widgets/text_utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddEvents extends StatefulWidget {
  AddEvents({Key? key}) : super(key: key);

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  AdminController controller = Get.put(AdminController());
  var titleController = TextEditingController();
  var dateController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  bool keyboardOpen = false;
  @override
  Widget build(BuildContext context) {
    keyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Image.asset(
            'assets/images/logo.png',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                         TextUtils(
                    
                          text: "حدث جديد",
                    
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 250,
                          child: ClipRRect(
                            
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            child: Stack(
                              
                              children: <Widget>[
                                ClipRRect(
                                  
                                  borderRadius: BorderRadius.circular(20),
                                  child: _photo == null
                                      ? Image.asset(
                                          'assets/images/mainphoto.png',
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          _photo!,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Positioned(
                                  top: 10,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.camera_enhance,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _showPicker(context);
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(200, 0, 0, 0),
                                          Color.fromARGB(0, 0, 0, 0)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                            controller: titleController,
                                            validator: (value) {
                                              if (value.toString().isEmpty) {
                                                return 'حدد عنوان للحدث';
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: const InputDecoration(
                                              hintText: 'عنوان الحدث',
                                              hintStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                              border: InputBorder.none,
                                              filled: true,
                                              fillColor: Colors.transparent,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: InkWell(
                                            onTap: () => _selectDate(context),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                              controller: dateController,
                                              validator: (value) {
                                                if (value.toString().isEmpty) {
                                                  return 'حدد تاريخ للحدث';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                hintText: 'تاريخ الحدث',
                                                hintStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                                border: InputBorder.none,
                                                filled: true,
                                                enabled: false,
                                                fillColor: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: keyboardOpen
            ? const SizedBox()
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MainButton(
                  pressed: () {
                    if (formKey.currentState!.validate() && _photo != null) {
                      uploadFiles();
                    } else {
                      Get.snackbar(
                        'خطأ',
                        'البيانات غير مكتملة',
                        colorText: Colors.white,
                        backgroundColor: theme.mainColor,
                      );
                    }
                  },
                  text: 'ارسال',
                ),
              ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('الاستديو'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('الكاميرا'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;

  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        //   uploadFile(_photo);
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        // uploadFile(_photo);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> uploadFile(File? _image) async {
    Reference storageReference =
        FirebaseStorage.instance.ref('files/${_image!.path}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.then((p0) => null);

    return await storageReference.getDownloadURL();
  }

  void uploadFiles() async {
    var imageUrl = await (uploadFile(_photo));
    controller.addEvent(
        date: dateController.text,
        title: titleController.text,
        image: imageUrl);
  }
}
