// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final purchaseCreditDetailResponse = purchaseCreditDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'purchase_credit_detail_response.g.dart';

PurchaseCreditDetailResponse purchaseCreditDetailResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return PurchaseCreditDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class PurchaseCreditDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  PurchaseCreditDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory PurchaseCreditDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$PurchaseCreditDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PurchaseCreditDetailResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'ReturnRequestId')
  int returnRequestId;

  @JsonKey(name: 'ReturnRequestNo')
  String returnRequestNo;

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

  @JsonKey(name: 'SeriesNameReturnRequest')
  String seriesNameReturnRequest;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

  @JsonKey(name: 'Items')
  List<Item> items;

  Data({
    this.returnRequestId: 0,
    this.returnRequestNo,
    this.id: 0,
    this.transNo,
    this.transDate,
    this.vendorCode,
    this.vendorName,
    this.contactPerson,
    this.refNo,
    this.address,
    this.seriesNameReturnRequest,
    this.seriesName,
    this.branchId,
    this.branchName,
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

  @JsonKey(name: 'ReturnRequestQty')
  double returnRequestQty;

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
    this.returnRequestId: 0,
    this.returnRequestLineNo: 0,
    this.webId,
    this.webDetId,
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName,
    this.returnRequestQty: 0,
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
