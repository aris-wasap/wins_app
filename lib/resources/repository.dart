import 'package:admart_app/models/cfl_batch_location_response.dart';
import 'package:admart_app/models/cfl_binlocation_response.dart';
import 'package:admart_app/models/cfl_branch_response.dart';
import 'package:admart_app/models/cfl_db_warehouse_model.dart';
import 'package:admart_app/models/cfl_item_batch_response.dart';
import 'package:admart_app/models/cfl_production_order_response.dart';
import 'package:admart_app/models/cfl_purchase_delivery_response.dart';
import 'package:admart_app/models/cfl_purchase_item_response.dart';
import 'package:admart_app/models/cfl_purchase_order_response.dart';
import 'package:admart_app/models/cfl_purchase_supplier_response.dart';
import 'package:admart_app/models/cfl_return_request_delivery_response.dart';
import 'package:admart_app/models/cfl_return_request_response.dart';
import 'package:admart_app/models/cfl_sales_order_response.dart';
import 'package:admart_app/models/cfl_delivery_order_response.dart';
import 'package:admart_app/models/cfl_goods_issue_response.dart';
import 'package:admart_app/models/cfl_transfer_branch_response.dart';
import 'package:admart_app/models/cfl_transfer_production_response.dart';
import 'package:admart_app/models/cfl_transfer_request_response.dart';
import 'package:admart_app/models/cfl_warehouse_response.dart';
import 'package:admart_app/models/delivery_order_detail_scan_response.dart';
import 'package:admart_app/models/goods_issue_detail_refresh_response.dart';
import 'package:admart_app/models/goods_issue_detail_response.dart';
import 'package:admart_app/models/goods_issue_detail_scan_response.dart';
import 'package:admart_app/models/goods_issue_list_response.dart';
import 'package:admart_app/models/goods_receipt_detail_response.dart';
import 'package:admart_app/models/goods_receipt_detail_scan_response.dart';
import 'package:admart_app/models/goods_receipt_list_response.dart';
import 'package:admart_app/models/inventory_transfer_detail_response.dart';
import 'package:admart_app/models/inventory_transfer_detail_scan_response.dart';
import 'package:admart_app/models/inventory_transfer_list_response.dart';
import 'package:admart_app/models/inventory_transfer_detail_response.dart'
    as inventoryTransferDetail;
import 'package:admart_app/models/issue_production_detail_response.dart';
import 'package:admart_app/models/issue_production_detail_scan_response.dart';
import 'package:admart_app/models/issue_production_list_response.dart';
import 'package:admart_app/models/login_response.dart';
import 'package:admart_app/models/payable_credit_detail_response.dart';
import 'package:admart_app/models/payable_credit_detail_scan_response.dart';
import 'package:admart_app/models/payable_credit_list_response.dart';
import 'package:admart_app/models/purchase_returns_detail_response.dart';
import 'package:admart_app/models/purchase_returns_detail_scan_response.dart';
import 'package:admart_app/models/purchase_returns_list_response.dart';
import 'package:admart_app/models/receipt_branch_detail_response.dart';
import 'package:admart_app/models/receipt_branch_detail_scan_response.dart';
import 'package:admart_app/models/receipt_branch_list_response.dart';
import 'package:admart_app/models/receipt_branch_detail_response.dart'
    as receiptBranchDetail;
import 'package:admart_app/models/receipt_issue_detail_response.dart'
    as receiptIssueDetail;
import 'package:admart_app/models/receivable_credit_detail_response.dart';
import 'package:admart_app/models/receivable_credit_detail_scan_response.dart';
import 'package:admart_app/models/receivable_credit_list_response.dart';
import 'package:admart_app/models/request_issue_detail_response.dart'
    as requestIssueDetail;
import 'package:admart_app/models/receipt_issue_detail_response.dart';
import 'package:admart_app/models/receipt_issue_detail_scan_response.dart';
import 'package:admart_app/models/receipt_issue_list_response.dart';
import 'package:admart_app/models/receipt_order_detail_response.dart';
import 'package:admart_app/models/receipt_order_detail_response.dart'
    as receiptOrderDetail;
import 'package:admart_app/models/receipt_supplier_detail_response.dart'
    as receiptSupplierDetail;
