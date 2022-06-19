import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/chatting/chat/massage.dart';
import 'package:untitled/chatting/chat/new_massage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser(){
    try{
      final user = _authentication.currentUser;
      if(user != null){
        loggedUser = user;
        print(loggedUser!.email);
      }
    }catch(err){
      print(err);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : const Text('Chat screen'),
        actions: [
          IconButton(
              onPressed: (){
                _authentication.signOut();
              },
              icon: const Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white
            )
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Massages()),
            NewMassage(),
          ],
        ),
      )
    );
  }
}
