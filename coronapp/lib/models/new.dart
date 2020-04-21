class New {
  final int id;
  final String title;
  final String body;
  final DateTime date;

  New({this.id, this.title, this.body, this.date});

  factory New.fromJson(Map<String, dynamic> json) {
    return New(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      date: json['date'],
    );
  }
  
}
