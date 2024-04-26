import 'dart:async';
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:master_stopwatch/plattform_alert.dart';

class sw extends StatefulWidget {
  const sw({super.key});

  @override
  State<sw> createState() => _swState();
}

class _swState extends State<sw> {
  int milliseconds = 0;
  late Timer timer;

  // @override
  // void initState() {
  //   super.initState();
  //   timer = Timer.periodic(Duration(seconds: 1),_onTick);
  // }

  void _onTick(Timer time) {
    // if(mounted){
    setState(() {
      milliseconds += 100;
    });
    // }
  }

  String _secondsText(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  @override
  void dispose() {
    timer.cancel();
    scrollController.dispose();
    super.dispose();
  }

  bool _isTicking = false;
  void _startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 100), _onTick);

    setState(() {
      milliseconds = 0;
      _isTicking = true;
      laps.clear();
    });
  }

  void _stopTimer(BuildContext context) {
    timer.cancel();
    setState(() {
      _isTicking = false;
    });
    // final totalRuntime = laps.fold(milliseconds, (total, lap) => total + lap);
    // final alert = PlatformAlert(
    //   'Run Completed!', 
    //   "Total Run Time is ${_secondsText(totalRuntime)}");
    //   alert.show(context);
   // showBottomSheet(context: context, builder: _buildRunCompleteSheet);

    final controller = showBottomSheet(context: context,builder: _buildRunCompleteSheet);

    Future.delayed(Duration(seconds: 5)).then((_) => controller.close());
  }

  final laps = <int>[];

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
    scrollController.animateTo(
      itemHeight * laps.length,
      duration: Duration(microseconds: 500),
      curve: Curves.easeIn,
    );
  }

  final itemHeight = 60.0;
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "StopWatch",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
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
          SizedBox(
            height: 20,
          ),
          Text(
            'Lap ${laps.length + 1}',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            _secondsText(milliseconds),
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          _buildControls(),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                controller: scrollController,
                itemExtent: itemHeight,
                itemCount: laps.length,
                itemBuilder: (context, index) {
                  final milliseconds = laps[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 50),
                    title: Text('Lap ${index + 1}',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    trailing: Text(_secondsText(milliseconds),
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  );
                },

                // for(int milliseconds in laps)
                // ListTile(
                //   title: Text(_secondsText(milliseconds),
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 25,
                //   ),),
              ),
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
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: _isTicking ? null : _startTimer,
          child: Text("Start"),
        ),
        SizedBox(
          width: 20,
        ),
        Builder(
          builder: (context) =>  ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _isTicking ?()=> _stopTimer(context) : null,
              child: Text("Stop")),
        ),
        SizedBox(
          width: 20,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
            ),
            onPressed: _isTicking ? _lap : null,
            child: Text("Lap")),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
  Widget _buildRunCompleteSheet(BuildContext context){
    final totalRunTIme = laps.fold(milliseconds, (total, lap) => total + lap);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child:Container(
        color: Theme.of(context).cardColor,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Run Finished!', style: textTheme.headlineSmall,),
              Text('Total Run Time is ${_secondsText(milliseconds)}')
            ],
          ),
        ),
      )
      );
  }
}
