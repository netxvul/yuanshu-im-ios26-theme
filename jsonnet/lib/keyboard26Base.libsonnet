// 26键键盘共享基础模块
// 将拼音键盘和英文键盘的共享逻辑抽取到此处，避免代码重复

local animation = import 'animation.libsonnet';
local center = import 'center.libsonnet';
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';
local others = import 'others.libsonnet';
local utils = import 'utils.libsonnet';

// 所有字母键
local letterKeys = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm'];

// 有特殊尺寸/bounds的按键覆盖配置
// sizeKey: 按键尺寸在ButtonSize中的键名（不设置则使用 '普通键size'）
// boundsKey: 按键bounds在ButtonSize中的键名（不设置则无bounds）
local keyOverrides = {
  a: { sizeKey: 'a键size', boundsKey: 'a键bounds' },
  l: { sizeKey: 'l键size', boundsKey: 'l键bounds' },
  t: { boundsKey: 't键bounds' },
  y: { boundsKey: 'y键bounds' },
};

// 批量生成26个字母按键及其HintStyle
local genLetterButtons(createButton, ButtonSize) =
  std.foldl(
    function(acc, key)
      local override = std.get(keyOverrides, key, {});
      local sizeKey = std.get(override, 'sizeKey', '普通键size');
      local boundsKey = std.get(override, 'boundsKey');
      acc + {
        [key + 'Button']: createButton(
          params={
            key: key,
            size: std.get(ButtonSize, sizeKey),
            [if boundsKey != null then 'bounds']: std.get(ButtonSize, boundsKey),
          }
        ),
        [key + 'ButtonHintStyle']: {
          backgroundStyle: 'alphabeticHintBackgroundStyle',
          foregroundStyle: key + 'ButtonHintForegroundStyle',
          swipeUpForegroundStyle: key + 'ButtonSwipeUpHintForegroundStyle',
        },
      },
    letterKeys,
    {}
  );

// Shift 按键及其三个前景样式（普通、大写、大写锁定）
local genShiftSection(theme, ButtonSize, createButton) = {
  shiftButton: createButton(
    params={
      key: 'shift',
      action: 'shift',
      size: std.get(ButtonSize, 'shift键size'),
      isLetter: false,
    },
  ) + {
    uppercasedStateAction: 'shift',
    capsLockedStateForegroundStyle: 'shiftButtonCapsLockedForegroundStyle',
    uppercasedStateForegroundStyle: 'shiftButtonUppercasedForegroundStyle',
  },

  shiftButtonForegroundStyle: utils.makeSystemImageStyle(
    params={
      systemImageName: 'shift',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    }
  ),
  shiftButtonUppercasedForegroundStyle: utils.makeSystemImageStyle(
    params={
      systemImageName: 'shift.fill',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    }
  ),
  shiftButtonCapsLockedForegroundStyle: utils.makeSystemImageStyle(
    params={
      systemImageName: 'capslock.fill',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    }
  ),
};

// Backspace 按键及前景样式
local genBackspaceSection(theme, ButtonSize, createButton) = {
  backspaceButton: createButton(
    params={
      key: 'backspace',
      size: ButtonSize['backspace键size'],
      action: 'backspace',
      repeatAction: 'backspace',
      isLetter: false,
    }
  ),

  backspaceButtonForegroundStyle: utils.makeSystemImageStyle(
    params={
      systemImageName: 'delete.left',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      targetScale: 0.7,
    }
  ),
};

// 123 按键及前景样式
local gen123Section(theme, ButtonSize, orientation, createButton) = {
  '123Button': createButton(
    params={
      key: '123',
      size: ButtonSize['123键size'],
      action: { keyboardType: if orientation == 'portrait' then 'numeric' else 'symbolic' },
      isLetter: false,
    }
  ),

  '123ButtonForegroundStyle': utils.makeSystemImageStyle(
    params={
      systemImageName: 'numbers',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      center: center['功能键前景文字偏移'] { y: 0.5 },
    }
  ),
};

