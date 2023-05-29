import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/Joke_bloc.dart';
import '../Bloc/joke_event.dart';
import '../Bloc/joke_state.dart';
import '../Database/db.dart';
import '../Model/joke_model.dart';

class FavouriteJokes extends StatefulWidget {
  @override
  _FavouriteJokesState createState() => _FavouriteJokesState();
}

class _FavouriteJokesState extends State<FavouriteJokes> {
  final JokeBloc _jokeBloc = JokeBloc();

  @override
  void initState() {
    _jokeBloc.add(GetJokeListFromDB());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke List'),
        actions: [
          IconButton(onPressed: (){
            _jokeBloc.add(DeleteAllJokeFromDB());
          }, icon: Icon(Icons.delete))
        ],
      ),
      body: _buildListJoke(),
    );
  }

  Widget _buildListJoke() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _jokeBloc,
        child: BlocListener<JokeBloc, JokeState>(
          listener: (context, state) {
            if (state is JokeMsg) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<JokeBloc, JokeState>(
            builder: (context, state) {
              if (state is JokeInitial) {
                return _buildLoading();
              } else if (state is JokeLoading) {
                return _buildLoading();
              } else if (state is JokeLoaded) {
                return _buildCard(context, state.jokeModel);
              } else if (state is JokeMsg) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, JokeModel model) {
    if(model.jokes!.isEmpty){
      return const Center(
        child: Text("No data saved in DB"),
      );
    }
    return ListView(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: model.jokes?.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("Joke: ${model.jokes![index].joke}"),
                        trailing: IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: ()async{
                           await DB.db.addJoke(model.jokes![index]);
                            _jokeBloc.add(GetJokeListFromDB());
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}