import 'package:intelleplay/play_main.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class CheckState{
  static bool isMusicOnBtn = true;
  static bool isMusicOnEnv = true;
  static final music = AudioPlayer();

}


// void main() => runApp(const MyApp());
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  static final  player = AudioPlayer();
  bool showIntro = true;


  void loopMusic() async {
    try {

      await CheckState.music.setSourceAsset('background.mp3');
      await CheckState.music.setReleaseMode(ReleaseMode.loop);
      await CheckState.music.resume();
    } catch (e) {

      CheckState.isMusicOnEnv = !CheckState.isMusicOnEnv;
    }
  }
  @override
  void initState() {
    super.initState();
    CheckState.music.release();
    if(CheckState.isMusicOnEnv){

      loopMusic();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4FBFE),
      body: Stack(
        children: <Widget> [
          Center(
            child: Transform.scale(
              scale: MediaQuery.of(context).size.height / 220.0, // Adjust the scale factor as per your requirement
              child: Lottie.asset(
                'assets/json/joyfulbackground.json', // Replace with the path to your JSON animation file
                fit: BoxFit.contain,
              ),
            ),
          ),

          Visibility(
            visible: showIntro,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                width: 370.0,
                height: 260.0,
                child: Card(
                  color: const Color(0xffffffff).withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(95.0)
                  ),
                  child:  Stack(
                    children: <Widget> [
                      Positioned(
                        top: 20,
                        left: 40,
                        height: 100,
                        width: 170,
                        child: SvgPicture.asset(
                          'assets/svg/simple_circle.svg',
                        ),
                      ),
                      const Positioned(
                        top: 35,
                        left: 55,
                        child: Text(
                          "Intelleplay",
                          style: TextStyle(
                            fontSize: 30.0,

                            fontFamily: 'IntroFont',
                            fontWeight: FontWeight.bold,
                            color: Color(0xff160D47),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 35,
                        left: 40,
                        height: 190,
                        width: 250,

                        child: SvgPicture.asset(
                          'assets/svg/intro_text_background.svg',
                        ),
                      ),
                      const Positioned(
                        top: 105,
                        left: 50,
                        child: Text(
                          "-Puzzel to test your brain.\n-It includes mind games.\n-You can level-up yourself.",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'Instruction',
                            fontWeight: FontWeight.bold,
                            color: Color(0xff160D47),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        right: 30,
                        child: Image.asset(
                          'assets/png/study.png',
                          width: 100,
                          height: 100,
                          semanticLabel: 'My Intro Image',
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: showIntro,
            child: Center(
              child: Transform.translate(
                offset: const Offset(0, 110),
                child: SizedBox(
                  height: 80,
                  width: 100,
                  child: OutlinedButton(
                      onPressed: (){


                        if(CheckState.isMusicOnBtn){
                          player.play(AssetSource('touch.mp3'));
                        }


                        setState(() {
                          showIntro = false; // Hide the intro widgets

                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                          Color(0xff160D47),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60)
                          ),
                        ),
                      ),
                      child: const Text(
                        "PLAY",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Intelleplay"
                        ),
                      )),
                ),
              ),
            ),
          ),
          // New Center Widget with Card List
          Visibility(
            visible: !showIntro,
            child: Center(
              child: Stack(

                children: <Widget>[

                  //sdsdsd
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric( horizontal: 20.0),
                      width: 370.0,
                      height: 250.0,
                      child: Card(
                        color: const Color(0xffffffff).withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            // App bar-like container
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              decoration: BoxDecoration(
                                color: Color(0xff160D47), // Change this color to your desired app bar color
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // App bar title or content
                                  Text(
                                    "Intelleplay",
                                    style: TextStyle(
                                      color: Colors.white, // Change text color to your liking=fontSize: 18.0, // Adjust font size as needed
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Intelleplay",// Adjust font weight as needed
                                    ),
                                  ),
                                  // Button in the top-right corner
                                  IconButton(
                                    icon: Icon(
                                      CheckState.isMusicOnEnv ? Icons.multitrack_audio : Icons.music_off, // Change the icon based on the state
                                      color: Colors.white,
                                    ),
                                    onPressed: (){
                                      if (CheckState.isMusicOnEnv){
                                        CheckState.music.release();
                                      } else {
                                        CheckState.music.release();
                                        loopMusic();
                                      }

                                      setState(() {

                                        CheckState.isMusicOnEnv = !CheckState.isMusicOnEnv;
                                      });

                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CheckState.isMusicOnBtn ? Icons.music_note : Icons.music_off_outlined, // Change the icon based on the state
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if(!CheckState.isMusicOnBtn){
                                        player.play(AssetSource('touch.mp3'));
                                      }
                                      // Toggle the music state and update the icon
                                      setState(() {
                                        CheckState.isMusicOnBtn = !CheckState.isMusicOnBtn;
                                      });

                                      // Add your logic to handle music playback here
                                      if (CheckState.isMusicOnBtn) {
                                        // Start or resume music playback
                                      } else {
                                        // Pause or stop music playback
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.close, // Change the icon to your desired icon
                                      color: Colors.white, // Change icon color to your liking
                                    ),
                                    onPressed: () {
                                      if(CheckState.isMusicOnBtn){
                                        player.play(AssetSource('touch.mp3'));
                                      }
                                      // Handle button press here
                                      setState(() {
                                        showIntro = true; // Hide the intro widgets
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),



                            Container(
                              width: 320,
                              height: 90,
                              margin: const EdgeInsets.all( 10.0),
                              padding: const EdgeInsets.all( 5.0),
                              child: SizedBox(

                                child: OutlinedButton(
                                  onPressed: (){
                                    if(CheckState.isMusicOnBtn){
                                      player.play(AssetSource('touch.mp3'));
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const PlayMain()),
                                    );
                                  },
                                  style: ButtonStyle(

                                    backgroundColor: const MaterialStatePropertyAll(
                                      Color(0xffffffff),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                      ),

                                    ),
                                    alignment: Alignment.centerLeft,
                                  ),
                                  child: Container(
                                    child: Text(

                                      "     Prime Sum",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xff160D47), // Change text color to your liking=                                      fontSize: 18.0, // Adjust font size as needed
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Intelleplay",
                                        fontSize: 24,

                                      ),
                                    ),
                                  ),

                                ),
                              ),
                            ),

                            Text(
                              "* more games will be added soon",
                              style: TextStyle(
                                  color: Color(0xff160D47).withOpacity(0.5), // Change text color to your liking=                                      fontSize: 18.0, // Adjust font size as needed
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Intelleplay",
                                  fontSize: 12// Adjust font weight as needed
                              ),
                            ),
                            // Other content of your card can go here
                          ],
                        ),
                      ),
                    ),
                  ),


                  // Your card list here

                ],
              ),
            ),
          ),

        ],
      ),

    );
  }

}