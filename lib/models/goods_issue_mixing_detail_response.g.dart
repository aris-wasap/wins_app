// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_issue_mixing_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsIssueMixingDetailResponse _$GoodsIssueMixingDetailResponseFromJson(
    Map<String, dynamic> json) {
  return GoodsIssueMixingDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GoodsIssueMixingDetailResponseToJson(
        GoodsIssueMixingDetailResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    woId: json['WoId'] as int,
    woNo: json['WoNo'] as String,
    id: json['Id'] as int,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    seriesNameWo: json['SeriesNameWo'] as String,
    seriesName: json['SeriesName'] as String,
    sapGoodsIssueId: json['SapGoodsIssueId'] as int,
    sapGoodsIssueNo: json['SapGoodsIssueNo'] as String,
    items: (json['Items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..woDate =
        json['WoDate'] == null ? null : DateTime.parse(json['WoDate'] as String)
    ..productCode = json['ProductCode'] as String
    ..productName = json['ProductName'] as String;
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'WoId': instance.woId,
      'WoNo': instance.woNo,
      'WoDate': instance.woDate?.toIso8601String(),
      'ProductCode': instance.productCode,
      'ProductName': instance.productName,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'SeriesNameWo': instance.seriesNameWo,
      'SeriesName': instance.seriesName,
      'SapGoodsIssueId': instance.sapGoodsIssueId,
      'SapGoodsIssueNo': instance.sapGoodsIssueNo,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    woId: json['WoId'] as int,
    woLineNo: json['WoLineNo'] as int,
    woVisOrder: json['WoVisOrder'] as int,
    id: json['Id'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    woQty: (json['WoQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    openQty: (json['OpenQty'] as num)?.toDouble(),
    uom: json['Uom'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    binAbs: json['BinAbs'] as int,
    binCode: json['BinCode'] as String,
    toWhsCode: json['ToWhsCode'] as String,
    toWhsName: json['ToWhsName'] as String,
    toBinAbs: json['ToBinAbs'] as int,
    toBinCode: json['ToBinCode'] as String,
    batchNo: json['BatchNo'] as String,
    productionType: json['ProductionType'] as String,
    valuationMethod: json['ValuationMethod'] as String,
    batchs: (json['Batchs'] as List)
        ?.map((e) =>
            e == null ? null : ItemBatch.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'WoId': instance.woId,
      'WoLineNo': instance.woLineNo,
      'WoVisOrder': instance.woVisOrder,
      'Id': instance.id,
      'LineNo': instance.lineNo,
      'VisLineNo': instance.visLineNo,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'WoQty': instance.woQty,
      'Qty': instance.qty,
      'OpenQty': instance.openQty,
      'Uom': instance.uom,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'BinAbs': instance.binAbs,
      'BinCode': instance.binCode,
      'ToWhsCode': instance.toWhsCode,
      'ToWhsName': instance.toWhsName,
      'ToBinAbs': instance.toBinAbs,
      'ToBinCode': instance.toBinCode,
      'BatchNo': instance.batchNo,
      'ProductionType': instance.productionType,
      'ValuationMethod': instance.valuationMethod,
      'Batchs': instance.batchs,
    };

ItemBatch _$ItemBatchFromJson(Map<String, dynamic> json) {
  return ItemBatch(
    id: json['Id'] as int,
    detId: json['DetId'] as int,
    detDetId: json['DetDetId'] as int,
    itemCode: json['ItemCode'] as String,
    binAbs: json['BinAbs'] as int,
    binCode: json['BinCode'] as String,
    batchNo: json['BatchNo'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    toWhsCode: json['ToWhsCode'] as String,
    toWhsName: json['ToWhsName'] as String,
    toBinAbs: json['ToBinAbs'] as int,
    toBinCode: json['ToBinCode'] as String,
    woQty: (json['WoQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    openQty: (json['OpenQty'] as num)?.toDouble(),
    uomCode: json['UomCode'] as String,
    uomName: json['UomName'] as String,
    manufacturingDate: json['ManufacturingDate'] == null
        ? null
        : DateTime.parse(json['ManufacturingDate'] as String),
    expirationDate: json['ExpirationDate'] == null
        ? null
        : DateTime.parse(json['ExpirationDate'] as String),
    length: (json['Length'] as num)?.toDouble(),
    length2: (json['Length2'] as num)?.toDouble(),
    width: (json['Width'] as num)?.toDouble(),
    weight: (json['Weight'] as num)?.toDouble(),
    micron: (json['Micron'] as num)?.toDouble(),
    group: json['Group'] as String,
    shift: json['Shift'] as String,
    machine: json['Machine'] as String,
    type: json['Type'] as String,
    itemName: json['ItemName'] as String,
    lineNo: json['LineNo'] as int,
    qrCode: json['QrCode'] as String,
    quantity: (json['Quantity'] as num)?.toDouble(),
    createdDate: json['CreatedDate'] == null
        ? null
        : DateTime.parse(json['CreatedDate'] as String),
    createdUser: json['CreatedUser'] as int,
    modifiedDate: json['ModifiedDate'] == null
        ? null
        : DateTime.parse(json['ModifiedDate'] as String),
    modifiedUser: json['ModifiedUser'] as int,
  );
}

Map<String, dynamic> _$ItemBatchToJson(ItemBatch instance) => <String, dynamic>{
      'Id': instance.id,
      'DetId': instance.detId,
      'DetDetId': instance.detDetId,
      'ItemCode': instance.itemCode,
      'BinAbs': instance.binAbs,
      'BinCode': instance.binCode,
      'BatchNo': instance.batchNo,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'ToWhsCode': instance.toWhsCode,
      'ToWhsName': instance.toWhsName,
      'ToBinAbs': instance.toBinAbs,
      'ToBinCode': instance.toBinCode,
      'WoQty': instance.woQty,
      'Qty': instance.qty,
      'OpenQty': instance.openQty,
      'UomCode': instance.uomCode,
      'UomName': instance.uomName,
      'ManufacturingDate': instance.manufacturingDate?.toIso8601String(),
      'ExpirationDate': instance.expirationDate?.toIso8601String(),
      'Length': instance.length,
      'Length2': instance.length2,
      'Width': instance.width,
      'Weight': instance.weight,
      'Micron': instance.micron,
      'Group': instance.group,
      'Shift': instance.shift,
      'Machine': instance.machine,
      'Type': instance.type,
      'ItemName': instance.itemName,
      'LineNo': instance.lineNo,
      'QrCode': instance.qrCode,
      'Quantity': instance.quantity,
      'CreatedDate': instance.createdDate?.toIso8601String(),
      'CreatedUser': instance.createdUser,
      'ModifiedDate': instance.modifiedDate?.toIso8601String(),
      'ModifiedUser': instance.modifiedUser,
    };
