import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:lottie/lottie.dart';
import 'package:intelleplay/main.dart';


class PlayMain extends StatefulWidget {
  const PlayMain({Key? key}) : super(key: key);

  @override
  State<PlayMain> createState() => _PlayMainState();
}

class _PlayMainState extends State<PlayMain> with TickerProviderStateMixin  {



  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isSpinning = false;
  List<int> _randomNumbers = List.filled(4, 0);
  int myRandom = (Random().nextInt(90 - 10 + 1) + 10);

  Color _containerColor0 = const Color(0xffEAEFF2);
  Color _containerColor1 = const Color(0xffEAEFF2);
  Color _containerColor2 = const Color(0xffEAEFF2);
  Color _containerColor3 = const Color(0xffEAEFF2);

  late AnimationController _controllerProgress;
  late Animation<double> _animationProgress;
  double _progress = 0.0;

  late final int level = 5;
  late int count_level= 0;
  late String showCount_level = "${count_level}/${level}";

  late int game_score = 0;

  final player = AudioPlayer();
  final audioplayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isSpinning = false;
          _generateRandomNumbers(); // Generate numbers after spinning completes
        });
      }
    });

    //Progress Bar animation
    _controllerProgress = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );
    _animationProgress = Tween<double>(begin: 0.0, end: 1.0).animate(_controllerProgress)
      ..addListener(() {
        setState(() {
          _progress = _animationProgress.value * 100;
        });
      });

    _controllerProgress.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {

          if (!(count_level==level)){
            count_level+=1;
            _startSpinAnimation();
          } else{
            _showLevelDialog();
          }


        });
      }
    });

  }

  Widget buildScoreWidgets(int gameScore) {
    if (gameScore==0){
      return Column(
        children: [
          Image.asset(
            'assets/png/bad.png',
            width: 100,
            height: 100,
            semanticLabel: 'My Intro Image',
          ),
          Text("$gameScore : Bad", style: TextStyle(fontFamily: "Intelleplay")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
            ],
          ),
        ],
      );
    } else if (gameScore == 1) {
      return Column(
        children: [
          Image.asset(
            'assets/png/bad.png',
            width: 100,
            height: 100,
            semanticLabel: 'My Intro Image',
          ),
          Text("$gameScore : Not Bad", style: TextStyle(fontFamily: "Intelleplay")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
            ],
          ),
        ],
      );
    } else if (gameScore == 2){
      return Column(
        children: [
          Image.asset(
            'assets/png/good.png',
            width: 100,
            height: 100,
            semanticLabel: 'My Intro Image',
          ),
          Text("$gameScore : Good", style: TextStyle(fontFamily: "Intelleplay")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
            ],
          ),
        ],
      );
    } else if(gameScore == 3){
      return Column(
        children: [
          Image.asset(
            'assets/png/good.png',
            width: 100,
            height: 100,
            semanticLabel: 'My Intro Image',
          ),
          Text("$gameScore : Smart", style: TextStyle(fontFamily: "Intelleplay")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
            ],
          ),
        ],
      );
    } else if(gameScore==4){
      return Column(
        children: [
          Image.asset(
            'assets/png/smart.png',
            width: 100,
            height: 100,
            semanticLabel: 'My Intro Image',
          ),
          Text("$gameScore : Excellent", style: TextStyle(fontFamily: "Intelleplay")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
            ],
          ),
        ],
      );
    } else if (gameScore == 5){
      return Column(
        children: [
          Image.asset(
            'assets/png/smart.png',
            width: 100,
            height: 100,
            semanticLabel: 'My Intro Image',
          ),
          Text("$gameScore : Intelligent", style: TextStyle(fontFamily: "Intelleplay")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Image.asset(
            'assets/png/bad.png',
            width: 100,
            height: 100,
            semanticLabel: 'My Intro Image',
          ),
          Text("Please play again", style: TextStyle(fontFamily: "Intelleplay")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
              Image.asset(
                'assets/png/star_noscore.png',
                width: 50,
                height: 50,
                semanticLabel: 'My Intro Image',
              ),
            ],
          ),
        ],
      );
    }


  }
  void _showBackDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0)
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(

                children: [

                  Text("Are you sure?\nWant to go back?", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontFamily: 'Intelleplay', ),),
                  Text("You may lose your current progress!", textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontFamily: 'Intelleplay'),),

                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      if(CheckState.isMusicOnBtn){
                        audioplayer.play(AssetSource('touch.mp3'));
                      }

                      Navigator.pop(context);

                    },
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xff160D47),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: const Text(
                      "No",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Instruction",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: (){
                      if(CheckState.isMusicOnBtn){
                        audioplayer.play(AssetSource('touch.mp3'));
                      }
                      if(CheckState.isMusicOnEnv){
                        CheckState.music.release();
                      }

                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );

                    },

                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xff160D47),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Instruction"
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

        );
      },
    );
  }

  void _showLevelDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0)
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildScoreWidgets(game_score),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      if(CheckState.isMusicOnBtn){
                        audioplayer.play(AssetSource('touch.mp3'));
                      }

                      // Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xff160D47),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: const Text(
                      "HOME",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Instruction",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: (){
                      if(CheckState.isMusicOnBtn){
                        audioplayer.play(AssetSource('touch.mp3'));
                      }

                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const PlayMain()),
                      );

                    },

                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xff160D47),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: const Text(
                      "PLAY AGAIN",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Instruction"
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

        );
      },
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    _controllerProgress.dispose();
    super.dispose();
  }
  void startProgressBarAnimation() {
    _controllerProgress.reset();
    showCount_level = "${count_level}/${level}";
    _controllerProgress.forward();
  }
  void _startSpinAnimation() {
    if (_isSpinning) {

      // _controller.stop();
      // setState(() {
      //   _isSpinning = false;
      // });
    } else {
      if(count_level == 0){
        count_level+=1;
        showCount_level = "${count_level}/${level}";
      }
      _controller.repeat();
      setState(() {
        _isSpinning = true;

      });
      if(CheckState.isMusicOnBtn){
        audioplayer.play(AssetSource('spinner.mp3'));
      }
      Future.delayed(const Duration(seconds: 2), () {
        _controller.stop();
        setState(() {
          _isSpinning = false;
          _generateRandomNumbers();
          startProgressBarAnimation();
        });
      });
    }
  }

  bool isPrime(int number) {
    if (number <= 1) return false;
    for (int i = 2; i <= number / 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  void _generateRandomNumbers() {
    final random = Random();
    setState(() {
      _randomNumbers = List.generate(4, (index) {
        int randomNumber;
        int sum;
        if (index == 3) {
          do {
            randomNumber = random.nextInt(90) + 10;
            sum = myRandom + randomNumber;
          } while (!isPrime(sum));
        } else {
          do {
            randomNumber = random.nextInt(90) + 10;
            sum = myRandom + randomNumber;
          } while (isPrime(sum));
        }
        return randomNumber;
      });
      _randomNumbers.shuffle();
    });
  }
  void _changeContainerColor(int index, int num) {
    setState(() {
      if (num==0){
        _startSpinAnimation();
      } else {
        int sum = myRandom +num;
        myRandom = sum;
        if (index == 0) {
          if(isPrime(sum)){
            game_score++;
            _containerColor0 = Colors.green;
          } else {
            _containerColor0 = Colors.red;
          }
          Future.delayed(Duration(milliseconds: 1500), () {
            setState(() {
              _containerColor0 = const Color(0xffEAEFF2);
              if (!(count_level==level)){
                count_level+=1;
                _startSpinAnimation();
              } else if (count_level == level){
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  _showLevelDialog();

                });
              }
            });
          });
        } else if (index == 1) {
          if(isPrime(sum)){
            game_score++;
            _containerColor1 = Colors.green;
          } else {
            _containerColor1 = Colors.red;
          }
          Future.delayed(Duration(milliseconds: 1500), () {
            setState(() {
              _containerColor1 = const Color(0xffEAEFF2);
              if (!(count_level==level)){
                count_level+=1;
                _startSpinAnimation();
              } else if (count_level == level){
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  _showLevelDialog();
                });
              }
            });
          });
        } else if (index == 2) {
          if(isPrime(sum)){
            game_score++;
            _containerColor2 = Colors.green;
          } else {
            _containerColor2 = Colors.red;
          }
          Future.delayed(Duration(milliseconds: 1500), () {
            setState(() {
              _containerColor2 = const Color(0xffEAEFF2);
              if (!(count_level==level)){
                count_level+=1;
                _startSpinAnimation();
              } else if (count_level == level){
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  _showLevelDialog();
                });
              }
            });
          });
        } else if (index == 3) {
          if(isPrime(sum)){
            game_score++;
            _containerColor3 = Colors.green;
          } else {
            _containerColor3 = Colors.red;
          }
          Future.delayed(Duration(milliseconds: 1500), () {
            setState(() {
              _containerColor3 = const Color(0xffEAEFF2);
              if (!(count_level==level)){
                count_level+=1;
                _startSpinAnimation();
              } else if (count_level == level){
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  _showLevelDialog();
                });
              }
            });
          });
        }

      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF4FBFE),
      body: Stack(
        children: [
          Center(
            child: Transform.scale(
              scale: MediaQuery.of(context).size.height / 220.0, // Adjust the scale factor as per your requirement
              child: Lottie.asset(
                'assets/json/joyfulbackground.json', // Replace with the path to your JSON animation file
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child:  Container(
              height: 25.0,
              color: Colors.white.withOpacity(0.5),
              child:  Center(
                child: Text("Intelleplay",
                  style: TextStyle(
                    fontFamily: "IntroFont",
                    fontWeight: FontWeight.bold,
                    color: Color(0xff160D47).withOpacity(0.9),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            child: Center(
              child: Transform.translate(
                offset: const Offset(0, -80),
                child: SizedBox(
                  width: 340,
                  height: 300,
                  child: Card(
                    color: Colors.white.withOpacity(0.85),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70.0)
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Transform.translate(
                            offset: const Offset(0, -70),
                            child: SvgPicture.asset(
                              'assets/svg/simple_circle.svg',
                            ),
                          ),
                        ),
                        Center(
                          child: Transform.translate(
                            offset: const Offset(0, -70),
                            child: Text(
                              "${myRandom}",
                              style: const TextStyle(
                                fontFamily: "Intelleplay",
                                fontWeight: FontWeight.bold,
                                fontSize: 60.0,
                                color: Color(0xff160D47),
                              ),
                            ),
                          ),
                        ),

                        Center(
                          child: Transform.translate(
                            offset: const Offset(0, -30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 18,
                                      child: Card(
                                        color: const Color(0xffffffff),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(70.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: _progress,
                                      height: 18,
                                      child: Card(
                                        color: const Color(0xff160D47),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(70.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Text(
                                  showCount_level,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Intelleplay",
                                    color: Color(0xff160D47),
                                  ),

                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: Center(
              child: Transform.translate(
                offset: const Offset(0, -75),
                child: const Text(
                  "Spin and pick a number for Prime sum",
                  style: TextStyle(
                    fontFamily: "Intelleplay",
                    color: Color(0xff160D47),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: Center(
              child: Transform.translate(
                offset: const Offset(0, 210),
                child: SizedBox(
                  width: 340,
                  height: 200,
                  child: Card(
                    color: Colors.white.withOpacity(0.85),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70.0)
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            child: Center(
              child: Transform.translate(
                offset: const Offset(-70, 305),
                child: SizedBox(
                  height: 45,
                  width: 75,

                  child: OutlinedButton(
                      onPressed: (){
                        if(CheckState.isMusicOnBtn){
                          audioplayer.play(AssetSource('touch.mp3'));
                        }
                        _showBackDialog();
                      },
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                          Color(0xff160D27),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      )
                  ),

                ),

              ),
            ),
          ),


          Positioned(
            child: Center(
              child: Transform.translate(
                offset: const Offset(35, 305),
                child: SizedBox(
                  height: 45,
                  width: 140,
                  child: OutlinedButton(
                      onPressed: (){

                        if (!(count_level==level) ){
                          count_level+=1;
                          showCount_level = "${count_level}/${level}";
                          _startSpinAnimation();
                        } else{
                          _showLevelDialog();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                          Color(0xff160D47),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                      child: const Text(
                        "NEXT",

                        style: TextStyle(
                          fontFamily: 'IntroFont',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
            ),
          ),



          Positioned(
            child: Center(
              child: Transform.translate(
                offset: const Offset(0, 100),
                child: spinner(),
              ),
            ),
          ),

        ],
      ),
    );
  }

  dynamic spinner() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * 2 * pi,
          child: Stack(
            alignment: Alignment.center,
            children: [

              Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 180, // Adjust the size of the box as per your requirements
                      height: 180,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffeceff1), // Adjust the color of the circle
                      ),
                    ),
                    Positioned(
                      top: 10,
                      child: Transform.rotate(
                        angle: 1 * pi / 2,
                        child: Transform.rotate(
                          angle: 3 * pi / 2,
                          child: GestureDetector(
                            onTap: () {
                              _changeContainerColor(0, _randomNumbers[0]);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _containerColor0,
                              ),
                              child: Center(
                                child: Text(
                                  '${_randomNumbers[0]}',
                                  style: const TextStyle(fontSize: 20, fontFamily: "Intelleplay"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),


                    Positioned(
                      right: 10,
                      child: Transform.rotate(
                        angle: 2 * pi / 2,
                        child: Transform.rotate(
                          angle: 2 * pi / 2,
                          child: GestureDetector(
                            onTap: () {
                              _changeContainerColor(1, _randomNumbers[1]);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _containerColor1,
                              ),
                              child: Center(
                                child: Text(
                                  '${_randomNumbers[1]}',
                                  style: const TextStyle(fontSize: 20,fontFamily: "Intelleplay",),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 10,
                      child: Transform.rotate(
                        angle: 3 * pi / 2,
                        child: Transform.rotate(
                          angle: 1 * pi / 2,
                          child: GestureDetector(
                            onTap: () {
                              _changeContainerColor(2, _randomNumbers[2]);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _containerColor2,
                              ),
                              child: Center(
                                child: Text(
                                  '${_randomNumbers[2]}',
                                  style: const TextStyle(fontSize: 20,fontFamily: "Intelleplay",),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      child: Transform.rotate(
                        angle: 2 * pi / 2,
                        child: Transform.rotate(
                          angle: 2 * pi / 2,
                          child: GestureDetector(
                            onTap: () {
                              _changeContainerColor(3, _randomNumbers[3]);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _containerColor3,
                              ),
                              child: Center(
                                child: Text(
                                  '${_randomNumbers[3]}',
                                  style: const TextStyle(fontSize: 20,fontFamily: "Intelleplay",),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                child: GestureDetector(
                  onTap: _startSpinAnimation,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff160D47),
                    ),
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _animation.value * 2 * pi,
                          child: Icon(
                            _isSpinning ? Icons.ac_unit : Icons.replay_rounded,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


