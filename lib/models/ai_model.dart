class AiModel {
  final String name;
  final String model;

  AiModel(this.name, this.model);

  factory AiModel.fromJson(Map<String, dynamic> json) {
    return AiModel(
      json['name'] ?? "",
      json['model'] ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'model': model};
  }
}
