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
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    sapDeliveryId: json['SapDeliveryId'] as int,
    sapDeliveryNo: json['SapDeliveryNo'] as String,
    createdUser: json['CreatedUser'] as int,
    status: json['Status'] as String,
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
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'SapDeliveryId': instance.sapDeliveryId,
      'SapDeliveryNo': instance.sapDeliveryNo,
      'CreatedUser': instance.createdUser,
      'Status': instance.status,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    soId: json['SoId'] as int,
    soLineNo: json['SoLineNo'] as int,
    id: json['Id'] as int,
    detId: json['DetId'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    soQty: (json['SoQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    length: (json['Length'] as num)?.toDouble(),
    length2: (json['Length2'] as num)?.toDouble(),
    width: (json['Width'] as num)?.toDouble(),
    weight: (json['Weight'] as num)?.toDouble(),
    type: json['Type'] as String,
    unitPriceTc: (json['UnitPriceTc'] as num)?.toDouble(),
    priceTc: (json['PriceTc'] as num)?.toDouble(),
    itemType: json['ItemType'] as String,
    uom: json['Uom'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    binAbs: json['BinAbs'] as int,
    binCode: json['BinCode'] as String,
    isAsset: json['IsAsset'] as String,
    isBatch: json['IsBatch'] as String,
    priceMode: json['PriceMode'] as String,
    batchNo: json['BatchNo'] as String,
  )..micron = (json['Micron'] as num)?.toDouble();
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'SoId': instance.soId,
      'SoLineNo': instance.soLineNo,
      'Id': instance.id,
      'DetId': instance.detId,
      'LineNo': instance.lineNo,
      'VisLineNo': instance.visLineNo,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'SoQty': instance.soQty,
      'Qty': instance.qty,
      'Length': instance.length,
      'Length2': instance.length2,
      'Width': instance.width,
      'Weight': instance.weight,
      'Micron': instance.micron,
      'Type': instance.type,
      'UnitPriceTc': instance.unitPriceTc,
      'PriceTc': instance.priceTc,
      'ItemType': instance.itemType,
      'Uom': instance.uom,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'BinAbs': instance.binAbs,
      'BinCode': instance.binCode,
      'IsAsset': instance.isAsset,
      'IsBatch': instance.isBatch,
      'PriceMode': instance.priceMode,
      'BatchNo': instance.batchNo,
    };
