
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matching_pairs/card.dart';
import 'package:matching_pairs/cubit/theme_model.dart';


class ThemeCard extends StatefulWidget {
  final ThemeModel selectedTheme;
  final CardType symbol;
  final bool isInitialFaceDown;
  final Function (CardType selectedSymbol, bool isFaceDown) symbolTapped;
  const ThemeCard({super.key, required this.symbol, required this.selectedTheme, required this.symbolTapped, required this.isInitialFaceDown});

  @override
  State<StatefulWidget> createState() => _ThemeCardState();
}

class _ThemeCardState extends State<ThemeCard> {
  late CardType currentCard;
  @override
  void initState() {
    currentCard = widget.symbol;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isInitialFaceDown == true) {
          setState(() {
            widget.symbol.isHidden = !widget.symbol.isHidden;
          });
          widget.symbolTapped(widget.symbol, widget.symbol.isHidden);
        }
      },
      child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO((widget.selectedTheme.cardColor!.red! * 100).toInt(), (widget.selectedTheme.cardColor!.green! * 100).toInt(), (widget.selectedTheme.cardColor!.blue! * 100).toInt(), 1),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: widget.symbol.isHidden == false ?Text(widget.symbol.icon) :
          Text(widget.selectedTheme.cardSymbol ?? "")),
    );
  }
}
