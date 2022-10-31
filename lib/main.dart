import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'route.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

/*
  * Things to be changed is 
  * 1. What screen you wanna load if the user is Authenticated -> replace it with BlankScreen()
  * 2. What screen you wanna load if the user is not Authenticated -> replace it with EnterPhoneScreen()
  * 3. What screen you wanna load if the user is not Authenticated, Then you try to autLogin in that case if the user is Authenticated -> replace it with BlankScreen()
*/
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Auth(),
      child: Consumer<Auth>(builder: (context, value, _) {
        return MaterialApp(
          title: 'Lane Dane',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (settings) => generateRoute(settings),
          home: value.isAuth
              ? const BlankScreen()
              : FutureBuilder(
                  future: value.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.data == true
                          ? const BlankScreen()
                          : const EnterPhoneScreen(),
                ),
        );
      }),
    );
  }
}
