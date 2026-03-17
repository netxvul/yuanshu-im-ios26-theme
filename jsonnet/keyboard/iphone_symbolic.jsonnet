// iphone_symbolic.jsonnet
// iPhone 符号键盘(第二页) - 基于 default 皮肤 iPhoneSymbolic.libsonnet 布局
// 4行10列布局: 更多符号(【】｛｝#%^*+-等) + 功能键
// 导航: numericButton → numeric(iPhoneNumeric), pinyinButton → pinyin

local animation = import '../lib/animation.libsonnet';
local center = import '../lib/center.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local keyboardLayout = import '../lib/keyboardLayout.libsonnet';
local others = import '../lib/others.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';

// 中文符号前景偏移（成对符号需要偏移以区分方向）
local chineseSymbolicLeftCenter = { x: 0.35 };
local chineseSymbolicRightCenter = { x: 0.65 };

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
  {
    local ButtonSize = keyboardLayout.getButtonSize(theme, orientation),

    [if std.objectHas(others, '中文键盘方案') then 'rimeSchema']: others['中文键盘方案'],
    preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
    toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
    keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],

    // ==================== 键盘布局 ====================
    keyboardLayout: [
      // 第一行: 【 】 ｛ ｝ # % ^ * + -
      {
        HStack: {
          subviews: [
            { Cell: 'leftChineseBracketButton' },
            { Cell: 'rightChineseBracketButton' },
            { Cell: 'leftChineseBraceButton' },
            { Cell: 'rightChineseBraceButton' },
            { Cell: 'hashButton' },
            { Cell: 'percentButton' },
            { Cell: 'caretButton' },
            { Cell: 'asteriskButton' },
            { Cell: 'plusButton' },
            { Cell: 'hyphenButton' },
          ],
        },
      },
      // 第二行: _ — \ | ~ 《 》 ` & ·
      {
        HStack: {
          subviews: [
            { Cell: 'underscoreButton' },
            { Cell: 'emDashButton' },
            { Cell: 'backslashButton' },
            { Cell: 'verticalBarButton' },
            { Cell: 'tildeButton' },
            { Cell: 'leftBookTitleMarkButton' },
            { Cell: 'rightBookTitleMarkButton' },
            { Cell: 'graveButton' },
            { Cell: 'ampersandButton' },
            { Cell: 'middleDotButton' },
          ],
        },
      },
      // 第三行: [123] … , . ? ! ' ' [⌫]
      {
        HStack: {
          subviews: [
            { Cell: 'numericButton' },
            { Cell: 'ellipsisButton' },
            { Cell: 'commaButton' },
            { Cell: 'periodButton' },
            { Cell: 'questionMarkButton' },
            { Cell: 'exclamationMarkButton' },
            { Cell: 'leftSingleQuoteButton' },
            { Cell: 'rightSingleQuoteButton' },
            { Cell: 'backspaceButton' },
          ],
        },
      },
      // 第四行: [拼音] [空格] [回车]
      {
        HStack: {
          subviews: [
            { Cell: 'pinyinButton' },
            { Cell: 'spaceButton' },
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

    // ==================== 第一行: 【 】 ｛ ｝ # % ^ * + - ====================

    // 中文左中括号 【
    leftChineseBracketButton: createButton(
      params={ key: 'leftChineseBracket', size: std.get(ButtonSize, '普通键size'), action: { symbol: '【' } }
    ),
    leftChineseBracketButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '【',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        center: chineseSymbolicLeftCenter,
      }
    ),

    // 中文右中括号 】
    rightChineseBracketButton: createButton(
      params={ key: 'rightChineseBracket', size: std.get(ButtonSize, '普通键size'), action: { symbol: '】' } }
    ),
    rightChineseBracketButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '】',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        center: chineseSymbolicRightCenter,
      }
    ),

    // 中文左大括号 ｛
    leftChineseBraceButton: createButton(
      params={ key: 'leftChineseBrace', size: std.get(ButtonSize, '普通键size'), action: { symbol: '｛' } }
    ),
    leftChineseBraceButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '｛',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        center: chineseSymbolicLeftCenter,
      }
    ),

    // 中文右大括号 ｝
    rightChineseBraceButton: createButton(
      params={ key: 'rightChineseBrace', size: std.get(ButtonSize, '普通键size'), action: { symbol: '｝' } }
    ),
    rightChineseBraceButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '｝',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        center: chineseSymbolicRightCenter,
      }
    ),

    // 井号 #
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

    // 百分号 %
    percentButton: createButton(
      params={ key: 'percent', size: std.get(ButtonSize, '普通键size'), action: { symbol: '%' } }
    ),
    percentButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '%',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // ^ 符号
    caretButton: createButton(
      params={ key: 'caret', size: std.get(ButtonSize, '普通键size'), action: { symbol: '^' } }
    ),
    caretButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '^',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // * 星号
    asteriskButton: createButton(
      params={ key: 'asterisk', size: std.get(ButtonSize, '普通键size'), action: { character: '*' } }
    ),
    asteriskButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '*',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // + 加号
    plusButton: createButton(
      params={ key: 'plus', size: std.get(ButtonSize, '普通键size'), action: { character: '+' } }
    ),
    plusButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '+',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // - 减号/连接号
    hyphenButton: createButton(
      params={ key: 'hyphen', size: std.get(ButtonSize, '普通键size'), action: { character: '-' } }
    ),
    hyphenButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '-',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // ==================== 第二行: _ — \ | ~ 《 》 ` & · ====================

    // _ 下划线
    underscoreButton: createButton(
      params={ key: 'underscore', size: std.get(ButtonSize, '普通键size'), action: { symbol: '_' } }
    ),
    underscoreButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '_',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // — 破折号
    emDashButton: createButton(
      params={ key: 'emDash', size: std.get(ButtonSize, '普通键size'), action: { character: '—' } }
    ),
    emDashButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '—',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // \ 反斜杠
    backslashButton: createButton(
      params={ key: 'backslash', size: std.get(ButtonSize, '普通键size'), action: { symbol: '\\' } }
    ),
    backslashButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '\\',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // | 竖线
    verticalBarButton: createButton(
      params={ key: 'verticalBar', size: std.get(ButtonSize, '普通键size'), action: { symbol: '|' } }
    ),
    verticalBarButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '|',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // ~ 波浪号
    tildeButton: createButton(
      params={ key: 'tilde', size: std.get(ButtonSize, '普通键size'), action: { symbol: '~' } }
    ),
    tildeButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '~',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // 《 左书名号
    leftBookTitleMarkButton: createButton(
      params={ key: 'leftBookTitleMark', size: std.get(ButtonSize, '普通键size'), action: { symbol: '《' } }
    ),
    leftBookTitleMarkButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '《',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        center: chineseSymbolicLeftCenter,
      }
    ),

    // 》 右书名号
    rightBookTitleMarkButton: createButton(
      params={ key: 'rightBookTitleMark', size: std.get(ButtonSize, '普通键size'), action: { symbol: '》' } }
    ),
    rightBookTitleMarkButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '》',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        center: chineseSymbolicRightCenter,
      }
    ),

    // ` 重音符
    graveButton: createButton(
      params={ key: 'grave', size: std.get(ButtonSize, '普通键size'), action: { character: '`' } }
    ),
    graveButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '`',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // & 和号
    ampersandButton: createButton(
      params={ key: 'ampersand', size: std.get(ButtonSize, '普通键size'), action: { symbol: '&' } }
    ),
    ampersandButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '&',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // · 中点
    middleDotButton: createButton(
      params={ key: 'middleDot', size: std.get(ButtonSize, '普通键size'), action: { symbol: '·' } }
    ),
    middleDotButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '·',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // ==================== 第三行: [123] … , . ? ! ' ' [⌫] ====================

    // 数字键盘切换键 (导航到 numeric 类型，即 iPhoneNumeric 键盘)
    numericButton: createButton(
      params={
        key: 'numeric',
        size: std.get(ButtonSize, 'shift键size'),
        bounds: { width: '151/168.75', alignment: 'left' },
        action: { keyboardType: 'numeric' },
        isChar: false,
      }
    ),
    numericButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '123',
        fontSize: fontSize['按键前景文字大小'] - 3,
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // … 省略号
    ellipsisButton: createButton(
      params={ key: 'ellipsis', size: std.get(ButtonSize, '普通键size'), action: { symbol: '…' } }
    ),
    ellipsisButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '…',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // , 英文逗号
    commaButton: createButton(
      params={ key: 'comma', size: std.get(ButtonSize, '普通键size'), action: { symbol: ',' } }
    ),
    commaButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: ',',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // . 英文句号
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

    // ? 英文问号
    questionMarkButton: createButton(
      params={ key: 'questionMark', size: std.get(ButtonSize, '普通键size'), action: { symbol: '?' } }
    ),
    questionMarkButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '?',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // ! 英文感叹号
    exclamationMarkButton: createButton(
      params={ key: 'exclamationMark', size: std.get(ButtonSize, '普通键size'), action: { symbol: '!' } }
    ),
    exclamationMarkButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '!',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // ' 左单引号
    leftSingleQuoteButton: createButton(
      params={ key: 'leftSingleQuote', size: std.get(ButtonSize, '普通键size'), action: { symbol: '\u2018' } }
    ),
    leftSingleQuoteButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '\u2018',
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }
    ),

    // ' 右单引号
    rightSingleQuoteButton: createButton(
      params={ key: 'rightSingleQuote', size: std.get(ButtonSize, '普通键size'), action: { symbol: '\u2019' } }
    ),
    rightSingleQuoteButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '\u2019',
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

    // ==================== 第四行: [拼音] [空格] [回车] ====================

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

    // 回车键
    enterButton: createButton(
      params={
        key: 'enter',
        size: std.get(ButtonSize, 'enter键size'),
        action: 'enter',
        isChar: false,
        backgroundStyle: 'enterButtonBackgroundStyle',
        foregroundStyle: 'enterButtonForegroundStyle',
      }
    ),
    enterButtonForegroundStyle: utils.makeSystemImageStyle(
      params={
        systemImageName: 'arrow.turn.down.left',
        normalColor: color[theme]['长按选中字体颜色'],
        highlightColor: color[theme]['长按非选中字体颜色'],
        fontSize: fontSize['按键前景文字大小'],
      }
    ),

    // ==================== 背景样式 ====================

    // 字符键背景（符号、标点）
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

    // 回车键背景（蓝色）
    enterButtonBackgroundStyle: utils.makeGeometryStyle(
      params={
        insets: { top: 5, left: 3, bottom: 5, right: 3 },
        normalColor: color[theme]['enter键背景(蓝色)'],
        highlightColor: color[theme]['功能键背景颜色-高亮'],
        cornerRadius: others['圆角']['enter键'],
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      }
    ),

    // 按键动画
    ButtonScaleAnimation: animation['26键按键动画'],
  };

{
  new(theme, orientation='portrait'):
    keyboard(theme, orientation) +
    toolbar.getToolBar(theme),
}
