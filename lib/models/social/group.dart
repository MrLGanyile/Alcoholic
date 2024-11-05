import '../section_name.dart';
import 'dart:math';

import '../Utilities/converter.dart';

// Collection Name /groups
class Group implements Comparable<Group> {
  String groupName;
  String groupImageURL;
  SectionName groupSectionName;
  String groupSpecificArea;

  String groupCreatorPhoneNumber;
  String groupCreatorImageURL;
  String groupCreatorUsername;
  bool isActive; // A group is active if it has atleast 10 members.
  int maxNoOfMembers;

  List<String> groupMembers;

  Group({
    required this.groupName,
    required this.groupImageURL,
    required this.groupSectionName,
    required this.groupSpecificArea,
    required this.groupCreatorPhoneNumber,
    required this.groupCreatorImageURL,
    required this.groupCreatorUsername,
    required this.groupMembers,
    this.isActive = false,
    required this.maxNoOfMembers,
  });

  void createRandomCompetitorGroup() {
    List<int> shuffledList = [];
    for (int i = 1; i <= 20; i++) {
      shuffledList.add(i);
    }
    shuffledList.shuffle();

    int numberOfGroupMembers = 1 + Random().nextInt(11);
    for (int groupMember = 0;
        groupMember < numberOfGroupMembers;
        groupMember++) {
      groupMembers
          .add('assets/users/alcoholics/${shuffledList[groupMember]}.jpg');
    }
  }

  Map<String, dynamic> toJson() => {
        'groupName': groupName,
        'groupImageURL': groupImageURL,
        'groupCreatorPhoneNumber': groupCreatorPhoneNumber,
        'groupSectionName': Converter.asString(groupSectionName),
        'groupSpecificArea': groupSpecificArea,
        'groupCreatorUsername': groupCreatorUsername,
        'groupCreatorImageURL': groupCreatorImageURL,
        'groupMembers': groupMembers,
        'isActive': isActive,
        'maxNoOfMembers': maxNoOfMembers,
      };

  factory Group.fromJson(dynamic json) => Group(
      groupName: json['groupName'],
      groupImageURL: json['groupImageURL'],
      groupSectionName: Converter.toSectionName(json['groupSectionName']),
      groupSpecificArea: json['groupSpecificArea'],
      groupCreatorPhoneNumber: json['groupCreatorPhoneNumber'],
      groupCreatorImageURL: json['groupCreatorImageURL'],
      groupMembers: toListOfStrings(json['groupMembers']),
      isActive: json['isActive'],
      maxNoOfMembers: json['maxNoOfMembers'],
      groupCreatorUsername: json['groupCreatorUsername']);

  @override
  int compareTo(Group other) {
    return Converter.asString(groupSectionName)
        .compareTo(Converter.asString(other.groupSectionName));
  }
}

List<String> toListOfStrings(List<dynamic> members) {
  List<String> list = [];

  for (int i = 0; i < members.length; i++) {
    list.add(members[i].toString());
  }
  return list;
}
