import 'package:equatable/equatable.dart';
import 'package:matching_pairs/cubit/theme_model.dart';

abstract class ScoreState extends Equatable {}

class InitialState extends ScoreState {
  @override
  List<Object> get props => [];
}

class LoadingState extends ScoreState {
  @override
  List<Object> get props => [];
}

class ErrorState extends ScoreState {
  final String? errorMessage;
  ErrorState({this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];

}

class GetScoreState extends ScoreState {
  final int? score;
  GetScoreState({this.score});

  @override
  // TODO: implement props
  List<Object?> get props => [score];
}