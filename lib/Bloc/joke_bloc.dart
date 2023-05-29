import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiley/Constants/api_url_constants.dart';
import '../ApiCall/api_call.dart';
import '../Database/db.dart';
import '../Model/joke_model.dart';
import 'joke_event.dart';
import 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  JokeBloc() : super(JokeInitial()) {

    on<GetJokeList>((event, emit) async {
      try {
        emit(JokeLoading());
        final mList = await ApiCall.getJokes(ApiUrlConstants.jokeAPIUrl);
        emit(JokeLoaded(mList));
        if (mList.errorMsg != null) {
          emit(JokeMsg(mList.errorMsg));
        }
      } on NetworkError {
        emit(const JokeMsg("Failed to fetch data. is your device online?"));
      }
    });

    on<GetJokeListFromDB>((event, emit) async {
      try {
        emit(JokeLoading());
        final mList = await DB.db.getAllJokes();//await ApiCall.getJokes(ApiUrlConstants.jokeAPIUrl);
        emit(JokeLoaded(mList));
        if (mList.errorMsg != null) {
          emit(JokeMsg(mList.errorMsg));
        }
      } on NetworkError {
        emit(const JokeMsg("Failed to fetch data. is your device online?"));
      }
    });

    on<DeleteAllJokeFromDB>((event, emit) async {
      try {
        emit(JokeLoading());
        final deleted = await DB.db.deleteAllJokes();//await ApiCall.getJokes(ApiUrlConstants.jokeAPIUrl);
        emit(const JokeMsg("Data deleted successfully"));
          emit(JokeLoaded(JokeModel(amount:0,jokes: [])));
      } on NetworkError {
        emit(const JokeMsg("Failed to fetch data. is your device online?"));
      }
    });

  }
}