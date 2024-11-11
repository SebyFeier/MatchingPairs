import 'package:equatable/equatable.dart';
import 'package:matching_pairs/cubit/theme_model.dart';

abstract class ThemeState extends Equatable {}

class InitialState extends ThemeState {
  @override
  List<Object> get props => [];
}

class LoadingState extends ThemeState {
  @override
  List<Object> get props => [];
}

class ErrorState extends ThemeState {
  final String? errorMessage;
  ErrorState({this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];

}

class GetThemeResultsState extends ThemeState {
  final List<ThemeModel>? themes;
  GetThemeResultsState({this.themes});

  @override
  // TODO: implement props
  List<Object?> get props => [themes];
}