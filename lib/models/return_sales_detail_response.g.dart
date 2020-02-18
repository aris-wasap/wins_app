// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_sales_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnSalesDetailResponse _$ReturnSalesDetailResponseFromJson(
    Map<String, dynamic> json) {
  return ReturnSalesDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReturnSalesDetailResponseToJson(
        ReturnSalesDetailResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    doId: json['DoId'] as int,
    doNo: json['DoNo'] as String,
    id: json['Id'] as int,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    customerCode: json['CustomerCode'] as String,
    customerName: json['CustomerName'] as String,
    contactPerson: json['ContactPerson'] as String,
    refNo: json['RefNo'] as String,
    address: json['Address'] as String,
    items: (json['Items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'DoId': instance.doId,
      'DoNo': instance.doNo,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'CustomerCode': instance.customerCode,
      'CustomerName': instance.customerName,
      'ContactPerson': instance.contactPerson,
      'RefNo': instance.refNo,
      'Address': instance.address,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    doId: json['DoId'] as int,
    doLineNo: json['DoLineNo'] as int,
    id: json['Id'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    doQty: (json['DoQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    uom: json['Uom'] as String,
    whsCode: json['WhsCode'] as String,
    batchNo: json['BatchNo'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'DoId': instance.doId,
      'DoLineNo': instance.doLineNo,
      'Id': instance.id,
      'LineNo': instance.lineNo,
      'VisLineNo': instance.visLineNo,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'DoQty': instance.doQty,
      'Qty': instance.qty,
      'Uom': instance.uom,
      'WhsCode': instance.whsCode,
      'BatchNo': instance.batchNo,
    };
