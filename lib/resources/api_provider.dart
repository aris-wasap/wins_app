import 'dart:convert';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/models/cfl_batch_location_response.dart';
import 'package:wins_app/models/cfl_binlocation_response.dart';
import 'package:wins_app/models/cfl_branch_response.dart';
import 'package:wins_app/models/cfl_goods_issue_response.dart';
import 'package:wins_app/models/cfl_goods_return_request_response.dart';
import 'package:wins_app/models/cfl_item_batch_response.dart';
import 'package:wins_app/models/cfl_item_response.dart';
import 'package:wins_app/models/cfl_payable_return_request_response.dart';
import 'package:wins_app/models/cfl_production_order_response.dart';
import 'package:wins_app/models/cfl_purchase_delivery_response.dart';
import 'package:wins_app/models/cfl_purchase_item_response.dart';
import 'package:wins_app/models/cfl_purchase_order_label_response.dart';
import 'package:wins_app/models/cfl_purchase_order_response.dart';
import 'package:wins_app/models/cfl_purchase_reference_response.dart';
import 'package:wins_app/models/cfl_purchase_supplier_response.dart';
import 'package:wins_app/models/cfl_receipt_production_label_response.dart';
import 'package:wins_app/models/cfl_receipt_production_response.dart';
import 'package:wins_app/models/cfl_request_branch_response.dart';
import 'package:wins_app/models/cfl_return_request_delivery_response.dart';
import 'package:wins_app/models/cfl_return_request_response.dart';
import 'package:wins_app/models/cfl_sales_order_response.dart';
import 'package:wins_app/models/cfl_delivery_order_response.dart';
import 'package:wins_app/models/cfl_scale_response.dart';
import 'package:wins_app/models/cfl_transfer_branch_response.dart';
import 'package:wins_app/models/cfl_transfer_production_response.dart';
import 'package:wins_app/models/cfl_transfer_request_response.dart';
import 'package:wins_app/models/cfl_warehouse_response.dart';
import 'package:wins_app/models/delivery_order_detail_scan_response.dart';
import 'package:wins_app/models/goods_issue_detail_refresh_response.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:wins_app/models/goods_issue_detail_scan_batch_response.dart';
import 'package:wins_app/models/goods_issue_detail_scan_response.dart';
import 'package:wins_app/models/goods_issue_list_response.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_scan_batch_response.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_scan_response.dart';
import 'package:wins_app/models/goods_issue_mixing_list_response.dart';
import 'package:wins_app/models/goods_receipt_detail_refresh_response.dart';
import 'package:wins_app/models/goods_receipt_detail_response.dart';
import 'package:wins_app/models/goods_receipt_detail_scan_batch_response.dart';
import 'package:wins_app/models/goods_receipt_detail_scan_response.dart';
import 'package:wins_app/models/goods_receipt_list_response.dart';
import 'package:wins_app/models/inventory_transfer_detail_response.dart';
import 'package:wins_app/models/inventory_transfer_detail_scan_response.dart';
import 'package:wins_app/models/inventory_transfer_list_response.dart';
import 'package:wins_app/models/inventory_transfer_detail_response.dart'
    as inventoryTransferDetail;
import 'package:wins_app/models/issue_production_detail_response.dart';
import 'package:wins_app/models/issue_production_detail_scan_response.dart';
import 'package:wins_app/models/issue_production_list_response.dart';
import 'package:wins_app/models/login_response.dart';
import 'package:wins_app/models/payable_credit_detail_response.dart';
import 'package:wins_app/models/payable_credit_detail_scan_response.dart';
import 'package:wins_app/models/payable_credit_list_response.dart';
import 'package:wins_app/models/purchase_returns_detail_response.dart';
import 'package:wins_app/models/purchase_returns_detail_scan_response.dart';
import 'package:wins_app/models/purchase_returns_list_response.dart';
import 'package:wins_app/models/receipt_branch_detail_response.dart';
import 'package:wins_app/models/receipt_branch_detail_scan_response.dart';
import 'package:wins_app/models/receipt_branch_list_response.dart';
import 'package:wins_app/models/receipt_branch_detail_response.dart'
    as receiptBranchDetail;
import 'package:wins_app/models/receipt_issue_detail_response.dart'
    as receiptIssueDetail;
import 'package:wins_app/models/receivable_credit_detail_response.dart';
import 'package:wins_app/models/receivable_credit_detail_scan_response.dart';
import 'package:wins_app/models/receivable_credit_list_response.dart';
import 'package:wins_app/models/request_issue_detail_response.dart'
    as requestIssueDetail;
import 'package:wins_app/models/receipt_issue_detail_response.dart';
import 'package:wins_app/models/receipt_issue_detail_scan_response.dart';
import 'package:wins_app/models/receipt_issue_list_response.dart';

import 'package:wins_app/models/receipt_supplier_detail_response.dart'
    as receiptSupplierDetail;
import 'package:wins_app/models/receipt_order_detail_response.dart'
    as receiptOrderDetail;
import 'package:wins_app/models/receipt_order_detail_response.dart';
import 'package:wins_app/models/receipt_order_detail_scan_response.dart';
import 'package:wins_app/models/receipt_order_list_response.dart';

import 'package:wins_app/models/receipt_production_detail_response.dart';
import 'package:wins_app/models/receipt_supplier_detail_response.dart';
import 'package:wins_app/models/receipt_supplier_detail_scan_response.dart';
import 'package:wins_app/models/receipt_supplier_list_response.dart';
import 'package:wins_app/models/request_issue_detail_response.dart';
import 'package:wins_app/models/request_issue_detail_scan_response.dart';
import 'package:wins_app/models/request_issue_list_response.dart';
import 'package:wins_app/models/serverInfo_response.dart';
import 'package:wins_app/models/transfer_branch_detail_response.dart';
import 'package:wins_app/models/transfer_branch_detail_scan_response.dart';
import 'package:wins_app/models/transfer_branch_list_response.dart';
import 'package:wins_app/models/transfer_production_detail_response.dart';
import 'package:wins_app/models/transfer_production_detail_scan_response.dart';
import 'package:wins_app/models/transfer_production_list_response.dart';
import 'package:wins_app/models/transfer_reject_detail_response.dart';
import 'package:wins_app/models/transfer_reject_detail_scan_response.dart';
import 'package:wins_app/models/transfer_reject_list_response.dart';
import 'package:wins_app/models/transfer_release_detail_response.dart';
import 'package:wins_app/models/transfer_release_detail_scan_response.dart';
import 'package:wins_app/models/transfer_release_list_response.dart';
import 'package:wins_app/models/transfer_request_detail_response.dart';
import 'package:wins_app/models/transfer_request_detail_scan_response.dart';
import 'package:wins_app/models/transfer_request_list_response.dart';
import 'package:wins_app/models/warehouse_response.dart';
import 'package:http/http.dart' as http;
import 'package:wins_app/models/delivery_order_detail_response.dart';
import 'package:wins_app/models/delivery_order_list_response.dart';
import 'package:wins_app/models/return_sales_detail_response.dart';
import 'package:wins_app/models/return_sales_list_response.dart';
import 'package:wins_app/models/return_sales_detail_scan_response.dart';
import 'package:wins_app/models/item_detail_scan_response.dart';
import 'package:wins_app/models/transfer_release_detail_response.dart'
    as transferReleaseDetail;
import 'package:wins_app/models/transfer_reject_detail_response.dart'
    as transferRejectDetail;
import 'package:wins_app/models/transfer_production_detail_response.dart'
    as transferProductionDetail;
import 'package:wins_app/models/transfer_request_detail_response.dart'
    as transferRequestDetail;
import 'package:wins_app/models/delivery_order_detail_response.dart'
    as deliveryOrderDetail;
import 'package:wins_app/models/return_sales_detail_response.dart'
    as returnSalesDetail;
import 'package:wins_app/models/receivable_credit_detail_response.dart'
    as receivableCreditDetail;
import 'package:wins_app/models/receipt_production_detail_response.dart'
    as receiptProductionDetail;
import 'package:wins_app/models/issue_production_detail_response.dart'
    as issueProductionDetail;
import 'package:wins_app/models/purchase_returns_detail_response.dart'
    as purchaseReturnsDetail;
import 'package:wins_app/models/payable_credit_detail_response.dart'
    as payableCreditDetail;
import 'package:wins_app/models/goods_issue_detail_response.dart'
    as goodsIssueDetail;
