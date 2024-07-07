import 'package:flutter/material.dart';
import 'package:github_search/components/search_history_grid_item.dart';
import 'package:github_search/models/search_history.dart';
import 'package:github_search/models/search_history_provider.dart';
import 'package:provider/provider.dart';

class SearchHistoryGrid extends StatelessWidget {
  const SearchHistoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchHistoryProvider>(context);
    final List<SearchHistory> searchHistory = provider.history;
    return searchHistory.isEmpty
        ? const Center(
            child: Text("SEM HISTÓRICO DE PESQUISA"),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: searchHistory.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
              value: searchHistory[index],
              child: SearchHistoryGridItem(),
            ),
          );
  }
}
