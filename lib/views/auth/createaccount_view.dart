import 'dart:io';
import 'package:famlicious/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';
import 'package:famlicious/manager/auth_manager.dart';

class CreateAccountsView extends StatefulWidget {
  CreateAccountsView({Key? key}) : super(key: key);

  @override
  State<CreateAccountsView> createState() => _CreateAccountsViewState();
}

class _CreateAccountsViewState extends State<CreateAccountsView> {
  _CreateAccountsViewState();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthManager _authManager = AuthManager();
  final emailRegexp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final ImagePicker _ImagePicker = ImagePicker();
  File? _imageFile;

  Future selectImage({ImageSource imageSource = ImageSource.camera}) async {
    XFile? selectedFile = await _ImagePicker.pickImage(source: imageSource);
    File _imageFile = File(selectedFile!.path);
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: selectedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Your Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    setState(() {
      _imageFile = croppedFile!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(padding: const EdgeInsets.all(16), children: [
            // CircleAvatar(
            //     radius: 65,
            //     backgroundImage: _imageFile == null
            //         ? AssetImage('assets/images/ive.jpg')
            //         : FileImage(_imageFile!) as ImageProvider),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: _imageFile == null
                    ? Image.asset(
                        'assets/images/ive.jpg',
                        width: 130,
                        height: 130,
                        fit: BoxFit.contain,
                      )
                    : Image.file(
                        _imageFile!,
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            TextButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              TextButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    selectImage(
                                        imageSource: ImageSource.camera);
                                  },
                                  icon: Icon(UniconsLine.camera),
                                  label: Text("Select a Picture from Camera")),
                              TextButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    selectImage(
                                        imageSource: ImageSource.gallery);
                                  },
                                  icon: Icon(UniconsLine.picture),
                                  label: Text("Select  picture from Gallery"))
                            ],
                          ),
                        );
                      });
                },
                icon: Icon(UniconsLine.camera),
                label: Text(
                  "Select a profile picture",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey),
                )),

            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Full Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Full Name is required!';
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Email Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "email is required";
                  }
                  if (!emailRegexp.hasMatch(value)) {
                    return "Email is not valid";
                  }
                }),

            const SizedBox(
              height: 15,
            ),
            TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Email Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password is required";
                  }
                  if (value.length < 8) {
                    return "Password must be more than 8 characters";
                  }
                }),
            const SizedBox(
              height: 15,
            ),
            _authManager.isLoading
                ? Center(child: const CircularProgressIndicator.adaptive())
                : TextButton(
                    child: const Text('Create Account'),
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .background),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // all good
                        String name = _nameController.text;
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        bool isCreated = await _authManager.creatNewUser(
                            name: name,
                            email: email,
                            password: password,
                            imageFile: _imageFile!);
                        if (isCreated) {
                          Fluttertoast.showToast(
                              msg: "Welcome!,$name",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: _authManager.message,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomeView()),
                              (route) => false);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please Check Input fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    })
          ]),
        ),
      ),
    );
  }
}
