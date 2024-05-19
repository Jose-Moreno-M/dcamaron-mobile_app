import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {

  String text = '';

  NoDataWidget({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              'assets/img/cero-items.png',
              height: MediaQuery.of(context).size.height * 0.3,
          ),//'assets/img/cero-items.png'
          SizedBox(height: 10),
          Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
          )
        ],
      ),
    );
  }
}