// Enter 按键 + 所有前景样式 + 蓝色背景 + 通知
local genEnterSection(theme, ButtonSize, createButton) = {
  enterButton: createButton(
    params={
      key: 'enter',
      size: ButtonSize['enter键size'],
      action: 'enter',
      isLetter: false,
    }
  ) + {
    backgroundStyle: [
      {
        styleName: 'systemButtonBackgroundStyle',
        conditionKey: '$returnKeyType',
        conditionValue: [0, 2, 3, 5, 8, 10, 11],
      },
      {
        styleName: 'enterButtonBlueBackgroundStyle',
        conditionKey: '$returnKeyType',
        conditionValue: [1, 4, 6, 7, 9],
      },
    ],
    foregroundStyle: [
      {
        styleName: 'enterButtonForegroundStyle0',
        conditionKey: '$returnKeyType',
        conditionValue: [0, 2, 3, 5, 8, 10, 11],
      },
      {
        styleName: 'enterButtonForegroundStyle14',
        conditionKey: '$returnKeyType',
        conditionValue: [1, 4],
      },
      {
        styleName: 'enterButtonForegroundStyle6',
        conditionKey: '$returnKeyType',
        conditionValue: [6],
      },
      {
        styleName: 'enterButtonForegroundStyle7',
        conditionKey: '$returnKeyType',
        conditionValue: [7],
      },
      {
        styleName: 'enterButtonForegroundStyle9',
        conditionKey: '$returnKeyType',
        conditionValue: [9],
      },
    ],
    // 按键通知
    notification: [
      'garyReturnKeyTypeNotification',
      'blueReturnKeyTypeNotification14',
      'blueReturnKeyTypeNotification6',
      'blueReturnKeyTypeNotification7',
      'blueReturnKeyTypeNotification9',
    ],
  },

  enterButtonForegroundStyle0: utils.makeSystemImageStyle(
    params={
      systemImageName: 'return.right',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      center: center['功能键前景文字偏移'] { y: 0.5 },
    }
  ),
  enterButtonForegroundStyle6: utils.makeSystemImageStyle(
    params={
      systemImageName: 'magnifyingglass',
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'],
      center: center['功能键前景文字偏移'] { y: 0.5 },
    }
  ),

  enterButtonForegroundStyle7: utils.makeSystemImageStyle(
    params={
      systemImageName: 'paperplane',
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'],
      center: center['功能键前景文字偏移'] { y: 0.5 },
    }
  ),

  enterButtonForegroundStyle14: utils.makeSystemImageStyle(
    params={
      systemImageName: 'chevron.forward',
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'],
      center: center['功能键前景文字偏移'] { y: 0.5 },
    }
  ),

  enterButtonForegroundStyle9: utils.makeSystemImageStyle(
    params={
      systemImageName: 'shareplay',
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'],
      center: center['功能键前景文字偏移'] { y: 0.5 },
    }
  ),

  enterButtonBlueBackgroundStyle: utils.makeGeometryStyle(
    params={
      buttonStyleType: 'geometry',
      insets: { top: 5, left: 3, bottom: 5, right: 3 },
      normalColor: color[theme]['enter键背景(蓝色)'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: others['圆角']['enter键'],
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    }
  ),

  // 灰色回车通知（前景 0）
  garyReturnKeyTypeNotification: {
    notificationType: 'returnKeyType',
    returnKeyType: [0, 2, 3, 5, 8, 10, 11],
    backgroundStyle: 'systemButtonBackgroundStyle',
    foregroundStyle: 'enterButtonForegroundStyle0',
  },

  // 蓝色回车通知（按前景细分）
  blueReturnKeyTypeNotification14: {
    notificationType: 'returnKeyType',
    returnKeyType: [1, 4],
    backgroundStyle: 'enterButtonBlueBackgroundStyle',
    foregroundStyle: 'enterButtonForegroundStyle14',
  },
  blueReturnKeyTypeNotification6: {
    notificationType: 'returnKeyType',
    returnKeyType: [6],
    backgroundStyle: 'enterButtonBlueBackgroundStyle',
    foregroundStyle: 'enterButtonForegroundStyle6',
  },
  blueReturnKeyTypeNotification7: {
    notificationType: 'returnKeyType',
    returnKeyType: [7],
    backgroundStyle: 'enterButtonBlueBackgroundStyle',
    foregroundStyle: 'enterButtonForegroundStyle7',
  },
  blueReturnKeyTypeNotification9: {
    notificationType: 'returnKeyType',
    returnKeyType: [9],
    backgroundStyle: 'enterButtonBlueBackgroundStyle',
    foregroundStyle: 'enterButtonForegroundStyle9',
  },
};

// 共享背景样式 + 动画
local genSharedStyles(theme) = {
  alphabeticBackgroundStyle: utils.makeGeometryStyle(
    params={
      insets: { top: 5, left: 3, bottom: 5, right: 3 },
      normalColor: color[theme]['字母键背景颜色-普通'],
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: others['圆角']['字母键'],
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    }
  ),

  systemButtonBackgroundStyle: utils.makeGeometryStyle(
    params={
      insets: { top: 5, left: 3, bottom: 6, right: 3 },
      normalColor: color[theme]['功能键背景颜色-普通'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: others['圆角']['功能键'],
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    }
  ),

  alphabeticHintBackgroundStyle: utils.makeGeometryStyle(
    params={
      normalColor: color[theme]['气泡背景颜色'],
      highlightColor: color[theme]['气泡高亮颜色'],
      cornerRadius: others['圆角']['气泡'],
      shadowColor: color[theme]['长按背景阴影颜色'],
      shadowOffset: { x: 0, y: 2 },
    }
  ),

  ButtonScaleAnimation: animation['26键按键动画'],
};

// 创建 createButton 工厂函数
// defaultActionType: 'character' 或 'symbol'，用于字母键的默认action类型
local makeCreateButton(swipe_up, swipe_down, hintSymbolsData, defaultActionType='character') =
  function(params={})
    local isLetter = std.get(params, 'isLetter', true);
    std.prune({
      size: std.get(params, 'size'),
      bounds: std.get(params, 'bounds'),
      backgroundStyle: if isLetter then 'alphabeticBackgroundStyle' else std.get(params, 'backgroundStyle', 'systemButtonBackgroundStyle'),
      foregroundStyle:
        if isLetter then
          std.prune([
            params.key + 'ButtonForegroundStyle',
            if std.objectHas(swipe_up, params.key) then params.key + 'ButtonUpForegroundStyle' else null,
            if std.objectHas(swipe_down, params.key) then params.key + 'ButtonDownForegroundStyle' else null,
          ])
        else
          std.get(params, 'foregroundStyle', params.key + 'ButtonForegroundStyle'),

      [if isLetter then 'uppercasedStateForegroundStyle']: std.prune([
        params.key + 'ButtonUppercasedStateForegroundStyle',
        if std.objectHas(swipe_up, params.key) then params.key + 'ButtonUpForegroundStyle' else null,
        if std.objectHas(swipe_down, params.key) then params.key + 'ButtonDownForegroundStyle' else null,
      ]),
      [if isLetter then 'capsLockedStateForegroundStyle']: self.uppercasedStateForegroundStyle,
      hintStyle: params.key + 'ButtonHintStyle',
      action: std.get(params, 'action', { [defaultActionType]: params.key }),
      [if isLetter then 'uppercasedStateAction']: {
        [defaultActionType]: std.asciiUpper(params.key),
      },
      repeatAction: std.get(params, 'repeatAction'),
      [if std.objectHas(swipe_up, params.key) then 'swipeUpAction']: swipe_up[params.key].action,
      [if std.objectHas(swipe_down, params.key) then 'swipeDownAction']: swipe_down[params.key].action,
      [if std.objectHas(hintSymbolsData, params.key) then 'hintSymbolsStyle']: params.key + 'ButtonHintSymbolsStyle',

      // 动画
      animation: [
        'ButtonScaleAnimation',
      ],
    });

// 生成完整的键盘基础部分（26个字母键 + shift/backspace/123/enter + 共享样式）
// 不包含: symbolButton, spaceButton, spaceRightButton（这些在各键盘中有差异）
// 不包含: rimeSchema（各键盘方案不同）
local genKeyboardBase(theme, orientation, createButton) =
  local ButtonSize = (import 'keyboardLayout.libsonnet').getButtonSize(theme, orientation);
  {
    preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
    toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
    keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
  }
  + genLetterButtons(createButton, ButtonSize)
  + genShiftSection(theme, ButtonSize, createButton)
  + genBackspaceSection(theme, ButtonSize, createButton)
  + gen123Section(theme, ButtonSize, orientation, createButton)
  + genEnterSection(theme, ButtonSize, createButton)
  + genSharedStyles(theme);

{
  letterKeys: letterKeys,
  makeCreateButton: makeCreateButton,
  genLetterButtons: genLetterButtons,
  genShiftSection: genShiftSection,
  genBackspaceSection: genBackspaceSection,
  gen123Section: gen123Section,
  genEnterSection: genEnterSection,
  genSharedStyles: genSharedStyles,
  genKeyboardBase: genKeyboardBase,
}
