
import 'package:audioplayers/audioplayers.dart';
import 'package:ebook_app/audio_file.dart';
import 'package:flutter/material.dart';
import 'package:ebook_app/app_colors.dart' as AppColors;
import 'package:flutter/widgets.dart';

class AudioScreen extends StatefulWidget {

  final booksData;
  final int? index;
  const AudioScreen({Key? key,this.booksData,this.index}) : super(key: key);

  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  AudioPlayer? advancedPlayer ;
  @override
  void initState()
  {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      appBar: AppBar(
        backgroundColor: AppColors.audioBlueBackground,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: (){},
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight/3 ,
              child: Container(
                color:AppColors.audioBlueBackground ,
              ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight*.12,
            height: screenHeight*.36 ,
            child: Container(
              decoration: BoxDecoration(
                color:Colors.white ,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight*.1,),
                  Text(
                      widget.booksData[widget.index]['title'],
                    style: const TextStyle(
                      fontSize: 25,
                      fontFamily: 'Avenir',
                    ),
                  ),
                  Text(
                    widget.booksData[widget.index]['text'],
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  AudioFile(advancedPlayer: advancedPlayer, audioPath:widget.booksData[widget.index]['audio'],),
                ],
              ),
            ),
          ),
          Positioned(
              top: screenHeight*0.02,
              left: (screenWidth-150)/2,
              right: (screenWidth-150)/2,
              height: screenHeight*.2,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.audioGreyBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white,width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white,width: 5),
                      image: DecorationImage(
                        image: AssetImage(widget.booksData[widget.index]['img'],),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
          ),
          Positioned(
              top: screenHeight*.49,
              left: 15,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                       'Add to Playlist',
                     style: TextStyle(fontSize: 25),
                   ),
                  const SizedBox(height: 8,),
                  Row(
                    children: const [
                      Image(
                        image: AssetImage('assets/images/pic-1.png'),
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 10.0,),
                      Image(
                        image: AssetImage('assets/images/pic-2.png'),
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 10.0,),
                      Image(
                        image: AssetImage('assets/images/pic-3.png'),
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 10.0,),
                    ],
                  ),
                ],
              ) ,
          ),
          Positioned(
            top: screenHeight*.78,
            left: 15,
            height:55,
            width: screenWidth*.9,
            child: Container(
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(20),
               border: Border.all(color: Colors.white,width: 2),
             ),
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: const [
                    Icon(Icons.favorite,size: 24,),
                    SizedBox(width: 50,),
                    Icon(Icons.star,size: 24,),
                    SizedBox(width: 50,),
                    Icon(Icons.remove_red_eye,size: 24,),
                    SizedBox(width: 50,),
                    Icon(Icons.share,size: 24,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

