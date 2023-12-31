class Task {
  final int? id;
  final String title;
  final String description;
  final String category;
  final String createdDate;
  final String createdTime;
  bool isCompleted;
  final int? color;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.createdDate,
      required this.createdTime,
      this.isCompleted = false,
      this.color});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'createdDate': createdDate,
      'createdTime': createdTime,
      'isCompleted': isCompleted ? 1 : 0,
      'color': color
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        category: map['category'],
        createdDate: map['createdDate'],
        createdTime: map['createdTime'],
        isCompleted: map['isCompleted'] == 1,
        color: map['color']);
  }
}
