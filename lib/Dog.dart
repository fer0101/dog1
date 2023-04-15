// ignore_for_file: file_names

class Dog {
  final String message;
  Dog({required this.message});
  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(message: json['message']);
  }
}
