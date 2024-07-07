import 'package:flutter/material.dart';
import 'package:github_search/components/search_history_grid.dart';
import 'package:github_search/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class HistoryOverviewsScreen extends StatelessWidget {
  const HistoryOverviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool actualTheme = themeProvider.getTheme();
    return Scaffold(
      body: SearchHistoryGrid(),
      appBar: AppBar(
        title: Text("Histórico de pesquisa"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.toggleTheme(); //Muda o theme atual
            },
            icon: actualTheme
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
          ),
        ],
      ),
    );
  }
}
