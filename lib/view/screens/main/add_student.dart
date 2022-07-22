import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/more_controller.dart';

import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/custom_button.dart';
import 'package:smfp/view/widgets/my_appbar.dart';
import 'package:smfp/view/widgets/text_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddStudent extends StatefulWidget {
  AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  MoreController controller = Get.put(MoreController());
  List<String> ii = ['', '', ''];
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var image1 = TextEditingController();
  var image2 = TextEditingController();
  var image3 = TextEditingController();
  var school;
  void clearText() {
    nameController.clear();
    image1.clear();
    image2.clear();
    image3.clear();
  }

  File? _photo1;
  File? _photo2;
  File? _photo3;

  late List<File?> _images;
  List<String> imageUrls = [];

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery(TextEditingController image, File? photo) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        if (image == image1) {
          _photo1 = File(pickedFile.path);
          String fileName = _photo1!.path.split('/').last;
          image1.text = fileName;
        } else if (image == image2) {
          _photo2 = File(pickedFile.path);
          String fileName = _photo2!.path.split('/').last;
          image2.text = fileName;
        } else if (image == image3) {
          _photo3 = File(pickedFile.path);
          String fileName = _photo3!.path.split('/').last;
          image3.text = fileName;
        }

        //   uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera(TextEditingController image, File? photo) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        if (image == image1) {
          _photo1 = File(pickedFile.path);
          String fileName = _photo1!.path.split('/').last;
          image1.text = fileName;
        } else if (image == image2) {
          _photo2 = File(pickedFile.path);
          String fileName = _photo2!.path.split('/').last;
          image2.text = fileName;
        } else {
          _photo3 = File(pickedFile.path);
          String fileName = _photo3!.path.split('/').last;
          image3.text = fileName;
        }
      } else {
        print('No image selected.');
      }
    });
  }

  void uploadFiles() async {
    _images = [_photo1, _photo2, _photo3];
    imageUrls = await Future.wait(_images.map((_image) => uploadFile(_image!)));
    controller.addStudent(
        name: nameController.text, schoolId: school.id, images: imageUrls);
  }

  Future<String> uploadFile(File _image) async {
    Reference storageReference =
        FirebaseStorage.instance.ref('files/${_image.path}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.then((p0) => null);

    return await storageReference.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      TextUtils(
                        text: "طلب تسجيل الطالب في المدرسة",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextUtils(
                              fontSize: 16,
                              text: ' اسم الطالب رباعي : ',
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            contentItem(
                              hintText: '',
                              control: nameController,
                              enabled: true,
                              icon: Icons.person,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextUtils(
                              fontSize: 16,
                              text: ' صورة هوية الأب : ',
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                _showPicker(context, image1, _photo1);
                              },
                              child: photoTextField(control: image1),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextUtils(
                              fontSize: 16,
                              text: ' صورة شهادة ميلاد الطفل : ',
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                _showPicker(context, image2, _photo2);
                              },
                              child: photoTextField(control: image2),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextUtils(
                              fontSize: 16,
                              text: ' صورة كرت التطعيم : ',
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                _showPicker(context, image3, _photo3);
                              },
                              child: photoTextField(control: image3),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextUtils(
                              fontSize: 16,
                              text: ' اختر المدرسة : ',
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(10),
                              shadowColor: Colors.grey,
                              child:
                                  GetX<MoreController>(builder: (controller) {
                                return DropdownButtonFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return 'من فضلك حدد المدرسة المراد تسجيل الطالب فيها';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: theme.secondaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: theme.secondaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: theme.secondaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: theme.secondaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(
                                      Icons.location_city,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  items:
                                      controller.allSchoolsModel.map((school) {
                                    return DropdownMenuItem(
                                      value: school,
                                      child: Text(
                                        school.name,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      school = value;
                                    });
                                  },
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            MainButton(
                              text: 'تقديم الطلب',
                              pressed: () {
                                if (formKey.currentState!.validate()) {
                                  uploadFiles();
                                  clearText();
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context, TextEditingController image, File? photo) {
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
                      imgFromGallery(image, photo);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('الكاميرا'),
                  onTap: () {
                    imgFromCamera(image, photo);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}

Widget contentItem(
    {required String hintText,
    required var control,
    required bool enabled,
    required IconData icon}) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    child: TextFormField(
      controller: control,
      validator: (v) {
        if (v.toString().isEmpty) {
          return 'من فضلك أدخل جميع البيانات المطلوبة';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        enabled: enabled,
        prefixIcon: control.text.isEmpty
            ? Icon(
                icon,
                color: Colors.grey,
              )
            : Icon(
                icon,
                color: theme.mainColor,
              ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: theme.secondaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: theme.secondaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: theme.secondaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: theme.secondaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}

Widget photoTextField({required TextEditingController control}) {
  return SizedBox(
    width: double.infinity,
    child: TextFormField(
      enabled: false,
      controller: control,
      validator: (v) {
        if (v.toString().isEmpty) {
          return 'من فضلك أدخل جميع البيانات المطلوبة';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        prefixIcon: control.text.isEmpty
            ? const Icon(Icons.camera_alt)
            : const Icon(
                Icons.done_all_rounded,
                color: theme.mainColor,
              ),
        contentPadding: const EdgeInsets.all(10),
        hintText: '',
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: theme.secondaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: theme.secondaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: theme.secondaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: theme.secondaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: theme.secondaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
