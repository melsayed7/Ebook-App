
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer? advancedPlayer;
  final String? audioPath;
  const AudioFile({Key? key, this.advancedPlayer, this.audioPath}) : super(key: key);

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  //String path ="assets/audio/assets_audio.mp3";
  bool isPlaying=false;
  bool isPaused=false;
  bool isRepeat=false;
  Color color= Colors.black;
  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState(){
    super.initState();
    widget.advancedPlayer!.onDurationChanged
        .listen((d) {
          setState(() {
            _duration=d;
          });});
    widget.advancedPlayer!.onAudioPositionChanged
        .listen((p) {
          setState(() {
            _position=p;
          });});

    widget.advancedPlayer!.setUrl(widget.audioPath!);
    widget.advancedPlayer!.onPlayerCompletion.listen((event) {
      setState(() {
        _position = const Duration(seconds: 0);
        if(isRepeat==true){
          isPlaying=true;
        }else{

          isPlaying=false;
          isRepeat=false;
        }
      });
    });
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying==false?
            Icon(_icons[0], size:50, color:Colors.blue):
            Icon(_icons[1], size:50, color:Colors.blue),
      onPressed: (){
        if(isPlaying==false) {
          widget.advancedPlayer!.play(widget.audioPath!);
          setState(() {
            isPlaying = true;
          });
        }else if(isPlaying==true){
          widget.advancedPlayer!.pause();
          setState(() {
            isPlaying=false;
          });
        }
      },
    );
  }

  Widget btnFast() {
    return
      IconButton(
        icon:   const ImageIcon(
          AssetImage('assets/images/forward.png'),
          size: 15,
          color: Colors.black,
        ),
        onPressed: () {
          //widget.advancedPlayer!.setPlaybackRate(playbackRate:1.5);
        },
      );
  }
  Widget btnSlow() {
    return IconButton(
      icon:   const ImageIcon(
        AssetImage('assets/images/backword.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {
        //widget.advancedPlayer!.setPlaybackRate(playbackRate: 0.5);

      },
    );
  }
  Widget btnLoop() {
    return  IconButton(
      onPressed: (){},
        icon:   const ImageIcon(
          AssetImage('assets/images/loop.png'),
          size: 15,
          color: Colors.black,
        ),

    );
  }
  Widget btnRepeat() {
    return IconButton(
      icon: ImageIcon(
        const AssetImage('assets/images/repeat.png'),
        size: 15,
        color:color,
      ),
      onPressed: (){
        if(isRepeat==false){
          widget.advancedPlayer!.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isRepeat=true;
            color=Colors.blue;
          });
        }else if(isRepeat==true){
          widget.advancedPlayer!.setReleaseMode(ReleaseMode.RELEASE);
          color=Colors.black;
          isRepeat=false;
        }
      },
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.red,
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });});
  }

  void changeToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer!.seek(newDuration);
  }

  Widget loadAsset() {
    return
      Container(
          child:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                btnRepeat(),
                btnSlow(),
                btnStart(),
                btnFast(),
                btnLoop()
              ])
      );
  }
  @override
  Widget build(BuildContext context) {
    return
      Container(child:
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(_position.toString().split(".")[0], style: const TextStyle(fontSize: 16),),

                Text(_duration.toString().split(".")[0], style: const TextStyle(fontSize: 16),),
              ],
            ),
          ),

          slider(),
          loadAsset(),
        ],
      )

      );
  }
}