import 'package:admart_app/models/receipt_order_detail_scan_response.dart';
import 'package:admart_app/models/receipt_order_list_response.dart';
import 'package:admart_app/models/receipt_production_detail_response.dart';
import 'package:admart_app/models/receipt_supplier_detail_response.dart';
import 'package:admart_app/models/receipt_supplier_detail_scan_response.dart';
import 'package:admart_app/models/receipt_supplier_list_response.dart';
import 'package:admart_app/models/request_issue_detail_response.dart';
import 'package:admart_app/models/request_issue_detail_scan_response.dart';
import 'package:admart_app/models/request_issue_list_response.dart';
import 'package:admart_app/models/serverInfo_response.dart';
import 'package:admart_app/models/transfer_branch_detail_response.dart';
import 'package:admart_app/models/transfer_branch_detail_scan_response.dart';
import 'package:admart_app/models/transfer_branch_list_response.dart';
import 'package:admart_app/models/transfer_production_detail_response.dart';
import 'package:admart_app/models/transfer_production_detail_scan_response.dart';
import 'package:admart_app/models/transfer_production_list_response.dart';
import 'package:admart_app/models/transfer_reject_detail_response.dart';
import 'package:admart_app/models/transfer_reject_detail_scan_response.dart';
import 'package:admart_app/models/transfer_reject_list_response.dart';
import 'package:admart_app/models/transfer_release_detail_response.dart';
import 'package:admart_app/models/transfer_release_detail_scan_response.dart';
import 'package:admart_app/models/transfer_release_list_response.dart';
import 'package:admart_app/models/transfer_request_detail_response.dart';
import 'package:admart_app/models/transfer_request_detail_scan_response.dart';
import 'package:admart_app/models/transfer_request_list_response.dart';
import 'package:admart_app/resources/api_provider.dart';
import 'package:admart_app/models/delivery_order_detail_response.dart';
import 'package:admart_app/models/delivery_order_list_response.dart';
import 'package:admart_app/models/return_sales_detail_response.dart';
import 'package:admart_app/models/return_sales_list_response.dart';
import 'package:admart_app/models/return_sales_detail_scan_response.dart';
import 'package:admart_app/models/item_detail_scan_response.dart';
import 'package:admart_app/models/transfer_release_detail_response.dart'
    as transferReleaseDetail;
import 'package:admart_app/models/transfer_reject_detail_response.dart'
    as transferRejectDetail;
import 'package:admart_app/models/transfer_production_detail_response.dart'
    as transferProductionDetail;
import 'package:admart_app/models/transfer_request_detail_response.dart'
    as transferRequestDetail;
import 'package:admart_app/models/delivery_order_detail_response.dart'
    as deliveryOrderDetail;
import 'package:admart_app/models/return_sales_detail_response.dart'
    as returnSalesDetail;
import 'package:admart_app/models/receivable_credit_detail_response.dart'
    as receivableCreditDetail;
import 'package:admart_app/models/purchase_returns_detail_response.dart'
    as purchaseReturnsDetail;
import 'package:admart_app/models/payable_credit_detail_response.dart'
    as payableCreditDetail;
import 'package:admart_app/models/receipt_production_detail_response.dart'
    as receiptProductionDetail;
import 'package:admart_app/models/issue_production_detail_response.dart'
    as issueProductionDetail;
import 'package:admart_app/models/goods_issue_detail_response.dart'
    as goodsIssueDetail;
import 'package:admart_app/models/goods_receipt_detail_response.dart'
    as goodsReceiptDetail;
//import 'package:admart_app/models/receipt_branch_detail_response.dart'
//    as receiptBranchDetail;
import 'package:admart_app/models/transfer_branch_detail_response.dart'
    as transferBranchDetail;
import 'package:admart_app/models/receipt_production_list_response.dart';
import 'package:admart_app/models/receipt_production_detail_scan_response.dart';

import 'package:admart_app/resources/db_provider.dart';

