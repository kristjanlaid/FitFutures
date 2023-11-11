class RegisterData {
  late String name;
  late int age;
  late int height;
  late int weight;

  RegisterData({
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'height': height,
      'weight': weight,
    };
  }
}
