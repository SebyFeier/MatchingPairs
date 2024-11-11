
import 'package:flutter/cupertino.dart';
import 'package:matching_pairs/card.dart';
import 'package:matching_pairs/cubit/theme_model.dart';
import 'package:matching_pairs/level_model.dart';
import 'package:matching_pairs/theme_card.dart';

class ThemeGridView extends StatefulWidget {
  final ThemeModel selectedTheme;
  final List<CardType> symbols;
  final bool isFaceDown;
  final Function (int score) updateScore;
  final Function gameIsFinished;
  final LevelModel level;
  const ThemeGridView({super.key,
    required this.selectedTheme,
    required this.symbols,
    required this.isFaceDown,
    required this.updateScore,
    required this.gameIsFinished,
    required this.level});

  @override
  State<StatefulWidget> createState() => _ThemeGridViewState();
}

class _ThemeGridViewState extends State<ThemeGridView> {
  List<CardType>? symbols = [];
  @override
  void initState() {
    super.initState();
    symbols = widget.symbols;
  }
  @override
  Widget build(BuildContext context) {
    List<CardType> selectedSymbols = [];
    return GridView.count(crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(widget.symbols.length, (index) {
          return ThemeCard(
              selectedTheme: widget.selectedTheme,
              symbol: symbols![index],
              isInitialFaceDown: widget.isFaceDown,
              symbolTapped: (selectedSymbol, isFaceDown){
                if (isFaceDown == false) {
                  if (selectedSymbols.length < widget.level.numberOfSameCards) {
                    selectedSymbols.add(selectedSymbol);
                  }

                  if (selectedSymbols.length == widget.level.numberOfSameCards) {
                    bool sameSymbols = false;
                    for (CardType symbol in selectedSymbols) {
                      if (symbol.icon == selectedSymbols[0].icon) {
                        sameSymbols = true;
                      } else {
                        sameSymbols = false;
                        break;
                      }
                    }
                    if (sameSymbols == true) {
                      Future.delayed(const Duration(milliseconds: 1000), ()
                      {
                        setState(() {
                          symbols!.removeWhere((item) => item.icon == selectedSymbol.icon);
                          if (symbols!.isEmpty) {
                            widget.gameIsFinished();
                          }
                        });
                        widget.updateScore(0);
                      });
                    } else {
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        List<CardType>? tempSymbols = symbols;
                        for (var element in tempSymbols!) {
                          element.isHidden = true;
                        }
                        setState(() {
                          symbols = tempSymbols;
                        });
                        widget.updateScore(4);
                      });
                    }
                  }
                } else {
                  if (selectedSymbols.contains(selectedSymbol)) {
                    selectedSymbols.removeWhere((item) => item == selectedSymbol);
                  }
                  for (var element in selectedSymbols) {
                    if (element.icon == selectedSymbol.icon) {
                      selectedSymbols.remove(selectedSymbol);
                      break;
                    }
                  }
                }
              });
        }));
  }
}