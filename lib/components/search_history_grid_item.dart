import 'package:flutter/material.dart';
import 'package:github_search/models/search_history.dart';
import 'package:github_search/screens/user_details_screen.dart';
import 'package:github_search/uteis/nav.dart';
import 'package:provider/provider.dart';

class SearchHistoryGridItem extends StatelessWidget {
  const SearchHistoryGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    final historyUser = Provider.of<SearchHistory>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: FittedBox(
            child: Text(
              "${historyUser.login}\n${historyUser.name} - ${historyUser.location}",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        child: GestureDetector(
          child: Hero(
            tag: historyUser.login,
            child: FadeInImage(
              placeholder: AssetImage("images/icon_user_default.png"),
              image: NetworkImage(historyUser.avatarUrl),
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            push(context,UserDetailsScreen(userLogin: historyUser.login,));
          },
        ),
      ),
    );
  }
}