import 'package:wins_app/models/goods_issue_mixing_detail_response.dart'
    as goodsIssueMixingDetail;
import 'package:wins_app/models/goods_receipt_detail_response.dart'
    as goodsReceiptDetail;
//import 'package:wins_app/models/receipt_branch_detail_response.dart'
//    as receiptBranchDetail;
import 'package:wins_app/models/transfer_branch_detail_response.dart'
    as transferBranchDetail;
import 'package:wins_app/models/receipt_production_list_response.dart';
import 'package:wins_app/models/receipt_production_detail_scan_response.dart';

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
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

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
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

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
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

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

  Future<TransferProductionDetailResponse> transferProductionDetail_Update(
      transferProductionDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/TransferProductionDetailApi/Update",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferProductionDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferProductionDetail_update:Failed to update TransferProduction(2)');
      }
    } catch (e) {
      throw Exception('transferProductionDetail_update:Failed to load post(1)');
    }
  }

  Future<TransferProductionDetailResponse> transferProductionDetail_Post(
      transferProductionDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/TransferProductionDetailApi/Post",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferProductionDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferProductionDetail_Post:Failed to post TransferProduction(2)');
      }
    } catch (e) {
      throw Exception('transferProductionDetail_Post:Failed to load post(1)');
    }
  }

  Future<TransferProductionDetailResponse> transferProductionDetail_RemoveItem(
      int id, int detId) async {
    try {
      var body =
          json.encode({"UserId": globalBloc.userId, "Id": id, "DetId": detId});

      final response = await http.post(
          "${_url}Api/TransferProductionDetailApi/Delete_Item",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return transferProductionDetailResponseFromJson(response.body);
      } else {
        throw Exception(
            'transferProductionDetail_RemoveItem:Failed to remove TransferProduction(2)');
      }
    } catch (e) {
      throw Exception(
          'transferProductionDetail_RemoveItem:Failed to load post(1)');
    }
  }

  Future<TransferProductionDetailScanResponse> transferProductionDetail_Scan(
      int woId, String fromWhsCode, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "WoId": woId,
        "FromWhsCode": fromWhsCode,
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
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

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
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

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

  Future<DeliveryOrderDetailResponse> deliveryOrderDetail_Update(
      deliveryOrderDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/DeliveryOrderDetailApi/Update",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(deliveryOrderDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'deliveryOrderDetail_Update:Failed to update DeliveryOrder(2)');
      }
    } catch (e) {
      throw Exception('deliveryOrderDetail_Update:Failed to load post(1)');
    }
  }

  Future<DeliveryOrderDetailResponse> deliveryOrderDetail_Post(
      deliveryOrderDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/DeliveryOrderDetailApi/Post",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(deliveryOrderDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'deliveryOrderDetail_Post:Failed to post DeliveryOrder(2)');
      }
    } catch (e) {
      throw Exception('deliveryOrderDetail_Post:Failed to load post(1)');
    }
  }

  Future<DeliveryOrderDetailResponse> deliveryOrderDetail_RemoveItem(
      int id, int detId) async {
    try {
      var body =
          json.encode({"UserId": globalBloc.userId, "Id": id, "DetId": detId});

      final response = await http.post(
          "${_url}Api/DeliveryOrderDetailApi/Delete_Item",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return deliveryOrderDetailResponseFromJson(response.body);
      } else {
        throw Exception(
            'deliveryOrderDetail_RemoveItem:Failed to add DeliveryOrder(2)');
      }
    } catch (e) {
      throw Exception('deliveryOrderDetail_RemoveItem:Failed to load post(1)');
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
  //ReturnSalesList
  //-----------------------------
  Future<ReturnSalesListResponse> returnSalesList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/ReturnSalesListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(returnSalesListResponseFromJson, response.body);
      } else {
        throw Exception('returnSalesList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('returnSalesList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<ReturnSalesListResponse> returnSalesList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post("${_url}api/ReturnSalesListApi/Refresh",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(returnSalesListResponseFromJson, response.body);
      } else {
        throw Exception('returnSalesList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('returnSalesList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //ReturnSalesDetail
  //-----------------------------
  Future<ReturnSalesDetailResponse> returnSalesDetail_GetById(int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/ReturnSalesDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(returnSalesDetailResponseFromJson, response.body);
      } else {
        throw Exception('returnSalesDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('returnSalesDetail_GetById:Failed to load post(1)');
    }
  }

  Future<ReturnSalesDetailResponse> returnSalesDetail_Add(
      returnSalesDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/ReturnSalesDetailApi/Add",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(returnSalesDetailResponseFromJson, response.body);
      } else {
        throw Exception('returnSalesDetail_Add:Failed to add ReturnSales(2)');
      }
    } catch (e) {
      throw Exception('returnSalesDetail_Add:Failed to load post(1)');
    }
  }

  Future<ReturnSalesDetailResponse> returnSalesDetail_Post(
      returnSalesDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/ReturnSalesDetailApi/Post",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(returnSalesDetailResponseFromJson, response.body);
      } else {
        throw Exception('returnSalesDetail_Post:Failed to post ReturnSales(2)');
      }
    } catch (e) {
      throw Exception('returnSalesDetail_Post:Failed to load post(1)');
    }
  }

  Future<ReturnSalesDetailScanResponse> returnSalesDetail_Scan(
      int returnRequestId, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "ReturnRequestId": returnRequestId,
        "QrResult": qrResult
      });

      final response = await http.post("${_url}api/ReturnSalesDetailApi/Scan",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(returnSalesDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('returnSalesDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('returnSalesDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //ReceivableCreditList
  //-----------------------------
  Future<ReceivableCreditListResponse> receivableCreditList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/ReceivableCreditListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receivableCreditListResponseFromJson, response.body);
      } else {
        throw Exception(
            'receivableCreditList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'receivableCreditList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<ReceivableCreditListResponse> receivableCreditList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/ReceivableCreditListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receivableCreditListResponseFromJson, response.body);
      } else {
        throw Exception('receivableCreditList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receivableCreditList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //ReceivableCreditDetail
  //-----------------------------
  Future<ReceivableCreditDetailResponse> receivableCreditDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/ReceivableCreditDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receivableCreditDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'receivableCreditDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receivableCreditDetail_GetById:Failed to load post(1)');
    }
  }

  Future<ReceivableCreditDetailResponse> receivableCreditDetail_Add(
      receivableCreditDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/ReceivableCreditDetailApi/Add",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receivableCreditDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'receivableCreditDetail_Add:Failed to add ReceivableCredit(2)');
      }
    } catch (e) {
      throw Exception('receivableCreditDetail_Add:Failed to load post(1)');
    }
  }

  Future<ReceivableCreditDetailResponse> receivableCreditDetail_Post(
      receivableCreditDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/ReceivableCreditDetailApi/Post",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receivableCreditDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'receivableCreditDetail_Post:Failed to post ReceivableCredit(2)');
      }
    } catch (e) {
      throw Exception('receivableCreditDetail_Post:Failed to load post(1)');
    }
  }

  Future<ReceivableCreditDetailScanResponse> receivableCreditDetail_Scan(
      int returnRequestId, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "ReturnRequestId": returnRequestId,
        "QrResult": qrResult
      });

      final response = await http.post(
          "${_url}api/ReceivableCreditDetailApi/Scan",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(
            receivableCreditDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('receivableCreditDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receivableCreditDetail_Scan:Failed to load post(1)');
    }
  }

