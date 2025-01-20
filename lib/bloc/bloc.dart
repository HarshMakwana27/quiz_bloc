import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/data/model/question.dart';
import 'package:quiz_app/data/repo/repo.dart';

part 'event.dart';
part 'state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuestionRepository repository;

  QuizBloc({required this.repository}) : super(QuizLoading()) {
    on<FetchQuestions>((event, emit) async {
      emit(QuizLoading());
      try {
        final questions = await repository.fetchQuestions();
        emit(QuizLoaded(questions: questions));
      } catch (e) {
        emit(QuizError(message: e.toString()));
      }
    });
  }
}
