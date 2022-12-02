class JwtResponse{
  final String token;
  final String refreshToken;
  final String firstName;
  final String lastName;

  JwtResponse({
    required this.token,
    required this.refreshToken,
    required this.firstName,
    required this.lastName
  });

  JwtResponse.fromJson(Map<String, dynamic> json)
   :token =  json['token'],
    refreshToken = json['refreshToken'],
    firstName = json['firstName'],
    lastName = json['lastName'];

  Map<String, dynamic> toJson() => {
    'token': token,
    'refreshToken': refreshToken,
    'firstName': firstName,
    'lastName' : lastName
  };
}