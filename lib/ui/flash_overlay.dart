import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WhiteFlashController extends ChangeNotifier {
  int _flashCount = 0;

  int get flashCount => _flashCount;

  void flash({int times = 1}) {
    _flashCount = times;
    notifyListeners();
  }

  void _reset() {
    _flashCount = 0;
  }
}

class WhiteFlashOverlay extends StatefulWidget {
  final Widget child;
  final WhiteFlashController controller;

  const WhiteFlashOverlay({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<WhiteFlashOverlay> createState() => _WhiteFlashOverlayState();
}

class _WhiteFlashOverlayState extends State<WhiteFlashOverlay> {
  bool _showFlash = false;
  int _flashCount = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleFlash);
  }

  void _handleFlash() {
    if (widget.controller.flashCount > 0 && !_showFlash) {
      setState(() {
        _flashCount = widget.controller.flashCount;
        _showFlash = true;
      });

      final totalDuration = _flashCount * 250 * 2; // fadeIn+fadeOut per flash

      Future.delayed(Duration(milliseconds: totalDuration), () {
        if (mounted) {
          setState(() => _showFlash = false);
          widget.controller._reset();
        }
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleFlash);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_showFlash)
          Positioned.fill(
            child: Animate(
              effects: [
                CustomEffect(
                  builder: (context, value, child) {
                    final totalFlashDuration =
                        250.0; // 50ms fade in + 200ms fade out
                    final totalDuration = _flashCount * totalFlashDuration;
                    final ms = value * totalDuration;
                    final t = ms % totalFlashDuration;

                    double opacity = 0.0;
                    if (t < 50) {
                      opacity = 1.0; // fade in (istante)
                    } else if (t < 250) {
                      opacity = 1.0 - ((t - 50) / 200); // fade out lineare
                    }

                    return Opacity(
                      opacity: opacity.clamp(0.0, 1.0),
                      child: Container(color: Colors.white),
                    );
                  },
                  duration: Duration(milliseconds: (_flashCount * 250).toInt()),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
