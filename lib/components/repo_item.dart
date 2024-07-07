import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoItem extends StatelessWidget {
  final repo;

  const RepoItem({super.key, required this.repo});

  //Metodo para abrir o repositorio no navegador
  _launchURL(String url) {
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  //Metodo para converter de yyyy-mm-dd para dd/mm/yyyy
  String formatarData(String dataString) {
    // Converter a String para DateTime
    DateTime data = DateTime.parse(dataString);
    // Formatar a Data para dd/mm/yyyy
    String formattedDate = DateFormat('dd/MM/yyyy').format(data);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => _launchURL(repo['html_url']),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        color: isDarkMode ? const Color.fromARGB(36, 0, 0, 0) :Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(repo['name'],
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 4),
                Text('Linguagem: ${repo['language'] ?? 'Sem linguagem informada'}'),
                const SizedBox(height: 4),
                Text('Descrição: ${repo['description'] ?? 'Sem descrição'}'),
                const SizedBox(height: 4),
                Text('Criado em: ${formatarData(repo['created_at'])}'),
                const SizedBox(height: 4),
                Text('Última alteração: ${formatarData(repo['pushed_at'])}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
