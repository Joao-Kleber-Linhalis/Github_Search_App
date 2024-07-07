import 'dart:convert';

import 'package:http/http.dart' as http;

class GitHubService {
  final String _url = "https://api.github.com/users/";

  Future<Map<String, dynamic>> fetchUserData(String username) async {
    final response = await http.get(Uri.parse('$_url$username'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Erro ao carregar usuário $username");
    }
  }

  Future<List<dynamic>> fetchUserRepos(String username) async {
    try {
      final response = await http.get(Uri.parse('$_url$username/repos'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ao carregar os repositórios do usuário');
      }
    } catch (e) {
      throw Exception('Erro ao carregar os repositórios do usuário: $e');
    }
  }
}
