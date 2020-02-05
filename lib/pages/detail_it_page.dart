import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DetailIT extends StatefulWidget {
  @override
  State createState() => new DetailITState();
}

class DetailITState extends State<DetailIT> {
  List<Map<String, dynamic>> data = [];

  Future<String> getData() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    String url = "https://192.168.1.9:50000/b1s/v1/StockTransfers(8)?\$select=DocEntry,DocDate,CardCode,CardName,Comments,%20FromWarehouse,ToWarehouse,DocNum,StockTransferLines";
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set("content-type", "application/json");
    request.headers.set("Cookie", "B1SESSION=90d5e0ba-a83d-11e9-8000-e4434b4da604");

    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();

    setState(() {
      var resBody = json.decode(reply);
      var jsonData = {'docNum' : resBody["DocNum"],
        'docDate' : resBody["DocDate"],
        'fromWhsCode' : resBody["FromWarehouse"],
        'toWhsCode' : resBody["ToWarehouse"],
        'details' : resBody["StockTransferLines"]};
      data.add(jsonData);
    });

    client.close();
    print(data);

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
          title: Text("Details 1916000000"),
          backgroundColor: Colors.blue[900],
          bottom: PreferredSize(
              child: Container(
                color: Colors.yellow[900],
                height: 5.0,
              ),
              preferredSize: Size.fromHeight(5.0))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 35)),
              Expanded(
                child: Text('DocNum', textAlign: TextAlign.left, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                flex: 5,
              ),
              Expanded(
                child: Text(': '+data[0]["docNum"].toString(), textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
                flex: 7,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 30)),
              Expanded(
                child: Text('DocDate', textAlign: TextAlign.left, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                flex: 5,
              ),
              Expanded(
                child: Text(': '+data[0]["docDate"].toString(), textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
                flex: 7,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 30)),
              Expanded(
                child: Text('FromWarehouse', textAlign: TextAlign.left, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                flex: 5,
              ),
              Expanded(
                child: Text(': '+data[0]["fromWhsCode"].toString(), textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
                flex: 7,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 30)),
              Expanded(
                child: Text('ToWarehouse', textAlign: TextAlign.left, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                flex: 5,
              ),
              Expanded(
                child: Text(': '+data[0]["toWhsCode"].toString(), textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
                flex: 7,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
