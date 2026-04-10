import 'package:flutter/material.dart';

/// A text widget that scrolls horizontally (marquee/ticker effect)
/// when the text overflows its container. If the text fits, it
/// renders as a normal static Text widget.
///
/// Usage:
///   MarqueeText(
///     text: album.album,
///     style: textStyles[1],
///   )
class MarqueeText extends StatefulWidget {
  final String text;
  final TextStyle? style;

  /// How fast the text scrolls in logical pixels per second.
  final double velocity;

  /// Pause at the start before scrolling begins.
  final Duration startPause;

  /// Pause when the text reaches the end before looping back.
  final Duration endPause;

  /// Gap between the end of the text and the start of the next loop.
  final double gap;

  const MarqueeText({
    super.key,
    required this.text,
    this.style,
    this.velocity = 40.0,
    this.startPause = const Duration(seconds: 2),
    this.endPause = const Duration(seconds: 1),
    this.gap = 48.0,
  });

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  late final ScrollController _controller;
  bool _needsScroll = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAndScroll());
  }

  @override
  void didUpdateWidget(MarqueeText old) {
    super.didUpdateWidget(old);
    if (old.text != widget.text) {
      _controller.jumpTo(0);
      _checkAndScroll();
    }
  }

  Future<void> _checkAndScroll() async {
    if (!mounted) return;

    // Wait one more frame so the ScrollView has measured itself
    await Future.delayed(Duration.zero);
    if (!mounted) return;

    final maxExtent = _controller.position.maxScrollExtent;
    if (maxExtent <= 0) {
      // Text fits — nothing to scroll
      setState(() => _needsScroll = false);
      return;
    }

    setState(() => _needsScroll = true);
    _runLoop(maxExtent);
  }

  Future<void> _runLoop(double maxExtent) async {
    while (mounted && _needsScroll) {
      // Wait at the start
      await Future.delayed(widget.startPause);
      if (!mounted) return;

      // Scroll to the end
      final duration = Duration(
        milliseconds: ((maxExtent / widget.velocity) * 1000).round(),
      );
      await _controller.animateTo(
        maxExtent,
        duration: duration,
        curve: Curves.linear,
      );
      if (!mounted) return;

      // Pause at the end
      await Future.delayed(widget.endPause);
      if (!mounted) return;

      // Jump back to start (instant)
      _controller.jumpTo(0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Text(
            widget.text,
            style: widget.style,
            maxLines: 1,
            softWrap: false,
          ),
        );
      },
    );
  }
}
