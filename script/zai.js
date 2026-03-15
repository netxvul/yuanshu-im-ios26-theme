// ⚠️ 请将下方 API_KEY 替换为你自己的密钥，切勿将真实密钥提交到公开仓库
// 获取方式: https://open.bigmodel.cn/
const API_KEY = "YOUR_API_KEY_HERE";

const BASE_URL = "https://api.z.ai/api/paas/v4/chat/completions";
const DEFAULT_MODEL = "GLM-4.7";
const DEFAULT_TEMPERATURE = 0.8;

/**
 * 主函数，用于处理输入并输出翻译结果
 */
async function output() {
  var text = $searchText || $pasteboardContent;
  if (!text) {
    return "";
  }
  return await bigModelTranslate(text);
}

/**
 * 调用 BigModel 翻译 API
 * @param {string} text - 需要翻译的文本
 * @returns {Promise<string>} - 翻译后的文本
 */
async function bigModelTranslate(text) {
  const messages = [
    {
      role: "system",
      content: `你是一位专业的助理，请为我服务。`,
    },
    {
      role: "user",
      content: `${text}`,
    },
  ];

  try {
    const response = await $http({
      url: BASE_URL,
      method: "POST",
      header: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${API_KEY}`,
      },
      body: {
        messages,
        model: DEFAULT_MODEL,
        temperature: DEFAULT_TEMPERATURE,
        top_p: 0.1,
        max_tokens: 2048,
        thinking: {
          type: "disabled",
        },
      },
      timeout: 30,
    });

    if (response.response.statusCode !== 200) {
      throw new Error(
        `API请求失败: HTTP状态码 ${response.response.statusCode}`,
      );
    }

    const responseData = JSON.parse(response.data);
    if (!responseData.choices || responseData.choices.length === 0) {
      throw new Error("API返回数据格式错误: 没有找到有效的回复");
    }

    // 返回翻译后的内容
    return responseData.choices[0].message?.content || "";
  } catch (error) {
    const errorMessage =
      error instanceof SyntaxError
        ? "API返回的数据无法解析为JSON"
        : error.message || "未知错误";
    $log(`BigModel API 错误: ${errorMessage}`);
    if (error.response) {
      $log(`响应详情: ${JSON.stringify(error.response)}`);
    }
    return `抱歉，发生了错误: ${errorMessage}`;
  }
}
