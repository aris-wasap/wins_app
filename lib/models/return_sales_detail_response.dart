// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final returnSalesDetailResponse = returnSalesDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'return_sales_detail_response.g.dart';

ReturnSalesDetailResponse returnSalesDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReturnSalesDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReturnSalesDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  ReturnSalesDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReturnSalesDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$ReturnSalesDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReturnSalesDetailResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'ReturnRequestId')
  int returnRequestId;

  @JsonKey(name: 'ReturnRequestNo')
  String returnRequestNo;

  @JsonKey(name: 'SeriesNameReqNo')
  String seriesNameReqNo;

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'DoId')
  int doId;

  @JsonKey(name: 'DoNo')
  String doNo;

  @JsonKey(name: 'SeriesNameDo')
  String seriesNameDo;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'CustomerCode')
  String customerCode;

  @JsonKey(name: 'CustomerName')
  String customerName;

  @JsonKey(name: 'ContactPerson')
  String contactPerson;

  @JsonKey(name: 'RefNo')
  String refNo;

  @JsonKey(name: 'Address')
  String address;

  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

  @JsonKey(name: 'SapReturnId')
  int sapReturnId;

  @JsonKey(name: 'SapReturnNo')
  String sapReturnNo;

  @JsonKey(name: 'CreatedUser')
  int createdUser;

  @JsonKey(name: 'Status')
  String status;

  @JsonKey(name: 'Items')
  List<Item> items;

  Data({
    this.returnRequestId = 0,
    this.returnRequestNo,
    this.seriesNameReqNo,
    this.doId: 0,
    this.doNo,
    this.seriesNameDo,
    this.id: 0,
    this.transNo,
    this.seriesName,
    this.transDate,
    this.customerCode,
    this.customerName,
    this.contactPerson,
    this.refNo,
    this.address,
    this.branchId,
    this.branchName,
    this.sapReturnId: 0,
    this.sapReturnNo,
    this.createdUser,
    this.status,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: 'ReturnRequestId')
  int returnRequestId;

  @JsonKey(name: 'ReturnRequestLineNo')
  int returnRequestLineNo;

  @JsonKey(name: 'DoId')
  int doId;

  @JsonKey(name: 'DoLineNo')
  int doLineNo;

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

  @JsonKey(name: 'ReqQty')
  double reqQty;

  @JsonKey(name: 'DoQty')
  double doQty;

  @JsonKey(name: 'Qty')
  double qty;

  @JsonKey(name: 'Length')
  double length;

  @JsonKey(name: 'Length2')
  double length2;

  @JsonKey(name: 'Width')
  double width;

  @JsonKey(name: 'Weight')
  double weight;

  @JsonKey(name: 'Micron')
  double micron;

  @JsonKey(name: 'Type')
  String type;

  @JsonKey(name: 'ItemType')
  String itemType;

  @JsonKey(name: 'Uom')
  String uom;

  @JsonKey(name: 'WhsCode')
  String whsCode;

  @JsonKey(name: 'WhsName')
  String whsName;

  @JsonKey(name: 'BinAbs')
  int binAbs;

  @JsonKey(name: 'BinCode')
  String binCode;

  @JsonKey(name: 'BatchNo')
  String batchNo;

  Item({
    this.returnRequestId,
    this.returnRequestLineNo,
    this.doId: 0,
    this.doLineNo: 0,
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName,
    this.reqQty,
    this.doQty: 0,
    this.qty: 0,
    this.length,
    this.length2,
    this.width,
    this.weight,
    this.type,
    this.itemType,
    this.uom,
    this.whsCode,
    this.whsName,
    this.binAbs,
    this.binCode,
    this.batchNo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
