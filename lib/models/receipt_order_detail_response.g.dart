// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_order_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptOrderDetailResponse _$ReceiptOrderDetailResponseFromJson(
    Map<String, dynamic> json) {
  return ReceiptOrderDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReceiptOrderDetailResponseToJson(
        ReceiptOrderDetailResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    poId: json['PoId'] as int,
    poNo: json['PoNo'] as String,
    id: json['Id'] as int,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    vendorCode: json['VendorCode'] as String,
    vendorName: json['VendorName'] as String,
    contactPerson: json['ContactPerson'] as String,
    refNo: json['RefNo'] as String,
    address: json['Address'] as String,
    seriesNamePo: json['SeriesNamePo'] as String,
    seriesName: json['SeriesName'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
    sapReceiptOrderId: json['SapReceiptOrderId'] as int,
    sapReceiptOrderNo: json['SapReceiptOrderNo'] as String,
    createdUser: json['CreatedUser'] as int,
    status: json['Status'] as String,
    scaleNo: json['ScaleNo'] as String,
    items: (json['Items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'PoId': instance.poId,
      'PoNo': instance.poNo,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'VendorCode': instance.vendorCode,
      'VendorName': instance.vendorName,
      'ContactPerson': instance.contactPerson,
      'RefNo': instance.refNo,
      'Address': instance.address,
      'SeriesNamePo': instance.seriesNamePo,
      'SeriesName': instance.seriesName,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
      'SapReceiptOrderId': instance.sapReceiptOrderId,
      'SapReceiptOrderNo': instance.sapReceiptOrderNo,
      'CreatedUser': instance.createdUser,
      'Status': instance.status,
      'ScaleNo': instance.scaleNo,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    poId: json['PoId'] as int,
    poLineNo: json['PoLineNo'] as int,
    webId: json['WebId'] as int,
    webDetId: json['WebDetId'] as int,
    id: json['Id'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    poQty: (json['PoQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    length: (json['Length'] as num)?.toDouble(),
    length2: (json['Length2'] as num)?.toDouble(),
    width: (json['Width'] as num)?.toDouble(),
    weight: (json['Weight'] as num)?.toDouble(),
    unitPriceTc: (json['UnitPriceTc'] as num)?.toDouble(),
    priceTc: (json['PriceTc'] as num)?.toDouble(),
    itemType: json['ItemType'] as String,
    uom: json['Uom'] as String,
    type: json['Type'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    binAbs: json['BinAbs'] as int,
    binCode: json['BinCode'] as String,
    isAsset: json['IsAsset'] as String,
    isBatch: json['IsBatch'] as String,
    priceMode: json['PriceMode'] as String,
    batchNo: json['BatchNo'] as String,
    micron: (json['Micron'] as num)?.toDouble(),
    group: json['Group'] as String,
    machine: json['Machine'] as String,
    shift: json['Shift'] as String,
    manufacturingDate: json['ManufacturingDate'] == null
        ? null
        : DateTime.parse(json['ManufacturingDate'] as String),
    expirationDate: json['ExpirationDate'] == null
        ? null
        : DateTime.parse(json['ExpirationDate'] as String),
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'PoId': instance.poId,
      'PoLineNo': instance.poLineNo,
      'WebId': instance.webId,
      'WebDetId': instance.webDetId,
      'Id': instance.id,
      'LineNo': instance.lineNo,
      'VisLineNo': instance.visLineNo,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'PoQty': instance.poQty,
      'Qty': instance.qty,
      'Length': instance.length,
      'Length2': instance.length2,
      'Width': instance.width,
      'Weight': instance.weight,
      'Micron': instance.micron,
      'ManufacturingDate': instance.manufacturingDate?.toIso8601String(),
      'ExpirationDate': instance.expirationDate?.toIso8601String(),
      'UnitPriceTc': instance.unitPriceTc,
      'PriceTc': instance.priceTc,
      'ItemType': instance.itemType,
      'Uom': instance.uom,
      'Type': instance.type,
      'Group': instance.group,
      'Machine': instance.machine,
      'Shift': instance.shift,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'BinAbs': instance.binAbs,
      'BinCode': instance.binCode,
      'IsAsset': instance.isAsset,
      'IsBatch': instance.isBatch,
      'PriceMode': instance.priceMode,
      'BatchNo': instance.batchNo,
    };
