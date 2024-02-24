
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peo_veo/constants/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:peo_veo/models/user.dart' as model;
import 'package:peo_veo/views/screens/auth/login_screen.dart';
import 'package:peo_veo/views/screens/home_screen.dart';


class AuthController extends GetxController {
   static AuthController instance = Get.find();
   // static AuthController instance = authController;
   late Rx<User?> _user;
   late Rx<File?> _pickedImage;

   File? get profilePhoto => _pickedImage.value;
   User get user => _user.value!;

   @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

   _setInitialScreen(User? user)
   {
      if(user == null)
        {
          Get.offAll( () => LoginScreen() );
        }
      else {
        Get.offAll( () =>  HomeScreen() );
      }
   }


   void pickImage() async {
     // Get.put(AuthController());
     final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
     if(pickedImage != null)
       {
          Get.snackbar('Profile Picture', 'You have successfully selected your profile pic!' );
       }
       _pickedImage = Rx<File?>(File(pickedImage!.path));
   }



  //Upload to firebase storage
  Future<String> _uploadToStorage(File image) async
  {
    Reference ref = firebaseStorage.ref().child('profilePics').child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;


  }


  //register the user
  void registerUser(String username, String email, String password, File? image ) async
  {
         try {
              if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image != null)
                {
                  //save the user to firebase firestore
                  UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

                 String downloadUrl = await _uploadToStorage(image);
                 model.User user = model.User(name: username, email: email,  uid: cred.user!.uid, profilePhoto: downloadUrl);

                 await fireStore.collection('users').doc(cred.user!.uid).set(user.toJson());
                }
              else {
                Get.snackbar('Error creating account', 'please enter all the fields');
              }
         }
         catch (e){
               Get.snackbar('Error creating account', e.toString());
         }
  }

  void loginUser(String email, String password) async
  {
         try {
           if(email.isNotEmpty && password.isNotEmpty)
             {
                 await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
                 print('logged success');
             }
           else
             {
               Get.snackbar('Error logging in account', 'Please enter all fields' );
             }
         }
         catch (e){
           Get.snackbar('Error logging in account', e.toString());
         }
  }

  signOut() async
  {
     await firebaseAuth.signOut();
  }






}