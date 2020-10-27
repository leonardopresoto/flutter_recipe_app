class Recipe {
  String title;
  String photo;
  String portion;
  String duration;
  String ingredients;
  String method;


  Recipe({this.title, this.photo, this.portion, this.duration, this.ingredients,
      this.method});

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    title: json['title'] as String,
    photo:  json['photo'] as String,
    portion: json['portion'] as String,
    duration: json['duration'] as String,
    ingredients: json['ingredients'] as String,
    method: json['method'] as String,
    );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['photo'] = this.photo;
    data['portion'] = this.portion;
    data['duration'] = this.duration;
    data['ingredients'] = this.ingredients;
    data['method'] = this.method;
    return data;
  }

  @override
  String toString() {
    return 'Recipe{title: $title, photo: $photo, portion: $portion, duration: $duration, ingredients: $ingredients, method: $method}';
  }
}

