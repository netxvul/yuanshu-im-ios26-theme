local config = {
  author: 'Kun Peh',
  name: 'Feature 26',
  pinyin: {
    iPhone: {
      portrait: 'pinyin_26_portrait',
      landscape: 'pinyin_26_landscape',
    },
    iPad: {
      portrait: 'pinyin_26_landscape',
      landscape: 'pinyin_26_landscape',
      floating: 'pinyin_26_portrait',
    },
  },
  alphabetic: {
    iPhone: {
      portrait: 'alphabetic_26_portrait',
      landscape: 'alphabetic_26_landscape',
    },
    iPad: {
      portrait: 'alphabetic_26_landscape',
      landscape: 'alphabetic_26_landscape',
      floating: 'alphabetic_26_portrait',
    },
  },
  numeric: {
    iPhone: {
      portrait: 'iphone_numeric_portrait',
      landscape: 'numeric_9_landscape',
    },
    iPad: {
      portrait: 'numeric_9_portrait',
      landscape: 'numeric_9_landscape',
      floating: 'numeric_9_portrait',
    },
  },
  symbolic: {
    iPhone: {
      portrait: 'iphone_symbolic_portrait',
      landscape: 'numeric_9_landscape',
    },
    iPad: {
      portrait: 'symbolic_portrait',
      landscape: 'numeric_9_landscape',
      floating: 'symbolic_portrait',
    },
  },
  emoji: {
     iPhone: {
       portrait: 'emoji_portrait',
       landscape: 'emoji_landscape',
     },
  },
  panel: {
    iPhone: {
      portrait: 'panel_portrait',
      landscape: 'panel_landscape',
    },
  },
  numeric_9: {
     iPhone: {
      portrait: 'numeric_9_portrait',
      landscape: 'numeric_9_landscape',
    },
    iPad: {
      portrait: 'numeric_9_portrait',
      landscape: 'numeric_9_landscape',
      floating: 'numeric_9_portrait',
    },
  },
  symbolic_all: {
    iPhone: {
      portrait: 'symbolic_portrait',
      landscape: 'numeric_9_landscape',
    },
    iPad: {
      portrait: 'symbolic_portrait',
      landscape: 'numeric_9_landscape',
      floating: 'symbolic_portrait',
    },
  },
  linux_terminal: {
    iPhone: {
      portrait: 'linux_terminal_portrait',
      landscape: 'linux_terminal_landscape',
    },
    iPad: {
      portrait: 'linux_terminal_landscape',
      landscape: 'linux_terminal_landscape',
      floating: 'linux_terminal_portrait',
    },
  },
  linux_terminal_file: {
    iPhone: {
      portrait: 'linux_terminal_file_portrait',
      landscape: 'linux_terminal_file_landscape',
    },
    iPad: {
      portrait: 'linux_terminal_file_landscape',
      landscape: 'linux_terminal_file_landscape',
      floating: 'linux_terminal_file_portrait',
    },
  },
  linux_terminal_shell: {
    iPhone: {
      portrait: 'linux_terminal_shell_portrait',
      landscape: 'linux_terminal_shell_landscape',
    },
    iPad: {
      portrait: 'linux_terminal_shell_landscape',
      landscape: 'linux_terminal_shell_landscape',
      floating: 'linux_terminal_shell_portrait',
    },
  },
  linux_terminal_git: {
    iPhone: {
      portrait: 'linux_terminal_git_portrait',
      landscape: 'linux_terminal_git_landscape',
    },
    iPad: {
      portrait: 'linux_terminal_git_landscape',
      landscape: 'linux_terminal_git_landscape',
      floating: 'linux_terminal_git_portrait',
    },
  },
  linux_terminal_ssh: {
    iPhone: {
      portrait: 'linux_terminal_ssh_portrait',
      landscape: 'linux_terminal_ssh_landscape',
    },
    iPad: {
      portrait: 'linux_terminal_ssh_landscape',
      landscape: 'linux_terminal_ssh_landscape',
      floating: 'linux_terminal_ssh_portrait',
    },
  },
};

local pinyin = import 'keyboard/pinyin_26.jsonnet';
local alphabetic = import 'keyboard/alphabetic_26.jsonnet';
local numericPortrait = import 'keyboard/numeric_9_portrait.jsonnet';
local numericLandscape = import 'keyboard/numeric_9_landscape.jsonnet';
local symbolic = import 'keyboard/symbolic_portrait.jsonnet';
local iphoneNumeric = import 'keyboard/iphone_numeric.jsonnet';
local iphoneSymbolic = import 'keyboard/iphone_symbolic.jsonnet';
local linuxTerminal = import 'keyboard/linux_terminal.jsonnet';
// local emoji = import 'keyboard/emoji_portrait.jsonnet';
local panel = import 'keyboard/panel.jsonnet';

