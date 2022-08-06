import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';

import 'package:audio_session/audio_session.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/utils/debug.dart';

import './control_buttons.dart';
import './position.dart';
import './progress_bar.dart';

class CirillaAudio extends StatefulWidget {
  final String uri;

  const CirillaAudio({Key? key, required this.uri}) : super(key: key);

  @override
  State<CirillaAudio> createState() => _CirillaAudioState();
}

class _CirillaAudioState extends State<CirillaAudio> with Utility {
  AudioPlayer? _player;
  late SliderThemeData _sliderThemeData;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _player!.playbackEventStream.listen((event) {}, onError: (Object e, StackTrace stackTrace) {
      avoidPrint(e);
    });
    try {
      await _player!.setAudioSource(AudioSource.uri(
        Uri.parse(widget.uri),
      ));
    } catch (e) {
      avoidPrint(e);
    }
  }

  @override
  void dispose() {
    _player!.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    double sizeIcon = 20;
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).dividerColor, borderRadius: BorderRadius.circular(24)),
      height: 42,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ControlButtons(
            player: _player,
            padding: const EdgeInsetsDirectional.only(start: 12, end: 6),
            iconLoading: SizedBox(
              width: sizeIcon,
              height: sizeIcon,
              child: const CircularProgressIndicator(),
            ),
            iconPlay: Icon(
              Icons.play_arrow,
              size: sizeIcon,
            ),
            iconPause: Icon(
              Icons.pause,
              size: sizeIcon,
            ),
            iconReplay: Icon(
              Icons.replay,
              size: sizeIcon,
            ),
          ),
          Position(
            player: _player,
            stylePosition: Theme.of(context).textTheme.caption,
            styleDuration: Theme.of(context).textTheme.caption,
          ),
          Expanded(
            child: ProgressBar(
              player: _player,
              sliderThemeProgress: _sliderThemeData.copyWith(
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0),
                activeTrackColor: Theme.of(context).primaryColor.withOpacity(0.3),
                inactiveTrackColor: Theme.of(context).colorScheme.surface,
                trackShape: CustomTrackShape(),
                // overlayColor: Colors.red.withAlpha(32),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 8.0),
              ),
              sliderThemeLineaProgress: _sliderThemeData.copyWith(
                inactiveTrackColor: Colors.transparent,
                activeTrackColor: Theme.of(context).primaryColor,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 0.0,
                ),
                trackShape: CustomTrackShape(),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 8.0),
              ),
              onChangeEnd: (newPosition) {
                _player!.seek(newPosition);
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              _showSliderDialog(
                context: context,
                title: "volume",
                divisions: 10,
                min: 0.0,
                max: 1.0,
                stream: _player!.volumeStream,
                onChanged: _player!.setVolume,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Icon(
                Icons.volume_up,
                size: sizeIcon,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(
                left: 6.0,
                right: 12.0,
              ),
              child: Icon(
                Icons.more_vert_sharp,
                size: sizeIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => SizedBox(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: const TextStyle(fontFamily: 'Fixed', fontWeight: FontWeight.bold, fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? 1.0,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
