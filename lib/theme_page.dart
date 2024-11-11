import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matching_pairs/card.dart';
import 'package:matching_pairs/cubit/score_cubit.dart';
import 'package:matching_pairs/cubit/score_state.dart';
import 'package:matching_pairs/cubit/theme_cubit.dart';
import 'package:matching_pairs/leaderboard_model.dart';
import 'package:matching_pairs/level_model.dart';
import 'package:matching_pairs/theme_grid_view.dart';
import 'package:matching_pairs/cubit/theme_model.dart';
import 'package:score_timer/score_timer.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';



class ThemePage extends StatefulWidget {
  final ThemeModel selectedTheme;
  final String? username;
  final LevelModel levelModel;

  const ThemePage({super.key, required this.selectedTheme, this.username, required this.levelModel});

  @override
  State<StatefulWidget> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  bool hasStarted = false;
  List<CardType> symbols = [];
  int newScore = 0;
  final CountdownController _controller = CountdownController(autoStart: false);
  bool isFinal = false;

  @override
  void initState() {
    initializeSymbolsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int finalTime = 0;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.selectedTheme.title ?? ""),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.blue,
            ),
          ),
        ),
        body:
        BlocProvider<ScoreCubit>(create: (BuildContext context) => ScoreCubit()..setScore(0),
            child: BlocBuilder<ScoreCubit, ScoreState>(
                builder: (context, state) {
                  if (state is GetScoreState) {
                    return SingleChildScrollView(
                      child: Column(children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0),
                            child: ThemeGridView(
                              selectedTheme: widget.selectedTheme,
                              symbols: symbols,
                              isFaceDown: hasStarted,
                              level: widget.levelModel,
                              updateScore: (score) {
                                setState(() {
                                  newScore += score;
                                });
                              },
                              gameIsFinished: () {
                                saveResult();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                    Text('Final score: $newScore $finalTime'),
                                  ),
                                );
                                setState(() {
                                  isFinal = true;
                                  _controller.pause();
                                  resetSymbols();
                                });
                              },)
                        ),
                        TextButton(onPressed: () {
                          setState(() {
                            hasStarted = !hasStarted;
                            newScore = 0;
                            if (hasStarted == true) {
                              isFinal = false;
                              _controller.restart();
                              shuffleSymbols();
                            } else {
                              isFinal = false;
                              _controller.pause();
                              resetSymbols();
                            }
                          });
                        },
                            child: hasStarted == false
                                ? const Text('Start')
                                : const Text(
                                'Reset')),
                        ScoreWidget(score: newScore),
                        Countdown(
                          seconds: widget.levelModel.seconds,
                          controller: _controller,
                          build: (BuildContext context, double time) {
                            if (isFinal == true) {
                              finalTime = time.toInt();
                              _controller.pause();
                              context.read<ScoreCubit>().setScore(time.toInt());
                            }

                            return Text('Timer ${time.toInt().toString()}');
                          },
                          interval: const Duration(seconds: 1),
                          onFinished: () {
                            setState(() {
                              isFinal = true;
                              hasStarted = false;
                              resetSymbols();
                            });
                            saveResult(finalTime: finalTime);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                Text('Final score: $newScore $finalTime ${state.score}'),
                              ),
                            );
                          },
                        ),
                      ]),
                    );
                  }
                  return const SizedBox();
                })));
  }

  void saveResult({int? finalTime}) async {
    print('saveResult $finalTime');
    // try {
    //   final prefs = await SharedPreferences.getInstance();
    //
    //   List<String> listOfScores = prefs.getStringList(widget.selectedTheme.title ?? "") ?? [];
    //   print('listOfScores1 $listOfScores');
    //   LeaderboardModel model = LeaderboardModel(
    //       level: widget.levelModel.level, theme: widget.selectedTheme.title ?? "", score: newScore, username: widget.username ?? "");
    //   print('model $model ${model.toJson()}');
    //   listOfScores.add(model.toJson().toString());
    //   print('listOfScores2 $listOfScores');
    //   prefs.setStringList(widget.selectedTheme.title ?? "", listOfScores);
    // } catch (e) {
    //   print('error$e');
    // }
  }

  void resetSymbols() {
    symbols.clear();
    initializeSymbolsList();
    symbols.sort((a, b) => a.icon.compareTo(b.icon));
  }
  void shuffleSymbols() {
    symbols.clear();
    int index = 0;
    for (int i = 0; i < widget.levelModel.numberOfSameCards; i++) {
      for (String element in widget.selectedTheme.symbols!) {
        symbols.add(CardType(icon: element, index: index, isHidden: true));
        index++;
      }
    }
    symbols.shuffle();
  }

  void initializeSymbolsList() {
    int index = 0;
    for (int i = 0; i < widget.levelModel.numberOfSameCards; i++) {
      for (String element in widget.selectedTheme.symbols!) {
        symbols.add(CardType(icon: element, index: index, isHidden: false));
        index++;
      }
    }
    symbols.sort((a, b) => a.icon.compareTo(b.icon));
  }
}