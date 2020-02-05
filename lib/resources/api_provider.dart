import 'dart:convert';
import 'package:ncf_app/blocs/global_bloc.dart';
import 'package:ncf_app/models/cfl_goods_issue_response.dart';
import 'package:ncf_app/models/cfl_production_order_response.dart';
import 'package:ncf_app/models/cfl_purchase_order_response.dart';
import 'package:ncf_app/models/cfl_sales_order_response.dart';
import 'package:ncf_app/models/delivery_order_detail_scan_response.dart';
import 'package:ncf_app/models/login_response.dart';

import 'package:ncf_app/models/receipt_issue_detail_response.dart'
    as receiptIssueDetail ;
import 'package:ncf_app/models/receipt_issue_detail_response.dart';
import 'package:ncf_app/models/receipt_issue_detail_scan_response.dart';
import 'package:ncf_app/models/receipt_issue_list_response.dart';

import 'package:ncf_app/models/receipt_order_detail_response.dart' as receiptOrderDetail;
import 'package:ncf_app/models/receipt_order_detail_response.dart';
import 'package:ncf_app/models/receipt_order_detail_scan_response.dart';
import 'package:ncf_app/models/receipt_order_list_response.dart';

import 'package:ncf_app/models/receipt_production_detail_response.dart';
import 'package:ncf_app/models/serverInfo_response.dart';
import 'package:ncf_app/models/transfer_production_detail_response.dart';
import 'package:ncf_app/models/transfer_production_detail_scan_response.dart';
import 'package:ncf_app/models/transfer_production_list_response.dart';
import 'package:ncf_app/models/transfer_reject_detail_response.dart';
import 'package:ncf_app/models/transfer_reject_detail_scan_response.dart';
import 'package:ncf_app/models/transfer_reject_list_response.dart';
import 'package:ncf_app/models/transfer_release_detail_response.dart';
import 'package:ncf_app/models/transfer_release_detail_scan_response.dart';
import 'package:ncf_app/models/transfer_release_list_response.dart';
import 'package:ncf_app/models/transfer_request_detail_response.dart';
import 'package:ncf_app/models/transfer_request_detail_scan_response.dart';
import 'package:ncf_app/models/transfer_request_list_response.dart';
import 'package:ncf_app/models/warehouse_response.dart';
import 'package:http/http.dart' as http;
import 'package:ncf_app/models/delivery_order_detail_response.dart';
import 'package:ncf_app/models/delivery_order_list_response.dart';
import 'package:ncf_app/models/item_detail_scan_response.dart';
import 'package:ncf_app/models/transfer_release_detail_response.dart'
    as transferReleaseDetail;
import 'package:ncf_app/models/transfer_reject_detail_response.dart'
    as transferRejectDetail;
import 'package:ncf_app/models/transfer_production_detail_response.dart'
    as transferProductionDetail;
import 'package:ncf_app/models/transfer_request_detail_response.dart'
    as transferRequestDetail;
import 'package:ncf_app/models/delivery_order_detail_response.dart'
    as deliveryOrderDetail;
import 'package:ncf_app/models/receipt_production_detail_response.dart' 
    as receiptProductionDetail;
import 'package:ncf_app/models/receipt_production_list_response.dart';
import 'package:ncf_app/models/receipt_production_detail_scan_response.dart';

import 'package:flutter/foundation.dart';

class ApiProvider {
  final _url = globalBloc.getUrl();

