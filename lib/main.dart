import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pocket_professor/screens/chat_screen.dart';
import 'package:pocket_professor/ui_components/themes/cool_theme.dart';

void main() {
  // Catch all errors that happen in the Flutter framework
  FlutterError.onError = (FlutterErrorDetails details) {
    // Log the error
    print('Flutter error: ${details.exception}');
    print('Stack trace: ${details.stack}');
    
    // In production would send to error reporting service
    // reportError(details);
  };
  
  // Catch all uncaught errors in the Dart runtime
  runZonedGuarded(
    () => runApp(const MyApp()),
    (error, stack) {
      // Log the error
      print('Uncaught error: $error');
      print('Stack trace: $stack');
      
      // In production would send to error reporting service
      // reportError(error, stack);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Professor',
      theme: CoolTheme.darkTheme,
      home: const ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
