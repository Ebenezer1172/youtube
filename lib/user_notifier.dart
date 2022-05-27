import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:youtube/main.dart';
import 'user.dart';

class UserNotifier extends ChangeNotifier {
final TextEditingController _note = TextEditingController();
final TextEditingController _title = TextEditingController(); 

TextEditingController get title =>_title; 
TextEditingController get note=>_note;
final List<User> _userlist=[];
UnmodifiableListView<User> get userList => UnmodifiableListView(_userlist);
  List<NoteList> nuiu= [ ];
 

addUser(User user){
_userlist.add(user);
notifyListeners();
}



deleteUser(index){
_userlist.removeWhere((_user) => _user.note == userList[index].title);
notifyListeners();
}

  
}