class User {
  String id;
  final String name;
  final String s_id;

  User({
    this.id = '',
    required this.name,
    required this.s_id,
  });

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 's_id': s_id};

  static User fromJson(Map<String, dynamic> json) =>
      User(name: json['name'], s_id: json['s_id']);
}
