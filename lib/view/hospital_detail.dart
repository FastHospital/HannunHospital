import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_tts/flutter_tts.dart';
// import 'package:flutter_tts/flutter_tts.dart';
import 'package:mytownmysymptom/config.dart';
import 'package:mytownmysymptom/model/hospital.dart';

class HospitalDetail extends StatefulWidget {
  const HospitalDetail({super.key});

  @override
  State<HospitalDetail> createState() => _HospitalDetailState();
}
enum TtsState { playing, stopped, paused, continued }
class _HospitalDetailState extends State<HospitalDetail> {
  late FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;
  
  var hospitalData = [];
  late Hospital? hospital = null; 
  late String number = '';
  List<String> hType = [
    '치과병원',
    '병원',
    '요양병원(일반요양병원)',
    '한방병원',
    '종합병원',
    '정신병원',
    '요양병원(노인병원)',
    '요양병원(장애인의료재활시설)'
    
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    setTts();

  }

  void setTts() async{
    // IOS Only
    // await flutterTts.setSharedInstance(true);
    flutterTts = FlutterTts();
    
    _setAwaitOptions();

    flutterTts.setStartHandler(() {
      setState(() {
        debugPrint("TtsState: Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        debugPrint("TtsState: Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        debugPrint("TtsState: Cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        debugPrint("TtsState: Paused");
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        debugPrint("TtsState: Continued");
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        debugPrint("TtsState: Error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<void> getData() async {
    try{
      hospitalData = await hospitalHandler.queryK({"id":5});
      if(hospitalData.length>0) hospital = hospitalData[0];
      number = hospital!.phone.split('.')[0];
      setState(() {});
    }catch(err){
      print(err);
    }
  }


  @override
  Widget build(BuildContext context) {
    
    if(hospital == null) {
      return Scaffold(body:Center(child:CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(hospital!.name),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width:500,
                  height:100,
                  color: Colors.lightBlue,
                  child: Text('image'),
                ),
            
          
                _boxTextHeader(),
                SizedBox(height:50),
                _boxTextMiddle(hospital!.type),
                SizedBox(height:50),
                ElevatedButton(
                  onPressed: () async => await FlutterPhoneDirectCaller.callNumber(number),
                  style: ElevatedButton.styleFrom(

                    // BUTTON COLOR
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)
                    )
                  ),
                  child: Text('전화걸기')
                )
              ],
            ),
          )
        ),
      )
    );
  }

  Widget _boxTextHeader(){
    return Column(
      children: [
        _boxTextHeaderRow('병원명',hospital!.name),
        _boxTextHeaderRow('전화번호', number),
        _boxTextHeaderRow('주소', hospital!.address),
      ],
    );
  }

  Widget _boxTextHeaderRow(String label, String n) {
    return Row(
          spacing: 5,
          children: [
            SizedBox(width: 80, child:Text(label, style: TextStyle(color:Colors.lightBlue,fontSize:20))),
            Expanded(child:  Text(n)),
            IconButton(
              onPressed: () async=> await _speak(n),
              icon: Icon(Icons.volume_up)
            ), 
          ]
    );
  }

  Widget _boxTextMiddle(String title) {

    return Column(
      children: [
        Text('이 병원은...'),
        Text(title),
      ],
    );
    // return Column(
    //   // 카타고리
    //   children: List.generate(
    //     hType.length,
    //     (index) => Text(hType[index]),
    //   )
    // );
  }
  
  // speak
  Future _speak(String n) async{
    
    var result = await flutterTts.speak(n);
    if (result == 1) {
      setState(() => ttsState = TtsState.playing);
    }
  }

  // Before staring, wait for loading
  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }



}