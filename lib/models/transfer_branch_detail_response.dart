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

  @JsonKey(name: 'Items')
  List<Item> items;

  Data({
    this.id: 0,
    this.seriesName,
    this.transNo,
    this.transDate,
    this.branchId,
    this.branchName,
    this.toBranchId,
    this.toBranchName,
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

  @JsonKey(name: 'ItemCost')
  double itemCost;

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
  String ToWhsName;

  @JsonKey(name: 'ToBinAbs')
  int ToBinAbs;

  @JsonKey(name: 'ToBinCode')
  String ToBinCode;

  @JsonKey(name: 'BatchNo')
  String batchNo;

  Item({
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName,
    this.qty: 0,
    this.itemCost: 0,
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
