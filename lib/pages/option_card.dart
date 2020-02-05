import 'package:flutter/material.dart';
import 'package:ncf_app/pages/icon_color.dart';


class OptionCard extends StatelessWidget{

  final String title;
  final String icon;
  final GestureTapCallback _onTap;

  OptionCard(this.title, this.icon, this._onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      //Backgound tertutup Card
      width: 100,
      height: 100,
      margin: EdgeInsets.all(15),
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(0),
        child: InkWell(
          onTap: _onTap,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 40, width: 40, child: Image(
                    image: AssetImage(icon),
                ),),
                Spacer(),
               Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0), textAlign: TextAlign.center,)
              ],

            ),
          ),
        ),
      ),
    );
  }
}