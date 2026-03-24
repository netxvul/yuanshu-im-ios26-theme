local center = import 'center.libsonnet';
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';
local others = import 'others.libsonnet';

// 文字前景样式
local textStyle(text, fs, theme) = {  //fs 字体大小
  buttonStyleType: 'text',
  text: text,
  fontSize: fs,
  normalColor: color[theme]['长按非选中字体颜色'],
  highlightColor: color[theme]['长按选中字体颜色'],
  center: center['长按气泡文字偏移'],
};

// sf符号前景样式
local systemImageStyle(systemImageName, fs, theme) = {
  buttonStyleType: 'systemImage',
  systemImageName: systemImageName,
  fontSize: fs,
  normalColor: color[theme]['长按非选中字体颜色'],
  highlightColor: color[theme]['长按选中字体颜色'],
  center: center['长按气泡sf符号偏移'],
};

local fileImageStyle(file) = {
  buttonStyleType: 'fileImage',
  contentMode: 'scaleAspectFit',
  normalImage: {
    file: file,
    image: 'IMG1',
  },
  highlightImage: {
    file: file,
    image: 'IMG1',
  },
  center: center['长按气泡sf符号偏移'],
};


// 长按符号样式生成
local holdSymbolsStyle(key, selectedIndex, size, symbol_list, theme) = {
  [key + 'ButtonHintSymbolsStyle']: {
    insets: { top: 2, bottom: 2, left: 2, right: 2 },
    backgroundStyle: 'alphabeticHintSymbolsBackgroundStyle',
    size:
      if size != {} then
        {
          width: size.width,
          height: size.height,
        }
      else
        {
          width: 40,
          height: 40,
        },
    symbolStyles: [
      key + 'ButtonHintSymbolsStyleOf' + std.toString(index)
      for index in std.range(0, std.length(symbol_list) - 1)
    ],
    selectedBackgroundStyle: 'alphabeticHintSymbolsSelectedStyle',
    selectedIndex: selectedIndex,
  },
} + {

  [key + 'ButtonHintSymbolsForegroundStyleOf' + std.toString(index)]:
    if std.objectHas(symbol_list[index].label, 'text') then
      textStyle(
        symbol_list[index].label.text,
        if std.objectHas(symbol_list[index], 'fontSize') then symbol_list[index].fontSize else fontSize['长按气泡文字大小'],
        theme
      )
    else if std.objectHas(symbol_list[index].label, 'file') then
      fileImageStyle(symbol_list[index].label.file)
    else
      systemImageStyle(
        symbol_list[index].label.systemImageName,
        if std.objectHas(symbol_list[index], 'fontSize') then symbol_list[index].fontSize else fontSize['长按气泡sf符号大小'],
        theme
      )
  for index in std.range(0, std.length(symbol_list) - 1)
} + {
  [key + 'ButtonHintSymbolsStyleOf' + std.toString(index)]: {
    action: symbol_list[index].action,
    foregroundStyle: key + 'ButtonHintSymbolsForegroundStyleOf' + std.toString(index),
  }
  for index in std.range(0, std.length(symbol_list) - 1)
};

// 直接生成最终对象，避免 `mergePatch` 和 `objectValuesAll`
local finalStyles(theme, hintSymbolsData) =
  std.foldl(
    function(acc, key) acc + holdSymbolsStyle(
      key,
      hintSymbolsData[key].selectedIndex,
      if std.objectHas(hintSymbolsData[key], 'size') then hintSymbolsData[key].size else {},
      hintSymbolsData[key].list,
      theme
    ),
    std.objectFields(hintSymbolsData),
    {}
  ) + {
    'alphabeticHintSymbolsBackgroundStyle': {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['长按背景颜色'],
      normalShadowColor: color[theme]['长按背景阴影颜色'],
      cornerRadius: others['圆角']['长按气泡'],
      targetScale: {
        x: 0.8,
        y: 1.0,
      },
    },
    'alphabeticHintSymbolsSelectedStyle': {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['长按背景颜色'],
      highlightColor: color[theme]['长按选中背景颜色'],
      cornerRadius: others['圆角']['长按气泡选中'],
      targetScale: {
        x: 0.6,
        y: 0.7,
      },
    },
  };

{
  getStyle(theme, hintSymbolsData):
    finalStyles(theme, hintSymbolsData),

}