class Repository {
  final apiProvider = ApiProvider();
  //-----------------------------
  //GetServerInfo
  //-----------------------------
  Future<ServerInfoResponse> getServerInfo() => apiProvider.getServerInfo();

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
          int woId, String whsCodeFrom, String qrResult) =>
      apiProvider.transferProductionDetail_Scan(woId, whsCodeFrom, qrResult);

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
  //ReceivableCreditList
  //-----------------------------
  Future<ReceivableCreditListResponse> receivableCreditList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.receivableCreditList_FetchNextPage(lastId, searchQuery);

  Future<ReceivableCreditListResponse> receivableCreditList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.receivableCreditList_Refresh(lastId, searchQuery);

  //-----------------------------
  //ReceivableCreditDetail
  //-----------------------------
  Future<ReceivableCreditDetailResponse> receivableCreditDetail_GetById(int id) =>
      apiProvider.receivableCreditDetail_GetById(id);

  Future<ReceivableCreditDetailResponse> receivableCreditDetail_Add(
          receivableCreditDetail.Data data) =>
      apiProvider.receivableCreditDetail_Add(data);

  Future<ReceivableCreditDetailScanResponse> receivableCreditDetail_Scan(
          int doId, String qrResult) =>
      apiProvider.receivableCreditDetail_Scan(doId, qrResult);

  //-----------------------------
  //IssueProductionList
  //-----------------------------
  Future<IssueProductionListResponse> issueProductionList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.issueProductionList_FetchNextPage(lastId, searchQuery);

  Future<IssueProductionListResponse> issueProductionList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.issueProductionList_Refresh(lastId, searchQuery);

  //-----------------------------
  //IssueProductionDetail
  //-----------------------------
  Future<IssueProductionDetailResponse> issueProductionDetail_GetById(int id) =>
      apiProvider.issueProductionDetail_GetById(id);

  Future<IssueProductionDetailResponse> issueProductionDetail_Add(
          issueProductionDetail.Data data) =>
      apiProvider.issueProductionDetail_Add(data);

  Future<IssueProductionDetailScanResponse> issueProductionDetail_Scan(
          int poId, String qrResult) =>
      apiProvider.issueProductionDetail_Scan(poId, qrResult);

  //-----------------------------
  //ReceiptProductionDetail
  //-----------------------------
  Future<ReceiptProductionDetailResponse> receiptProductionDetail_GetById(
          int id) =>
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
  //GoodsIssueList
  //-----------------------------
  Future<GoodsIssueListResponse> goodsIssueList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.goodsIssueList_FetchNextPage(lastId, searchQuery);

  Future<GoodsIssueListResponse> goodsIssueList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.goodsIssueList_Refresh(lastId, searchQuery);

  //-----------------------------
  //GoodsIssueDetail
  //-----------------------------
  Future<GoodsIssueDetailResponse> goodsIssueDetail_GetById(int id) =>
      apiProvider.goodsIssueDetail_GetById(id);

  Future<GoodsIssueDetailResponse> goodsIssueDetail_Add(
          goodsIssueDetail.Data data) =>
      apiProvider.goodsIssueDetail_Add(data);

  Future<GoodsIssueDetailScanResponse> goodsIssueDetail_Scan(
          int woId, String qrResult) =>
      apiProvider.goodsIssueDetail_Scan(woId, qrResult);

  Future<GoodsIssueDetailResponse> goodsIssueDetail_ViewDetailItem(int woId) =>
      apiProvider.goodsIssueDetail_ViewDetailItem(woId);

  //-----------------------------
  //GoodsReceiptList
  //-----------------------------
  Future<GoodsReceiptListResponse> goodsReceiptList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.goodsReceiptList_FetchNextPage(lastId, searchQuery);

  Future<GoodsReceiptListResponse> goodsReceiptList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.goodsReceiptList_Refresh(lastId, searchQuery);

  //-----------------------------
  //GoodsReceiptDetail
  //-----------------------------
  Future<GoodsReceiptDetailResponse> goodsReceiptDetail_GetById(int id) =>
      apiProvider.goodsReceiptDetail_GetById(id);

  Future<GoodsReceiptDetailResponse> goodsReceiptDetail_Add(
          goodsReceiptDetail.Data data) =>
      apiProvider.goodsReceiptDetail_Add(data);

  Future<GoodsReceiptDetailScanResponse> goodsReceiptDetail_Scan(
          int poId, String qrResult) =>
      apiProvider.goodsReceiptDetail_Scan(poId, qrResult);

  Future<GoodsIssueDetailRefreshResponse> goodsReceiptDetail_ViewDetailItem(
          int woId) =>
      apiProvider.goodsReceiptDetail_ViewDetailItem(woId);

  //-----------------------------
  //TransferBranchList
  //-----------------------------
  Future<TransferBranchListResponse> transferBranchList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.transferBranchList_FetchNextPage(lastId, searchQuery);

  Future<TransferBranchListResponse> transferBranchList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.transferBranchList_Refresh(lastId, searchQuery);

  //-----------------------------
  //TransferBranchDetail
  //-----------------------------
  Future<TransferBranchDetailResponse> transferBranchDetail_GetById(int id) =>
      apiProvider.transferBranchDetail_GetById(id);

  Future<TransferBranchDetailResponse> transferBranchDetail_Add(
          transferBranchDetail.Data data) =>
      apiProvider.transferBranchDetail_Add(data);

  Future<TransferBranchDetailScanResponse> transferBranchDetail_Scan(
          String qrResult) =>
      apiProvider.transferBranchDetail_Scan(qrResult);

  //-----------------------------
  //RequestIssueList
  //-----------------------------
  Future<RequestIssueListResponse> requestIssueList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.requestIssueList_FetchNextPage(lastId, searchQuery);

  Future<RequestIssueListResponse> requestIssueList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.requestIssueList_Refresh(lastId, searchQuery);

  //-----------------------------
  //RequestIssueDetail
  //-----------------------------
  Future<RequestIssueDetailResponse> requestIssueDetail_GetById(int id) =>
      apiProvider.requestIssueDetail_GetById(id);

  Future<RequestIssueDetailResponse> requestIssueDetail_Add(
          requestIssueDetail.Data data) =>
      apiProvider.requestIssueDetail_Add(data);

  Future<RequestIssueDetailScanResponse> requestIssueDetail_Scan(
          String qrResult) =>
      apiProvider.requestIssueDetail_Scan(qrResult);

  //-----------------------------
  //ReceiptBranchList
  //-----------------------------
  Future<ReceiptBranchListResponse> receiptBranchList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.receiptBranchList_FetchNextPage(lastId, searchQuery);

  Future<ReceiptBranchListResponse> receiptBranchList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.receiptBranchList_Refresh(lastId, searchQuery);

  //-----------------------------
  //ReceiptBranchDetail
  //-----------------------------
  Future<ReceiptBranchDetailResponse> receiptBranchDetail_GetById(int id) =>
      apiProvider.receiptBranchDetail_GetById(id);

  Future<ReceiptBranchDetailResponse> receiptBranchDetail_Add(
          receiptBranchDetail.Data data) =>
      apiProvider.receiptBranchDetail_Add(data);

  Future<ReceiptBranchDetailScanResponse> receiptBranchDetail_Scan(
          int soId, String qrResult) =>
      apiProvider.receiptBranchDetail_Scan(soId, qrResult);

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
  //ReceiptSupplierList
  //-----------------------------
  Future<ReceiptSupplierListResponse> receiptSupplierList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.receiptSupplierList_FetchNextPage(lastId, searchQuery);

  Future<ReceiptSupplierListResponse> receiptSupplierList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.receiptSupplierList_Refresh(lastId, searchQuery);

  //-----------------------------
  //ReceiptSupplierDetail
  //-----------------------------
  Future<ReceiptSupplierDetailResponse> receiptSupplierDetail_GetById(int id) =>
      apiProvider.receiptSupplierDetail_GetById(id);

  Future<ReceiptSupplierDetailResponse> receiptSupplierDetail_Add(
          receiptSupplierDetail.Data data) =>
      apiProvider.receiptSupplierDetail_Add(data);

  Future<ReceiptSupplierDetailScanResponse> receiptSupplierDetail_Scan(
          int poId, String qrResult) =>
      apiProvider.receiptSupplierDetail_Scan(poId, qrResult);

  //-----------------------------
  //PurchaseReturnsList
  //-----------------------------
  Future<PurchaseReturnsListResponse> purchaseReturnsList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.purchaseReturnsList_FetchNextPage(lastId, searchQuery);

  Future<PurchaseReturnsListResponse> purchaseReturnsList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.purchaseReturnsList_Refresh(lastId, searchQuery);

  //-----------------------------
  //PurchaseReturnsDetail
  //-----------------------------
  Future<PurchaseReturnsDetailResponse> purchaseReturnsDetail_GetById(int id) =>
      apiProvider.purchaseReturnsDetail_GetById(id);

  Future<PurchaseReturnsDetailResponse> purchaseReturnsDetail_Add(
          purchaseReturnsDetail.Data data) =>
      apiProvider.purchaseReturnsDetail_Add(data);

  Future<PurchaseReturnsDetailScanResponse> purchaseReturnsDetail_Scan(
          int grpoId, String qrResult) =>
      apiProvider.purchaseReturnsDetail_Scan(grpoId, qrResult);

  //-----------------------------
  //PayableCreditList
  //-----------------------------
  Future<PayableCreditListResponse> payableCreditList_FetchNextPage(
          int lastId, String searchQuery) =>
      apiProvider.payableCreditList_FetchNextPage(lastId, searchQuery);

  Future<PayableCreditListResponse> payableCreditList_Refresh(
          int lastId, String searchQuery) =>
      apiProvider.payableCreditList_Refresh(lastId, searchQuery);

  //-----------------------------
  //PayableCreditDetail
  //-----------------------------
  Future<PayableCreditDetailResponse> payableCreditDetail_GetById(int id) =>
      apiProvider.payableCreditDetail_GetById(id);

  Future<PayableCreditDetailResponse> payableCreditDetail_Add(
          payableCreditDetail.Data data) =>
      apiProvider.payableCreditDetail_Add(data);

  Future<PayableCreditDetailScanResponse> payableCreditDetail_Scan(
          int grpoId, String qrResult) =>
      apiProvider.payableCreditDetail_Scan(grpoId, qrResult);

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
          int requestId,
          String whsCodeFrom,
          int absEntryFrom,
          String binCodeFrom,
          String qrResult) =>
      apiProvider.inventoryTransferDetail_Scan(
          requestId, whsCodeFrom, absEntryFrom, binCodeFrom, qrResult);

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
  //CflTransferProduction
  //-----------------------------
  Future<CflTransferProductionResponse> cflTransferProduction_FetchNextPage(
          int rowStart, String searchQuery) =>
      apiProvider.cflTransferProduction_FetchNextPage(rowStart, searchQuery);

  //-----------------------------
  //CflTransferRequest
  //-----------------------------
  Future<CflTransferRequestResponse> cflTransferRequest_FetchNextPage(
          int rowStart, String searchQuery) =>
      apiProvider.cflTransferRequest_FetchNextPage(rowStart, searchQuery);

  //-----------------------------
  //CflTransferBranch
  //-----------------------------
  Future<CflTransferBranchResponse> cflTransferBranch_FetchNextPage(
          int rowStart, String searchQuery) =>
      apiProvider.cflTransferBranch_FetchNextPage(rowStart, searchQuery);

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
  //CflPurchaseSupplier
  //-----------------------------
  Future<CflPurchaseSupplierResponse> cflPurchaseSupplier_FetchNextPage(
          int rowStart, String searchQuery) =>
      apiProvider.cflPurchaseSupplier_FetchNextPage(rowStart, searchQuery);

  //-----------------------------
  //CflPurchaseItem
  //-----------------------------
  Future<CflPurchaseItemResponse> cflPurchaseItem_FetchNextPage(
          int rowStart, String searchQuery, int poId) =>
      apiProvider.cflPurchaseItem_FetchNextPage(rowStart, searchQuery, poId);

