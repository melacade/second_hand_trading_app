class SecurityProblems {
  String message;
  int code;
  List<Data> data;

  SecurityProblems({this.message, this.code, this.data});

  SecurityProblems.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String question;
  String answer;
  String userID;
  int changeTime;

  Data({this.id, this.question, this.answer, this.userID, this.changeTime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    userID = json['userID'];
    changeTime = json['changeTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['userID'] = this.userID;
    data['changeTime'] = this.changeTime;
    return data;
  }
}