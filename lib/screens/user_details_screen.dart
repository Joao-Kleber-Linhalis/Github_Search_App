import 'package:flutter/material.dart';
import 'package:github_search/components/repo_item.dart';
import 'package:github_search/screens/home_screen.dart';
import 'package:github_search/services/git_hub_service.dart';
import 'package:github_search/themes/theme_provider.dart';
import 'package:github_search/uteis/nav.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  //Recebe o userLogin
  //Não coloquei para receber o userData pra não ter que salvar todo o json no provider
  final String userLogin;

  const UserDetailsScreen({super.key, required this.userLogin});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  //Userdata do usuario que vai vir da api
  Map<String, dynamic>? _userData;

  //Lista dos repo que vão vir da api
  List<dynamic>? _repoUserData = [];

  //Service do github
  final GitHubService _gitHubService = GitHubService();

  //Mostrar o indicador de carregar
  bool _isLoading = true;

  Future<void> _fetchUserData(String username) async {
    try {
      final userData = await _gitHubService.fetchUserData(username);
      setState(() {
        _userData = userData;
        print(_userData);
      });
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> _fetchRepoUserData(String username) async {
    try {
      final repoUserData = await _gitHubService.fetchUserRepos(username);
      setState(() {
        _repoUserData = repoUserData;
      });
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  //Metodo para carregar as 2 data e poder usar async, já que no init não da pra ser async
  Future<void> _fetchAllUserData(String username) async {
    await _fetchUserData(username);
    await _fetchRepoUserData(username);
    //um pequeno delay só por estetica
    Future.delayed(const Duration(microseconds: 600), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchAllUserData(widget.userLogin);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool actualTheme = themeProvider.getTheme();
    //2 condicional de loading para melhor experiencia do usuario
    return Scaffold(
      appBar: AppBar(
        title: _isLoading
            ? null
            : FittedBox(
                child: Text(
                "Detalhes de ${_userData?['login']}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //Chamada da função de navegação
              push(context, const HomeScreen(), replace: true);
            },
            icon: const Icon(Icons.home),
          ),
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(_userData!['avatar_url']),
                        radius: 75,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "ID: ${_userData!['id']}\n${_userData!['name'] ?? 'Sem nome'}\n${_userData!['location'] != null ? _userData!['location'] : 'Sem localização'}\nSeguidores: ${_userData!['followers'].toString()}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            '${_userData!['public_repos']} Repositórios públicos',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _repoUserData!.length,
                            itemBuilder: (context, index) {
                              final repo = _repoUserData![index];
                              return RepoItem(repo: repo);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
