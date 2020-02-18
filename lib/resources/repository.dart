import 'package:ncf_app/models/cfl_db_warehouse_model.dart';
import 'package:ncf_app/models/cfl_production_order_response.dart';
import 'package:ncf_app/models/cfl_purchase_order_response.dart';
import 'package:ncf_app/models/cfl_sales_order_response.dart';
import 'package:ncf_app/models/cfl_delivery_order_response.dart';
import 'package:ncf_app/models/cfl_goods_issue_response.dart';
import 'package:ncf_app/models/delivery_order_detail_scan_response.dart';
import 'package:ncf_app/models/inventory_transfer_detail_response.dart';
import 'package:ncf_app/models/inventory_transfer_detail_scan_response.dart';
import 'package:ncf_app/models/inventory_transfer_list_response.dart';
import 'package:ncf_app/models/inventory_transfer_detail_response.dart'
    as inventoryTransferDetail;
import 'package:ncf_app/models/login_response.dart';
import 'package:ncf_app/models/receipt_issue_detail_response.dart' as receiptIssueDetail;
import 'package:ncf_app/models/receipt_issue_detail_response.dart';
import 'package:ncf_app/models/receipt_issue_detail_scan_response.dart';
import 'package:ncf_app/models/receipt_issue_list_response.dart';
import 'package:ncf_app/models/receipt_order_detail_response.dart';  
import 'package:ncf_app/models/receipt_order_detail_response.dart' as receiptOrderDetail;  
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
import 'package:ncf_app/resources/api_provider.dart';
import 'package:ncf_app/models/delivery_order_detail_response.dart';
import 'package:ncf_app/models/delivery_order_list_response.dart';
import 'package:ncf_app/models/return_sales_detail_response.dart';
import 'package:ncf_app/models/return_sales_list_response.dart';
import 'package:ncf_app/models/return_sales_detail_scan_response.dart';
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
import 'package:ncf_app/models/return_sales_detail_response.dart'
    as returnSalesDetail;

import 'package:ncf_app/models/receipt_production_detail_response.dart' as receiptProductionDetail;
import 'package:ncf_app/models/receipt_production_list_response.dart';
import 'package:ncf_app/models/receipt_production_detail_scan_response.dart';

import 'package:ncf_app/resources/db_provider.dart';

class Repository {
  final apiProvider = ApiProvider();
  //-----------------------------
  //GetServerInfo
  //-----------------------------
  Future<ServerInfoResponse> getServerInfo() =>
      apiProvider.getServerInfo();
      
  //-----------------------------
  //Login
  //-----------------------------
  Future<LoginResponse> login(String userName, String pwd) =>
      apiProvider.login(userName, pwd);

  //-----------------------------
  //TransferReleaseList
  //-----------------------------
  Future<TransferReleaseListResponse> transferReleaseList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.transferReleaseList_FetchNextPage(lastId, searchQuery);

  Future<TransferReleaseListResponse> transferReleaseList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.transferReleaseList_Refresh(lastId, searchQuery);

  //-----------------------------
  //TransferReleaseDetail
  //-----------------------------
  Future<TransferReleaseDetailResponse> transferReleaseDetail_GetById(int id) =>
      apiProvider.transferReleaseDetail_GetById(id);

  Future<TransferReleaseDetailResponse> transferReleaseDetail_Add(
          transferReleaseDetail.Data data) =>
      apiProvider.transferReleaseDetail_Add(data);

  Future<TransferReleaseDetailScanResponse> transferReleaseDetail_Scan(
          String whsCodeFrom, String qrResult) =>
      apiProvider.transferReleaseDetail_Scan(whsCodeFrom, qrResult);

  //-----------------------------
  //TransferRejectList
  //-----------------------------
  Future<TransferRejectListResponse> transferRejectList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.transferRejectList_FetchNextPage(lastId, searchQuery);

  Future<TransferRejectListResponse> transferRejectList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.transferRejectList_Refresh(lastId, searchQuery);

  //-----------------------------
  //TransferRejectDetail
  //-----------------------------
  Future<TransferRejectDetailResponse> transferRejectDetail_GetById(int id) =>
      apiProvider.transferRejectDetail_GetById(id);

  Future<TransferRejectDetailResponse> transferRejectDetail_Add(
          transferRejectDetail.Data data) =>
      apiProvider.transferRejectDetail_Add(data);

  Future<TransferRejectDetailScanResponse> transferRejectDetail_Scan(
          String whsCodeFrom, String qrResult) =>
      apiProvider.transferRejectDetail_Scan(whsCodeFrom, qrResult);

  //-----------------------------
  //TransferProductionList
  //-----------------------------
  Future<TransferProductionListResponse> transferProductionList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.transferProductionList_FetchNextPage(lastId, searchQuery);

  Future<TransferProductionListResponse> transferProductionList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.transferProductionList_Refresh(lastId, searchQuery);

