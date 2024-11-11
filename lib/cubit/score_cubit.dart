import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matching_pairs/cubit/score_state.dart';

class ScoreCubit extends Cubit<ScoreState> {
  ScoreCubit() : super(InitialState());

  Future setScore(int score) async {
    try {
      emit(LoadingState());
      emit(GetScoreState(score: score));
    } catch (e) {
      emit(ErrorState(errorMessage: 'Error'));
    }
  }
}