import 'package:flutter/material.dart';
import 'package:github_search/models/search_history_provider.dart';
import 'package:github_search/screens/history_overviews_screen.dart';
import 'package:github_search/screens/user_details_screen.dart';
import 'package:github_search/services/git_hub_service.dart';
import 'package:github_search/themes/theme_provider.dart';
import 'package:github_search/uteis/nav.dart';
import 'package:github_search/uteis/widgets/botao.dart';
import 'package:github_search/uteis/widgets/campo_text_field.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Map para o json do userData devolvido pela API do gitHub
  Map<String, dynamic>? _userData;
  //Instanciação do service do GitHub
  final GitHubService _gitHubService = GitHubService();
  //formKey para validação do textField
  final _formKey = GlobalKey<FormState>();

  //Controlador de Texto para o TextField
  final TextEditingController _controller = TextEditingController();
  //Verifica se está atualmente na home para desabilitar o botão home da appBar

  @override
  Widget build(BuildContext context) {
    //Providers do App
    final themeProvider = Provider.of<ThemeProvider>(context);
    final searchHistoryProvider = Provider.of<SearchHistoryProvider>(context);
    // Pega o theme atual para evitar repetição de codigo
    bool actualTheme = themeProvider.getTheme();
    void _showUserDetailsDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: Text(
              _userData!['name'] ?? 'No Name',
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    push(
                        context,
                        UserDetailsScreen(
                          userLogin: _userData!['login'],
                        ));
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(_userData!['avatar_url']),
                        radius: 50,
                      ),
                      SizedBox(height: 16),
                      Text(_userData!['login']),
                      SizedBox(height: 8),
                      Text(_userData!['location'] ?? 'No Location'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Future<void> _fetchUserData(String username) async {
      try {
        final userData = await _gitHubService.fetchUserData(username);
        setState(() {
          _userData = userData;
          _showUserDetailsDialog();
          searchHistoryProvider.addUserToHistory(
            login: _userData!['login'],
            name: _userData!['name'] ?? _userData!['login'],
            location: _userData!['location'] ?? 'No Location',
            avatarUrl: _userData!['avatar_url'],
          ); //Print pra conferir o uso da api
        });
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("GitHub Search"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              push(context, HistoryOverviewsScreen()); //Vai pro histórico
            },
            icon: Icon(Icons.history),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: Image.asset(
                fit: BoxFit.cover,
                actualTheme
                    ? "images/icon_github_black.png"
                    : "images/icon_github_white.png",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    //Entrada de nome para pesquisar no Github
                    CampoTextFormField(
                      "Nome do usuário",
                      textoDica: "Digite o nome do usuário do GitHub",
                      controlador: _controller,
                      funcao: () {
                        if (_formKey.currentState!.validate()) {
                          _fetchUserData(_controller.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Botao(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _fetchUserData(_controller.text);
                }
              },
              texto: "Pesquisar",
            ),
          ],
        ),
      ),
    );
  }
}
