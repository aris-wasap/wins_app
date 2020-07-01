import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:admart_app/pages/new_it_page.dart';
import 'package:admart_app/pages/detail_it_page.dart';

class InventoryTransfer extends StatefulWidget {
  @override
  State createState() => new InventoryTransferState();
}

class InventoryTransferState extends State<InventoryTransfer> {
  List data;

  Future<String> getData() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    String url = "https://192.168.1.9:50000/b1s/v1/StockTransfers?\$select=DocNum,DocDate,FromWarehouse,ToWarehouse&\$orderby=DocEntry";
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set("content-type", "application/json");
    request.headers.set("Cookie", "B1SESSION=90d5e0ba-a83d-11e9-8000-e4434b4da604");
    
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();

    setState(() {
      var resBody = json.decode(reply);
      data = resBody["value"];
    });
    
    client.close();

    return "success";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Inventory Transfer"),
        backgroundColor: Colors.blue[900],
        bottom: PreferredSize(
          child: Container(
            color: Colors.yellow[900],
            height: 5.0,
          ),
          preferredSize: Size.fromHeight(5.0)
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                return NewIt();
              }));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                return DetailIT();
              }));
            },
            child: Card(
              margin: EdgeInsets.all(1),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                            child: Text(
                              data[i]['DocNum'].toString(),
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                            child: Text(
                              "Doc Date: "+data[i]['DocDate'],
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "From Warehouse: "+data[i]['FromWarehouse'], textAlign: TextAlign.right,
                            ),
                            Text(
                              "To Warehouse: "+data[i]['ToWarehouse'], textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
