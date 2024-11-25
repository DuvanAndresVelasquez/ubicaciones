class FriendLocationModel {
  final int? id;
  final int friendId;
  final int locationId;

  FriendLocationModel({
    this.id,
    required this.friendId,
    required this.locationId,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'friend_id': friendId,
      'location_id': locationId,
    };
  }

   factory FriendLocationModel.fromMap(Map<String, dynamic> map) {
    return FriendLocationModel(
      id: map['id'],
      friendId: map['friend_id'],
      locationId: map['location_id'],
    );
  }
}
