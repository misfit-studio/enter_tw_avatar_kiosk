import 'package:auto_size_text/auto_size_text.dart';
import 'package:enter_bravo_kiosk/components/continuous_animated_rotation.dart';
import 'package:enter_bravo_kiosk/models/avatar.dart';
import 'package:enter_bravo_kiosk/state/intl_provider.dart';
import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:enter_bravo_kiosk/theme/theme.dart';
import 'package:enter_bravo_kiosk/utils/enter_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spine_flutter/spine_flutter.dart' as spine;

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _introController;
  late AnimationController _loopController;
  late Animation<double> _iconSizeTween;
  late Animation<double> _iconRotationSpeedTween;
  late Animation<Color?> _iconIntroColorTween;
  late Animation<Color?> _iconColorTween;
  late Animation<double> _avatarBacklightOpacityTween;
  late Animation<double> _avatarOpacityTween;

  EnterAvatar? _avatar;
  spine.SpineWidgetController? _spineController;

  final int _currentAnimation = 1;
  static const animations = [
    "COOL POSE",
    "Dance:WAVE",
    "HAPPY WALK",
    "Jump",
    "NORMAL WALK",
    "SHY IDLE",
    "SLOW WALK",
    "STATIC",
    "TWIST DANCE",
    "WAVE HELLO",
    "WIGGLE"
  ];

  @override
  void initState() {
    super.initState();

    _load();
    _initAnimations();
  }

  @override
  void dispose() {
    _introController.dispose();
    _loopController.dispose();

    super.dispose();
  }

  void _load() async {
    _avatar = await EnterAvatar.loadFromAsset(
      "assets/spine/enter_avatar.atlas",
      "assets/spine/enter_avatar.json",
    );

    _spineController = spine.SpineWidgetController(
      onInitialized: (controller) {
        _avatar?.initSkeleton();

        final questionnaire = ref.read(questionnaireStateProvider);
        final avatar = Avatar.fromQuestionnaire(questionnaire);
        _avatar?.applyAvatar(avatar);

        _spineController?.animationState
            .setAnimationByName(0, animations[_currentAnimation], true);
      },
    );

    setState(() {});
  }

  void _initAnimations() {
    _introController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _loopController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    );

    _introController.forward();
    _introController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _loopController.forward();
      }
    });
    _loopController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _loopController.reset();
        _introController.reset();
        _introController.forward();
      }
    });

    _iconSizeTween = Tween<double>(begin: 128, end: 1500).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(
          0.6,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _iconRotationSpeedTween = Tween<double>(begin: 3000, end: 12000).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(
          0.6,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _avatarBacklightOpacityTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(
          0.7,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _avatarOpacityTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(
          0.8,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _iconIntroColorTween = ColorTween(
      begin: Colors.white,
      end: EnterThemeColors.orange,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(
          0.5,
          1,
          curve: Curves.ease,
        ),
      ),
    );

    _iconColorTween = TweenSequence<Color?>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
            begin: EnterThemeColors.orange, end: EnterThemeColors.yellow),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
            begin: EnterThemeColors.yellow, end: EnterThemeColors.green),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
            begin: EnterThemeColors.green, end: EnterThemeColors.turquoise),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
            begin: EnterThemeColors.turquoise, end: EnterThemeColors.blue),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
            begin: EnterThemeColors.blue, end: EnterThemeColors.orange),
      ),
    ]).animate(CurvedAnimation(
      parent: _loopController,
      curve: const Interval(
        0.0,
        1.0,
        curve: Curves.ease,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final $s = ref.watch(intlStringsProvider);

    ref.listen(questionnaireStateProvider, (prev, next) {
      final avatar = Avatar.fromQuestionnaire(next);
      _avatar?.applyAvatar(avatar);
      print(next.techType.name);
    });

    final questionnaire = ref.watch(questionnaireStateProvider);
    final techType =
        "${$s[questionnaire.interestType?.name]}-Tech-${$s[questionnaire.techType.name]}";

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => context.go('/'),
        child: Stack(
          children: [
            _buildIconSpinBackground(),
            _buildAvatarBacklight(),
            if (_avatar != null) _buildAvatar(),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 96.sp, vertical: 172.sp),
              child: AnimatedBuilder(
                  animation: _avatarOpacityTween,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _avatarOpacityTween.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dein Technik-Typ',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          AutoSizeText(
                            techType,
                            wrapWords: false,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: Offset.zero,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Center(
      child: AnimatedBuilder(
        animation: _avatarOpacityTween,
        builder: (context, child) {
          return Opacity(
            opacity: _avatarOpacityTween.value,
            child: SizedBox(
              width: 984.w,
              height: 984.h,
              child: spine.SpineWidget.fromDrawable(
                _avatar!.drawable,
                _spineController!,
                boundsProvider: spine.SkinAndAnimationBounds(
                  animation: 'SLOW WALK',
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAvatarBacklight() {
    return Center(
      child: Image.asset(
        'assets/images/result_avatar_backlight.png',
        opacity: _avatarBacklightOpacityTween,
        width: 1080.w,
      ),
    );
  }

  Widget _buildIconSpinBackground() {
    return Center(
      child: AnimatedBuilder(
          animation: _introController,
          builder: (context, child) {
            return UnconstrainedBox(
              clipBehavior: Clip.hardEdge,
              child: ContinuousAnimatedRotation(
                duration: Duration(
                  milliseconds: _iconRotationSpeedTween.value.toInt(),
                ),
                child: AnimatedBuilder(
                    animation: _iconColorTween,
                    builder: (context, child) {
                      return Opacity(
                        opacity: 0.75,
                        child: SvgPicture.asset(
                          'assets/icons/enter_icon.svg',
                          width: _iconSizeTween.value.w,
                          height: _iconSizeTween.value.h,
                          color: _introController.isCompleted
                              ? _iconColorTween.value
                              : _iconIntroColorTween.value,
                        ),
                      );
                    }),
              ),
            );
          }),
    );
  }
}
