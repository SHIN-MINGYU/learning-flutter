import 'package:flutter/material.dart';
import 'package:untitled/screens/chat_screen.dart';
import 'screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 초기화메서드가 비동기 방식이면 에러가 발생함.
  // 근데 밑의 firebase initailizeApp method는 비동기 방식임
  // flutter 엔진이 runApp을 호출시키기전에는 초기화 x 따라서 접근 불가함.
  // 비동기엔진을 main안에 처리할려면 플루터엔진을 초기화 해야하는데
  // WidgetsFlutterBinding.ensureInitialized(); 이 메서드가 불러와져야함.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat UI',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ChatScreen();
            }else{
              return LoginSignupScreen();
            }
          },
        ));
  }
}
