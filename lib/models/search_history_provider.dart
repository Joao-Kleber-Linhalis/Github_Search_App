import 'package:flutter/material.dart';
import 'package:github_search/models/search_history.dart';

class SearchHistoryProvider with ChangeNotifier {
  List<SearchHistory> _searchHistory = [];

  List<SearchHistory> get history {
    return [..._searchHistory];
  }

  int get historyCount {
    return _searchHistory.length;
  }

  void addUserToHistory({
    required String login,
    required String name,
    required String location,
    required String avatarUrl,
  }) {
    final newUser = SearchHistory(
      login: login,
      name: name,
      avatarUrl: avatarUrl,
      location: location,
    );
    _searchHistory.removeWhere((user) => user.login == login);

    // Adicionar o usuário ao início da lista
    _searchHistory.insert(0, newUser);
    notifyListeners();
  }
}
