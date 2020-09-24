// To parse this JSON data, do
//
//     final groupLeaderCpBody = groupLeaderCpBodyFromJson(jsonString);

import 'dart:convert';

GroupLeaderCpBody groupLeaderCpBodyFromJson(String str) => GroupLeaderCpBody.fromJson(json.decode(str));

String groupLeaderCpBodyToJson(GroupLeaderCpBody data) => json.encode(data.toJson());

class GroupLeaderCpBody {
  GroupLeaderCpBody({
    this.transferCheckPointId,
    this.image,
    this.defectIds,
  });

  String transferCheckPointId;
  String image;
  List<dynamic> defectIds;

  GroupLeaderCpBody copyWith({
    String transferCheckPointId,
    String image,
    List<dynamic> defectIds,
  }) =>
      GroupLeaderCpBody(
        transferCheckPointId: transferCheckPointId ?? this.transferCheckPointId,
        image: image ?? this.image,
        defectIds: defectIds ?? this.defectIds,
      );

  factory GroupLeaderCpBody.fromJson(Map<String, dynamic> json) => GroupLeaderCpBody(
    transferCheckPointId: json["transferCheckPointId"],
    image: json["image"],
    defectIds: List<dynamic>.from(json["defectIds"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "transferCheckPointId": transferCheckPointId,
    "image": image,
    "defectIds": List<dynamic>.from(defectIds.map((x) => x)),
  };
}
