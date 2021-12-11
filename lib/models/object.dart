class Object {
  final String uid;
  Object({this.uid});
}

class UserData {
  final String uid;
  final String profileName;
  final String url;
  final String email;
  final String bio;
  final String username;
  final String userImage;
  final String postImage;
  final String caption;
  UserData(
      {this.uid,
      this.profileName,
      this.url,
      this.email,
      this.bio,
      this.username,
      this.userImage,
      this.postImage,
      this.caption});
}
