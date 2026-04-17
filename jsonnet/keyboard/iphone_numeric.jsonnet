// iphone_numeric.jsonnet
// iPhone 数字符号键盘 - 基于 default 皮肤 iPhoneNumeric.libsonnet 布局
// 4行10列布局: 数字(1-0) + 常用英文符号 + 功能键

local animation = import '../lib/animation.libsonnet';
local center = import '../lib/center.libsonnet';
local color = import '../lib/color.libsonnet';
local enterKey = import '../lib/enterKey.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local keyboardLayout = import '../lib/keyboardLayout.libsonnet';
local others = import '../lib/others.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';

// 中文符号前景偏移（参照 iPhoneNumeric.libsonnet 的 chineseSymbolicOffset）
local chineseSymbolicCenter = { x: 0.65 };

local createButton(params={}) =
  local isChar = std.get(params, 'isChar', true);
  std.prune({
    size: std.get(params, 'size'),
    bounds: std.get(params, 'bounds'),
    backgroundStyle: if isChar then 'alphabeticBackgroundStyle' else std.get(params, 'backgroundStyle', 'systemButtonBackgroundStyle'),
    foregroundStyle: std.get(params, 'foregroundStyle', params.key + 'ButtonForegroundStyle'),
    action: std.get(params, 'action', { character: params.key }),
    repeatAction: std.get(params, 'repeatAction'),
    animation: [
      'ButtonScaleAnimation',
    ],
  });

