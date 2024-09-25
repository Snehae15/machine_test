class JewelleryModel {
  final String id;
  final String name;
  final int uid;
  final int docType;
  final String url;

  JewelleryModel.fromJson(Map<String, dynamic> json)
      : id = json["_id"],
        name = json["_name"],
        uid = json["_uid"],
        docType = json["_docType"],
        url = json["_url"];
}
