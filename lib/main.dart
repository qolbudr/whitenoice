import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:whitenoice/injection.dart' as di;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'White Noice',
      theme: ThemeData.dark(),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late AudioSession session;
  List<String> sounds = [
    'assets/forest.mp3',
    'assets/rain.mp3',
    'assets/thunder.mp3',
    'assets/train.mp3',
    'assets/wind.mp3',
  ];

  @override
  void initState() {
    super.initState();
    setup();
  }

  void setup() async {
    session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
      avAudioSessionMode: AVAudioSessionMode.defaultMode,
      avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: AndroidAudioAttributes(
        contentType: AndroidAudioContentType.music,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.media,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransientMayDuck,
      androidWillPauseWhenDucked: true,
    ));
  }

  void play(int index) {
    session.setActive(true);
    di.getIt<AudioHandler>().playMediaItem(MediaItem(id: sounds[index], title: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              trailing: const Icon(Icons.forest_outlined),
              title: const Text('Forest'),
              subtitle: const Text('Play forest sound'),
              onTap: () => play(0),
            ),
            const Divider(height: 1),
            ListTile(
              trailing: const Icon(Icons.cloud_outlined),
              title: const Text('Rain'),
              subtitle: const Text('Play rain sound'),
              onTap: () => play(1),
            ),
            const Divider(height: 1),
            ListTile(
              trailing: const Icon(Icons.thunderstorm_outlined),
              title: const Text('Thunder'),
              subtitle: const Text('Play thunder sound'),
              onTap: () => play(2),
            ),
            const Divider(height: 1),
            ListTile(
              trailing: const Icon(Icons.directions_railway_outlined),
              title: const Text('Train'),
              subtitle: const Text('Play train sound'),
              onTap: () => play(3),
            ),
            const Divider(height: 1),
            ListTile(
              trailing: const Icon(Icons.wind_power_outlined),
              title: const Text('Wind'),
              subtitle: const Text('Play wind sound'),
              onTap: () => play(4),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.stop),
        onPressed: () {
          di.getIt<AudioHandler>().stop();
          session.setActive(false);
        }
      ),
    );
  }
}
