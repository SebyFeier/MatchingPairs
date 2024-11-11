import 'dart:core';

class ThemeModelResponse {
  final List<ThemeModel>? themes;
  ThemeModelResponse({this.themes});

  factory ThemeModelResponse.fromJson(dynamic json) {
    return ThemeModelResponse(
      themes: (json as List<dynamic>?)?.map((dynamic e) => ThemeModel.fromJson(e as Map<String, dynamic>)).toList()
    );
  }
}

class ThemeModel {
  final CardColor? cardColor;
  final String? cardSymbol;
  final List<String>? symbols;
  final String? title;
  ThemeModel({this.cardColor, this.cardSymbol, this.symbols, this.title});

factory ThemeModel.fromJson(Map<String, dynamic> json) {
  print('themeModel $json');
  return ThemeModel(
      cardColor: CardColor.fromJson(json["card_color"]),
      cardSymbol: json["card_symbol"] as String?,
      symbols: json["symbols"] == null ? [] : List<String>.from((json["symbols"] as List).map((e) => e)),
      title: json["title"] as String?
  );
}
}

class CardColor {
  final double? blue;
  final double? green;
  final double? red;

  CardColor({this.blue, this.green, this.red});

  factory CardColor.fromJson(Map<String, dynamic> json) {
    print('json card color $json');
    return CardColor(
        blue: json["blue"] as double?,
        green: json["green"] as double?,
        red: json["red"] as double?
    );
  }
}