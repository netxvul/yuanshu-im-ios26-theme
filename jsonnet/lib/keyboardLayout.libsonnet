local color = import 'color.libsonnet';

// ========== 共享布局模板 ==========

// 竖屏布局模板（中英文完全相同）
local portraitLayout(theme) = {
  keyboardLayout: [
    {
      HStack: {
        subviews: [
          { Cell: 'qButton' },
          { Cell: 'wButton' },
          { Cell: 'eButton' },
          { Cell: 'rButton' },
          { Cell: 'tButton' },
          { Cell: 'yButton' },
          { Cell: 'uButton' },
          { Cell: 'iButton' },
          { Cell: 'oButton' },
          { Cell: 'pButton' },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: 'aButton' },
          { Cell: 'sButton' },
          { Cell: 'dButton' },
          { Cell: 'fButton' },
          { Cell: 'gButton' },
          { Cell: 'hButton' },
          { Cell: 'jButton' },
          { Cell: 'kButton' },
          { Cell: 'lButton' },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: 'shiftButton' },
          { Cell: 'zButton' },
          { Cell: 'xButton' },
          { Cell: 'cButton' },
          { Cell: 'vButton' },
          { Cell: 'bButton' },
          { Cell: 'nButton' },
          { Cell: 'mButton' },
          { Cell: 'backspaceButton' },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: '123Button' },
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
};

// 横屏布局模板（参数化左下角按键行顺序）
// leftBottomRow: 左半区底部行按键数组，中文为 [123, symbol, space]，英文为 [symbol, 123, space]
local landscapeLayout(theme, leftBottomRow) = {
  keyboardLayout: [
    {
      VStack: {
        style: 'columnStyle1',
        subviews: [
          {
            HStack: {
              subviews: [
                { Cell: 'qButton' },
                { Cell: 'wButton' },
                { Cell: 'eButton' },
                { Cell: 'rButton' },
                { Cell: 'tButton' },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                { Cell: 'aButton' },
                { Cell: 'sButton' },
                { Cell: 'dButton' },
                { Cell: 'fButton' },
                { Cell: 'gButton' },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                { Cell: 'shiftButton' },
                { Cell: 'zButton' },
                { Cell: 'xButton' },
                { Cell: 'cButton' },
                { Cell: 'vButton' },
              ],
            },
          },
          {
            HStack: {
              subviews: leftBottomRow,
            },
          },
        ],
      },
    },
    {
      VStack: {
        style: 'columnStyle2',
      },
    },
    {
      VStack: {
        style: 'columnStyle3',
        subviews: [
          {
            HStack: {
              subviews: [
                { Cell: 'yButton' },
                { Cell: 'uButton' },
                { Cell: 'iButton' },
                { Cell: 'oButton' },
                { Cell: 'pButton' },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                { Cell: 'gButton' },
                { Cell: 'hButton' },
                { Cell: 'jButton' },
                { Cell: 'kButton' },
                { Cell: 'lButton' },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                { Cell: 'vButton' },
                { Cell: 'bButton' },
                { Cell: 'nButton' },
                { Cell: 'mButton' },
                { Cell: 'backspaceButton' },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                { Cell: 'spaceButton' },
                { Cell: 'spaceRightButton' },
                { Cell: 'enterButton' },
              ],
            },
          },
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
  columnStyle1: {
    size: {
      width: '2/5',
    },
  },
  columnStyle2: {
    size: {
      width: '1/5',
    },
  },
  columnStyle3: {
    size: {
      width: '2/5',
    },
  },
};

// ========== 横屏左下角按键行定义 ==========

// 中文键盘: 123, symbol, space
local cnLandscapeLeftBottomRow = [
  { Cell: '123Button' },
  { Cell: 'symbolButton' },
  { Cell: 'spaceButton' },
];

// 英文键盘: symbol, 123, space
local enLandscapeLeftBottomRow = [
  { Cell: 'symbolButton' },
  { Cell: '123Button' },
  { Cell: 'spaceButton' },
];

// ========== 按键尺寸 ==========

local buttonSizes = {
  '竖屏按键尺寸': {
    '普通键size': {
      width: {
        percentage: 0.1,
      },
    },
    't键size': {
      width: '200/784',
    },
    'y键size': {
      width: '200/784',
    },
    'a键size': {
      width: {
        percentage: 0.15,
      },
    },
    'a键bounds': {
      width: '2/3',
      alignment: 'right',
    },
    'l键size': {
      width: {
        percentage: 0.15,
      },
    },
    'l键bounds': {
      width: '2/3',
      alignment: 'left',
    },
    'shift键size': {
      width: {
        percentage: 0.15,
      },
    },
    'backspace键size': {
      width: {
        percentage: 0.15,
      },
    },
    'symbol键size': {
      width: {
        percentage: 0.115,
      },
    },
    '123键size': {
      width: {
        percentage: 0.15,
      },
    },
    'space键size': {
      width: {
        percentage: 0.435,
      },
    },
    'spaceRight键size': {
      width: {
        percentage: 0.1,
      },
    },
    'enter键size': {
      width: {
        percentage: 0.2,
      },
    },
  },

  '横屏按键尺寸': {
    '普通键size': {
      width: '146/784',
    },
    't键size': {
      width: '200/784',
    },
    't键bounds': {
      width: '146/200',
      alignment: 'left',
    },
    'y键size': {
      width: '200/784',
    },
    'y键bounds': {
      width: '146/200',
      alignment: 'right',
    },
    'a键size': {
      width: '200/784',
    },
    'a键bounds': {
      width: '146/200',
      alignment: 'right',
    },
    'l键size': {
      width: '200/784',
    },
    'l键bounds': {
      width: '146/200',
      alignment: 'left',
    },
    'shift键size': {
      width: '200/784',
    },
    'backspace键size': {
      width: '200/784',
    },
    'symbol键size': {
      width: '173/784',
    },
    '123键size': {
      width: '173/784',
    },
    'space键size': {
      width: '438/784',
    },
    'spaceRight键size': {
      width: '173/784',
    },
    'enter键size': {
      width: '173/784',
    },
  },
};

// ========== 导出接口 ==========

{
  getPinyinLayout(theme, orientation):
    if orientation == 'portrait' then portraitLayout(theme)
    else landscapeLayout(theme, cnLandscapeLeftBottomRow),

  getEnLayout(theme, orientation):
    if orientation == 'portrait' then portraitLayout(theme)
    else landscapeLayout(theme, enLandscapeLeftBottomRow),

  getButtonSize(theme, orientation):
    if orientation == 'portrait' then buttonSizes['竖屏按键尺寸']
    else buttonSizes['横屏按键尺寸'],
}
