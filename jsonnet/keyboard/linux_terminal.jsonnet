local animation = import '../lib/animation.libsonnet';
local color = import '../lib/color.libsonnet';
local enterKey = import '../lib/enterKey.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local others = import '../lib/others.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';

local createButton(params={}) =
  std.prune({
    size: std.get(params, 'size'),
    bounds: std.get(params, 'bounds'),
    backgroundStyle: std.get(params, 'backgroundStyle', 'systemButtonBackgroundStyle'),
    foregroundStyle: std.get(params, 'foregroundStyle', params.key + 'ButtonForegroundStyle'),
    action: std.get(params, 'action', { character: params.key }),
    repeatAction: std.get(params, 'repeatAction'),
    animation: ['ButtonScaleAnimation'],
  });

local makeTextButton(theme, key, text, action, size, backgroundStyle='systemButtonBackgroundStyle') = {
  [key + 'Button']: createButton(
    params={
      key: key,
      size: size,
      action: action,
      backgroundStyle: backgroundStyle,
    }
  ),
  [key + 'ButtonForegroundStyle']: utils.makeTextStyle(
    params={
      text: text,
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize:
        if std.length(text) >= 6 then fontSize['按键前景文字大小'] - 7
        else if std.length(text) >= 4 then fontSize['按键前景文字大小'] - 5
        else fontSize['按键前景文字大小'] - 3,
      fontWeight: 0,
    }
  ),
};

local makeImageButton(theme, key, image, action, size) = {
  [key + 'Button']: createButton(
    params={
      key: key,
      size: size,
      action: action,
    }
  ),
  [key + 'ButtonForegroundStyle']: utils.makeSystemImageStyle(
    params={
      systemImageName: image,
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 2,
      center: { y: 0.53 },
    }
  ),
};

local portraitLayout = [
  {
    HStack: {
      subviews: [
        { Cell: 'escButton' },
        { Cell: 'tabButton' },
        { Cell: 'slashButton' },
        { Cell: 'dashButton' },
        { Cell: 'underscoreButton' },
        { Cell: 'pipeButton' },
        { Cell: 'ampButton' },
        { Cell: 'backslashButton' },
        { Cell: 'tildeButton' },
        { Cell: 'backspaceButton' },
      ],
    },
  },
  {
    HStack: {
      subviews: [
        { Cell: 'sudoButton' },
        { Cell: 'cdButton' },
        { Cell: 'lsButton' },
        { Cell: 'grepButton' },
        { Cell: 'gitButton' },
        { Cell: 'sshButton' },
        { Cell: 'chmodButton' },
        { Cell: 'homePathButton' },
        { Cell: 'parentPathButton' },
        { Cell: 'enterButton' },
      ],
    },
  },
  {
    HStack: {
      subviews: [
        { Cell: 'andButton' },
        { Cell: 'orButton' },
        { Cell: 'gtButton' },
        { Cell: 'dgtButton' },
        { Cell: 'dollarButton' },
        { Cell: 'starButton' },
        { Cell: 'equalButton' },
        { Cell: 'colonButton' },
        { Cell: 'quoteButton' },
        { Cell: 'doubleQuoteButton' },
      ],
    },
  },
  {
    HStack: {
      subviews: [
        { Cell: 'returnButton' },
        { Cell: 'dotSlashButton' },
        { Cell: 'commandSubButton' },
        { Cell: 'spaceButton' },
      ],
    },
  },
];

local landscapeLayout = [
  {
    HStack: {
      subviews: [
        { Cell: 'escButton' },
        { Cell: 'tabButton' },
        { Cell: 'slashButton' },
        { Cell: 'dashButton' },
        { Cell: 'underscoreButton' },
        { Cell: 'pipeButton' },
        { Cell: 'ampButton' },
        { Cell: 'backslashButton' },
        { Cell: 'tildeButton' },
        { Cell: 'andButton' },
        { Cell: 'orButton' },
        { Cell: 'backspaceButton' },
      ],
    },
  },
  {
    HStack: {
      subviews: [
        { Cell: 'sudoButton' },
        { Cell: 'cdButton' },
        { Cell: 'lsButton' },
        { Cell: 'grepButton' },
        { Cell: 'gitButton' },
        { Cell: 'sshButton' },
        { Cell: 'chmodButton' },
        { Cell: 'homePathButton' },
        { Cell: 'parentPathButton' },
        { Cell: 'dotSlashButton' },
        { Cell: 'commandSubButton' },
        { Cell: 'enterButton' },
      ],
    },
  },
  {
    HStack: {
      subviews: [
        { Cell: 'gtButton' },
        { Cell: 'dgtButton' },
        { Cell: 'dollarButton' },
        { Cell: 'starButton' },
        { Cell: 'equalButton' },
        { Cell: 'colonButton' },
        { Cell: 'quoteButton' },
        { Cell: 'doubleQuoteButton' },
        { Cell: 'spaceButton' },
        { Cell: 'returnButton' },
      ],
    },
  },
];

