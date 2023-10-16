// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final goodsIssueDetailResponse = goodsIssueDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'goods_issue_detail_response.g.dart';

GoodsIssueDetailResponse goodsIssueDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return GoodsIssueDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class GoodsIssueDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  GoodsIssueDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory GoodsIssueDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$GoodsIssueDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GoodsIssueDetailResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'BaseId')
  int baseId;

  @JsonKey(name: 'WoId')
  int woId;

  @JsonKey(name: 'WoNo')
  String woNo;

  @JsonKey(name: 'WoDate')
  DateTime woDate;

  @JsonKey(name: 'ProductCode')
  String productCode;

  @JsonKey(name: 'ProductName')
  String productName;

  @JsonKey(name: 'Weight')
  double weight;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'BaseNo')
  String baseNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'SeriesNameWo')
  String seriesNameWo;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'SapGoodsIssueId')
  int sapGoodsIssueId;

  @JsonKey(name: 'SapGoodsIssueNo')
  String sapGoodsIssueNo;

  @JsonKey(name: 'SapGoodsReceiptId')
  int sapGoodsReceiptId;

  @JsonKey(name: 'SapGoodsReceiptNo')
  String sapGoodsReceiptNo;

  @JsonKey(name: 'Status')
  String status;

  @JsonKey(name: 'Items')
  List<Item> items;

  Data({
    this.woId: 0,
    this.woNo,
    this.id: 0,
    this.transNo,
    this.baseId: 0,
    this.baseNo,
    this.transDate,
    this.seriesNameWo,
    this.seriesName,
    this.sapGoodsIssueId: 0,
    this.sapGoodsIssueNo,
    this.sapGoodsReceiptId: 0,
    this.sapGoodsReceiptNo,
    this.weight: 0,
    this.status,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: 'WoId')
  int woId;

  @JsonKey(name: 'WoLineNo')
  int woLineNo;

  @JsonKey(name: 'WoVisOrder')
  int woVisOrder;

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'DetId')
  int detId;

  @JsonKey(name: 'DetDetId')
  int detDetId;

  @JsonKey(name: 'LineNo')
  int lineNo;

  @JsonKey(name: 'VisLineNo')
  int visLineNo;

  @JsonKey(name: 'ItemCode')
  String itemCode;

  @JsonKey(name: 'ItemName')
  String itemName;

  @JsonKey(name: 'WoQty')
  double woQty;

  @JsonKey(name: 'Qty')
  double qty;

  @JsonKey(name: 'OpenQty')
  double openQty;

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

  @JsonKey(name: 'ProductionType')
  String productionType;

  @JsonKey(name: 'ValuationMethod')
  String valuationMethod;

  @JsonKey(name: 'Batchs')
  List<ItemBatch> batchs;

  Item({
    this.woId: 0,
    this.woLineNo: 0,
    this.woVisOrder: 0,
    this.id: 0,
    this.detId: 0,
    this.detDetId: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName,
    this.woQty: 0,
    this.qty: 0,
    this.openQty: 0,
    this.uom,
    this.whsCode,
    this.whsName,
    this.binAbs: 0,
    this.binCode,
    this.toWhsCode,
    this.toWhsName,
    this.toBinAbs: 0,
    this.toBinCode,
    this.batchNo,
    this.productionType,
    this.valuationMethod,
    this.batchs,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class ItemBatch {
  @JsonKey(name: 'Id')
  int id;
  @JsonKey(name: 'DetId')
  int detId;
  @JsonKey(name: 'DetDetId')
  int detDetId;
  @JsonKey(name: 'ItemCode')
  String itemCode;
  @JsonKey(name: 'BinAbs')
  int binAbs;
  @JsonKey(name: 'BinCode')
  String binCode;
  @JsonKey(name: 'BatchNo')
  String batchNo;
  @JsonKey(name: 'WhsCode')
  String whsCode;
  @JsonKey(name: 'WhsName')
  String whsName;
  @JsonKey(name: 'ToWhsCode')
  String toWhsCode;
  @JsonKey(name: 'ToWhsName')
  String toWhsName;
  @JsonKey(name: 'ToBinAbs')
  int toBinAbs;
  @JsonKey(name: 'ToBinCode')
  String toBinCode;
  @JsonKey(name: 'WoQty')
  double woQty;
  @JsonKey(name: 'Qty')
  double qty;
  @JsonKey(name: 'OpenQty')
  double openQty;
  @JsonKey(name: 'UomEntry')
  int uomEntry;
  @JsonKey(name: 'Uom')
  String uom;
  @JsonKey(name: 'ManufacturingDate')
  DateTime manufacturingDate;
  @JsonKey(name: 'ExpirationDate')
  DateTime expirationDate;
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
  @JsonKey(name: 'Group')
  String group;
  @JsonKey(name: 'Shift')
  String shift;
  @JsonKey(name: 'Machine')
  String machine;
  @JsonKey(name: 'Type')
  String type;
  @JsonKey(name: 'ItemName')
  String itemName;
  @JsonKey(name: 'LineNo')
  int lineNo;
  @JsonKey(name: 'QrCode')
  String qrCode;
  @JsonKey(name: 'Quantity')
  double quantity;
  @JsonKey(name: 'CreatedDate')
  DateTime createdDate;
  @JsonKey(name: 'CreatedUser')
  int createdUser;
  @JsonKey(name: 'ModifiedDate')
  DateTime modifiedDate;
  @JsonKey(name: 'ModifiedUser')
  int modifiedUser;

  ItemBatch({
    this.id: 0,
    this.detId: 0,
    this.detDetId: 0,
    this.itemCode,
    this.binAbs: 0,
    this.binCode,
    this.batchNo,
    this.whsCode,
    this.whsName,
    this.toWhsCode,
    this.toWhsName,
    this.toBinAbs: 0,
    this.toBinCode,
    this.woQty: 0,
    this.qty: 0,
    this.openQty: 0,
    this.uomEntry: 0,
    this.uom,
    this.manufacturingDate,
    this.expirationDate,
    this.length: 0,
    this.length2: 0,
    this.width: 0,
    this.weight: 0,
    this.micron: 0,
    this.group,
    this.shift,
    this.machine,
    this.type,
    this.itemName,
    this.lineNo: 0,
    this.qrCode,
    this.quantity: 0,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
  });

  factory ItemBatch.fromJson(Map<String, dynamic> json) =>
      _$ItemBatchFromJson(json);

  Map<String, dynamic> toJson() => _$ItemBatchToJson(this);
}
