import 'dart:convert';

JewelleryData jewelleryDataFromJson(String str) => JewelleryData.fromJson(json.decode(str));

String jewelleryDataToJson(JewelleryData data) => json.encode(data.toJson());

class JewelleryData {
  bool status;
  List<Datum> data;

  JewelleryData({
    required this.status,
    required this.data,
  });

  factory JewelleryData.fromJson(Map<String, dynamic> json) => JewelleryData(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String jewlleryname;
  String jewlleryprice;
  String jewllerydescription;
  String jewllerycategory;
  String jewllcategoryId;
  String jewllavailableItemquantity;
  String jewllImage;

  Datum({
    required this.id,
    required this.jewlleryname,
    required this.jewlleryprice,
    required this.jewllerydescription,
    required this.jewllerycategory,
    required this.jewllcategoryId,
    required this.jewllavailableItemquantity,
    required this.jewllImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    jewlleryname: json["jewlleryname"],
    jewlleryprice: json["jewlleryprice"],
    jewllerydescription: json["jewllerydescription"],
    jewllerycategory: json["jewllerycategory"],
    jewllcategoryId: json["jewllcategory_id"],
    jewllavailableItemquantity: json["jewllavailable_itemquantity"],
    jewllImage: json["jewll_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "jewlleryname": jewlleryname,
    "jewlleryprice": jewlleryprice,
    "jewllerydescription": jewllerydescription,
    "jewllerycategory": jewllerycategory,
    "jewllcategory_id": jewllcategoryId,
    "jewllavailable_itemquantity": jewllavailableItemquantity,
    "jewll_image": jewllImage,
  };
}
