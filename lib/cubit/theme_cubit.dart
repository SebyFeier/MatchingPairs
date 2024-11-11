import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matching_pairs/cubit/theme_data_source.dart';
import 'package:matching_pairs/cubit/theme_model.dart';
import 'package:matching_pairs/cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(InitialState());
  ThemeDataSourceImpl themeDataSourceImpl = ThemeDataSourceImpl();

  Future getThemes() async {
    try {
      emit(LoadingState());
      final ThemeModelResponse response = await themeDataSourceImpl.getThemes();
      List<ThemeModel> list = [];
      list.addAll(response.themes as Iterable<ThemeModel>);
      emit(GetThemeResultsState(themes: list));
    } catch (e) {
      emit(ErrorState(errorMessage: 'Error'));
    }
  }

  // Future initializeSymbolsList(selectedThemeSymbols) async {
  //   List<Map<String, dynamic>> symbols = [];
  //   int index = 0;
  //   for (String element in selectedThemeSymbols!) {
  //     symbols.add({'icon': element, 'index': index, 'isFaceDown': false});
  //     index++;
  //   }
  //   for (String element in selectedThemeSymbols!) {
  //     symbols.add({'icon': element, 'index': index, 'isFaceDown': false});
  //     index++;
  //   }
  //   symbols.sort((a, b) => a["icon"].compareTo(b["icon"]));
  //   emit(GetSymbolsState(symbols: symbols));
  // }
}