// 拼音
local lightPinyinPortrait = pinyin.new('light', 'portrait');
local darkPinyinPortrait = pinyin.new('dark', 'portrait');
local lightPinyinLandscape = pinyin.new('light', 'landscape');
local darkPinyinLandscape = pinyin.new('dark', 'landscape');

// 字母
local lightAlphabeticPortrait = alphabetic.new('light', 'portrait');
local darkAlphabeticPortrait = alphabetic.new('dark', 'portrait');
local lightAlphabeticLandscape = alphabetic.new('light', 'landscape');
local darkAlphabeticLandscape = alphabetic.new('dark', 'landscape');

// 数字
local lightNumericPortrait = numericPortrait.new('light');
local darkNumericPortrait = numericPortrait.new('dark');
local lightNumericLandscape = numericLandscape.new('light');
local darkNumericLandscape = numericLandscape.new('dark');

// 符号（分类符号浏览器，保留备用）
local lightSymbolicPortrait = symbolic.new('light');
local darkSymbolicPortrait = symbolic.new('dark');

// iPhoneNumeric 风格数字符号键盘（绑定到 123Button / numericButton）
local lightIphoneNumericPortrait = iphoneNumeric.new('light', 'portrait');
local darkIphoneNumericPortrait = iphoneNumeric.new('dark', 'portrait');
local lightIphoneNumericLandscape = iphoneNumeric.new('light', 'landscape');
local darkIphoneNumericLandscape = iphoneNumeric.new('dark', 'landscape');

// iPhoneSymbolic 风格符号键盘（绑定到 symbolButton）
local lightIphoneSymbolicPortrait = iphoneSymbolic.new('light', 'portrait');
local darkIphoneSymbolicPortrait = iphoneSymbolic.new('dark', 'portrait');
local lightIphoneSymbolicLandscape = iphoneSymbolic.new('light', 'landscape');
local darkIphoneSymbolicLandscape = iphoneSymbolic.new('dark', 'landscape');

// Linux terminal
local lightLinuxTerminalPortrait = linuxTerminal.new('light', 'portrait');
local darkLinuxTerminalPortrait = linuxTerminal.new('dark', 'portrait');
local lightLinuxTerminalLandscape = linuxTerminal.new('light', 'landscape');
local darkLinuxTerminalLandscape = linuxTerminal.new('dark', 'landscape');
local lightLinuxTerminalFilePortrait = linuxTerminal.newByCategory('light', 'portrait', 'file');
local darkLinuxTerminalFilePortrait = linuxTerminal.newByCategory('dark', 'portrait', 'file');
local lightLinuxTerminalFileLandscape = linuxTerminal.newByCategory('light', 'landscape', 'file');
local darkLinuxTerminalFileLandscape = linuxTerminal.newByCategory('dark', 'landscape', 'file');
local lightLinuxTerminalShellPortrait = linuxTerminal.newByCategory('light', 'portrait', 'shell');
local darkLinuxTerminalShellPortrait = linuxTerminal.newByCategory('dark', 'portrait', 'shell');
local lightLinuxTerminalShellLandscape = linuxTerminal.newByCategory('light', 'landscape', 'shell');
local darkLinuxTerminalShellLandscape = linuxTerminal.newByCategory('dark', 'landscape', 'shell');
local lightLinuxTerminalGitPortrait = linuxTerminal.newByCategory('light', 'portrait', 'git');
local darkLinuxTerminalGitPortrait = linuxTerminal.newByCategory('dark', 'portrait', 'git');
local lightLinuxTerminalGitLandscape = linuxTerminal.newByCategory('light', 'landscape', 'git');
local darkLinuxTerminalGitLandscape = linuxTerminal.newByCategory('dark', 'landscape', 'git');
local lightLinuxTerminalSshPortrait = linuxTerminal.newByCategory('light', 'portrait', 'ssh');
local darkLinuxTerminalSshPortrait = linuxTerminal.newByCategory('dark', 'portrait', 'ssh');
local lightLinuxTerminalSshLandscape = linuxTerminal.newByCategory('light', 'landscape', 'ssh');
local darkLinuxTerminalSshLandscape = linuxTerminal.newByCategory('dark', 'landscape', 'ssh');

// emoji
// local lightEmojiPortrait = emoji.new('light');
// local darkEmojiPortrait = emoji.new('dark');

// 面板
local lightPanelPortrait = panel.new('light', 'portrait');
local darkPanelPortrait = panel.new('dark', 'portrait');
local lightPanelLandscape = panel.new('light', 'landscape');
local darkPanelLandscape = panel.new('dark', 'landscape');

