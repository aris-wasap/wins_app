// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final transferReleaseDetailResponse = transferReleaseDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'transfer_release_detail_response.g.dart';

TransferReleaseDetailResponse transferReleaseDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return TransferReleaseDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class TransferReleaseDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  TransferReleaseDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory TransferReleaseDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$TransferReleaseDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TransferReleaseDetailResponseToJson(this);
}

@JsonSerializable()
class Data {
  
  @JsonKey(name: 'Id')
  int id;  

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;  

  @JsonKey(name: 'WhsCodeFrom')
  String whsCodeFrom; 
  
  @JsonKey(name: 'WhsNameFrom')
  String whsNameFrom;

  @JsonKey(name: 'WhsCodeTo')
  String whsCodeTo;

  @JsonKey(name: 'WhsNameTo')
  String whsNameTo;


  @JsonKey(name: 'Items')
  List<Item> items;

  
  

  Data({  
    this.id: 0,
    this.transNo,
    this.transDate, 
    this.whsCodeFrom,
    this.whsNameFrom,
    this.whsCodeTo, 
    this.whsNameTo, 
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
} 

@JsonSerializable()
class Item {  

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'LineNo')
  int lineNo;

  @JsonKey(name: 'VisLineNo')
  int visLineNo;

  @JsonKey(name: 'ItemCode')
  String itemCode;

  @JsonKey(name: 'ItemName')
  String itemName; 

  @JsonKey(name: 'Qty')
  double qty;

  @JsonKey(name: 'Uom')
  String uom; 

  @JsonKey(name: 'BatchNo')
  String batchNo; 
   
 
 
  Item({ 
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName, 
    this.qty: 0,
    this.uom, 
    this.batchNo, 
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
 