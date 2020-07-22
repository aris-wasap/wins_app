// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_order_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryOrderDetailResponse _$DeliveryOrderDetailResponseFromJson(
    Map<String, dynamic> json) {
  return DeliveryOrderDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DeliveryOrderDetailResponseToJson(
        DeliveryOrderDetailResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    soId: json['SoId'] as int,
    soNo: json['SoNo'] as String,
    seriesNameSo: json['SeriesNameSo'] as String,
    id: json['Id'] as int,
    transNo: json['TransNo'] as String,
    seriesName: json['SeriesName'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    customerCode: json['CustomerCode'] as String,
    customerName: json['CustomerName'] as String,
    contactPerson: json['ContactPerson'] as String,
    refNo: json['RefNo'] as String,
    address: json['Address'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
    items: (json['Items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'SoId': instance.soId,
      'SoNo': instance.soNo,
      'SeriesNameSo': instance.seriesNameSo,
      'TransNo': instance.transNo,
      'SeriesName': instance.seriesName,
      'TransDate': instance.transDate?.toIso8601String(),
      'CustomerCode': instance.customerCode,
      'CustomerName': instance.customerName,
      'ContactPerson': instance.contactPerson,
      'RefNo': instance.refNo,
      'Address': instance.address,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    soId: json['SoId'] as int,
    soLineNo: json['SoLineNo'] as int,
    id: json['Id'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    soQty: (json['SoQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    uom: json['Uom'] as String,
    whsCode: json['WhsCode'] as String,
    batchNo: json['BatchNo'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'SoId': instance.soId,
      'SoLineNo': instance.soLineNo,
      'Id': instance.id,
      'LineNo': instance.lineNo,
      'VisLineNo': instance.visLineNo,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'SoQty': instance.soQty,
      'Qty': instance.qty,
      'Uom': instance.uom,
      'WhsCode': instance.whsCode,
      'BatchNo': instance.batchNo,
    };