//-----------------------------
  //CflPurchaseDelivery
  //-----------------------------
  Future<CflPurchaseDeliveryResponse> cflPurchaseDelivery_FetchNextPage(
          int rowStart, String searchQuery) =>
      apiProvider.cflPurchaseDelivery_FetchNextPage(rowStart, searchQuery);

//-----------------------------
  //CflReturnRequest
  //-----------------------------
  Future<CflReturnRequestResponse> cflReturnRequest_FetchNextPage(
          int rowStart, String searchQuery) =>
      apiProvider.cflReturnRequest_FetchNextPage(rowStart, searchQuery);

//-----------------------------
  //CflReturnRequestDelivery
  //-----------------------------
  Future<CflReturnRequestDeliveryResponse> cflReturnRequestDelivery_FetchNextPage(
          int rowStart, String searchQuery) =>
      apiProvider.cflReturnRequestDelivery_FetchNextPage(rowStart, searchQuery);


  //-----------------------------s
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

  //-----------------------------
  //CflBranch
  //-----------------------------
  Future<CflBranchResponse> cflBranch_FetchNextPage(
          int rowStart, String searchQuery, int branchId) =>
      apiProvider.cflBranch_FetchNextPage(rowStart, searchQuery, branchId);

  //-----------------------------
  //CflWarehouse
  //-----------------------------
  Future<CflWarehouseResponse> cflWarehouse_FetchNextPage(
          int rowStart, String searchQuery, int branchId) =>
      apiProvider.cflWarehouse_FetchNextPage(rowStart, searchQuery, branchId);

  //-----------------------------
  //CflBinLocation
  //-----------------------------
  Future<CflBinLocationResponse> cflBinLocation_FetchNextPage(
          int rowStart, String searchQuery, String whsCode) =>
      apiProvider.cflBinLocation_FetchNextPage(rowStart, searchQuery, whsCode);

  //-----------------------------
  //CflBatchLocation
  //-----------------------------
  Future<CflBatchLocationResponse> cflBatchLocation_FetchNextPage(
          int rowStart,
          String searchQuery,
          String whsCode,
          String batchNo,
          String itemCode) =>
      apiProvider.cflBatchLocation_FetchNextPage(
          rowStart, searchQuery, whsCode, batchNo, itemCode);

  //-----------------------------
  //CflItemBatch
  //-----------------------------
  Future<CflItemBatchResponse> cflItemBatch_FetchNextPage(int rowStart,
          String searchQuery, String whsCode, String batchNo, int id) =>
      apiProvider.cflItemBatch_FetchNextPage(
          rowStart, searchQuery, whsCode, batchNo, id);
}
