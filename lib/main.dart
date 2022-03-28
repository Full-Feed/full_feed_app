import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:full_feed_app/providers/diet_provider.dart';
import 'package:full_feed_app/providers/preferences_provider.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:full_feed_app/screens/pages/authentication/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();

}


class MyAppState extends State<MyApp> {
  late StreamChatClient client;

  @override
  void initState() {
    client = StreamChatClient(
      '4u4qb3jxyjpa',
      logLevel: Level.WARNING,
    );
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => PreferenceProvider()),
          ChangeNotifierProvider(create: (ctx) => UserProvider()),
          ChangeNotifierProvider(create: (ctx) => DietProvider())
        ],
        child: MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
            ],
            title: 'Full Feed',
            theme: ThemeData(
                textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)
            ),
            builder: (context, child){
              return StreamChat(
                child: child,
                client: client,
              );
            },
            home: SplashScreen()
        )
    );
  }
}