local keyboard(theme, orientation) =
  local compactSize =
    if orientation == 'portrait' then { width: { percentage: 0.1 } }
    else { width: { percentage: 0.0833333333 } };
  local wideSize =
    if orientation == 'portrait' then { width: { percentage: 0.2 } }
    else { width: { percentage: 0.1666666667 } };
  {
    preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
    toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
    keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],

    keyboardLayout: if orientation == 'portrait' then portraitLayout else landscapeLayout,
    keyboardStyle: {
      insets: { top: 3, bottom: 3, left: 4, right: 4 },
      backgroundStyle: 'keyboardBackgroundStyle',
    },
    keyboardBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['键盘背景颜色'],
    },
    systemButtonBackgroundStyle: utils.makeGeometryStyle(
      params={
        insets: { top: 5, left: 3, bottom: 5, right: 3 },
        normalColor: color[theme]['功能键背景颜色-普通'],
        highlightColor: color[theme]['功能键背景颜色-高亮'],
        cornerRadius: others['圆角']['功能键'],
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      }
    ),
    accentButtonBackgroundStyle: utils.makeGeometryStyle(
      params={
        insets: { top: 5, left: 3, bottom: 5, right: 3 },
        normalColor: color[theme]['字母键背景颜色-普通'],
        highlightColor: color[theme]['字母键背景颜色-高亮'],
        cornerRadius: others['圆角']['功能键'],
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      }
    ),
    ButtonScaleAnimation: animation['26键按键动画'],
  }
  + makeTextButton(theme, 'esc', 'Esc', { sendKeys: '\u001b' }, compactSize)
  + makeTextButton(theme, 'tab', 'Tab', 'tab', compactSize)
  + makeTextButton(theme, 'slash', '/', { character: '/' }, compactSize)
  + makeTextButton(theme, 'dash', '-', { character: '-' }, compactSize)
  + makeTextButton(theme, 'underscore', '_', { character: '_' }, compactSize)
  + makeTextButton(theme, 'pipe', '|', { character: '|' }, compactSize)
  + makeTextButton(theme, 'amp', '&', { character: '&' }, compactSize)
  + makeTextButton(theme, 'backslash', '\\', { character: '\\' }, compactSize)
  + makeTextButton(theme, 'tilde', '~', { character: '~' }, compactSize)
  + makeTextButton(theme, 'sudo', 'sudo', { sendKeys: 'sudo ' }, compactSize)
  + makeTextButton(theme, 'cd', 'cd', { sendKeys: 'cd ' }, compactSize)
  + makeTextButton(theme, 'ls', 'ls', { sendKeys: 'ls -la' }, compactSize)
  + makeTextButton(theme, 'grep', 'grep', { sendKeys: 'grep ' }, compactSize)
  + makeTextButton(theme, 'git', 'git', { sendKeys: 'git status' }, compactSize)
  + makeTextButton(theme, 'ssh', 'ssh', { sendKeys: 'ssh ' }, compactSize)
  + makeTextButton(theme, 'chmod', 'chmod', { sendKeys: 'chmod +x ' }, compactSize)
  + makeTextButton(theme, 'homePath', '~/', { sendKeys: '~/' }, compactSize)
  + makeTextButton(theme, 'parentPath', '../', { sendKeys: '../' }, compactSize)
  + makeTextButton(theme, 'and', '&&', { sendKeys: ' && ' }, compactSize)
  + makeTextButton(theme, 'or', '||', { sendKeys: ' || ' }, compactSize)
  + makeTextButton(theme, 'gt', '>', { character: '>' }, compactSize)
  + makeTextButton(theme, 'dgt', '>>', { sendKeys: '>>' }, compactSize)
  + makeTextButton(theme, 'dollar', '$', { character: '$' }, compactSize)
  + makeTextButton(theme, 'star', '*', { character: '*' }, compactSize)
  + makeTextButton(theme, 'equal', '=', { character: '=' }, compactSize)
  + makeTextButton(theme, 'colon', ':', { character: ':' }, compactSize)
  + makeTextButton(theme, 'quote', '\'', { character: '\'' }, compactSize)
  + makeTextButton(theme, 'doubleQuote', '"', { character: '"' }, compactSize)
  + makeTextButton(theme, 'dotSlash', './', { sendKeys: './' }, wideSize)
  + makeTextButton(theme, 'commandSub', '$()', { sendKeys: '$()' }, wideSize)
  + {
    returnButton: createButton(
      params={ key: 'return', size: wideSize, action: 'returnLastKeyboard' }
    ),
    returnButtonForegroundStyle: utils.makeSystemImageStyle(
      params={
        systemImageName: 'arrow.backward',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] - 2,
      }
    ),
    backspaceButton: createButton(
      params={ key: 'backspace', size: compactSize, action: 'backspace', repeatAction: 'backspace' }
    ),
    backspaceButtonForegroundStyle: utils.makeSystemImageStyle(
      params={
        systemImageName: 'delete.left',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] - 2,
        center: { y: 0.53 },
      }
    ),
    spaceButton: createButton(
      params={ key: 'space', size: wideSize, action: 'space', backgroundStyle: 'accentButtonBackgroundStyle' }
    ),
    spaceButtonForegroundStyle: utils.makeSystemImageStyle(
      params={
        systemImageName: 'space',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] - 3,
      }
    ),
  }
  + enterKey.genEnterSection(theme, createButton, 'sharedDynamic', { isChar: false, size: wideSize }, null);

{
  new(theme, orientation):
    keyboard(theme, orientation) + toolbar.getToolBar(theme),
}
