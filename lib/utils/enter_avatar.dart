import 'package:enter_bravo_kiosk/models/avatar.dart';
import 'package:spine_flutter/spine_flutter.dart';

class EnterAvatar {
  final SkeletonDrawable drawable;

  EnterAvatar({
    required this.drawable,
  });

  void initSkeleton() {
    //drawable.skeleton.setScaleX(0.5);
    //drawable.skeleton.setScaleY(0.5);

    drawable.skeleton.setAttachment('HEAD_SLOTS', '');
    drawable.skeleton.setAttachment('CHEST SLOTS', '');

    drawable.skeleton.setAttachment('LEFT_ARM_UP_SLOTS', '');
    drawable.skeleton.setAttachment('LEFT_ARM_DOWN_SLOTS', '');

    drawable.skeleton.setAttachment('RIGHT_ARM_UP_SLOTS', '');
    drawable.skeleton.setAttachment('RIGHT_ARM_DOWN_SLOTS', '');

    drawable.skeleton.setAttachment('LEFT_UP_SLOTS', '');
    drawable.skeleton.setAttachment('LEFT_DOWN_SLOTS', '');
    drawable.skeleton.setAttachment('LEFT_FOOT_SLOTS', '');

    drawable.skeleton.setAttachment('RIGHT_UP_SLOTS', '');
    drawable.skeleton.setAttachment('RIGHT_DOWN_SLOTS', '');
    drawable.skeleton.setAttachment('RIGHT_FOOT_SLOTS', '');

    drawable.skeleton.setAttachment('SINGLE_LEG_WHEEL_SLOTS', '');
    drawable.skeleton.setAttachment('SINGLE_LEG_STEM_SLOTS', '');
  }

  void applyAvatar(Avatar avatar) {
    print("HEAD_SLOTS: ${avatar.head.attachmentName}");
    drawable.skeleton.setAttachment(
      'HEAD_SLOTS',
      avatar.head.attachmentName,
    );
    print("CHEST_SLOTS: ${avatar.torso.attachmentName}");
    drawable.skeleton.setAttachment(
      'CHEST SLOTS',
      avatar.torso.attachmentName,
    );
    print("LEFT_ARM_UP_SLOTS: ${avatar.arms.getPartAttachmentName('L', 'UP')}");
    drawable.skeleton.setAttachment(
      'LEFT_ARM_UP_SLOTS',
      avatar.arms.getPartAttachmentName('L', 'UP'),
    );
    print(
        "LEFT_ARM_DOWN_SLOTS: ${avatar.arms.getPartAttachmentName('L', 'DOWN')}");
    drawable.skeleton.setAttachment(
      'LEFT_ARM_DOWN_SLOTS',
      avatar.arms.getPartAttachmentName('L', 'DOWN'),
    );
    print(
        "RIGHT_ARM_UP_SLOTS: ${avatar.arms.getPartAttachmentName('R', 'UP')}");
    drawable.skeleton.setAttachment(
      'RIGHT_ARM_UP_SLOTS',
      avatar.arms.getPartAttachmentName('R', 'UP'),
    );
    print(
        "RIGHT_ARM_DOWN_SLOTS: ${avatar.arms.getPartAttachmentName('R', 'DOWN')}");
    drawable.skeleton.setAttachment(
      'RIGHT_ARM_DOWN_SLOTS',
      avatar.arms.getPartAttachmentName('R', 'DOWN'),
    );
    print("LEFT_UP_SLOTS: ${avatar.legs.leftThighAttachment}");
    drawable.skeleton.setAttachment(
      'LEFT_UP_SLOTS',
      avatar.legs.leftThighAttachment,
    );
    print("LEFT_DOWN_SLOTS: ${avatar.legs.leftShinAttachment}");
    drawable.skeleton.setAttachment(
      'LEFT_DOWN_SLOTS',
      avatar.legs.leftShinAttachment,
    );
    print("LEFT_FOOT_SLOTS: ${avatar.legs.leftFootAttachment}");
    drawable.skeleton.setAttachment(
      'LEFT_FOOT_SLOTS',
      avatar.legs.leftFootAttachment,
    );
    print("RIGHT_UP_SLOTS: ${avatar.legs.rightThighAttachment}");
    drawable.skeleton.setAttachment(
      'RIGHT_UP_SLOTS',
      avatar.legs.rightThighAttachment,
    );
    print("RIGHT_DOWN_SLOTS: ${avatar.legs.rightShinAttachment}");
    drawable.skeleton.setAttachment(
      'RIGHT_DOWN_SLOTS',
      avatar.legs.rightShinAttachment,
    );
    print("RIGHT_FOOT_SLOTS: ${avatar.legs.rightFootAttachment}");
    drawable.skeleton.setAttachment(
      'RIGHT_FOOT_SLOTS',
      avatar.legs.rightFootAttachment,
    );
    print("SINGLE_LEG_STEM_SLOTS: ${avatar.legs.unicycleStemAttachment}");
    drawable.skeleton.setAttachment(
      'SINGLE_LEG_STEM_SLOTS',
      avatar.legs.unicycleStemAttachment,
    );
    print("SINGLE_LEG_WHEEL_SLOTS: ${avatar.legs.unicycleWheelAttachment}");
    drawable.skeleton.setAttachment(
      'SINGLE_LEG_WHEEL_SLOTS',
      avatar.legs.unicycleWheelAttachment,
    );
  }

  static Future<EnterAvatar> loadFromAsset(
    String atlasFile,
    String skeletonFile,
  ) async {
    final skeleton = await SkeletonDrawable.fromAsset(atlasFile, skeletonFile);
    return EnterAvatar(
      drawable: skeleton,
    );
  }
}