//-----------------------------
  //IssueProductionList
  //-----------------------------
  Future<IssueProductionListResponse> issueProductionList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/IssueProductionListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(issueProductionListResponseFromJson, response.body);
      } else {
        throw Exception(
            'issueProductionList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'issueProductionList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<IssueProductionListResponse> issueProductionList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/IssueProductionListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(issueProductionListResponseFromJson, response.body);
      } else {
        throw Exception('issueProductionList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('issueProductionList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //IssueProductionDetail
  //-----------------------------
  Future<IssueProductionDetailResponse> issueProductionDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/IssueProductionDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(issueProductionDetailResponseFromJson, response.body);
      } else {
        throw Exception('issueProductionDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('issueProductionDetail_GetById:Failed to load post(1)');
    }
  }

  Future<IssueProductionDetailResponse> issueProductionDetail_Add(
      issueProductionDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/IssueProductionDetailApi/Add",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(issueProductionDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'issueProductionDetail_Add:Failed to add IssueProduction(2)');
      }
    } catch (e) {
      throw Exception('issueProductionDetail_Add:Failed to load post(1)');
    }
  }

  Future<IssueProductionDetailScanResponse> issueProductionDetail_Scan(
      int woId, String qrResult) async {
    try {
      var body = json.encode(
          {"UserId": globalBloc.userId, "WoId": woId, "QrResult": qrResult});

      final response = await http.post(
          "${_url}api/IssueProductionDetailApi/Scan",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(
            issueProductionDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('issueProductionDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('issueProductionDetail_Scan:Failed to load post(1)');
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
      throw Exception(
          'receiptProductionList_FetchNextPage:Failed to load post(1)');
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
        throw Exception(
            'receiptProductionDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptProductionDetail_GetById:Failed to load post(1)');
    }
  }

  Future<ReceiptProductionDetailResponse> receiptProductionDetail_Add(
      receiptProductionDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/ReceiptProductionDetailApi/Add",
          headers: {'Content-type': 'application/json'},
          body: body);

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

      final response = await http.post(
          "${_url}api/ReceiptProductionDetailApi/Scan",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(
            receiptProductionDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('receiptProductionDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptProductionDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //GoodsIssueProductionList
  //-----------------------------
  Future<GoodsIssueListResponse> goodsIssueProductionList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/GoodsIssueListProductionApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueListResponseFromJson, response.body);
      } else {
        throw Exception(
            'goodsIssueProductionList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'goodsIssueProductionList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<GoodsIssueListResponse> goodsIssueProductionList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/GoodsIssueListProductionApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueListResponseFromJson, response.body);
      } else {
        throw Exception(
            'goodsIssueProductionList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'goodsIssueProductionList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //GoodsIssueList
  //-----------------------------
  Future<GoodsIssueListResponse> goodsIssueList_FetchNextPage(
      int lastId, String searchQuery, int woId) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery,
        "woId": woId,
      });

      final response = await http.post(
          "${_url}api/GoodsIssueListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueListResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<GoodsIssueListResponse> goodsIssueList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post("${_url}api/GoodsIssueListApi/Refresh",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueListResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //GoodsIssueDetail
  //-----------------------------
  Future<GoodsIssueDetailResponse> goodsIssueDetail_GetById(int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post("${_url}api/GoodsIssueDetailApi/GetById",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_GetById:Failed to load post(1)');
    }
  }

  Future<GoodsIssueDetailResponse> goodsIssueDetail_Add(
      goodsIssueDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/GoodsIssueDetailApi/Add",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_Add:Failed to add GoodsIssue(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_Add:Failed to load post(1)');
    }
  }

  Future<GoodsIssueDetailResponse> goodsIssueDetail_Post(
      goodsIssueDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/GoodsIssueDetailApi/Post",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_Add:Failed to add GoodsIssue(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_Add:Failed to load post(1)');
    }
  }

  Future<GoodsIssueDetailResponse> goodsIssueDetail_Cancel(
      goodsIssueDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/GoodsIssueDetailApi/Cancel",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_Cancel:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_Cancel:Failed to load post(1)');
    }
  }

  Future<GoodsIssueDetailScanResponse> goodsIssueDetail_UpdateDetailBatch(
      goodsIssueDetail.Item item) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": item.toJson()
      });

      final response = await http.post(
          "${_url}api/GoodsIssueDetailApi/UpdateDetailBatch",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_Cancel:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_Cancel:Failed to load post(1)');
    }
  }

  Future<GoodsIssueDetailScanResponse> goodsIssueDetail_Scan(
      int woId, String qrResult) async {
    try {
      var body = json.encode(
          {"UserId": globalBloc.userId, "WoId": woId, "QrResult": qrResult});

      final response = await http.post("${_url}api/GoodsIssueDetailApi/Scan",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_Scan:Failed to load post(1)');
    }
  }

  Future<GoodsIssueDetailScanResponse> goodsIssueDetail_ScanItemBatch(
      int id, int detId, int woId, int woLineNo, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Id": id,
        "DetId": detId,
        "WoId": woId,
        "WoLineNo": woLineNo,
        "QrResult": qrResult,
      });

      final response = await http.post(
          "${_url}api/GoodsIssueDetailApi/ScanBatch",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_ScanBatch:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_ScanBatch:Failed to load post(1)');
    }
  }

  // Future<GoodsIssueDetailScanBatchResponse> goodsIssueDetail_ScanBatch(
  //     int id, int detId, int woId, int woLineNo, String qrResult) async {
  //   try {
  //     var body = json.encode({
  //       "UserId": globalBloc.userId,
  //       "BranchId": globalBloc.branchId,
  //       "Id": id,
  //       "DetId": detId,
  //       "WoId": woId,
  //       "WoLineNo": woLineNo,
  //       "QrResult": qrResult,
  //     });

  //     final response = await http.post(
  //         "${_url}api/GoodsIssueDetailApi/ScanBatch",
  //         headers: {'Content-type': 'application/json'},
  //         body: body);

  //     if (response.statusCode == 200) {
  //       //print(response.body);
  //       return compute(
  //           goodsIssueDetailScanBatchResponseFromJson, response.body);
  //     } else {
  //       throw Exception('goodsIssueDetail_ScanBatch:Failed to load post(2)');
  //     }
  //   } catch (e) {
  //     throw Exception('goodsIssueDetail_ScanBatch:Failed to load post(1)');
  //   }
  // }

  Future<GoodsIssueDetailScanResponse> goodsIssueDetail_RemoveContent(
      int id, int detId, int detDetId) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "Id": id,
        "DetId": detId,
        "DetDetId": detDetId
      });

      final response = await http.post(
          "${_url}Api/GoodsIssueDetailApi/Delete_Content",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        print(response.body);
        return goodsIssueDetailScanResponseFromJson(response.body);
      } else {
        throw Exception(
            'goodsIssueDetail_RemoveContent:Failed to remove batch detail(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_RemoveContent:Failed to load post(1)');
    }
  }

  Future<GoodsIssueDetailResponse> goodsIssueDetail_ViewDetailItem(
      int woId, DateTime transDate) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "WoId": woId,
        "TransDate": transDate,
        "BranchId": globalBloc.branchId,
      });

      final response = await http.post(
          "${_url}api/GoodsIssueDetailApi/ViewDetailItem",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'goodsIssueDetail_ViewDetailItem:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_ViewDetailItem:Failed to load post(1)');
    }
  }

  Future<GoodsIssueDetailResponse> goodsIssueDetail_ResetData(
      int id, int woId) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "Id": id,
        "WoId": woId,
        "BranchId": globalBloc.branchId,
      });

      final response = await http.post(
          "${_url}api/GoodsIssueDetailApi/ResetDataItem",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_ResetData:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_ResetData:Failed to load post(1)');
    }
  }

  Future<GoodsIssueDetailResponse> goodsIssueDetail_RefreshAfter(int id) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "Id": id,
        "BranchId": globalBloc.branchId,
      });

      final response = await http.post(
          "${_url}api/GoodsIssueDetailApi/RefreshAfter",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_RefreshAfter:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_RefreshAfter:Failed to load post(1)');
    }
  }

  // Create Additional Item Detail
  Future<GoodsIssueDetailScanResponse> goodsIssueDetail_CreateAdditionalItem(
      int woId,
      int id,
      int detId,
      String itemCode,
      double plannedQty,
      String whsCode,
      int binAbs,
      String binCode) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "WoId": woId,
        "Id": id,
        "ItemCode": detId,
        "PlannedQty": plannedQty,
        "WhsCode": whsCode,
        "BinAbs": binAbs,
        "BinCode": binCode,
        "BranchId": globalBloc.branchId,
      });

      final response = await http.post(
          "${_url}api/GoodsIssueDetailApi/CreateAdditionalItem",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueDetailScanResponseFromJson, response.body);
      } else {
        throw Exception(
            'goodsIssueDetail_CreateAdditionalItem:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'goodsIssueDetail_CreateAdditionalItem:Failed to load post(1)');
    }
  }

  // Refresh Detail
  Future<GoodsIssueDetailScanResponse> goodsIssueDetailItemDetail_RefreshDetail(
      int id, int detId, double qtyItem) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "Id": id,
        "DetId": detId,
        "QtyItem": qtyItem,
        "BranchId": globalBloc.branchId,
      });

      final response = await http.post(
          "${_url}api/GoodsIssueDetailApi/RefreshDetail",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_RefreshAfter:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_RefreshAfter:Failed to load post(1)');
    }
  }

  //-----------------------------
  //GoodsIssueMixingProductionList
  //-----------------------------
  Future<GoodsIssueMixingListResponse>
      goodsIssueMixingProductionList_FetchNextPage(
          int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/GoodsIssueMixingListProductionApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueMixingListResponseFromJson, response.body);
      } else {
        throw Exception(
            'goodsIssueMixingProductionList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'goodsIssueMixingProductionList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<GoodsIssueMixingListResponse> goodsIssueMixingProductionList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/GoodsIssueMixingListProductionApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueMixingListResponseFromJson, response.body);
      } else {
        throw Exception(
            'goodsIssueMixingProductionList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'goodsIssueMixingProductionList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //GoodsIssueMixingList
  //-----------------------------
  Future<GoodsIssueMixingListResponse> goodsIssueMixingList_FetchNextPage(
      int lastId, String searchQuery, int woId) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery,
        "woId": woId,
      });

      final response = await http.post(
          "${_url}api/GoodsIssueMixingListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueMixingListResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<GoodsIssueMixingListResponse> goodsIssueMixingList_Refresh(
      int lastId, String searchQuery, int woId) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery,
        "woId": woId
      });

      final response = await http.post(
          "${_url}api/GoodsIssueMixingListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueMixingListResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //GoodsIssueMixingDetail
  //-----------------------------
  Future<GoodsIssueMixingDetailResponse> goodsIssueMixingDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/GoodsIssueMixingDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueMixingDetailResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_GetById:Failed to load post(1)');
    }
  }

  Future<GoodsIssueMixingDetailResponse> goodsIssueMixingDetail_Add(
      goodsIssueMixingDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/GoodsIssueMixingDetailApi/Add",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueMixingDetailResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_Add:Failed to add GoodsIssue(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_Add:Failed to load post(1)');
    }
  }

  Future<GoodsIssueMixingDetailResponse> goodsIssueMixingDetail_Cancel(
      goodsIssueMixingDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/GoodsIssueMixingDetailApi/Cancel",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueMixingDetailResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_Cancel:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_Cancel:Failed to load post(1)');
    }
  }

  Future<GoodsIssueMixingDetailResponse> goodsIssueMixingDetail_Post(
      goodsIssueMixingDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/GoodsIssueMixingDetailApi/Post",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueMixingDetailResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_Add:Failed to add GoodsIssue(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_Add:Failed to load post(1)');
    }
  }

  Future<GoodsIssueMixingDetailScanResponse> goodsIssueMixingDetail_Scan(
      int woId, String qrResult) async {
    try {
      var body = json.encode(
          {"UserId": globalBloc.userId, "WoId": woId, "QrResult": qrResult});

      final response = await http.post(
          "${_url}api/GoodsIssueMixingDetailApi/Scan",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(
            goodsIssueMixingDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_Scan:Failed to load post(1)');
    }
  }

  Future<GoodsIssueMixingDetailScanResponse>
      goodsIssueMixingDetail_ScanItemBatch(
          int id, int detId, int woId, int woLineNo, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Id": id,
        "DetId": detId,
        "WoId": woId,
        "WoLineNo": woLineNo,
        "QrResult": qrResult,
      });

      final response = await http.post(
          "${_url}api/GoodsIssueMixingDetailApi/ScanBatch",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(
            goodsIssueMixingDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_ScanBatch:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_ScanBatch:Failed to load post(1)');
    }
  }

  // Future<GoodsIssueMixingDetailScanBatchResponse>
  //     goodsIssueMixingDetail_ScanBatch(
  //         int id, int detId, int woId, int woLineNo, String qrResult) async {
  //   try {
  //     var body = json.encode({
  //       "UserId": globalBloc.userId,
  //       "BranchId": globalBloc.branchId,
  //       "Id": id,
  //       "DetId": detId,
  //       "WoId": woId,
  //       "WoLineNo": woLineNo,
  //       "QrResult": qrResult,
  //     });

  //     final response = await http.post(
  //         "${_url}api/GoodsIssueMixingDetailApi/ScanBatch",
  //         headers: {'Content-type': 'application/json'},
  //         body: body);

  //     if (response.statusCode == 200) {
  //       //print(response.body);
  //       return compute(
  //           goodsIssueMixingDetailScanBatchResponseFromJson, response.body);
  //     } else {
  //       throw Exception(
  //           'goodsIssueMixingDetail_ScanBatch:Failed to load post(2)');
  //     }
  //   } catch (e) {
  //     throw Exception(
  //         'goodsIssueMixingDetail_ScanBatch:Failed to load post(1)');
  //   }
  // }

  Future<GoodsIssueMixingDetailScanResponse>
      goodsIssueMixingDetail_RemoveContent(
          int id, int detId, int detDetId) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "Id": id,
        "DetId": detId,
        "DetDetId": detDetId
      });

      final response = await http.post(
          "${_url}Api/GoodsIssueMixingDetailApi/Delete_Content",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        print(response.body);
        return goodsIssueMixingDetailScanResponseFromJson(response.body);
      } else {
        throw Exception(
            'goodsIssueMixingDetail_RemoveContent:Failed to remove batch detail(2)');
      }
    } catch (e) {
      throw Exception(
          'goodsIssueMixingDetail_RemoveContent:Failed to load post(1)');
    }
  }

  Future<GoodsIssueMixingDetailResponse> goodsIssueMixingDetail_ViewDetailItem(
      int woId, DateTime transDate) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "WoId": woId,
        "TransDate": transDate,
        "BranchId": globalBloc.branchId,
      });

      final response = await http.post(
          "${_url}api/GoodsIssueMixingDetailApi/ViewDetailItem",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueMixingDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'goodsIssueMixingDetail_ViewDetailItem:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'goodsIssueMixingDetail_ViewDetailItem:Failed to load post(1)');
    }
  }

  Future<GoodsIssueMixingDetailResponse> goodsIssueMixingDetail_ResetData(
      int id, int woId) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "Id": id,
        "WoId": woId,
        "BranchId": globalBloc.branchId,
      });

      final response = await http.post(
          "${_url}api/GoodsIssueMixingDetailApi/ResetDataItem",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueMixingDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'goodsIssueMixingDetail_ResetData:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'goodsIssueMixingDetail_ResetData:Failed to load post(1)');
    }
  }

  Future<GoodsIssueMixingDetailResponse> goodsIssueMixingDetail_RefreshAfter(
      int id) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "Id": id,
        "BranchId": globalBloc.branchId,
      });

      final response = await http.post(
          "${_url}api/GoodsIssueMixingDetailApi/RefreshAfter",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsIssueMixingDetailResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_RefreshAfter:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_RefreshAfter:Failed to load post(1)');
    }
  }

  // Refresh Detail
  Future<GoodsIssueMixingDetailScanResponse>
      goodsIssueMixingDetailItemDetail_RefreshDetail(
          int detId, int woLineNo) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "DetId": detId,
        "WoLineNo": woLineNo,
        "BranchId": globalBloc.branchId,
      });

      final response = await http.post(
          "${_url}api/GoodsIssueMixingDetailApi/RefreshDetail",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(
            goodsIssueMixingDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('goodsIssueDetail_RefreshAfter:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsIssueDetail_RefreshAfter:Failed to load post(1)');
    }
  }

  //-----------------------------
  //GoodsReceiptProductionList
  //-----------------------------
  Future<GoodsReceiptListResponse> goodsReceiptProductionList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/GoodsReceiptListProductionApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsReceiptListResponseFromJson, response.body);
      } else {
        throw Exception(
            'goodsReceiptProductionList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'goodsReceiptProductionList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<GoodsReceiptListResponse> goodsReceiptProductionList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/GoodsReceiptListProductionApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsReceiptListResponseFromJson, response.body);
      } else {
        throw Exception(
            'goodsReceiptProductionList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'goodsReceiptProductionList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //GoodsReceiptList
  //-----------------------------
  Future<GoodsReceiptListResponse> goodsReceiptList_FetchNextPage(
      int lastId, String searchQuery, int woId) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery,
        "WoId": woId,
      });

      final response = await http.post(
          "${_url}api/GoodsReceiptListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsReceiptListResponseFromJson, response.body);
      } else {
        throw Exception(
            'goodsReceiptList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsReceiptList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<GoodsReceiptListResponse> goodsReceiptList_Refresh(
      int lastId, String searchQuery, int woId) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery,
        "WoId": woId,
      });

      final response = await http.post("${_url}api/GoodsReceiptListApi/Refresh",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsReceiptListResponseFromJson, response.body);
      } else {
        throw Exception('goodsReceiptList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsReceiptList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //GoodsReceiptDetail
  //-----------------------------
  Future<GoodsReceiptDetailResponse> goodsReceiptDetail_GetById(int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/GoodsReceiptDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsReceiptDetailResponseFromJson, response.body);
      } else {
        throw Exception('goodsReceiptDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsReceiptDetail_GetById:Failed to load post(1)');
    }
  }

  Future<GoodsReceiptDetailResponse> goodsReceiptDetail_Add(
      goodsReceiptDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/GoodsReceiptDetailApi/Add",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsReceiptDetailResponseFromJson, response.body);
      } else {
        throw Exception('goodsReceiptDetail_Add:Failed to add GoodsReceipt(2)');
      }
    } catch (e) {
      throw Exception('goodsReceiptDetail_Add:Failed to load post(1)');
    }
  }

  Future<GoodsReceiptDetailResponse> goodsReceiptDetail_Update(
      goodsReceiptDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/GoodsReceiptDetailApi/Update",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsReceiptDetailResponseFromJson, response.body);
      } else {
        throw Exception('goodsReceiptDetail_Add:Failed to add GoodsReceipt(2)');
      }
    } catch (e) {
      throw Exception('goodsReceiptDetail_Add:Failed to load post(1)');
    }
  }

  Future<GoodsReceiptDetailResponse> goodsReceiptDetail_Post(
      goodsReceiptDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/GoodsReceiptDetailApi/Post",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsReceiptDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'goodsReceiptDetail_Post:Failed to post GoodsReceipt(2)');
      }
    } catch (e) {
      throw Exception('goodsReceiptDetail_Post:Failed to load post(1)');
    }
  }

  Future<GoodsReceiptDetailScanResponse> goodsReceiptDetail_Scan(
      int woId, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "WoId": woId,
        "QrResult": qrResult,
      });

      final response = await http.post("${_url}api/GoodsReceiptDetailApi/Scan",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsReceiptDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('goodsReceiptDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsReceiptDetail_Scan:Failed to load post(1)');
    }
  }

  Future<GoodsReceiptDetailScanResponse> goodsReceiptDetail_ScanItemBatch(
      int id, int detId, int webId, int woId, int woLineNo, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Id": id,
        "DetId": detId,
        "WebId": webId,
        // "WoId": woId,
        // "WoLineNo": woLineNo,
        "QrResult": qrResult,
      });

      final response = await http.post(
          "${_url}api/GoodsReceiptDetailApi/ScanBatch",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsReceiptDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('goodsReceiptDetail_ScanBatch:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('goodsReceiptDetail_ScanBatch:Failed to load post(1)');
    }
  }

  // Future<GoodsReceiptDetailScanBatchResponse> goodsReceiptDetail_ScanBatch(
  //     int id, int detId, int woId, int woLineNo, String qrResult) async {
  //   try {
  //     var body = json.encode({
  //       "UserId": globalBloc.userId,
  //       "BranchId": globalBloc.branchId,
  //       "Id": id,
  //       "DetId": detId,
  //       "WoId": woId,
  //       "WoLineNo": woLineNo,
  //       "QrResult": qrResult,
  //     });

  //     final response = await http.post(
  //         "${_url}api/GoodsReceiptDetailApi/ScanBatch",
  //         headers: {'Content-type': 'application/json'},
  //         body: body);

  //     if (response.statusCode == 200) {
  //       //print(response.body);
  //       return compute(
  //           goodsReceiptDetailScanBatchResponseFromJson, response.body);
  //     } else {
  //       throw Exception('goodsReceiptDetail_ScanBatch:Failed to load post(2)');
  //     }
  //   } catch (e) {
  //     throw Exception('goodsReceiptDetail_ScanBatch:Failed to load post(1)');
  //   }
  // }

  Future<GoodsReceiptDetailScanResponse> goodsReceiptDetail_RemoveContent(
      int id, int detId, int detDetId) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "Id": id,
        "DetId": detId,
        "DetDetId": detDetId
      });

      final response = await http.post(
          "${_url}Api/GoodsReceiptDetailApi/Delete_Content",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        print(response.body);
        return goodsReceiptDetailScanResponseFromJson(response.body);
      } else {
        throw Exception(
            'goodsReceiptDetail_RemoveContent:Failed to remove batch detail(2)');
      }
    } catch (e) {
      throw Exception('goodsReceiptDetail_RemoveContent:Failed to load post(1)');
    }
  }

  Future<GoodsReceiptDetailResponse> goodsReceiptDetail_ViewDetailItem(
      int webId, String transDate) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "WebId": webId,
        "TransDate": transDate,
        "BranchId": globalBloc.branchId,
      });

      final response = await http.post(
          "${_url}api/GoodsReceiptDetailApi/ViewDetailItem",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(goodsReceiptDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'goodsReceiptDetail_ViewDetailItem:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'goodsReceiptDetail_ViewDetailItem:Failed to load post(1)');
    }
  }

  //-----------------------------
  //TransferBranchList
  //-----------------------------
  Future<TransferBranchListResponse> transferBranchList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/TransferBranchListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferBranchListResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferBranchList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'transferBranchList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<TransferBranchListResponse> transferBranchList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/TransferBranchListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferBranchListResponseFromJson, response.body);
      } else {
        throw Exception('transferBranchList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('transferBranchList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //TransferBranchDetail
  //-----------------------------
  Future<TransferBranchDetailResponse> transferBranchDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/TransferBranchDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferBranchDetailResponseFromJson, response.body);
      } else {
        throw Exception('transferBranchDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('transferBranchDetail_GetById:Failed to load post(1)');
    }
  }

  Future<TransferBranchDetailResponse> transferBranchDetail_Add(
      transferBranchDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/TransferBranchDetailApi/Add",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferBranchDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferBranchDetail_Add:Failed to add TransferBranch(2)');
      }
    } catch (e) {
      throw Exception('transferBranchDetail_Add:Failed to load post(1)');
    }
  }

  Future<TransferBranchDetailResponse> transferBranchDetail_Post(
      transferBranchDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/TransferBranchDetailApi/Post",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferBranchDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'transferBranchDetail_Post:Failed to post TransferBranch(2)');
      }
    } catch (e) {
      throw Exception('transferBranchDetail_Post:Failed to load post(1)');
    }
  }

  Future<TransferBranchDetailScanResponse> transferBranchDetail_Scan(
      int requestId, String qrResult) async {
    try {
      var body = json.encode(
        {
          "UserId": globalBloc.userId,
          "RequestId": requestId,
          "QrResult": qrResult
        },
      );

      final response = await http.post(
          "${_url}api/TransferBranchDetailApi/Scan",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(transferBranchDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('transferBranchDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('transferBranchDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //RequestIssueList
  //-----------------------------
  Future<RequestIssueListResponse> requestIssueList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/RequestIssueListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(requestIssueListResponseFromJson, response.body);
      } else {
        throw Exception(
            'requestIssueList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('requestIssueList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<RequestIssueListResponse> requestIssueList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post("${_url}api/RequestIssueListApi/Refresh",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(requestIssueListResponseFromJson, response.body);
      } else {
        throw Exception('requestIssueList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('requestIssueList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //RequestIssueDetail
  //-----------------------------
  Future<RequestIssueDetailResponse> requestIssueDetail_GetById(int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/RequestIssueDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(requestIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception('requestIssueDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('requestIssueDetail_GetById:Failed to load post(1)');
    }
  }

  Future<RequestIssueDetailResponse> requestIssueDetail_Add(
      requestIssueDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/RequestIssueDetailApi/Add",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(requestIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception('requestIssueDetail_Add:Failed to add RequestIssue(2)');
      }
    } catch (e) {
      throw Exception('requestIssueDetail_Add:Failed to load post(1)');
    }
  }

  Future<RequestIssueDetailResponse> requestIssueDetail_Update(
      requestIssueDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/RequestIssueDetailApi/Update",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(requestIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'requestIssueDetail_Update:Failed to update RequestIssue(2)');
      }
    } catch (e) {
      throw Exception('requestIssueDetail_Update:Failed to load post(1)');
    }
  }

  Future<RequestIssueDetailResponse> requestIssueDetail_Post(
      requestIssueDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/RequestIssueDetailApi/Post",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(requestIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'requestIssueDetail_Post:Failed to post RequestIssue(2)');
      }
    } catch (e) {
      throw Exception('requestIssueDetail_Post:Failed to load post(1)');
    }
  }

  Future<RequestIssueDetailResponse> requestIssueDetail_RemoveItem(
      int id, int detId) async {
    try {
      var body =
          json.encode({"UserId": globalBloc.userId, "Id": id, "DetId": detId});

      final response = await http.post(
          "${_url}Api/RequestIssueDetailApi/Delete_Item",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return requestIssueDetailResponseFromJson(response.body);
      } else {
        throw Exception(
            'requestIssueDetail_RemoveItem:Failed to remove RequestIssue(2)');
      }
    } catch (e) {
      throw Exception('requestIssueDetail_RemoveItem:Failed to load post(1)');
    }
  }

  Future<RequestIssueDetailScanResponse> requestIssueDetail_Scan(
      int requestId, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "RequestId": requestId,
        "QrResult": qrResult,
      });

      final response = await http.post("${_url}api/RequestIssueDetailApi/Scan",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(requestIssueDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('requestIssueDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('requestIssueDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //ReceiptBranchList
  //-----------------------------
  Future<ReceiptBranchListResponse> receiptBranchList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/ReceiptBranchListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptBranchListResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptBranchList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptBranchList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<ReceiptBranchListResponse> receiptBranchList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/ReceiptBranchListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptBranchListResponseFromJson, response.body);
      } else {
        throw Exception('receiptBranchList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptBranchList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //ReceiptBranchDetail
  //-----------------------------
  Future<ReceiptBranchDetailResponse> receiptBranchDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/ReceiptBranchDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptBranchDetailResponseFromJson, response.body);
      } else {
        throw Exception('receiptBranchDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptBranchDetail_GetById:Failed to load post(1)');
    }
  }

  Future<ReceiptBranchDetailResponse> receiptBranchDetail_Add(
      receiptBranchDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/ReceiptBranchDetailApi/Add",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptBranchDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptBranchDetail_Add:Failed to add ReceiptBranch(2)');
      }
    } catch (e) {
      throw Exception('receiptBranchDetail_Add:Failed to load post(1)');
    }
  }

  Future<ReceiptBranchDetailResponse> receiptBranchDetail_Post(
      receiptBranchDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/ReceiptBranchDetailApi/Post",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptBranchDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptBranchDetail_Post:Failed to post ReceiptBranch(2)');
      }
    } catch (e) {
      throw Exception('receiptBranchDetail_Post:Failed to load post(1)');
    }
  }

  Future<ReceiptBranchDetailScanResponse> receiptBranchDetail_Scan(
      int issueId, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "IssueId": issueId,
        "QrResult": qrResult
      });

      final response = await http.post("${_url}api/ReceiptBranchDetailApi/Scan",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptBranchDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('receiptBranchDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptBranchDetail_Scan:Failed to load post(1)');
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

      final response = await http.post("${_url}api/ReceiptIssueListApi/Refresh",
          headers: {'Content-type': 'application/json'}, body: body);

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
  Future<ReceiptIssueDetailResponse> receiptIssueDetail_GetById(int id) async {
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
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/ReceiptIssueDetailApi/Add",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception('receiptIssueDetail_Add:Failed to add ReceiptIssue(2)');
      }
    } catch (e) {
      throw Exception('receiptIssueDetail_Add:Failed to load post(1)');
    }
  }

  Future<ReceiptIssueDetailResponse> receiptIssueDetail_Update(
      receiptIssueDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/ReceiptIssueDetailApi/Update",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptIssueDetail_Update:Failed to update ReceiptIssue(2)');
      }
    } catch (e) {
      throw Exception('receiptIssueDetail_Update:Failed to load post(1)');
    }
  }

  Future<ReceiptIssueDetailResponse> receiptIssueDetail_Post(
      receiptIssueDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/ReceiptIssueDetailApi/Post",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptIssueDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptIssueDetail_Post:Failed to post ReceiptIssue(2)');
      }
    } catch (e) {
      throw Exception('receiptIssueDetail_Post:Failed to load post(1)');
    }
  }

  Future<ReceiptIssueDetailResponse> receiptIssueDetail_RemoveItem(
      int id, int detId) async {
    try {
      var body =
          json.encode({"UserId": globalBloc.userId, "Id": id, "DetId": detId});

      final response = await http.post(
          "${_url}Api/ReceiptIssueDetailApi/Delete_Item",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return receiptIssueDetailResponseFromJson(response.body);
      } else {
        throw Exception(
            'receiptIssueDetail_RemoveItem:Failed to remove ReceiptIssue(2)');
      }
    } catch (e) {
      throw Exception('receiptIssueDetail_RemoveItem:Failed to load post(1)');
    }
  }

  Future<ReceiptIssueDetailScanResponse> receiptIssueDetail_Scan(
      int issueId, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "IssueId": issueId,
        "QrResult": qrResult
      });

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

      final response = await http.post("${_url}api/ReceiptOrderListApi/Refresh",
          headers: {'Content-type': 'application/json'}, body: body);

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
  Future<ReceiptOrderDetailResponse> receiptOrderDetail_GetById(int id) async {
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
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/ReceiptOrderDetailApi/Add",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptOrderDetailResponseFromJson, response.body);
      } else {
        throw Exception('receiptOrderDetail_Add:Failed to add ReceiptOrder(2)');
      }
    } catch (e) {
      throw Exception('receiptOrderDetail_Add:Failed to load post(1)');
    }
  }

  Future<ReceiptOrderDetailResponse> receiptOrderDetail_Post(
      receiptOrderDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/ReceiptOrderDetailApi/Post",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptOrderDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptOrderDetail_Post:Failed to post ReceiptOrder(2)');
      }
    } catch (e) {
      throw Exception('receiptOrderDetail_Post:Failed to load post(1)');
    }
  }

  Future<ReceiptOrderDetailScanResponse> receiptOrderDetail_Scan(
      int webId, String qrResult) async {
    try {
      var body = json.encode(
        {
          "UserId": globalBloc.userId,
          "WebId": webId,
          "QrResult": qrResult,
        },
      );

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
  //ReceiptSupplierList
  //-----------------------------
  Future<ReceiptSupplierListResponse> receiptSupplierList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/ReceiptSupplierListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptSupplierListResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptSupplierList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'receiptSupplierList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<ReceiptSupplierListResponse> receiptSupplierList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/ReceiptSupplierListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptSupplierListResponseFromJson, response.body);
      } else {
        throw Exception('receiptSupplierList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptSupplierList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //ReceiptSupplierDetail
  //-----------------------------
  Future<ReceiptSupplierDetailResponse> receiptSupplierDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/ReceiptSupplierDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptSupplierDetailResponseFromJson, response.body);
      } else {
        throw Exception('receiptSupplierDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptSupplierDetail_GetById:Failed to load post(1)');
    }
  }

  Future<ReceiptSupplierDetailResponse> receiptSupplierDetail_Add(
      receiptSupplierDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/ReceiptSupplierDetailApi/Add",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptSupplierDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptSupplierDetail_Add:Failed to add ReceiptSupplier(2)');
      }
    } catch (e) {
      throw Exception('receiptSupplierDetail_Add:Failed to load post(1)');
    }
  }

  Future<ReceiptSupplierDetailResponse> receiptSupplierDetail_Post(
      receiptSupplierDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/ReceiptSupplierDetailApi/Post",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(receiptSupplierDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'receiptSupplierDetail_Post:Failed to post ReceiptSupplier(2)');
      }
    } catch (e) {
      throw Exception('receiptSupplierDetail_Post:Failed to load post(1)');
    }
  }

  Future<ReceiptSupplierDetailScanResponse> receiptSupplierDetail_Scan(
      int poId, String qrResult) async {
    try {
      var body = json.encode(
          {"UserId": globalBloc.userId, "PoId": poId, "QrResult": qrResult});

      final response = await http.post(
          "${_url}api/ReceiptSupplierDetailApi/Scan",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(
            receiptSupplierDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('receiptSupplierDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('receiptSupplierDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //PurchaseReturnsList
  //-----------------------------
  Future<PurchaseReturnsListResponse> purchaseReturnsList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/PurchaseReturnsListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(purchaseReturnsListResponseFromJson, response.body);
      } else {
        throw Exception(
            'purchaseReturnsList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'purchaseReturnsList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<PurchaseReturnsListResponse> purchaseReturnsList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/PurchaseReturnsListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(purchaseReturnsListResponseFromJson, response.body);
      } else {
        throw Exception('purchaseReturnsList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('purchaseReturnsList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //PurchaseReturnsDetail
  //-----------------------------
  Future<PurchaseReturnsDetailResponse> purchaseReturnsDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/PurchaseReturnsDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(purchaseReturnsDetailResponseFromJson, response.body);
      } else {
        throw Exception('purchaseReturnsDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('purchaseReturnsDetail_GetById:Failed to load post(1)');
    }
  }

  Future<PurchaseReturnsDetailResponse> purchaseReturnsDetail_Add(
      purchaseReturnsDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/PurchaseReturnsDetailApi/Add",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(purchaseReturnsDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'purchaseReturnsDetail_Add:Failed to add PurchaseReturns(2)');
      }
    } catch (e) {
      throw Exception('purchaseReturnsDetail_Add:Failed to load post(1)');
    }
  }

  Future<PurchaseReturnsDetailResponse> purchaseReturnsDetail_Post(
      purchaseReturnsDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/PurchaseReturnsDetailApi/Post",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(purchaseReturnsDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'purchaseReturnsDetail_Post:Failed to post PurchaseReturns(2)');
      }
    } catch (e) {
      throw Exception('purchaseReturnsDetail_Post:Failed to load post(1)');
    }
  }

  Future<PurchaseReturnsDetailScanResponse> purchaseReturnsDetail_Scan(
      int returnRequestId, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "ReturnRequestId": returnRequestId,
        "QrResult": qrResult
      });

      final response = await http.post(
          "${_url}api/PurchaseReturnsDetailApi/Scan",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(
            purchaseReturnsDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('purchaseReturnsDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('purchaseReturnsDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //PayableCreditList
  //-----------------------------
  Future<PayableCreditListResponse> payableCreditList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/PayableCreditListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(payableCreditListResponseFromJson, response.body);
      } else {
        throw Exception(
            'payableCreditList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('payableCreditList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<PayableCreditListResponse> payableCreditList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/PayableCreditListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(payableCreditListResponseFromJson, response.body);
      } else {
        throw Exception('payableCreditList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('payableCreditList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //PayableCreditDetail
  //-----------------------------
  Future<PayableCreditDetailResponse> payableCreditDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/PayableCreditDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(payableCreditDetailResponseFromJson, response.body);
      } else {
        throw Exception('payableCreditDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('payableCreditDetail_GetById:Failed to load post(1)');
    }
  }

  Future<PayableCreditDetailResponse> payableCreditDetail_Add(
      payableCreditDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/PayableCreditDetailApi/Add",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(payableCreditDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'payableCreditDetail_Add:Failed to add PayableCredit(2)');
      }
    } catch (e) {
      throw Exception('payableCreditDetail_Add:Failed to load post(1)');
    }
  }

  Future<PayableCreditDetailResponse> payableCreditDetail_Post(
      payableCreditDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post("${_url}api/PayableCreditDetailApi/Post",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(payableCreditDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'payableCreditDetail_Post:Failed to post PayableCredit(2)');
      }
    } catch (e) {
      throw Exception('payableCreditDetail_Post:Failed to load post(1)');
    }
  }

  Future<PayableCreditDetailScanResponse> payableCreditDetail_Scan(
      int returnRequestId, String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "ReturnRequestId": returnRequestId,
        "QrResult": qrResult
      });

      final response = await http.post("${_url}api/PayableCreditDetailApi/Scan",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(payableCreditDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('payableCreditDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('payableCreditDetail_Scan:Failed to load post(1)');
    }
  }

  //-----------------------------
  //InventoryTransferList
  //-----------------------------
  Future<InventoryTransferListResponse> inventoryTransferList_FetchNextPage(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "Size": 10,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/InventoryTransferListApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(inventoryTransferListResponseFromJson, response.body);
      } else {
        throw Exception(
            'inventoryTransferList_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'inventoryTransferList_FetchNextPage:Failed to load post(1)');
    }
  }

  Future<InventoryTransferListResponse> inventoryTransferList_Refresh(
      int lastId, String searchQuery) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "LastId": lastId,
        "searchQuery": searchQuery
      });

      final response = await http.post(
          "${_url}api/InventoryTransferListApi/Refresh",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(inventoryTransferListResponseFromJson, response.body);
      } else {
        throw Exception('inventoryTransferList_Refresh:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('inventoryTransferList_Refresh:Failed to load post(1)');
    }
  }

  //-----------------------------
  //InventoryTransferDetail
  //-----------------------------
  Future<InventoryTransferDetailResponse> inventoryTransferDetail_GetById(
      int id) async {
    try {
      var body = json.encode({"UserId": globalBloc.userId, "Id": id});

      final response = await http.post(
          "${_url}api/InventoryTransferDetailApi/GetById",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(inventoryTransferDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'inventoryTransferDetail_GetById:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('inventoryTransferDetail_GetById:Failed to load post(1)');
    }
  }

  Future<InventoryTransferDetailResponse> inventoryTransferDetail_Add(
      inventoryTransferDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/InventoryTransferDetailApi/Add",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(inventoryTransferDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'inventoryTransferDetail_Add:Failed to add InventoryTransfer(2)');
      }
    } catch (e) {
      throw Exception('inventoryTransferDetail_Add:Failed to load post(1)');
    }
  }

  Future<InventoryTransferDetailResponse> inventoryTransferDetail_Update(
      inventoryTransferDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/InventoryTransferDetailApi/Update",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(inventoryTransferDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'inventoryTransferDetail_Update:Failed to update InventoryTransfer(2)');
      }
    } catch (e) {
      throw Exception('inventoryTransferDetail_Update:Failed to load post(1)');
    }
  }

  Future<InventoryTransferDetailResponse> inventoryTransferDetail_Post(
      inventoryTransferDetail.Data data) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "BranchId": globalBloc.branchId,
        "Data": data.toJson()
      });

      final response = await http.post(
          "${_url}api/InventoryTransferDetailApi/Post",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(inventoryTransferDetailResponseFromJson, response.body);
      } else {
        throw Exception(
            'inventoryTransferDetail_Post:Failed to post InventoryTransfer(2)');
      }
    } catch (e) {
      throw Exception('inventoryTransferDetail_Post:Failed to load post(1)');
    }
  }

  Future<InventoryTransferDetailScanResponse> inventoryTransferDetail_Scan(
      int requestId,
      String whsCodeFrom,
      int absEntryFrom,
      String binCodeFrom,
      String qrResult) async {
    try {
      var body = json.encode({
        "UserId": globalBloc.userId,
        "RequestId": requestId,
        "WhsCodeFrom": whsCodeFrom,
        "AbsEntry": absEntryFrom,
        "BinCode": binCodeFrom,
        "QrResult": qrResult
      });

      final response = await http.post(
          "${_url}api/InventoryTransferDetailApi/Scan",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(
            inventoryTransferDetailScanResponseFromJson, response.body);
      } else {
        throw Exception('inventoryTransferDetail_Scan:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('inventoryTransferDetail_Scan:Failed to load post(1)');
    }
  }
  //-----------------------------
  //ItemDetail
  //-----------------------------

  Future<ItemDetailScanResponse> itemDetail_Scan(String qrResult) async {
    try {
      var body = json.encode({"QrResult": qrResult});

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
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
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
  //CflReceiptProduction
  //-----------------------------
  Future<CflReceiptProductionResponse> cflReceiptProduction_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
      });

      final response = await http.post(
          "${_url}api/CflReceiptProductionApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflReceiptProductionResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflReceiptProduction_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'cflReceiptProduction_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflTransferProduction
  //-----------------------------
  Future<CflTransferProductionResponse> cflTransferProduction_FetchNextPage(
      int rowStart, String searchQuery, String productionType) async {
    // note: tambahkan parameter production type
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "productionType": productionType,
        "branchId": globalBloc.branchId
      });

      final response = await http.post(
          "${_url}api/CflTransferProductionApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflTransferProductionResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflTransferProduction_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'cflTransferProduction_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflTransferRequest
  //-----------------------------
  Future<CflTransferRequestResponse> cflTransferRequest_FetchNextPage(
      int rowStart, String searchQuery, String transType) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId,
        "transType": transType,
      });

      final response = await http.post(
          "${_url}api/CflTransferRequestApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflTransferRequestResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflTransferRequest_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'cflTransferRequest_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflRequestBranch
  //-----------------------------
  Future<CflRequestBranchResponse> cflRequestBranch_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId,
      });

      final response = await http.post(
          "${_url}api/CflRequestBranchApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflRequestBranchResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflRequestBranch_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflRequestBranch_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflTransferBranch
  //-----------------------------
  Future<CflTransferBranchResponse> cflTransferBranch_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId,
      });

      final response = await http.post(
          "${_url}api/CflTransferBranchApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflTransferBranchResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflTransferBranch_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflTransferBranch_FetchNextPage:Failed to load post(1)');
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
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
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
  //CflDeliveryOrder
  //-----------------------------
  Future<CflDeliveryOrderResponse> cflDeliveryOrder_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
      });

      final response = await http.post(
          "${_url}api/CflDeliveryOrderApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflDeliveryOrderResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflDeliveryOrder_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflDeliveryOrder_FetchNextPage:Failed to load post(1)');
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
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
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
  //CflReceiptProductionLabel
  //-----------------------------
  Future<CflReceiptProductionLabelResponse>
      cflReceiptProductionLabel_FetchNextPage(
          int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
      });

      final response = await http.post(
          "${_url}api/CflReceiptProductionLabelApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(
            cflReceiptProductionLabelResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflReceiptProductionLabel_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'cflReceiptProductionLabel_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflPurchaseOrderLabel
  //-----------------------------
  Future<CflPurchaseOrderLabelResponse> cflPurchaseOrderLabel_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
      });

      final response = await http.post(
          "${_url}api/CflPurchaseOrderLabelApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflPurchaseOrderLabelResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflPurchaseOrderLabel_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'cflPurchaseOrderLabel_FetchNextPage:Failed to load post(1)');
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
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
      });

      final response = await http.post(
          "${_url}api/CflPurchaseOrderApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflPurchaseOrderResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflPurchaseOrder_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflPurchaseOrder_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflScale
  //-----------------------------
  Future<CflScaleResponse> cflScale_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
      });

      final response = await http.post("${_url}api/CflScaleApi/FetchNextPage",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflScaleResponseFromJson, response.body);
      } else {
        throw Exception('cflScale_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflScale_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflPurchaseReference
  //-----------------------------
  Future<CflPurchaseReferenceResponse> cflPurchaseReference_FetchNextPage(
      int rowStart, String searchQuery, int poId) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId,
        "poId": poId,
      });

      final response = await http.post(
          "${_url}api/CflPurchaseReferenceApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflPurchaseReferenceResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflPurchaseReference_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'cflPurchaseReference_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflPurchaseSupplier
  //-----------------------------
  Future<CflPurchaseSupplierResponse> cflPurchaseSupplier_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
      });

      final response = await http.post(
          "${_url}api/CflPurchaseSupplierApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflPurchaseSupplierResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflPurchaseSupplier_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'cflPurchaseSupplier_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflPurchaseItem
  //-----------------------------
  Future<CflPurchaseItemResponse> cflPurchaseItem_FetchNextPage(
      int rowStart, String searchQuery, int poId) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "poId": poId
      });

      final response = await http.post(
          "${_url}api/CflPurchaseItemApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflPurchaseItemResponseFromJson, response.body);
      } else {
        throw Exception('cflPurchaseItem_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflPurchaseItem_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflPurchaseDelivery
  //-----------------------------
  Future<CflPurchaseDeliveryResponse> cflPurchaseDelivery_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
      });

      final response = await http.post(
          "${_url}api/CflPurchaseDeliveryApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflPurchaseDeliveryResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflPurchaseDelivery_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'cflPurchaseDelivery_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflReturnRequest
  //-----------------------------
  Future<CflReturnRequestResponse> cflReturnRequest_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
      });

      final response = await http.post(
          "${_url}api/CflReturnRequestApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflReturnRequestResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflReturnRequest_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflReturnRequest_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflReturnRequestDelivery
  //-----------------------------
  Future<CflReturnRequestDeliveryResponse>
      cflReturnRequestDelivery_FetchNextPage(
          int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
      });

      final response = await http.post(
          "${_url}api/CflReturnRequestDeliveryApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflReturnRequestDeliveryResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflReturnRequestDelivery_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'cflReturnRequestDelivery_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflGoodsReturnRequest
  //-----------------------------
  Future<CflGoodsReturnRequestResponse> cflGoodsReturnRequest_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
      });

      final response = await http.post(
          "${_url}api/CflGoodsReturnRequestApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflGoodsReturnRequestResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflGoodsReturnRequest_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'cflGoodsReturnRequest_FetchNextPage:Failed to load post(1)');
    }
  }

