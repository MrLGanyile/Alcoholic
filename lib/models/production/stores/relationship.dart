// Collection Name /relationships/userId
class Relationship{

  String userId;
  String imageURL;
 
  List<String> joinedStoresFKs;

  Relationship({
    required this.userId,
    required this.imageURL,
    
    this.joinedStoresFKs = const[],
  });

  Map<String, dynamic> toJson(){

    return {
      'User Id': userId,
      'Image URL': imageURL,
      
      'Joined Stores FKs': joinedStoresFKs,
    };
  }

  factory Relationship.fromJson(Map<String, dynamic> json){
    
    Relationship storeMember = Relationship(
    userId: json['User Id'], 
    imageURL: json['Image URL'],
    
    joinedStoresFKs: json['Joined Stores FKs']
    );

    return storeMember;
  }
}