  //-----------------------------
  //TransferProductionDetail
  //-----------------------------
  Future<TransferProductionDetailResponse> transferProductionDetail_GetById(
          int id) =>
      apiProvider.transferProductionDetail_GetById(id);

  Future<TransferProductionDetailResponse> transferProductionDetail_Add(
          transferProductionDetail.Data data) =>
      apiProvider.transferProductionDetail_Add(data);

  Future<TransferProductionDetailScanResponse> transferProductionDetail_Scan(
          int prodOrderId, String whsCodeFrom, String qrResult) =>
      apiProvider.transferProductionDetail_Scan(
          prodOrderId, whsCodeFrom, qrResult);

  //-----------------------------
  //TransferRequestList
  //-----------------------------
  Future<TransferRequestListResponse> transferRequestList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.transferRequestList_FetchNextPage(lastId, searchQuery);

  Future<TransferRequestListResponse> transferRequestList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.transferRequestList_Refresh(lastId, searchQuery);

  //-----------------------------
  //TransferRequestDetail
  //-----------------------------
  Future<TransferRequestDetailResponse> transferRequestDetail_GetById(int id) =>
      apiProvider.transferRequestDetail_GetById(id);

  Future<TransferRequestDetailResponse> transferRequestDetail_Add(
          transferRequestDetail.Data data) =>
      apiProvider.transferRequestDetail_Add(data);

  Future<TransferRequestDetailScanResponse> transferRequestDetail_Scan(
          String whsCodeFrom, String qrResult) =>
      apiProvider.transferRequestDetail_Scan(whsCodeFrom, qrResult);

  //-----------------------------
  //DeliveryOrderList
  //-----------------------------
  Future<DeliveryOrderListResponse> deliveryOrderList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.deliveryOrderList_FetchNextPage(lastId, searchQuery);

  Future<DeliveryOrderListResponse> deliveryOrderList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.deliveryOrderList_Refresh(lastId, searchQuery);

  //-----------------------------
  //DeliveryOrderDetail
  //-----------------------------
  Future<DeliveryOrderDetailResponse> deliveryOrderDetail_GetById(int id) =>
      apiProvider.deliveryOrderDetail_GetById(id);

  Future<DeliveryOrderDetailResponse> deliveryOrderDetail_Add(
          deliveryOrderDetail.Data data) =>
      apiProvider.deliveryOrderDetail_Add(data);

  Future<DeliveryOrderDetailScanResponse> deliveryOrderDetail_Scan(
          int soId, String qrResult) =>
      apiProvider.deliveryOrderDetail_Scan(soId, qrResult);

  //-----------------------------
  //ReturnSalesList
  //-----------------------------
  Future<ReturnSalesListResponse> returnSalesList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.returnSalesList_FetchNextPage(lastId, searchQuery);

  Future<ReturnSalesListResponse> returnSalesList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.returnSalesList_Refresh(lastId, searchQuery);

  //-----------------------------
  //ReturnSalesDetail
  //-----------------------------
  Future<ReturnSalesDetailResponse> returnSalesDetail_GetById(int id) =>
      apiProvider.returnSalesDetail_GetById(id);

  Future<ReturnSalesDetailResponse> returnSalesDetail_Add(
          returnSalesDetail.Data data) =>
      apiProvider.returnSalesDetail_Add(data);

  Future<ReturnSalesDetailScanResponse> returnSalesDetail_Scan(
          int doId, String qrResult) =>
      apiProvider.returnSalesDetail_Scan(doId, qrResult);

  //-----------------------------
  //ReceiptProductionDetail
  //-----------------------------
  Future<ReceiptProductionDetailResponse> receiptProductionDetail_GetById(int id) =>
      apiProvider.receiptProductionDetail_GetById(id);

  Future<ReceiptProductionDetailResponse> receiptProductionDetail_Add(
          receiptProductionDetail.Data data) =>
      apiProvider.receiptProductionDetail_Add(data);

  Future<ReceiptProductionDetailScanResponse> receiptProductionDetail_Scan(
         String qrResult) =>
      apiProvider.receiptProductionDetail_Scan(qrResult);

//-----------------------------
  //ReceiptProductionList
  //-----------------------------
  Future<ReceiptProductionListResponse> receiptProductionList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.receiptProductionList_FetchNextPage(lastId, searchQuery);

  Future<ReceiptProductionListResponse> receiptProductionList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.receiptProductionList_Refresh(lastId, searchQuery);


  //-----------------------------
  //ReceiptIssueList
  //-----------------------------
  Future<ReceiptIssueListResponse> receiptIssueList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.receiptIssueList_FetchNextPage(lastId, searchQuery);

  Future<ReceiptIssueListResponse> receiptIssueList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.receiptIssueList_Refresh(lastId, searchQuery);

  //-----------------------------
  //ReceiptIssueDetail
  //-----------------------------
  Future<ReceiptIssueDetailResponse> receiptIssueDetail_GetById(int id) =>
      apiProvider.receiptIssueDetail_GetById(id);