//-----------------------------
  //CflPayableReturnRequest
  //-----------------------------
  Future<CflPayableReturnRequestResponse> cflPayableReturnRequest_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": globalBloc.branchId
      });

      final response = await http.post(
          "${_url}api/CflPayableReturnRequestApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflPayableReturnRequestResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflPayableReturnRequest_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception(
          'cflPayableReturnRequest_FetchNextPage:Failed to load post(1)');
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

  //-----------------------------
  //CflBranch
  //-----------------------------
  Future<CflBranchResponse> cflBranch_FetchNextPage(
      int rowStart, String searchQuery, int branchId) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": branchId
      });

      final response = await http.post("${_url}api/CflBranchApi/FetchNextPage",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflBranchResponseFromJson, response.body);
      } else {
        throw Exception('cflBranch_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflBranch_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflWarehouse
  //-----------------------------
  Future<CflWarehouseResponse> cflWarehouse_FetchNextPage(
      int rowStart, String searchQuery, int branchId) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "branchId": branchId
      });

      final response = await http.post(
          "${_url}api/CflWarehouseApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflWarehouseResponseFromJson, response.body);
      } else {
        throw Exception('cflWarehouse_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflWarehouse_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflBinLocation
  //-----------------------------
  Future<CflBinLocationResponse> cflBinLocation_FetchNextPage(
      int rowStart, String searchQuery, String whsCode) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "whsCode": whsCode
      });

      final response = await http.post(
          "${_url}api/CflBinLocationApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflBinLocationResponseFromJson, response.body);
      } else {
        throw Exception('cflBinLocation_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflBinLocation_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflBatchLocation
  //-----------------------------
  Future<CflBatchLocationResponse> cflBatchLocation_FetchNextPage(
      int rowStart,
      String searchQuery,
      String whsCode,
      String batchNo,
      String itemCode) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "whsCode": whsCode,
        "batchNo": batchNo,
        "itemCode": itemCode
      });

      final response = await http.post(
          "${_url}api/CflBatchLocationApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflBatchLocationResponseFromJson, response.body);
      } else {
        throw Exception(
            'cflBatchLocation_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflBatchLocation_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflItemBatch
  //-----------------------------
  Future<CflItemBatchResponse> cflItemBatch_FetchNextPage(int rowStart,
      String searchQuery, String whsCode, String batchNo, int id) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
        "whsCode": whsCode,
        "batchNo": batchNo,
        "id": id
      });

      final response = await http.post(
          "${_url}api/CflItemBatchApi/FetchNextPage",
          headers: {'Content-type': 'application/json'},
          body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflItemBatchResponseFromJson, response.body);
      } else {
        throw Exception('cflItemBatch_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflItemBatch_FetchNextPage:Failed to load post(1)');
    }
  }

  //-----------------------------
  //CflItem
  //-----------------------------
  Future<CflItemResponse> cflItem_FetchNextPage(
      int rowStart, String searchQuery) async {
    try {
      var body = json.encode({
        "userId": globalBloc.userId,
        "rowStart": rowStart,
        "pageSize": 10,
        "searchQuery": searchQuery,
      });

      final response = await http.post("${_url}api/CflItemApi/FetchNextPage",
          headers: {'Content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        //print(response.body);
        return compute(cflItemResponseFromJson, response.body);
      } else {
        throw Exception('cflItem_FetchNextPage:Failed to load post(2)');
      }
    } catch (e) {
      throw Exception('cflItem_FetchNextPage:Failed to load post(1)');
    }
  }
}