local keyboard(theme, orientation) =
  local ButtonSize = keyboardLayout.getButtonSize(theme, orientation);
  {
    [if std.objectHas(others, '中文键盘方案') then 'rimeSchema']: others['中文键盘方案'],
    preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
    toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
    keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],

    // ==================== 键盘布局 ====================
    keyboardLayout: [
      // 第一行: 数字 1-9, 0
      {
        HStack: {
          subviews: [
            { Cell: 'oneButton' },
            { Cell: 'twoButton' },
            { Cell: 'threeButton' },
            { Cell: 'fourButton' },
            { Cell: 'fiveButton' },
            { Cell: 'sixButton' },
            { Cell: 'sevenButton' },
            { Cell: 'eightButton' },
            { Cell: 'nineButton' },
            { Cell: 'zeroButton' },
          ],
        },
      },
      // 第二行: 常用符号
      {
        HStack: {
          subviews: [
            { Cell: 'hyphenButton' },
            { Cell: 'forwardSlashButton' },
            { Cell: 'chineseColonButton' },
            { Cell: 'chineseSemicolonButton' },
            { Cell: 'leftParenthesisButton' },
            { Cell: 'rightParenthesisButton' },
            { Cell: 'dollarButton' },
            { Cell: 'atButton' },
            { Cell: 'leftCurlyQuoteButton' },
            { Cell: 'rightCurlyQuoteButton' },
          ],
        },
      },
      // 第三行: 更多符号切换 + 标点 + 退格
      {
        HStack: {
          subviews: [
            { Cell: 'symbolicButton' },
            { Cell: 'chinesePeriodButton' },
            { Cell: 'chineseCommaButton' },
            { Cell: 'ideographicCommaButton' },
            { Cell: 'hashButton' },
            { Cell: 'chineseQuestionMarkButton' },
            { Cell: 'chineseExclamationMarkButton' },
            { Cell: 'periodButton' },
            { Cell: 'backspaceButton' },
          ],
        },
      },
      // 第四行: 拼音切换 + 空格 + 回车
      {
        HStack: {
          subviews: [
            { Cell: 'pinyinButton' },
            { Cell: 'symbolButton' },
            { Cell: 'spaceButton' },
            { Cell: 'spaceRightButton' },
            { Cell: 'enterButton' },
          ],
        },
      },
    ],

    keyboardStyle: {
      insets: {
        top: 3,
        bottom: 3,
        left: 4,
        right: 4,
      },
      backgroundStyle: 'keyboardBackgroundStyle',
    },

    keyboardBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['键盘背景颜色'],
    },

    // ==================== 第一行: 数字键 ====================
    oneButton: createButton(
      params={ key: 'one', size: std.get(ButtonSize, '普通键size'), action: { character: '1' } }
    ),
    oneButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '1',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    twoButton: createButton(
      params={ key: 'two', size: std.get(ButtonSize, '普通键size'), action: { character: '2' } }
    ),
    twoButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '2',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    threeButton: createButton(
      params={ key: 'three', size: std.get(ButtonSize, '普通键size'), action: { character: '3' } }
    ),
    threeButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '3',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    fourButton: createButton(
      params={ key: 'four', size: std.get(ButtonSize, '普通键size'), action: { character: '4' } }
    ),
    fourButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '4',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    fiveButton: createButton(
      params={ key: 'five', size: std.get(ButtonSize, '普通键size'), action: { character: '5' } }
    ),
    fiveButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '5',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    sixButton: createButton(
      params={ key: 'six', size: std.get(ButtonSize, '普通键size'), action: { character: '6' } }
    ),
    sixButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '6',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    sevenButton: createButton(
      params={ key: 'seven', size: std.get(ButtonSize, '普通键size'), action: { character: '7' } }
    ),
    sevenButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '7',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    eightButton: createButton(
      params={ key: 'eight', size: std.get(ButtonSize, '普通键size'), action: { character: '8' } }
    ),
    eightButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '8',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    nineButton: createButton(
      params={ key: 'nine', size: std.get(ButtonSize, '普通键size'), action: { character: '9' } }
    ),
    nineButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '9',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    zeroButton: createButton(
      params={ key: 'zero', size: std.get(ButtonSize, '普通键size'), action: { character: '0' } }
    ),
    zeroButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '0',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // ==================== 第二行: 常用符号 ====================
    // 连接号(减号)
    hyphenButton: createButton(
      params={ key: 'hyphen', size: std.get(ButtonSize, '普通键size'), action: { symbol: '-' } }
    ),
    hyphenButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '-',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 斜杠
    forwardSlashButton: createButton(
      params={ key: 'forwardSlash', size: std.get(ButtonSize, '普通键size'), action: { symbol: '/' } }
    ),
    forwardSlashButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '/',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 中文冒号
    chineseColonButton: createButton(
      params={ key: 'chineseColon', size: std.get(ButtonSize, '普通键size'), action: { symbol: ':' } }
    ),
    chineseColonButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: ':',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        // center: chineseSymbolicCenter,
      }
    ),

    // 中文分号
    chineseSemicolonButton: createButton(
      params={ key: 'chineseSemicolon', size: std.get(ButtonSize, '普通键size'), action: { symbol: ';' } }
    ),
    chineseSemicolonButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: ';',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        // center: chineseSymbolicCenter,
      }
    ),

    // 左括号
    leftParenthesisButton: createButton(
      params={ key: 'leftParenthesis', size: std.get(ButtonSize, '普通键size'), action: { symbol: '(' } }
    ),
    leftParenthesisButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '(',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 右括号
    rightParenthesisButton: createButton(
      params={ key: 'rightParenthesis', size: std.get(ButtonSize, '普通键size'), action: { symbol: ')' } }
    ),
    rightParenthesisButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: ')',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 美元符号
    dollarButton: createButton(
      params={ key: 'dollar', size: std.get(ButtonSize, '普通键size'), action: { symbol: '$' } }
    ),
    dollarButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '$',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // @符号
    atButton: createButton(
      params={ key: 'at', size: std.get(ButtonSize, '普通键size'), action: { symbol: '@' } }
    ),
    atButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '@',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 双引号 "
    leftCurlyQuoteButton: createButton(
      params={ key: 'leftCurlyQuote', size: std.get(ButtonSize, '普通键size'), action: { symbol: '"' } }
    ),
    leftCurlyQuoteButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '"',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 双引号 "
    rightCurlyQuoteButton: createButton(
      params={ key: 'rightCurlyQuote', size: std.get(ButtonSize, '普通键size'), action: { symbol: '"' } }
    ),
    rightCurlyQuoteButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '"',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // ==================== 第三行: 标点 + 功能键 ====================
    // 更多符号切换键 (导航到 symbolic 键盘，即 iPhoneSymbolic 符号键盘)
    symbolicButton: createButton(
      params={
        key: 'symbolic',
        size: std.get(ButtonSize, 'shift键size'),
        bounds: { width: '151/168.75', alignment: 'left' },
        action: { keyboardType: 'symbolic' },
        isChar: false,
      }
    ),
    symbolicButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '#+=',
        fontSize: fontSize['按键前景文字大小'] - 3,
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 英文句号
    chinesePeriodButton: createButton(
      params={ key: 'chinesePeriod', size: std.get(ButtonSize, '普通键size'), action: { symbol: '.' } }
    ),
    chinesePeriodButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '.',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 英文逗号
    chineseCommaButton: createButton(
      params={ key: 'chineseComma', size: std.get(ButtonSize, '普通键size'), action: { symbol: ',' } }
    ),
    chineseCommaButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: ',',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 撇号
    ideographicCommaButton: createButton(
      params={ key: 'ideographicComma', size: std.get(ButtonSize, '普通键size'), action: { symbol: "'" } }
    ),
    ideographicCommaButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: "'",
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 井号
    hashButton: createButton(
      params={ key: 'hash', size: std.get(ButtonSize, '普通键size'), action: { symbol: '#' } }
    ),
    hashButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '#',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 英文问号
    chineseQuestionMarkButton: createButton(
      params={ key: 'chineseQuestionMark', size: std.get(ButtonSize, '普通键size'), action: { symbol: '?' } }
    ),
    chineseQuestionMarkButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '?',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 英文感叹号
    chineseExclamationMarkButton: createButton(
      params={ key: 'chineseExclamationMark', size: std.get(ButtonSize, '普通键size'), action: { symbol: '!' } }
    ),
    chineseExclamationMarkButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '!',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 英文句号
    periodButton: createButton(
      params={ key: 'period', size: std.get(ButtonSize, '普通键size'), action: { symbol: '.' } }
    ),
    periodButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '.',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 退格键
    backspaceButton: createButton(
      params={
        key: 'backspace',
        size: std.get(ButtonSize, 'backspace键size'),
        bounds: { width: '151/168.75', alignment: 'right' },
        action: 'backspace',
        repeatAction: 'backspace',
        isChar: false,
      }
    ),
    backspaceButtonForegroundStyle: utils.makeSystemImageStyle(
      params={
        systemImageName: 'delete.left',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'],
      }
    ),

    // ==================== 第四行: 宽功能键 ====================
    // 拼音切换键
    pinyinButton: createButton(
      params={
        key: 'pinyin',
        size: std.get(ButtonSize, '123键size'),
        action: { keyboardType: 'pinyin' },
        isChar: false,
      }
    ),
    pinyinButtonForegroundStyle: utils.makeSystemImageStyle(
      params={
        systemImageName: 'arrow.backward',
        fontSize: fontSize['按键前景文字大小'] - 3,
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),
    symbolButton: createButton(
      params={
        key: 'symbol',
        size: ButtonSize['symbol键size'],
        action: { keyboardType: 'numeric_9' },
        foregroundStyle: 'symbolButtonForegroundStyle',
        isChar: false,
      }
    ),

    symbolButtonForegroundStyle: {
      buttonStyleType: 'fileImage',
      contentMode: 'scaleAspectFit',
      normalImage: {
        file: 'key_popcorn',
        image: 'IMG1',
      },
      highlightImage: {
        file: 'key_popcorn',
        image: 'IMG1',
      },
      center: center['功能键前景文字偏移'] { y: 0.5 },
    },
    // 空格键
    spaceButton: createButton(
      params={
        key: 'space',
        action: 'space',
        isChar: false,
        backgroundStyle: 'alphabeticBackgroundStyle',
      }
    ),
    spaceButtonForegroundStyle: utils.makeSystemImageStyle(
      params={
        systemImageName: 'space',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] - 3,
      }
    ),
    spaceRightButton: createButton(
      params={
        key: 'symbol',
        size: ButtonSize['symbol键size'],
        bounds: { width: '151/168.75', alignment: 'left' },
        action: { keyboardType: 'symbolic_all' },
        foregroundStyle: 'spaceRightButtonForegroundStyle',
        isChar: false,
      }
    ),

    spaceRightButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: 'ツ',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),
    // ==================== 背景样式 ====================
    // 字符键背景（数字、符号、标点）
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

    // 功能键背景（切换键、退格键等）
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

    // 按键动画
    ButtonScaleAnimation: animation['26键按键动画'],
  }
  + enterKey.genEnterSection(theme, createButton, 'sharedDynamic', {
    size: std.get(ButtonSize, 'enter键size'),
    isChar: false,
  }, ButtonSize);

{
  new(theme, orientation='portrait'):
    keyboard(theme, orientation) +
    toolbar.getToolBar(theme),
}
