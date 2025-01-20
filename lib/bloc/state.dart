part of 'bloc.dart';

abstract class QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<Question> questions;

  QuizLoaded({required this.questions});
}

class QuizError extends QuizState {
  final String message;

  QuizError({required this.message});
}
