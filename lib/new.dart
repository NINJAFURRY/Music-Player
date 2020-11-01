import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';

import 'package:audioplayers/audio_cache.dart';

var icon = Icon(
  Icons.video_collection,
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AudioPlayer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Audio Player"),
          actions: [
            RaisedButton(
              color: Colors.blue,
              child: icon,
              onPressed: () {
                Navigator.pushNamed(context, "/video");
              },
            ),
          ],
        ),
        body: MyHomePage(
          title: "music player",
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isPlaying = false;
  AudioPlayer audioPlayer;
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String localFilePath;

  playAudioFromLocalStorage(path) async {
    int response = await audioPlayer.play(path, isLocal: true);
    if (response == 1) {
      // success

    } else {
      print('Some error occured in playing from storage!');
    }
  }

  pauseAudio() async {
    int response = await audioPlayer.pause();
    if (response == 1) {
      // success

    } else {
      print('Some error occured in pausing');
    }
  }

  stopAudio() async {
    int response = await audioPlayer.stop();
    if (response == 1) {
      // success

    } else {
      print('Some error occured in stopping');
    }
  }

  resumeAudio() async {
    int response = await audioPlayer.resume();
    if (response == 1) {
      // success

    } else {
      print('Some error occured in resuming');
    }
  }

  seek() async {
    int response = await audioPlayer.seek(Duration(milliseconds: 1200));
    if (response == 1) {
    } else {
      print("error occured");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/mm.gif"),
              fit: BoxFit.contain,
            ),
          ),
          padding: EdgeInsetsDirectional.fromSTEB(0, 600, 0, 26),
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  color: Colors.blue,
                  onPressed: () {
                    if (_isPlaying == true) {
                      pauseAudio();
                      setState(() {
                        _isPlaying = false;
                      });
                    } else {
                      resumeAudio();
                      setState(() {
                        _isPlaying = true;
                      });
                    }
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    stopAudio();
                    setState(() {
                      _isPlaying = false;
                    });
                  },
                  child: Icon(Icons.stop),
                  color: Colors.blue,
                ),
                RaisedButton(
                  onPressed: () => seek(),
                  child: Icon(Icons.next_plan),
                  color: Colors.blue,
                ),
                RaisedButton(
                  onPressed: () async {
                    var path =
                        await FilePicker.getFilePath(type: FileType.audio);
                    setState(() {
                      _isPlaying = true;
                    });
                    playAudioFromLocalStorage(path);
                  },
                  child: Text(
                    'Local',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
