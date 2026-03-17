local center = import 'center.libsonnet';
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';
local others = import 'others.libsonnet';
local utils = import 'utils.libsonnet';

local enterThemes = {
  default: {
    systemImageName: 'return.right',
    foregroundNormalColorKey: '长按选中字体颜色',
    foregroundHighlightColorKey: '长按非选中字体颜色',
    backgroundNormalColorKey: 'enter键背景(蓝色)',
    backgroundHighlightColorKey: '功能键背景颜色-高亮',
    cornerRadiusKey: 'enter键',
    insets: { top: 5, left: 3, bottom: 5, right: 3 },
    center: center['功能键前景文字偏移'] { y: 0.5 },
    fontSize: fontSize['按键前景文字大小'],
  },
  defaultGray: {
    systemImageName: 'return.right',
    foregroundNormalColorKey: '按键前景颜色',
    foregroundHighlightColorKey: '按键前景颜色',
    backgroundNormalColorKey: '功能键背景颜色-普通',
    backgroundHighlightColorKey: '功能键背景颜色-高亮',
    cornerRadiusKey: '功能键',
    insets: { top: 5, left: 3, bottom: 6, right: 3 },
    center: center['功能键前景文字偏移'] { y: 0.5 },
    fontSize: fontSize['按键前景文字大小'],
  },
  search: {
    systemImageName: 'magnifyingglass',
    foregroundNormalColorKey: '长按选中字体颜色',
    foregroundHighlightColorKey: '长按非选中字体颜色',
    backgroundNormalColorKey: 'enter键背景(蓝色)',
    backgroundHighlightColorKey: '功能键背景颜色-高亮',
    cornerRadiusKey: 'enter键',
    insets: { top: 5, left: 3, bottom: 5, right: 3 },
    center: center['功能键前景文字偏移'] { y: 0.5 },
    fontSize: fontSize['按键前景文字大小'],
  },
  send: {
    systemImageName: 'arrow.uturn.right',
    foregroundNormalColorKey: '长按选中字体颜色',
    foregroundHighlightColorKey: '长按非选中字体颜色',
    backgroundNormalColorKey: 'enter键背景(蓝色)',
    backgroundHighlightColorKey: '功能键背景颜色-高亮',
    cornerRadiusKey: 'enter键',
    insets: { top: 5, left: 3, bottom: 5, right: 3 },
    center: center['功能键前景文字偏移'] { y: 0.5 },
    fontSize: fontSize['按键前景文字大小'],
  },
  next: {
    systemImageName: 'chevron.forward',
    foregroundNormalColorKey: '长按选中字体颜色',
    foregroundHighlightColorKey: '长按非选中字体颜色',
    backgroundNormalColorKey: 'enter键背景(蓝色)',
    backgroundHighlightColorKey: '功能键背景颜色-高亮',
    cornerRadiusKey: 'enter键',
    insets: { top: 5, left: 3, bottom: 5, right: 3 },
    center: center['功能键前景文字偏移'] { y: 0.5 },
    fontSize: fontSize['按键前景文字大小'],
  },
  done: {
    systemImageName: 'shareplay',
    foregroundNormalColorKey: '长按选中字体颜色',
    foregroundHighlightColorKey: '长按非选中字体颜色',
    backgroundNormalColorKey: 'enter键背景(蓝色)',
    backgroundHighlightColorKey: '功能键背景颜色-高亮',
    cornerRadiusKey: 'enter键',
    insets: { top: 5, left: 3, bottom: 5, right: 3 },
    center: center['功能键前景文字偏移'] { y: 0.5 },
    fontSize: fontSize['按键前景文字大小'],
  },
};

local enterProfiles = {
  sharedDynamic: {
    mode: 'dynamic',
    mapping: [
      { returnKeyTypes: [0, 2, 3, 5, 8, 10, 11], theme: 'defaultGray' },
      { returnKeyTypes: [1, 4], theme: 'next' },
      { returnKeyTypes: [6], theme: 'search' },
      { returnKeyTypes: [7], theme: 'send' },
      { returnKeyTypes: [9], theme: 'done' },
    ],
  },
};

local getThemeConfig(themeName, overrides={}) =
  std.get(enterThemes, themeName, enterThemes.default) + overrides;

local getProfile(profileName) =
  std.get(enterProfiles, profileName, enterProfiles.sharedDynamic);

