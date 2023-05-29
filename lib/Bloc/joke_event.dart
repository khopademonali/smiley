// part of 'Joke_bloc.dart';

import '../Model/joke_model.dart';

abstract class JokeEvent {
  const JokeEvent();

  List<Object> get props => [];
}

class GetJokeList extends JokeEvent {}

class GetJokeListFromDB extends JokeEvent{}

class DeleteAllJokeFromDB extends JokeEvent{}
