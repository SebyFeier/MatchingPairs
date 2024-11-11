import 'package:flutter/material.dart';
import 'package:matching_pairs/cubit/theme_model.dart';
import 'package:matching_pairs/level_model.dart';
import 'package:matching_pairs/theme_page.dart';

class ChooseLevelPage extends StatelessWidget {
  final ThemeModel selectedTheme;
  final String? username;

  ChooseLevelPage({super.key, required this.selectedTheme, this.username});
  final List<LevelModel> levels = [
    LevelModel(level: 1, seconds: 60, numberOfSameCards: 2),
    LevelModel(level: 2, seconds: 30, numberOfSameCards: 2),
    LevelModel(level: 3, seconds: 60, numberOfSameCards: 3),
    LevelModel(level: 4, seconds: 30, numberOfSameCards: 3),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Select level')),
      ), body: SingleChildScrollView(child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: levels.length,
              itemBuilder: (context, index) {
                var level = levels[index];
                return Center(child: TextButton(onPressed: () { Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            ThemePage(selectedTheme: selectedTheme, username: username, levelModel: level,))); },
                  child: Text('Level ${level.level}')));
              })
        ]))),);
  }

}