class Task {
  late String id;
  late String userId;
  late String title;
  late bool completed;
  late bool excluido;

  Task(
      {required this.id,
      required this.userId,
      required this.title,
      required this.completed,
      required this.excluido});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    completed = json['completed'];
    excluido = json['excluido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['title'] = title;
    data['completed'] = completed;
    data['excluido'] = excluido;
    return data;
  }
}
