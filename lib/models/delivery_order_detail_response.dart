// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final deliveryOrderDetailResponse = deliveryOrderDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'delivery_order_detail_response.g.dart';

DeliveryOrderDetailResponse deliveryOrderDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return DeliveryOrderDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class DeliveryOrderDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  DeliveryOrderDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory DeliveryOrderDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$DeliveryOrderDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DeliveryOrderDetailResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'SoId')
  int soId;

  @JsonKey(name: 'SoNo')
  String soNo;

  @JsonKey(name: 'SeriesNameSo')
  String seriesNameSo;

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

  @JsonKey(name: 'SapDeliveryId')
  int sapDeliveryId;

  @JsonKey(name: 'SapDeliveryNo')
  String sapDeliveryNo;

  @JsonKey(name: 'CreatedUser')
  int createdUser;

  @JsonKey(name: 'Status')
  String status;

  @JsonKey(name: 'Items')
  List<Item> items;

  Data({
    this.soId: 0,
    this.soNo,
    this.seriesNameSo,
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
    this.sapDeliveryId:0,
    this.sapDeliveryNo,
    this.createdUser,
    this.status,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: 'SoId')
  int soId;

  @JsonKey(name: 'SoLineNo')
  int soLineNo;

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

  @JsonKey(name: 'SoQty')
  double soQty;

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

  @JsonKey(name: 'Type')
  String type;

  @JsonKey(name: 'UnitPriceTc')
  double unitPriceTc;

  @JsonKey(name: 'PriceTc')
  double priceTc;

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

  @JsonKey(name: 'IsAsset')
  String isAsset;

  @JsonKey(name: 'IsBatch')
  String isBatch;

  @JsonKey(name: 'PriceMode')
  String priceMode;

  @JsonKey(name: 'BatchNo')
  String batchNo;

  Item({
    this.soId: 0,
    this.soLineNo: 0,
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName,
    this.soQty: 0,
    this.qty: 0,
    this.length,
    this.width,
    this.weight,
    this.type,
    this.unitPriceTc,
    this.priceTc,
    this.itemType,
    this.uom,
    this.whsCode,
    this.whsName,
    this.binAbs,
    this.binCode,
    this.isAsset,
    this.isBatch,
    this.priceMode,
    this.batchNo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
