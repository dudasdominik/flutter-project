class User {
  final String id;
  final String userName;
  final String tagName;
  final String email;
  final String phoneNumber;
  final String password;
  final DateTime birthDate;
  final DateTime joinDate;
  final String? profilePicture;
  final String? bannerPicture;
  final List<int> ownPosts;
  final List<int> savedPosts;
  final List<int> likedPosts;
  final List<int> followers;
  final List<int> followings;
  final String? location;
  final String? bio;
  final String? role;
  final bool isVerified;
  final DateTime? lastLoginDate;
  final int gender;
  final String firstName;
  final String lastName;

  const User({
    required this.id,
    required this.userName,
    required this.tagName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.birthDate,
    required this.joinDate,
    this.profilePicture,
    this.bannerPicture,
    this.ownPosts = const [],
    this.savedPosts = const [],
    this.likedPosts = const [],
    this.followers = const [],
    this.followings = const [],
    this.location,
    this.bio,
    this.role,
    this.isVerified = false,
    this.lastLoginDate,
    this.gender = 0,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      userName: json['userName'] as String,
      tagName: json['tagName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      joinDate: DateTime.parse(json['joinDate'] as String),
      profilePicture: json['profilePicture'] as String?,
      bannerPicture: json['bannerPicture'] as String?,
      ownPosts:
          (json['ownPosts'] as List<dynamic>).map((e) => e as int).toList(),
      savedPosts:
          (json['savedPosts'] as List<dynamic>).map((e) => e as int).toList(),
      likedPosts:
          (json['likedPosts'] as List<dynamic>).map((e) => e as int).toList(),
      followers:
          (json['followers'] as List<dynamic>).map((e) => e as int).toList(),
      followings:
          (json['followings'] as List<dynamic>).map((e) => e as int).toList(),
      location: json['location'] as String?,
      bio: json['bio'] as String?,
      role: json['role'] as String?,
      isVerified: json['isVerified'] as bool,
      lastLoginDate: json['lastLoginDate'] == null
          ? null
          : DateTime.parse(json['lastLoginDate'] as String),
      gender: json['gender'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );
  }
}
