import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class sw extends StatefulWidget {
  const sw({super.key});

  @override
  State<sw> createState() => _swState();
}

class _swState extends State<sw> {
  int milliseconds =0;
  late Timer timer;

  // @override
  // void initState() {
  //   super.initState();
  //   timer = Timer.periodic(Duration(seconds: 1),_onTick);
  // }

  void _onTick(Timer time){
    // if(mounted){
      setState(() {
        milliseconds+=100;
      });
   // }
  }

  String _secondsText(int milliseconds) {
    final seconds = milliseconds /1000;
    return '$seconds seconds';
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  bool _isTicking = false;
  void _startTimer(){
     timer = Timer.periodic(Duration(milliseconds: 100),_onTick);
   
    setState(() {
       milliseconds = 0;
      _isTicking = true;
      laps.clear();
    });
  }
  void _stopTimer(){
    timer.cancel();
    setState(() {
      _isTicking = false;
    });
  }
  final laps = <int>[];

  void _lap(){
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StopWatch",style: TextStyle(color: Colors.white,fontSize: 30),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Expanded(child: _buildcounter(context)),
      ),
    );
  }

  Widget _buildcounter(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Text(
              'Lap ${laps.length+1}',
              style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
            ),
            SizedBox(height: 20,),
            Text(
              _secondsText(milliseconds),
              style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
            ),
            SizedBox(height: 20,),
            _buildControls(),
            SizedBox(height: 20,),
            Expanded(
              child: ListView(
                children: [
                  for(int milliseconds in laps)
                  ListTile(
                    title: Text(_secondsText(milliseconds),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),),
                  )
                ],
              ),
            )
          ],
        ),
    );
  }

  Widget _buildControls() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _isTicking?null:_startTimer, 
                child: Text("Start"),
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                  onPressed:_isTicking ? _stopTimer:null, 
                  child: Text("Stop")),
                  SizedBox(width: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                    onPressed:_isTicking?_lap:null, 
                    child: Text("Lap")),
                    SizedBox(width: 20,),
            ],
          );
  }
}
