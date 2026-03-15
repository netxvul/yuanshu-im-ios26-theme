local center = import '../lib/center.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local _hintSymbolsData = import '../lib/hintSymbolsData.libsonnet';
local keyboardLayout = import '../lib/keyboardLayout.libsonnet';
local others = import '../lib/others.libsonnet';
local swipeData = import '../lib/swipeData-en.libsonnet';
local toolbar = import '../lib/toolbar-en.libsonnet';
local utils = import '../lib/utils.libsonnet';

local hintSymbolsStyles = import '../lib/hintSymbolsStyles.libsonnet';
local swipeStyles = import '../lib/swipeStyles2.libsonnet';
local base = import '../lib/keyboard26Base.libsonnet';

// 划动以及长按数据
local swipe_up = std.get(swipeData, 'swipe_up', {});
local swipe_down = std.get(swipeData, 'swipe_down', {});
local hintSymbolsData = std.get(_hintSymbolsData, 'pinyin', {});

local isBindSchema = std.objectHas(others, '英文键盘方案');

// 使用共享的 createButton 工厂，英文键盘根据是否绑定方案决定 action 类型
local createButton = base.makeCreateButton(swipe_up, swipe_down, hintSymbolsData, if isBindSchema then 'character' else 'symbol');

// 英文键盘特有的部分（symbolButton, spaceButton, spaceRightButton 与拼音键盘不同）
local alphabeticSpecific(theme, orientation) =
  local ButtonSize = keyboardLayout.getButtonSize(theme, orientation);
  {
    [if isBindSchema then 'rimeSchema']: others['英文键盘方案'],

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
        systemImageName: 'person',
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
        action: 'space',
        isLetter: false,
      }
    ),

    spaceButtonForegroundStyle: utils.makeSystemImageStyle(
      params={
        systemImageName: 'space',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] - 3,
        center: center['功能键前景文字偏移'] { y: 0.6 },
      }
    ),
    spaceRightButton: createButton(
      params={
        key: 'spaceRight',
        size: ButtonSize['spaceRight键size'],
        action: { symbol: '.' },
        backgroundStyle: 'alphabeticBackgroundStyle',
        foregroundStyle: [
          'spaceRightButtonForegroundStyle',
          'spaceRightButtonForegroundStyle2',
        ],
        isLetter: false,
      }
    ),

    spaceRightButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: ',',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'],
        center: { x: 0.5, y: 0.34 },
      }
    ),
    spaceRightButtonForegroundStyle2: utils.makeTextStyle(
      params={
        text: '.',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'],
        center: { x: 0.5, y: 0.54 },
      }
    ),
  };

{
  new(theme, orientation):
    base.genKeyboardBase(theme, orientation, createButton) +  // 共享基础（26字母键 + shift/backspace/123/enter + 背景样式）
    alphabeticSpecific(theme, orientation) +  // 英文特有（symbol/space/spaceRight + rimeSchema）
    keyboardLayout.getEnLayout(theme, orientation) +  // 布局
    swipeStyles.makeSwipeStyles(theme, {
      swipe_up: swipe_up,
      swipe_down: swipe_down,
      type: 'pinyin',
    }) +
    hintSymbolsStyles.getStyle(theme, hintSymbolsData) +  // 长按
    toolbar.getToolBar(theme) +  // 工具栏
    utils.genAlphabeticStyles(theme) +  // 批量生成前景
    utils.genHintStyles(theme),
}
