class Task {
  final int? id;
  final String title;
  final String description;
  final String category;
  final String createdDate;
  final String createdTime;
  final int? isCompleted;
  final int? color;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.createdDate,
      required this.createdTime,
      this.isCompleted,
      this.color});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'createdDate': createdDate,
      'createdTime': createdTime,
      'isCompleted': isCompleted,
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
        isCompleted: map['isCompleted'],
        color: map['color']);
  }
}
