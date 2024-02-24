import 'dart:collection';

import 'package:get/get.dart';
import 'package:peo_veo/constants/constant.dart';
import 'package:peo_veo/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchController1 extends GetxController {

  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {
    _searchedUsers.bindStream(
     fireStore.collection('users').where('name', isGreaterThanOrEqualTo: typedUser).snapshots().map((QuerySnapshot query) {
       List<User> retVal = [];
       for(var element in query.docs){
         retVal.add(User.fromSnap(element));
       }
       return retVal;
     })
    );

    
  }


}