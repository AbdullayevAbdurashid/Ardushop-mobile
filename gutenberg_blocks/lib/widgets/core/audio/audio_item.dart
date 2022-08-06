import 'package:flutter/material.dart';
import 'control_button.dart';
import 'seek_bar.dart';

class AudioItem extends StatefulWidget {
  final Color? bufferedColor;

  final Color? handleColor;

  final Color? playedColor;

  final EdgeInsetsDirectional? padding;

  final GestureTapCallback? onTapPlay;

  final Widget? volumn;

  final double? height;

  final double? radius;

  final Color? color;

  final Widget? position;

  final bool playing;

  final Duration? durationSeek;

  final Duration? positionSeek;

  final Duration? bufferedPosition;

  const AudioItem({
    Key? key,
    required this.playing,
    this.bufferedColor,
    this.playedColor,
    this.handleColor,
    this.padding,
    this.height,
    this.radius,
    this.color,
    this.onTapPlay,
    this.position,
    this.volumn,
    this.durationSeek,
    this.bufferedPosition,
    this.positionSeek,
  }) : super(key: key);

  @override
  State<AudioItem> createState() => _AudioItemState();
}

class _AudioItemState extends State<AudioItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(color: widget.color, borderRadius: BorderRadius.circular(widget.radius ?? 24)),
      height: widget.height ?? 42,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: widget.onTapPlay,
            child: ControlButton(
              playing: widget.playing,
            ),
          ),
          widget.position ?? Container(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SeekBar(
                duration: widget.durationSeek!,
                position: widget.positionSeek!,
                bufferedPosition: widget.bufferedPosition!,
                bufferedColor: widget.bufferedColor,
                playedColor: widget.playedColor,
                handleColor: widget.handleColor,
              ),
            ),
          ),
          widget.volumn ?? Container()
        ],
      ),
    );
  }
}
