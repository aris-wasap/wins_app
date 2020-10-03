// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final purchaseReturnsDetailResponse = purchaseReturnsDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'purchase_returns_detail_response.g.dart';

PurchaseReturnsDetailResponse purchaseReturnsDetailResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return PurchaseReturnsDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class PurchaseReturnsDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  PurchaseReturnsDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory PurchaseReturnsDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$PurchaseReturnsDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PurchaseReturnsDetailResponseToJson(this);
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

  @JsonKey(name: 'GrpoId')
  int grpoId;

  @JsonKey(name: 'GrpoNo')
  String grpoNo;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'VendorCode')
  String vendorCode;

  @JsonKey(name: 'VendorName')
  String vendorName;

  @JsonKey(name: 'ContactPerson')
  String contactPerson;

  @JsonKey(name: 'RefNo')
  String refNo;

  @JsonKey(name: 'Address')
  String address;

  @JsonKey(name: 'SeriesNameGrpo')
  String seriesNameGrpo;

  @JsonKey(name: 'SeriesName')
  String seriesName;

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
    this.grpoId: 0,
    this.grpoNo,
    this.id: 0,
    this.transNo,
    this.transDate,
    this.vendorCode,
    this.vendorName,
    this.contactPerson,
    this.refNo,
    this.address,
    this.seriesNameGrpo,
    this.seriesName,
    this.branchId,
    this.branchName,
    this.sapReturnId:0,
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

  @JsonKey(name: 'GrpoId')
  int grpoId;

  @JsonKey(name: 'GrpoLineNo')
  int grpoLineNo;

  @JsonKey(name: 'WebId')
  int webId;

  @JsonKey(name: 'WebDetId')
  int webDetId;

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

  @JsonKey(name: 'GrpoQty')
  double grpoQty;

  @JsonKey(name: 'Qty')
  double qty;

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
    this.grpoId: 0,
    this.grpoLineNo: 0,
    this.webId,
    this.webDetId,
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName,
    this.reqQty: 0,
    this.grpoQty: 0,
    this.qty: 0,
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
