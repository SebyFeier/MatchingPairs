import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matching_pairs/choose_level_page.dart';
import 'package:matching_pairs/cubit/theme_cubit.dart';
import 'package:matching_pairs/cubit/theme_state.dart';
import 'package:matching_pairs/leaderboard_page.dart';
import 'package:matching_pairs/theme_page.dart';


class ThemeListPage extends StatelessWidget {
  final String? username;
  const ThemeListPage({super.key, this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Matching Pairs')),
        actions: [IconButton(
          icon: const Icon(
            Icons.leaderboard,
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        const LeaderboardPage()));
          },
        )],),
      body: BlocProvider<ThemeCubit>(create: (BuildContext context) => ThemeCubit()..getThemes(),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const SizedBox();
              } else if (state is GetThemeResultsState) {
                return SingleChildScrollView(child: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: state.themes!.length,
                          itemBuilder: (context, index) {
                            var theme = state.themes![index];
                            return Center(child: TextButton(onPressed: () { Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChooseLevelPage(selectedTheme: theme, username: username,))); },
                            child: Text(theme.title ?? ""),));
                          })
                    ])));
              }
              return const SizedBox();
            },
          )),
    );
  }
}