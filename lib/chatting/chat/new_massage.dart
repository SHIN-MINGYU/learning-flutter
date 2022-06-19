import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMassage extends StatefulWidget {
  const NewMassage({Key? key}) : super(key: key);

  @override
  State<NewMassage> createState() => _NewMassageState();
}

class _NewMassageState extends State<NewMassage> {
  final _controller = TextEditingController();
  var _userEnterMassage = '';
  void _sendMassage(){
    FocusScope.of(context).unfocus();
    final currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('chat').add({
      'text' : _userEnterMassage,
      'time' : Timestamp.now(),
      'userID' : currentUser!.uid,
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Send a massage...'
                ),
                onChanged: (value){
                  setState(() {
                    _userEnterMassage = value;
                  });
                },
                controller: _controller,
              )
          ),
          IconButton(
              onPressed : _userEnterMassage.trim().isEmpty ? null : _sendMassage,
              icon: Icon(Icons.send),
              color: Colors.blue
          )
        ],
      ),
    );
  }
}
