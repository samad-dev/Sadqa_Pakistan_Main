class UserDetail {
  String? displayName;
  String? email;
  String? id;
  String? photoUrl;

  UserDetail({
    this.displayName, 
    this.email, 
    this.id,
    this.photoUrl
  });

  UserDetail.fromJson(Map<String, dynamic> json){
    displayName = json["displayName"];
    email = json["email"];
    id = json["id"];
    photoUrl = json["photoUrl"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["displayName"]  = this.displayName;
    data["email"]  = this.email;
    data["id"]  = this.id;
    data["photoUrl"]  = this.photoUrl;

    return data;

  }
}
