import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/chatting/chat/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Massages extends StatelessWidget {
  const Massages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chat').orderBy('time',descending: true).snapshots(),
        builder:( context ,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = snapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (context,index){
              return ChatBubble(chatDocs[index]['text'],chatDocs[index]['userID'].toString() == currentUser.uid);
            },
          );
      }
    );
  }
}
