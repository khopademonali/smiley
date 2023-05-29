import '../Model/joke_model.dart';

class JokeState {
  const JokeState();

  // @override
  List<Object?> get props => [];
}
class JokeInitial extends JokeState {}

class JokeLoading extends JokeState {}

class JokeLoaded extends JokeState {
  final JokeModel jokeModel;
  const JokeLoaded(this.jokeModel);
}

class JokeMsg extends JokeState {
  final String? message;
  const JokeMsg(this.message);
}

// class JokeLoadedAlready extends JokeState{}