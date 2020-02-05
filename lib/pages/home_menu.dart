import 'package:flutter/material.dart';
import 'package:ncf_app/blocs/global_bloc.dart';
import 'package:ncf_app/pages/delivery_order/delivery_order_list_page.dart';
import 'package:ncf_app/pages/option_card.dart';
import 'package:ncf_app/pages/receipt_issue/receipt_issue_list_page.dart';
import 'package:ncf_app/pages/receipt_order/receipt_order_list_page.dart';
import 'package:ncf_app/pages/receipt_production/receipt_production_list_page.dart';

class HomeMenuPage extends StatefulWidget {
  @override
  _HomeMenuPageState createState() => _HomeMenuPageState();
}

class _HomeMenuPageState extends State<HomeMenuPage> {

  Widget buildOptions() {
              
    return Container(
      height: 100,
        child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                
                ),
        children: <Widget>[
          
          GridTile(
            child: OptionCard('Receipt From Production', 'assets/images/receipt.png',(){
                if (globalBloc.loginResponse.data
                                                .receiptProduction_Auth_Detail ==
                                            'Y') {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (BuildContext context) {
                                            return ReceiptProductionListPage();
                                          }));
                                       }
              }),
          ),
          GridTile(
            child: OptionCard('Receipt From Issue', 'assets/images/receipt_issue.png',(){
                if (globalBloc.loginResponse.data
                                                .receiptIssue_Auth_Detail ==
                                            'Y') {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (BuildContext context) {
                                            return ReceiptIssueListPage();
                                          }));
                                       }
              }),
          ),
          GridTile(
            child: OptionCard('Receipt From Purchase Order', 'assets/images/receipt_po.png',()
            {
                if (globalBloc.loginResponse.data
                                                .receiptOrder_Auth_Detail ==
                                            'Y') {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (BuildContext context) {
                                            return ReceiptOrderListPage();
                                          }));
                                       }
              }),
          ),
          GridTile(
            child: OptionCard('Inventory Transfer', 'assets/images/transfer.png',(){
                if (globalBloc.loginResponse.data
                                                .inventoryTransfer_Auth_Detail ==
                                            'Y') {
                                          // Navigator.push(context, MaterialPageRoute(
                                          //     builder: (BuildContext context) {
                                          //   return InventoryTransferListPage();
                                          // }));
                                       }
              }),
          ),
          GridTile(
            child: OptionCard('Delivery', 'assets/images/delivery.png',(){
                if (globalBloc.loginResponse.data
                                                .deliveryOrder_Auth_Detail ==
                                            'Y') {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (BuildContext context) {
                                            return DeliveryOrderListPage();
                                          }));
                                       }
              
              }),
          ),
          GridTile(
            child: OptionCard('Return', 'assets/images/return.png',(){
                if (globalBloc.loginResponse.data
                                                .returnSales_Auth_Detail ==
                                            'Y') {
                                          // Navigator.push(context, MaterialPageRoute(
                                          //     builder: (BuildContext context) {
                                          //   return ReturnSalesListPage();
                                          // }));
                                       }

              }),
          ),
          
          
        ],
        
      ),
    );
  
  }
  
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double heightScreen = mediaQueryData.size.height;

    return  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //   Center(
              //   child: _widgetOptions.elementAt(_selectedIndex),
              // ),
               Flexible(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  
                  child: Container(
                  margin: EdgeInsets.all(0.0),
                  height: heightScreen,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFD0E1F9), 
                        const Color(0xFFFD0E1F9), 
                        ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  ),
                  child: GridView.count(
                      crossAxisCount: 1,
                      children: <Widget>[
                        buildOptions(),
                      ],
                  ),
                  
                )
                ),
              )
            ],

          );
  }
}