local makeForegroundStyle(theme, config) =
  utils.makeSystemImageStyle(
    params={
      systemImageName: config.systemImageName,
      normalColor: color[theme][config.foregroundNormalColorKey],
      highlightColor: color[theme][config.foregroundHighlightColorKey],
      fontSize: std.get(config, 'fontSize', fontSize['按键前景文字大小']),
      center: std.get(config, 'center', center['功能键前景文字偏移'] { y: 0.5 }),
    }
  );

local makeBackgroundStyle(theme, config) =
  utils.makeGeometryStyle(
    params={
      buttonStyleType: 'geometry',
      insets: std.get(config, 'insets', { top: 5, left: 3, bottom: 5, right: 3 }),
      normalColor: color[theme][config.backgroundNormalColorKey],
      highlightColor: color[theme][config.backgroundHighlightColorKey],
      cornerRadius: others['圆角'][std.get(config, 'cornerRadiusKey', 'enter键')],
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    }
  );

local genStaticEnterSection(theme, createButton, profileName='sharedDynamic', buttonParams={}, themeOverrides={}) =
  local profile = getProfile(profileName);
  local config = getThemeConfig(std.get(profile, 'theme', 'default'), themeOverrides);
  {
    enterButton: createButton(
      params=buttonParams + {
        key: 'enter',
        action: 'enter',
        backgroundStyle: 'enterButtonBackgroundStyle',
        foregroundStyle: 'enterButtonForegroundStyle',
      }
    ),
    enterButtonForegroundStyle: makeForegroundStyle(theme, config),
    enterButtonBackgroundStyle: makeBackgroundStyle(theme, config),
  };

local genDynamicReturnKeyEnterSection(theme, ButtonSize, createButton, profileName='sharedDynamic', buttonParams={}) =
  local profile = getProfile(profileName);
  local mappingWithIds =
    std.mapWithIndex(
      function(idx, item)
        item + { id: idx }
      ,
      std.get(profile, 'mapping', [])
    );
  local foregroundConditions =
    std.map(
      function(item)
        {
          styleName: 'enterButtonForegroundStyle' + std.toString(item.id),
          conditionKey: '$returnKeyType',
          conditionValue: item.returnKeyTypes,
        },
      mappingWithIds
    );
  local backgroundConditions =
    std.map(
      function(item)
        {
          styleName: 'enterButtonBackgroundStyle' + std.toString(item.id),
          conditionKey: '$returnKeyType',
          conditionValue: item.returnKeyTypes,
        },
      mappingWithIds
    );
  local notifications =
    std.foldl(
      function(acc, item)
        acc + {
          ['enterReturnKeyNotification' + std.toString(item.id)]: {
            notificationType: 'returnKeyType',
            returnKeyType: item.returnKeyTypes,
            backgroundStyle: 'enterButtonBackgroundStyle' + std.toString(item.id),
            foregroundStyle: 'enterButtonForegroundStyle' + std.toString(item.id),
          },
        },
      mappingWithIds,
      {}
    );
  local styles =
    std.foldl(
      function(acc, item)
        local config = getThemeConfig(item.theme, std.get(item, 'overrides', {}));
        acc + {
          ['enterButtonForegroundStyle' + std.toString(item.id)]: makeForegroundStyle(theme, config),
          ['enterButtonBackgroundStyle' + std.toString(item.id)]: makeBackgroundStyle(theme, config),
        },
      mappingWithIds,
      {}
    );
  {
    enterButton: createButton(
      params=buttonParams + {
        key: 'enter',
        action: 'enter',
        [if ButtonSize != null && !std.objectHas(buttonParams, 'size') then 'size']: ButtonSize['enter键size'],
        foregroundStyle: foregroundConditions,
        backgroundStyle: backgroundConditions,
        notification: std.map(
          function(item) 'enterReturnKeyNotification' + std.toString(item.id),
          mappingWithIds
        ),
      }
    ),
  }
  + styles
  + notifications;

local genEnterSection(theme, createButton, profileName='sharedDynamic', buttonParams={}, ButtonSize=null, themeOverrides={}) =
  local profile = getProfile(profileName);
  if std.get(profile, 'mode') == 'dynamic' then
    genDynamicReturnKeyEnterSection(theme, ButtonSize, createButton, profileName, buttonParams)
  else
    genStaticEnterSection(theme, createButton, profileName, buttonParams, themeOverrides);

{
  enterThemes: enterThemes,
  enterProfiles: enterProfiles,
  genEnterSection: genEnterSection,
  genStaticEnterSection: genStaticEnterSection,
  genDynamicReturnKeyEnterSection: genDynamicReturnKeyEnterSection,
}
