abstract interface class Dto {
  Dto.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
