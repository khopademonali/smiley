class JokeModel {
  bool? error;
  int? amount;
  List<Joke>? jokes;
  String? errorMsg;

  JokeModel({this.error, this.amount, this.jokes});

  JokeModel.withError(String errorMessage) {
    errorMsg = errorMessage;
  }

  JokeModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    amount = json['amount'];
    if (json['jokes'] != null) {
      jokes = <Joke>[];
      json['jokes'].forEach((v) {
        jokes!.add(new Joke.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['amount'] = this.amount;
    if (this.jokes != null) {
      data['jokes'] = this.jokes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Joke {
  // String? category;
  // String? type;
  // String? id;
  String? joke;
  // Flags? flags;
  int? jokeID;
  // bool? safe;
  // String? lang;
  int? likeCount;

  Joke(
      {
        // this.id,
        // this.category,
        // this.type,
        this.joke,
        // this.flags,
        this.jokeID,
        // this.safe,
        // this.lang
        this.likeCount
      });

  Joke.fromJson(Map<String, dynamic> json) {
    // id = '';
    // category = json['category'];
    // type = json['type'];
    joke = json['joke'];
    // flags = json['flags'] != null ? new Flags.fromJson(json['flags']) : null;
    if(json['jokeID']==null) {
      jokeID = json['id'];
    }
    else{
      jokeID = json['jokeID'];
    }
    // safe = json['safe'];
    // lang = json['lang'];
    likeCount = json['likeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['category'] = this.category;
    // data['type'] = this.type;
    // data['id'] = '';
    data['joke'] = this.joke;
    // if (this.flags != null) {
    //   data['flags'] = this.flags!.toJson();
    // }
    data['jokeID'] = this.jokeID;
    // data['safe'] = this.safe;
    // data['lang'] = this.lang;
    data['likeCount'] = this.likeCount;
    return data;
  }
}
