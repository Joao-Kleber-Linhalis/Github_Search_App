import 'package:flutter/material.dart';
import 'package:github_search/models/search_history_provider.dart';
import 'package:github_search/screens/home_screen.dart';
import 'package:github_search/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //criação do provider na arvore de widgets
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchHistoryProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'GitHub Search',
            theme: Provider.of<ThemeProvider>(context)
                .themeData, //Referindo ao theme atual dentro do provider.
            debugShowCheckedModeBanner: false,
            initialRoute: '/', // Define a rota inicial como '/'
            routes: {
              '/': (context) => HomeScreen(), // Define a rota para a HomeScreen
            },
          );
        }
      ),
    );
  }
}
