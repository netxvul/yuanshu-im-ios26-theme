local center = import '../lib/center.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local _hintSymbolsData = import '../lib/hintSymbolsData.libsonnet';
local keyboardLayout = import '../lib/keyboardLayout.libsonnet';
local others = import '../lib/others.libsonnet';
local swipeData = import '../lib/swipeData.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';

local hintSymbolsStyles = import '../lib/hintSymbolsStyles.libsonnet';
local swipeStyles = import '../lib/swipeStyles2.libsonnet';
local base = import '../lib/keyboard26Base.libsonnet';

// 划动以及长按数据
local swipe_up = std.get(swipeData, 'swipe_up', {});
local swipe_down = std.get(swipeData, 'swipe_down', {});
local hintSymbolsData = std.get(_hintSymbolsData, 'pinyin', {});

// 使用共享的 createButton 工厂，中文键盘默认 action 类型为 character
local createButton = base.makeCreateButton(swipe_up, swipe_down, hintSymbolsData, 'character');

// 拼音键盘特有的部分（symbolButton, spaceButton, spaceRightButton 与英文键盘不同）
local pinyinSpecific(theme, orientation) =
  local ButtonSize = keyboardLayout.getButtonSize(theme, orientation);
  {
    [if std.objectHas(others, '中文键盘方案') then 'rimeSchema']: others['中文键盘方案'],

    symbolButton: createButton(
      params={
        key: 'symbol',
        size: ButtonSize['symbol键size'],
        action: { keyboardType: 'symbolic' },
        isLetter: false,
      }
    ),

    symbolButtonForegroundStyle: utils.makeSystemImageStyle(
      params={
        systemImageName: 'pencil.tip',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] + 2,
        center: center['功能键前景文字偏移'] { y: 0.5 },
      }
    ),

    spaceButton: createButton(
      params={
        key: 'space',
        size: ButtonSize['space键size'],
        backgroundStyle: 'alphabeticBackgroundStyle',
        foregroundStyle: [
          'spaceButtonForegroundStyle',
          'spaceButtonForegroundStyle2',
        ],
        action: 'space',
        isLetter: false,
      }
    ),

    // spaceButtonBackgroundStyle: utils.makeGeometryStyle(
    //   params = {
    //     insets: { top: 5, left: 3, bottom: 6, right: 3 },
    //     cornerRadius: 9,
    //     normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
    //     highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    //     normalColor: ["#9bafd9", "#103783" ],
    //     highlightColor: ["#432371", "#faae7b" ],
    //     colorLocation: [0, 1],
    //     colorStartPoint: { x: 0, y: 0.5 },
    //     colorEndPoint: { x: 1, y: 0.5 },
    //     colorGradientType: 'linear'
    //   }
    // ),
    spaceButtonForegroundStyle: utils.makeSystemImageStyle(
      params={
        systemImageName: 'space',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] - 3,
        center: center['功能键前景文字偏移'] { y: 0.6 },
      }
    ),

    // 显示方案名
    spaceButtonForegroundStyle2: utils.makeTextStyle({
      text: '$rimeSchemaName',
      fontSize: 8,
      center: { x: 0.75, y: 0.75 },
      normalColor: color[theme]['划动字符颜色'],
      highlightColor: color[theme]['划动字符颜色'],
    }),

    spaceRightButton: createButton(
      params={
        key: 'spaceRight',
        size: ButtonSize['spaceRight键size'],
        action: { character: '.' },
        backgroundStyle: 'systemButtonBackgroundStyle',
        foregroundStyle: [
          'spaceRightButtonForegroundStyle',
          'spaceRightButtonForegroundStyle2',
        ],
        isLetter: false,
      }
    ),

    spaceRightButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '，',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'],
        center: { x: 0.50, y: 0.55 },
      }
    ),

    spaceRightButtonForegroundStyle2: utils.makeTextStyle(
      params={
        text: '.',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] - 2,
        center: { x: 0.5, y: 0.35 },
      }
    ),
  };

{
  new(theme, orientation):
    base.genKeyboardBase(theme, orientation, createButton) +  // 共享基础（26字母键 + shift/backspace/123/enter + 背景样式）
    pinyinSpecific(theme, orientation) +  // 拼音特有（symbol/space/spaceRight + rimeSchema）
    keyboardLayout.getPinyinLayout(theme, orientation) +  // 布局
    swipeStyles.makeSwipeStyles(theme, {
      swipe_up: swipe_up,
      swipe_down: swipe_down,
      type: 'pinyin',
    }) +
    hintSymbolsStyles.getStyle(theme, hintSymbolsData) +  // 长按
    toolbar.getToolBar(theme) +  // 工具栏
    utils.genPinyinStyles(theme) +  // 批量生成前景
    utils.genHintStyles(theme),
}
