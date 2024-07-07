import 'package:flutter/material.dart';

class SearchHistory with ChangeNotifier{
  final String login;
  final String name;
  final String location;
  final String avatarUrl;

  SearchHistory({
    required this.login,
    required this.name,
    required this.avatarUrl,
    required this.location,
  });
}