{
  'config.yaml': std.manifestYamlDoc(config, indent_array_in_object=true, quote_keys=false),
  // 拼音
  'light/pinyin_26_portrait.yaml': std.toString(lightPinyinPortrait),
  'dark/pinyin_26_portrait.yaml': std.toString(darkPinyinPortrait),
  'light/pinyin_26_landscape.yaml': std.toString(lightPinyinLandscape),
  'dark/pinyin_26_landscape.yaml': std.toString(darkPinyinLandscape),

  // 字母
  'light/alphabetic_26_portrait.yaml': std.toString(lightAlphabeticPortrait),
  'dark/alphabetic_26_portrait.yaml': std.toString(darkAlphabeticPortrait),
  'light/alphabetic_26_landscape.yaml': std.toString(lightAlphabeticLandscape),
  'dark/alphabetic_26_landscape.yaml': std.toString(darkAlphabeticLandscape),

  // 数字
  'light/numeric_9_portrait.yaml': std.toString(lightNumericPortrait),
  'dark/numeric_9_portrait.yaml': std.toString(darkNumericPortrait),
  'light/numeric_9_landscape.yaml': std.toString(lightNumericLandscape),
  'dark/numeric_9_landscape.yaml': std.toString(darkNumericLandscape),

  // 符号（分类浏览器，保留备用）
  'light/symbolic_portrait.yaml': std.toString(lightSymbolicPortrait),
  'dark/symbolic_portrait.yaml': std.toString(darkSymbolicPortrait),

  // iPhoneNumeric 风格数字符号键盘（123Button / numericButton 绑定目标）
  'light/iphone_numeric_portrait.yaml': std.toString(lightIphoneNumericPortrait),
  'dark/iphone_numeric_portrait.yaml': std.toString(darkIphoneNumericPortrait),
  'light/iphone_numeric_landscape.yaml': std.toString(lightIphoneNumericLandscape),
  'dark/iphone_numeric_landscape.yaml': std.toString(darkIphoneNumericLandscape),

  // iPhoneSymbolic 风格符号键盘（symbolButton 绑定目标）
  'light/iphone_symbolic_portrait.yaml': std.toString(lightIphoneSymbolicPortrait),
  'dark/iphone_symbolic_portrait.yaml': std.toString(darkIphoneSymbolicPortrait),
  'light/iphone_symbolic_landscape.yaml': std.toString(lightIphoneSymbolicLandscape),
  'dark/iphone_symbolic_landscape.yaml': std.toString(darkIphoneSymbolicLandscape),

  // Linux terminal
  'light/linux_terminal_portrait.yaml': std.toString(lightLinuxTerminalPortrait),
  'dark/linux_terminal_portrait.yaml': std.toString(darkLinuxTerminalPortrait),
  'light/linux_terminal_landscape.yaml': std.toString(lightLinuxTerminalLandscape),
  'dark/linux_terminal_landscape.yaml': std.toString(darkLinuxTerminalLandscape),
  'light/linux_terminal_file_portrait.yaml': std.toString(lightLinuxTerminalFilePortrait),
  'dark/linux_terminal_file_portrait.yaml': std.toString(darkLinuxTerminalFilePortrait),
  'light/linux_terminal_file_landscape.yaml': std.toString(lightLinuxTerminalFileLandscape),
  'dark/linux_terminal_file_landscape.yaml': std.toString(darkLinuxTerminalFileLandscape),
  'light/linux_terminal_shell_portrait.yaml': std.toString(lightLinuxTerminalShellPortrait),
  'dark/linux_terminal_shell_portrait.yaml': std.toString(darkLinuxTerminalShellPortrait),
  'light/linux_terminal_shell_landscape.yaml': std.toString(lightLinuxTerminalShellLandscape),
  'dark/linux_terminal_shell_landscape.yaml': std.toString(darkLinuxTerminalShellLandscape),
  'light/linux_terminal_git_portrait.yaml': std.toString(lightLinuxTerminalGitPortrait),
  'dark/linux_terminal_git_portrait.yaml': std.toString(darkLinuxTerminalGitPortrait),
  'light/linux_terminal_git_landscape.yaml': std.toString(lightLinuxTerminalGitLandscape),
  'dark/linux_terminal_git_landscape.yaml': std.toString(darkLinuxTerminalGitLandscape),
  'light/linux_terminal_ssh_portrait.yaml': std.toString(lightLinuxTerminalSshPortrait),
  'dark/linux_terminal_ssh_portrait.yaml': std.toString(darkLinuxTerminalSshPortrait),
  'light/linux_terminal_ssh_landscape.yaml': std.toString(lightLinuxTerminalSshLandscape),
  'dark/linux_terminal_ssh_landscape.yaml': std.toString(darkLinuxTerminalSshLandscape),

  // emoji
  // 'light/emoji_portrait.yaml': std.toString(lightEmojiPortrait),
  // 'dark/emoji_portrait.yaml': std.toString(darkEmojiPortrait),

  // 面板
  'light/panel_portrait.yaml': std.toString(lightPanelPortrait),
  'dark/panel_portrait.yaml': std.toString(darkPanelPortrait),
  'light/panel_landscape.yaml': std.toString(lightPanelLandscape),
  'dark/panel_landscape.yaml': std.toString(darkPanelLandscape),
}
