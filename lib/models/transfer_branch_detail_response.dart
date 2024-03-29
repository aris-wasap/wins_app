// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final TransferBranchDetailResponse = TransferBranchDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'transfer_branch_detail_response.g.dart';

TransferBranchDetailResponse transferBranchDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return TransferBranchDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class TransferBranchDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  TransferBranchDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory TransferBranchDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$TransferBranchDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TransferBranchDetailResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'RequestId')
  int requestId;

  @JsonKey(name: 'RequestNo')
  String requestNo;

  @JsonKey(name: 'SeriesNameReqNo')
  String seriesNameReqNo;

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

  @JsonKey(name: 'ToBranchId')
  int toBranchId;

  @JsonKey(name: 'ToBranchName')
  String toBranchName;

  @JsonKey(name: 'SapTransferBranchId')
  int sapTransferBranchId;

  @JsonKey(name: 'SapTransferBranchNo')
  String sapTransferBranchNo;

  @JsonKey(name: 'CreatedUser')
  int createdUser;

  @JsonKey(name: 'Status')
  String status;

  @JsonKey(name: 'Items')
  List<Item> items;

  Data({
    this.requestId = 0,
    this.requestNo,
    this.seriesNameReqNo,
    this.id: 0,
    this.seriesName,
    this.transNo,
    this.transDate,
    this.branchId,
    this.branchName,
    this.toBranchId,
    this.toBranchName,
    this.sapTransferBranchId: 0,
    this.sapTransferBranchNo,
    this.createdUser,
    this.status,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: 'RequestId')
  int requestId;

  @JsonKey(name: 'RequestLineNo')
  int requestLineNo;

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

  @JsonKey(name: 'Qty')
  double qty;

  @JsonKey(name: 'AvailableQty')
  double availableQty;

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

  @JsonKey(name: 'ToWhsCode')
  String toWhsCode;

  @JsonKey(name: 'ToWhsName')
  String toWhsName;

  @JsonKey(name: 'ToBinAbs')
  int toBinAbs;

  @JsonKey(name: 'ToBinCode')
  String toBinCode;

  @JsonKey(name: 'BatchNo')
  String batchNo;

  Item({
    this.requestId,
    this.requestLineNo,
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName,
    this.reqQty: 0,
    this.qty: 0,
    this.availableQty: 0,
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
    this.toWhsCode,
    this.toWhsName,
    this.toBinAbs,
    this.toBinCode,
    this.batchNo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
