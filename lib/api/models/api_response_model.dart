class ApiResponse {
  final String value;

  ApiResponse({required this.value});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(value: json['value']);
  }
}