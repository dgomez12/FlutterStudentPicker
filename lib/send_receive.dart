import 'package:flutter/material.dart';
import 'send.dart' as sendpage;
import 'receive.dart' as receivepage;

class SendReceive extends StatefulWidget {
  @override
  _SendReceiveState createState() => _SendReceiveState();
}

class _SendReceiveState extends State<SendReceive> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
  void initState(){
    super.initState();
    controller = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GGC Thorns, Roses and Buds"),
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.arrow_upward),
              text: "Send",
            ),
            Tab(
              icon: Icon(Icons.arrow_downward),
              text: "Receive",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          new sendpage.SendPage(),
          new receivepage.ReceivePage(),
        ],
      ),
    );
  }
}
