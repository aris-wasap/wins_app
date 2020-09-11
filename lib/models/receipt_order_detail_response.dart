// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final receiptOrderDetailResponse = receiptOrderDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'receipt_order_detail_response.g.dart';

ReceiptOrderDetailResponse receiptOrderDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReceiptOrderDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceiptOrderDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  ReceiptOrderDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceiptOrderDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$ReceiptOrderDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceiptOrderDetailResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'PoId')
  int poId;

  @JsonKey(name: 'PoNo')
  String poNo;

  @JsonKey(name: 'TransNo')
  String transNo;

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

  @JsonKey(name: 'SeriesNamePo')
  String seriesNamePo;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

  @JsonKey(name: 'Items')
  List<Item> items;

  Data({
    this.poId: 0,
    this.poNo,
    this.id: 0,
    this.transNo,
    this.transDate,
    this.customerCode,
    this.customerName,
    this.contactPerson,
    this.refNo,
    this.address,
    this.seriesNamePo,
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
  @JsonKey(name: 'PoId')
  int poId;

  @JsonKey(name: 'PoLineNo')
  int poLineNo;

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

  @JsonKey(name: 'PoQty')
  double poQty;

  @JsonKey(name: 'Qty')
  double qty;

  @JsonKey(name: 'Length')
  double length;

  @JsonKey(name: 'Width')
  double width;

  @JsonKey(name: 'Weight')
  double weight;

  @JsonKey(name: 'Micron')
  double micron;

  @JsonKey(name: 'UnitPriceTc')
  double unitPriceTc;

  @JsonKey(name: 'NetUnitPriceTc')
  double netUnitPriceTc;

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
    this.poId: 0,
    this.poLineNo: 0,
    this.webId,
    this.webDetId,
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName,
    this.poQty: 0,
    this.qty: 0,
    this.length,
    this.width,
    this.weight,
    this.unitPriceTc,
    this.netUnitPriceTc,
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
