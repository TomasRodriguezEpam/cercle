import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:convert';
import 'dart:async';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset('assets/logo.jpg'),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? vidID = YoutubePlayer.convertUrlToId(
        'https://www.youtube.com/watch?v=pA96m95T3NA');

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildLogo(),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    _buildGridTile(
                      context,
                      'assets/image1.jpg',
                      'concerts',
                      () {
                        if (vidID != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ConcertHome()),
                          );
                        }
                      },
                    ),
                    _buildGridTile(
                      context,
                      'assets/image2.jpg',
                      'website',
                      () {
                        if (vidID != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => CercleHomePage()),
                          );
                        }
                      },
                    ),
                    _buildGridTile(
                      context,
                      'assets/image3.jpg',
                      'info',
                      () {
                        if (vidID != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => InfoPage()),
                          );
                        }
                      },
                    ),
                    _buildGridTile(
                      context,
                      'assets/image4.jpg',
                      'apple music',
                      () {
                        if (vidID != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ApplePage()),
                          );
                        }
                      },
                    ),
                    _buildGridTile(
                      context,
                      'assets/image5.jpg',
                      'contact',
                      () {
                        if (vidID != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ContactPage()),
                          );
                        }
                      },
                    ),
                    _buildGridTile(
                      context,
                      'assets/image6.jpg',
                      'listen',
                      () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image2.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.60),
            BlendMode.darken,
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Image.asset(
        'assets/logo_transparent.png',
        height: 150,
      ),
    );
  }

  Widget _buildGridTile(BuildContext context, String imagePath, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: GridTile(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(0, 255, 255, 255), width: 1),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              color: Color.fromARGB(125, 255, 255, 255).withOpacity(0.0),
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  label,
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                    fontFamily: 'Lato Bold',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image5.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.60),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/logo_transparent.png',
                  height: 150,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Cercle is a livestream media dedicated to promoting artists & venues. We film and broadcast DJ sets & live performances on Facebook in carefully selected and unusual places.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image1.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.60),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/logo_transparent.png',
                  height: 150,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'If you have any questions, comments or suggestions, we would love to hear from you. Please get in touch at any time and we will get back to you. hello@cercle.io www.cercle.io',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class ApplePage extends StatelessWidget {
  final String url = 'https://music.apple.com/es/curator/cercle/1558721971';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo_transparent.png',
                width: 400,
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0), // Square shape
                    side: BorderSide(
                        color: Color.fromARGB(0, 255, 255, 255), width: 1), // White border
                  ),
                  backgroundColor: const Color.fromARGB(100, 0, 0, 10), // Black inside
                ),
                onPressed: () {
                  _launchURL(url);
                },
                child: Text(
                  'apple music cercle',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 255, 255, 255), // White letters
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CercleHomePage extends StatelessWidget {
  final String url = 'https://www.cercle.io';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo_transparent.png',
                width: 400,
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0), // Square shape
                    side: BorderSide(
                        color: Color.fromARGB(0, 255, 255, 255), width: 1), // White border
                  ),
                  backgroundColor: const Color.fromARGB(100, 0, 0, 10), // Black inside
                ),
                onPressed: () {
                  _launchURL(url);
                },
                child: Text(
                  'go to website',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 255, 255, 255), // White letters
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _launchURL(String url) async {
  final urlString = url;
  if (await canLaunchUrlString(urlString)) {
    await launchUrlString(urlString);
  } else {
    throw 'Could not launch $urlString';
  }
}

class VideoPlayerPage extends StatefulWidget {
  final String videoId;

  const VideoPlayerPage({Key? key, required this.videoId}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;
  String _videoTitle = '';

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    _fetchVideoTitle();
  }

  Future<void> _fetchVideoTitle() async {
    // Fetch video metadata using the YouTube Data API or any other method
    // For demonstration, we'll just set a dummy title
    setState(() {
      _videoTitle = YoutubeMetaData(videoId: widget.videoId).title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            onReady: () {
              _controller.addListener(() {
                if (_controller.value.isFullScreen) {
                  SystemChrome.setEnabledSystemUIMode(
                      SystemUiMode.immersiveSticky);
                } else {
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                }
              });
            },
          ),
        ),
      ),
    );
  }
}

class ConcertHome extends StatelessWidget {
  const ConcertHome({Key? key}) : super(key: key);

  Future<Map<String, String>> _fetchVideoUrls() async {
    try {
      final String response = await rootBundle.loadString('assets/videos.json');
      final String response2 =
          await rootBundle.loadString('assets/titles.json');
      final data = await json.decode(response) as List<dynamic>;
      final data2 = await json.decode(response2) as List<dynamic>;
      print('Fetched data: $data'); // Add this line

      // Ensure both lists have the same length
      if (data.length != data2.length) {
        throw Exception('Videos and titles lists have different lengths');
      }

      // Create a map of video URLs to titles
      final Map<String, String> videoDetails = {};
      for (int i = 0; i < data.length; i++) {
        videoDetails[data[i] as String] = data2[i] as String;
      }

      return videoDetails;
    } catch (e) {
      print('Error loading videos: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image6.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.60),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Image.asset(
                  'assets/logo_transparent.png',
                  height: 150,
                ),
              ),
          Expanded(
            child: FutureBuilder<Map<String, String>>(
              future: _fetchVideoUrls(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No videos found'));
                } else {
                  final videoDetails = snapshot.data!;
                  return ListView.builder(
                    itemCount: videoDetails.length,
                    itemBuilder: (context, index) {
                      final url = videoDetails.keys.elementAt(index);
                      final title = videoDetails[url]!;
                      final videoId = YoutubePlayer.convertUrlToId(url);

                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: GestureDetector(
                          onTap: () {
                            if (videoId != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      VideoPlayerPage(videoId: videoId),
                                ),
                              );
                            }
                          },
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  child: Image.network(
                                    'https://img.youtube.com/vi/$videoId/0.jpg',
                                    fit: BoxFit.fitWidth,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  title,
                                  style: const TextStyle(
                                    fontFamily: 'Lato Italic',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}
