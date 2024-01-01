import 'package:chat_app/Cubit/Call/call_cubit.dart';
import 'package:chat_app/Cubit/ChatPage/chat_cubit.dart';
import 'package:chat_app/Presentation/chat_page.dart';
import 'package:chat_app/Resources/Managers/routes_manager.dart';
import 'package:chat_app/Resources/Theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => CallCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getApplicationtheme(false),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.authRoute,
      ),
    );
  }
}