  //-----------------------------
  //ServerInfo
  //-----------------------------
  Future<ServerInfoResponse> getServerInfo() async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
      });

      final response = await http.post("${_url}api/ServerInfoApi/GetServerInfo",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(serverInfoResponseFromJson, response.body);
      } else {
        throw Exception('getServerInfo:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('getServerInfo:Failed to load post(1)');
    }
  }

  //-----------------------------
  //Login
  //-----------------------------
  Future<LoginResponse> login(String userName, String pwd) async {
    try {
      var body = json.encode({"UserName": userName, "Pwd": pwd});

      final response = await http.post(_url + "api/LoginApi/Login",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        return compute(loginResponseFromJson, response.body);
      } else {
        throw Exception('login:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('login:Failed to load post(1)');
    }
  }

  //-----------------------------
  //TransferReleaseList
  //-----------------------------
  Future<TransferReleaseListResponse> transferReleaseList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/TransferReleaseListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferReleaseListResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferReleaseList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'transferReleaseList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<TransferReleaseListResponse> transferReleaseList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/TransferReleaseListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferReleaseListResponseFromJson, response.body);
      } else {
        throw Exception('transferReleaseList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('transferReleaseList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //TransferReleaseDetail
  //-----------------------------
  Future<TransferReleaseDetailResponse> transferReleaseDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/TransferReleaseDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferReleaseDetailResponseFromJson, response.body);
      } else {
        throw Exception('transferReleaseDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('transferReleaseDetail_GetById:Failed to load post(1)');
    }
  }

  Future<TransferReleaseDetailResponse> transferReleaseDetail_Add(
      transferReleaseDetail.Data data) async {
    try {
      var body =
          json.encode({"UserId": globalBloc.userId, "Data": data.toJson()});

      final response = await http.post(
          "${_url}api/TransferReleaseDetailApi/Add",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferReleaseDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferReleaseDetail_Add:Failed to add TransferRelease(2)');
      }
    } catch (e) {
      throw Exception('transferReleaseDetail_Add:Failed to load post(1)');
    }
  }

  Future<TransferReleaseDetailScanResponse> transferReleaseDetail_Scan(
      String whsCodeFrom, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "WhsCodeFrom": whsCodeFrom,
        "QrResult": qrResult
      });

      final response = await http.post(
          "${_url}api/TransferReleaseDetailApi/Scan",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(
            transferReleaseDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('transferReleaseDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('transferReleaseDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //TransferRejectList
  //-----------------------------
  Future<TransferRejectListResponse> transferRejectList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/TransferRejectListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferRejectListResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferRejectList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'transferRejectList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<TransferRejectListResponse> transferRejectList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/TransferRejectListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferRejectListResponseFromJson, response.body);
      } else {
        throw Exception('transferRejectList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('transferRejectList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //TransferRejectDetail
  //-----------------------------
  Future<TransferRejectDetailResponse> transferRejectDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/TransferRejectDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferRejectDetailResponseFromJson, response.body);
      } else {
        throw Exception('transferRejectDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('transferRejectDetail_GetById:Failed to load post(1)');
    }
  }

  Future<TransferRejectDetailResponse> transferRejectDetail_Add(
      transferRejectDetail.Data data) async {
    try {
      var body =
          json.encode({"UserId": globalBloc.userId, "Data": data.toJson()});

      final response = await http.post("${_url}api/TransferRejectDetailApi/Add",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferRejectDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferRejectDetail_Add:Failed to add TransferReject(2)');
      }
    } catch (e) {
      throw Exception('transferRejectDetail_Add:Failed to load post(1)');
    }
  }

  Future<TransferRejectDetailScanResponse> transferRejectDetail_Scan(
      String whsCodeFrom, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "WhsCodeFrom": whsCodeFrom,
        "QrResult": qrResult
      });

      final response = await http.post(
          "${_url}api/TransferRejectDetailApi/Scan",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferRejectDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('transferRejectDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('transferRejectDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //TransferProductionList
  //-----------------------------
  Future<TransferProductionListResponse> transferProductionList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/TransferProductionListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferProductionListResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferProductionList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'transferProductionList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<TransferProductionListResponse> transferProductionList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/TransferProductionListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferProductionListResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferProductionList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('transferProductionList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //TransferProductionDetail
  //-----------------------------
  Future<TransferProductionDetailResponse> transferProductionDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/TransferProductionDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferProductionDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferProductionDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'transferProductionDetail_GetById:Failed to load post(1)');
    }
  }

  Future<TransferProductionDetailResponse> transferProductionDetail_Add(
      transferProductionDetail.Data data) async {
    try {
      var body =
          json.encode({"UserId": globalBloc.userId, "Data": data.toJson()});

      final response = await http.post(
          "${_url}api/TransferProductionDetailApi/Add",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferProductionDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferProductionDetail_Add:Failed to add TransferProduction(2)');
      }
    } catch (e) {
      throw Exception('transferProductionDetail_Add:Failed to load post(1)');
    }
  }

  Future<TransferProductionDetailScanResponse> transferProductionDetail_Scan(
      int prodOrderId, String whsCodeFrom, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "ProdOrderId": prodOrderId,
        "WhsCodeFrom": whsCodeFrom,
        "QrResult": qrResult
      });

      final response = await http.post(
          "${_url}api/TransferProductionDetailApi/Scan",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(
            transferProductionDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('transferProductionDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('transferProductionDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //TransferRequestList
  //-----------------------------
  Future<TransferRequestListResponse> transferRequestList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/TransferRequestListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferRequestListResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferRequestList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'transferRequestList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<TransferRequestListResponse> transferRequestList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/TransferRequestListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferRequestListResponseFromJson, response.body);
      } else {
        throw Exception('transferRequestList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('transferRequestList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //TransferRequestDetail
  //-----------------------------
  Future<TransferRequestDetailResponse> transferRequestDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/TransferRequestDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferRequestDetailResponseFromJson, response.body);
      } else {
        throw Exception('transferRequestDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('transferRequestDetail_GetById:Failed to load post(1)');
    }
  }

  Future<TransferRequestDetailResponse> transferRequestDetail_Add(
      transferRequestDetail.Data data) async {
    try {
      var body =
          json.encode({"UserId": globalBloc.userId, "Data": data.toJson()});

      final response = await http.post(
          "${_url}api/TransferRequestDetailApi/Add",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferRequestDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferRequestDetail_Add:Failed to add TransferRequest(2)');
      }
    } catch (e) {
      throw Exception('transferRequestDetail_Add:Failed to load post(1)');
    }
  }

  Future<TransferRequestDetailScanResponse> transferRequestDetail_Scan(
      String whsCodeFrom, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "whsCodeFrom": whsCodeFrom,
        "QrResult": qrResult
      });

      final response = await http.post(
          "${_url}api/TransferRequestDetailApi/Scan",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(
            transferRequestDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('transferRequestDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('transferRequestDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //DeliveryOrderList
  //-----------------------------
  Future<DeliveryOrderListResponse> deliveryOrderList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/DeliveryOrderListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(deliveryOrderListResponseFromJson, response.body);
      } else {
        throw Exception(
            'deliveryOrderList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('deliveryOrderList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<DeliveryOrderListResponse> deliveryOrderList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/DeliveryOrderListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(deliveryOrderListResponseFromJson, response.body);
      } else {
        throw Exception('deliveryOrderList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('deliveryOrderList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //DeliveryOrderDetail
  //-----------------------------
  Future<DeliveryOrderDetailResponse> deliveryOrderDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/DeliveryOrderDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(deliveryOrderDetailResponseFromJson, response.body);
      } else {
        throw Exception('deliveryOrderDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('deliveryOrderDetail_GetById:Failed to load post(1)');
    }
  }

  Future<DeliveryOrderDetailResponse> deliveryOrderDetail_Add(
      deliveryOrderDetail.Data data) async {
    try {
      var body =
          json.encode({"UserId": globalBloc.userId, "Data": data.toJson()});

      final response = await http.post("${_url}api/DeliveryOrderDetailApi/Add",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(deliveryOrderDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'deliveryOrderDetail_Add:Failed to add DeliveryOrder(2)');
      }
    } catch (e) {
      throw Exception('deliveryOrderDetail_Add:Failed to load post(1)');
    }
  }

  Future<DeliveryOrderDetailScanResponse> deliveryOrderDetail_Scan(
      int soId, String qrResult) async {
    try {
      var body = json.encode(
          {"UserId": globalBloc.userId, "SoId": soId, "QrResult": qrResult});

      final response = await http.post("${_url}api/DeliveryOrderDetailApi/Scan",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(deliveryOrderDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('deliveryOrderDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('deliveryOrderDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //ReceiptProductionList
  //-----------------------------
  Future<ReceiptProductionListResponse> receiptProductionList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/ReceiptProductionListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptProductionListResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptProductionList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptProductionList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<ReceiptProductionListResponse> receiptProductionList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/ReceiptProductionListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptProductionListResponseFromJson, response.body);
      } else {
        throw Exception('receiptProductionList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptProductionList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //ReceiptProductionDetail
  //-----------------------------
  Future<ReceiptProductionDetailResponse> receiptProductionDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/ReceiptProductionDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptProductionDetailResponseFromJson, response.body);
      } else {
        throw Exception('receiptProductionDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptProductionDetail_GetById:Failed to load post(1)');
    }
  }

  Future<ReceiptProductionDetailResponse> receiptProductionDetail_Add(
      receiptProductionDetail.Data data) async {
    try {
      var body =
          json.encode({"UserId": globalBloc.userId, "Data": data.toJson()});

      final response = await http.post("${_url}api/ReceiptProductionDetailApi/Add",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptProductionDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptProductionDetail_Add:Failed to add DeliveryOrder(2)');
      }
    } catch (e) {
      throw Exception('receiptProductionDetail_Add:Failed to load post(1)');
    }
  }

  Future<ReceiptProductionDetailScanResponse> receiptProductionDetail_Scan(
      String qrResult) async {
    try {
      var body = json.encode(
         // {"UserId": globalBloc.userId, "WoId": woId, "QrResult": qrResult});
           {"UserId": globalBloc.userId, "QrResult": qrResult});

      final response = await http.post("${_url}api/ReceiptProductionDetailApi/Scan",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptProductionDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('receiptProductionDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptProductionDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //ReceiptIssueList
  //-----------------------------
  Future<ReceiptIssueListResponse> receiptIssueList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/ReceiptIssueListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptIssueListResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptIssueList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptIssueList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<ReceiptIssueListResponse> receiptIssueList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/ReceiptIssueListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptIssueListResponseFromJson, response.body);
      } else {
        throw Exception('receiptIssueList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptIssueList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //ReceiptIssueDetail
  //-----------------------------
  Future<ReceiptIssueDetailResponse> receiptIssueDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/ReceiptIssueDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception('receiptIssueDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptIssueDetail_GetById:Failed to load post(1)');
    }
  }

  Future<ReceiptIssueDetailResponse> receiptIssueDetail_Add(
      receiptIssueDetail.Data data) async {
    try {
      var body =
          json.encode({"UserId": globalBloc.userId, "Data": data.toJson()});

      final response = await http.post("${_url}api/ReceiptIssueDetailApi/Add",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptIssueDetail_Add:Failed to add ReceiptIssue(2)');
      }
    } catch (e) {
      throw Exception('receiptIssueDetail_Add:Failed to load post(1)');
    }
  }

  Future<ReceiptIssueDetailScanResponse> receiptIssueDetail_Scan(
      int issueId, String qrResult) async {
    try {
      var body = json.encode(
          {"UserId": globalBloc.userId, "IssueId": issueId, "QrResult": qrResult});

      final response = await http.post("${_url}api/ReceiptIssueDetailApi/Scan",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptIssueDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('receiptIssueDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptIssueDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //ReceiptOrderList
  //-----------------------------
  Future<ReceiptOrderListResponse> receiptOrderList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/ReceiptOrderListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptOrderListResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptOrderList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptOrderList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<ReceiptOrderListResponse> receiptOrderList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/ReceiptOrderListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptOrderListResponseFromJson, response.body);
      } else {
        throw Exception('receiptOrderList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptOrderList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //ReceiptOrderDetail
  //-----------------------------
  Future<ReceiptOrderDetailResponse> receiptOrderDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/ReceiptOrderDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptOrderDetailResponseFromJson, response.body);
      } else {
        throw Exception('receiptOrderDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptOrderDetail_GetById:Failed to load post(1)');
    }
  }

  Future<ReceiptOrderDetailResponse> receiptOrderDetail_Add(
      receiptOrderDetail.Data data) async {
    try {
      var body =
          json.encode({"UserId": globalBloc.userId, "Data": data.toJson()});

      final response = await http.post("${_url}api/ReceiptOrderDetailApi/Add",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptOrderDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptOrderDetail_Add:Failed to add ReceiptOrder(2)');
      }
    } catch (e) {
      throw Exception('receiptOrderDetail_Add:Failed to load post(1)');
    }
  }

  Future<ReceiptOrderDetailScanResponse> receiptOrderDetail_Scan(
      int soId, String qrResult) async {
    try {
      var body = json.encode(
          {"UserId": globalBloc.userId, "SoId": soId, "QrResult": qrResult});

      final response = await http.post("${_url}api/ReceiptOrderDetailApi/Scan",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptOrderDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('receiptOrderDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptOrderDetail_Scan:Failed to load post(1)');
    }
  }
  
  //-----------------------------
  //ItemDetail
  //-----------------------------

  Future<ItemDetailScanResponse> itemDetail_Scan(String qrResult) async {
    try {
      var body = json.encode(
          {"QrResult": qrResult});

      final response = await http.post("${_url}api/MasterApi/Item_Scan",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(itemDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('itemDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('itemDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflProductionOrder
  //-----------------------------
  Future<CflProductionOrderResponse> cflProductionOrder_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/CflProductionOrderApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflProductionOrderResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflProductionOrder_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'cflProductionOrder_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflSalesOrder
  //-----------------------------
  Future<CflSalesOrderResponse> cflSalesOrder_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/CflSalesOrderApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflSalesOrderResponseFromJson, response.body);
      } else {
        throw Exception('cflSalesOrder_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflSalesOrder_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflGoodsIssue
  //-----------------------------
  Future<CflGoodsIssueResponse> cflGoodsIssue_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/CflGoodsIssueApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflGoodsIssueResponseFromJson, response.body);
      } else {
        throw Exception('cflGoodsIssue_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflGoodsIssue_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflPurchaseOrder
  //-----------------------------
  Future<CflPurchaseOrderResponse> cflPurchaseOrder_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/CflPurchaseOrderApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflPurchaseOrderResponseFromJson, response.body);
      } else {
        throw Exception('cflPurchaseOrder_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflPurchaseOrder_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //Warehouse
  //-----------------------------
  Future<WarehouseResponse> warehouse_GetAll() async {
    try {
      var body = json.encode({"UserId": globalBloc.userId});

      final response = await http.post("${_url}api/MasterApi/Warehouse_GetAll",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(warehouseResponseFromJson, response.body);
      } else {
        throw Exception('warehouse_GetAll:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('warehouse_GetAll:Failed to load post(1)');
    }
  }
}
