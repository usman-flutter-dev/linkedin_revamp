import 'package:flutter/material.dart';
import 'linkedin_logo.dart';

/// A fully custom pull-to-refresh widget.
///
/// ⚠️ We do NOT use Flutter's [RefreshIndicator] because it always renders
/// a [CircularProgressIndicator] that can't be fully hidden.
///
/// ─── How it works ────────────────────────────────────────────────────────────
/// 1. [NotificationListener] watches scroll events.
/// 2. While dragging down at top: logo follows finger (grows + fades in).
/// 3. On RELEASE ([ScrollEndNotification]):
///    - If drag >= [triggerOffset] → refresh starts, logo pulses.
///    - If drag < [triggerOffset]  → logo snaps back, nothing happens.
/// 4. Pulse runs for exactly [refreshDuration], then logo fades out.
///
/// ─── Usage ───────────────────────────────────────────────────────────────────
/// ```dart
/// LinkedInRefreshIndicator(
///   onRefresh: () async => ref.refresh(myProvider.future),
///   refreshDuration: Duration(seconds: 2),  // logo visible for 2s minimum
///   triggerOffset: 80,                       // pull 80px to trigger
///   logoSize: 44,                            // logo size
///   child: CustomScrollView(...),
/// )
/// ```
/// ─────────────────────────────────────────────────────────────────────────────
class LinkedInRefreshIndicator extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  /// Pixels user must pull before release triggers refresh. Default: 80.
  final double triggerOffset;

  /// Size of the pulsing logo. Default: 44.
  final double logoSize;

  /// Minimum time the pulsing logo stays visible after release.
  /// If [onRefresh] takes longer, logo stays until data is ready.
  /// Default: 1500ms.
  final Duration refreshDuration;

  /// Speed of the breathing pulse animation. Default: 700ms per cycle.
  final Duration pulseDuration;

  const LinkedInRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.triggerOffset = 80.0,
    this.logoSize = 44.0,
    this.refreshDuration = const Duration(milliseconds: 1500),
    this.pulseDuration = const Duration(milliseconds: 700),
  });

  @override
  State<LinkedInRefreshIndicator> createState() =>
      _LinkedInRefreshIndicatorState();
}

class _LinkedInRefreshIndicatorState extends State<LinkedInRefreshIndicator>
    with SingleTickerProviderStateMixin {
  // ── Pulse animation ────────────────────────────────────────────────────────
  late final AnimationController _pulse;
  late final Animation<double> _pulseAnim;

  // ── Drag state ─────────────────────────────────────────────────────────────

  /// Live drag distance while finger is down (0 → triggerOffset)
  double _dragOffset = 0.0;

  /// True while finger is on screen and pulling
  bool _isDragging = false;

  /// True while refresh future + minimum duration are running
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();

    // Pulse duration is fully controllable via widget.pulseDuration
    _pulse = AnimationController(vsync: this, duration: widget.pulseDuration)
      ..repeat(reverse: true);

    _pulseAnim = Tween<double>(
      begin: 0.88,
      end: 1.12,
    ).animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  // ── Scroll notification handler ────────────────────────────────────────────
  bool _onScrollNotification(ScrollNotification notification) {
    // Only handle vertical scroll at the very top
    if (notification.metrics.axis != Axis.vertical) return false;
    if (notification.metrics.extentBefore != 0) return false;
    if (_isRefreshing) return false;

    // ── Finger dragging down ───────────────────────────────────────────────
    if (notification is OverscrollNotification) {
      setState(() {
        _isDragging = true;
        _dragOffset = (_dragOffset - notification.overscroll).clamp(
          0.0,
          widget.triggerOffset,
        );
      });
    }

    // ── Finger lifted ──────────────────────────────────────────────────────
    // THIS is where we decide: trigger refresh or snap back.
    // Animation only starts HERE — not while dragging.
    if (notification is ScrollEndNotification) {
      _isDragging = false;

      if (_dragOffset >= widget.triggerOffset) {
        // ✅ Threshold met → start refresh on release
        _startRefresh();
      } else {
        // ❌ Not enough pull → snap back silently
        setState(() => _dragOffset = 0.0);
      }
    }

    return false;
  }

  Future<void> _startRefresh() async {
    setState(() => _isRefreshing = true);

    try {
      // Run both the refresh AND minimum display duration in parallel.
      // Logo stays visible for at least [refreshDuration] regardless of
      // how fast the data loads — feels more intentional, less janky.
      await Future.wait([
        widget.onRefresh(),
        Future.delayed(widget.refreshDuration),
      ]);
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
          _dragOffset = 0.0;
        });
      }
    }
  }

  // ── Computed visual properties ─────────────────────────────────────────────

  /// 0.0 → 1.0 as drag goes 0 → triggerOffset. Full opacity while refreshing.
  double get _opacity {
    if (_isRefreshing) return 1.0;
    return (_dragOffset / widget.triggerOffset).clamp(0.0, 1.0);
  }

  /// Logo grows from 0.4x → 1.0x as user drags. Full size while refreshing.
  double get _scale {
    if (_isRefreshing) return 1.0;
    return 0.4 + 0.6 * (_dragOffset / widget.triggerOffset).clamp(0.0, 1.0);
  }

  /// Logo top position follows drag finger, locked at triggerOffset on refresh.
  double get _topPosition {
    final double offset = _isRefreshing ? widget.triggerOffset : _dragOffset;
    return offset - widget.logoSize / 2;
  }

  @override
  Widget build(BuildContext context) {
    final bool showLogo = _dragOffset > 0 || _isRefreshing;

    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: Stack(
        children: [
          // ── Scrollable content ─────────────────────────────────────────────
          widget.child,

          // ── Logo overlay ───────────────────────────────────────────────────
          if (showLogo)
            Positioned(
              top: _topPosition,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 150),
                  child: _isRefreshing
                      // Pulsing logo while data loads
                      ? AnimatedBuilder(
                          animation: _pulseAnim,
                          builder: (_, child) => Transform.scale(
                            scale: _pulseAnim.value,
                            child: child,
                          ),
                          child: LinkedInLogo(
                            size: widget.logoSize,
                            animated: false,
                          ),
                        )
                      // Growing logo while user drags
                      : Transform.scale(
                          scale: _scale,
                          child: LinkedInLogo(
                            size: widget.logoSize,
                            animated: false,
                          ),
                        ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
