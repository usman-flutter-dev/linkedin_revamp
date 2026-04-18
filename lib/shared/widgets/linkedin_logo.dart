import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Reusable animated LinkedIn "in" logo.
///
/// Usage anywhere in the app:
/// ```dart
/// LinkedInLogo()                    // default size (34)
/// LinkedInLogo(size: 48)            // bigger
/// LinkedInLogo(animated: false)     // no entrance animation
/// ```
///
/// Animation: fade + springy scale + slide-up — runs ONCE on mount.
class LinkedInLogo extends StatefulWidget {
  /// Size of the square logo box. Defaults to 34.
  final double size;

  /// Whether to play the entrance animation. Set false if you just
  /// want a static logo (e.g., splash screen, loading states).
  final bool animated;

  /// Corner radius. Defaults to size * 0.235 (proportional rounding).
  final double? borderRadius;

  const LinkedInLogo({
    super.key,
    this.size = 34,
    this.animated = true,
    this.borderRadius,
  });

  @override
  State<LinkedInLogo> createState() => _LinkedInLogoState();
}

class _LinkedInLogoState extends State<LinkedInLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  /// 0 → 1 opacity, finishes at 60% of duration
  late final Animation<double> _fade;

  /// 0.6 → 1.05 → 1.0  (pop-in with tiny overshoot)
  late final Animation<double> _scale;

  /// 6px down → 0  (glides upward into place)
  late final Animation<double> _slideY;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.6,
          end: 1.05,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 70,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.05,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
    ]).animate(_ctrl);

    _slideY = Tween<double>(begin: 6.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    // Only animate if [animated] is true
    if (widget.animated) {
      _ctrl.forward();
    } else {
      // Jump straight to end state — no animation
      _ctrl.value = 1.0;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  /// The static logo box — extracted as [child] so AnimatedBuilder
  /// doesn't rebuild it on every tick (only the transforms rebuild).
  Widget get _logoBox {
    final double radius = widget.borderRadius ?? widget.size * 0.235;
    final double fontSize = widget.size * 0.47;

    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: AppColors.linkedInBlue,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.linkedInBlue.withValues(alpha: 0.35),
            blurRadius: widget.size * 0.24,
            offset: Offset(0, widget.size * 0.09),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'in',
          style: TextStyle(
            color: AppColors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child) => FadeTransition(
        opacity: _fade,
        child: Transform.translate(
          offset: Offset(0, _slideY.value),
          child: Transform.scale(scale: _scale.value, child: child),
        ),
      ),
      // Pass logoBox as child so it's not rebuilt on every animation tick
      child: _logoBox,
    );
  }
}
