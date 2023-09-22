class User {
  final String id;
  final String name;
  final String email;
  final String imageUrl;

  User({this.id = '', this.name = '', this.email = '', this.imageUrl = ''});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      imageUrl: json['image'] as String,
    );
  }
}