  Future<ReceiptIssueDetailResponse> receiptIssueDetail_Add(
          receiptIssueDetail.Data data) =>
      apiProvider.receiptIssueDetail_Add(data);

  Future<ReceiptIssueDetailScanResponse> receiptIssueDetail_Scan(
          int soId, String qrResult) =>
      apiProvider.receiptIssueDetail_Scan(soId, qrResult);

  //-----------------------------
  //ReceiptOrderList
  //-----------------------------
  Future<ReceiptOrderListResponse> receiptOrderList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.receiptOrderList_FetchNextPage(lastId, searchQuery);

  Future<ReceiptOrderListResponse> receiptOrderList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.receiptOrderList_Refresh(lastId, searchQuery);

  //-----------------------------
  //ReceiptOrderDetail
  //-----------------------------
  Future<ReceiptOrderDetailResponse> receiptOrderDetail_GetById(int id) =>
      apiProvider.receiptOrderDetail_GetById(id);

  Future<ReceiptOrderDetailResponse> receiptOrderDetail_Add(
          receiptOrderDetail.Data data) =>
      apiProvider.receiptOrderDetail_Add(data);

  Future<ReceiptOrderDetailScanResponse> receiptOrderDetail_Scan(
          int poId, String qrResult) =>
      apiProvider.receiptOrderDetail_Scan(poId, qrResult);

  //-----------------------------
  //InventoryTransferList
  //-----------------------------
  Future<InventoryTransferListResponse> inventoryTransferList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.inventoryTransferList_FetchNextPage(lastId, searchQuery);

  Future<InventoryTransferListResponse> inventoryTransferList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.inventoryTransferList_Refresh(lastId, searchQuery);

  //-----------------------------
  //InventoryTransferDetail
  //-----------------------------
  Future<InventoryTransferDetailResponse> inventoryTransferDetail_GetById(
          int id) =>
      apiProvider.inventoryTransferDetail_GetById(id);

  Future<InventoryTransferDetailResponse> inventoryTransferDetail_Add(
          inventoryTransferDetail.Data data) =>
      apiProvider.inventoryTransferDetail_Add(data);

  Future<InventoryTransferDetailScanResponse> inventoryTransferDetail_Scan(
          int prodOrderId, String whsCodeFrom, String qrResult) =>
      apiProvider.inventoryTransferDetail_Scan(
          prodOrderId, whsCodeFrom, qrResult);

  
  //-----------------------------
  //ItemDetail
  //-----------------------------
  Future<ItemDetailScanResponse> itemDetail_Scan(String qrResult) =>
      apiProvider.itemDetail_Scan(qrResult);

  //-----------------------------
  //CflProductionOrder
  //-----------------------------
  Future<CflProductionOrderResponse> cflProductionOrder_FetchNextPage(
          int rowStart, String searchQuery) =>
      apiProvider.cflProductionOrder_FetchNextPage(rowStart, searchQuery);

  //-----------------------------
  //CflSalesOrder
  //-----------------------------
  Future<CflSalesOrderResponse> cflSalesOrder_FetchNextPage(
          int rowStart, String searchQuery) =>
      apiProvider.cflSalesOrder_FetchNextPage(rowStart, searchQuery);
  //-----------------------------
  //CflDeliveryOrder
  //-----------------------------
  Future<CflDeliveryOrderResponse> cflDeliveryOrder_FetchNextPage(
          int rowStart, String searchQuery) =>
      apiProvider.cflDeliveryOrder_FetchNextPage(rowStart, searchQuery);


  //-----------------------------
  //CflGoodsIssue
  //-----------------------------
  Future<CflGoodsIssueResponse> cflGoodsIssue_FetchNextPage(
          int rowStart, String searchQuery) =>
      apiProvider.cflGoodsIssue_FetchNextPage(rowStart, searchQuery);

  //-----------------------------
  //CflPurchaseOrder
  //-----------------------------
  Future<CflPurchaseOrderResponse> cflPurchaseOrder_FetchNextPage(
          int rowStart, String searchQuery) =>
      apiProvider.cflPurchaseOrder_FetchNextPage(rowStart, searchQuery);

  //-----------------------------
  //Warehouse
  //-----------------------------
  Future<bool> warehouse_CopyApiToDb() async {
    var warehouses = await apiProvider.warehouse_GetAll();
    await DbProvider.db.warehouse_CopyToDb(warehouses);

    return true;
  }

  //-----------------------------
  //All
  //-----------------------------
  Future all_CopyApiToDb() async {
    await warehouse_CopyApiToDb();
  }

  //-----------------------------
  //CflDbWarehouse
  //-----------------------------
  Future<List<CflDbWarehouseModel>> cflDbWarehouse_FetchNextPage(
          String id, String searchQuery) =>
      DbProvider.db.cflDbWarehouse_FetchNextPage(id, searchQuery);

  Future<List<CflDbWarehouseModel>> cflDbWarehouse_Refresh(
          String id, String searchQuery) =>
      DbProvider.db.cflDbWarehouse_Refresh(id, searchQuery);
}
