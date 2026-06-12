-- 中文模式下 - 后紧跟 > 时输出 ->（而非 -》）
local M = {}

function M.func(key, env)
    if key:release() then
        return 2
    end
    local repr = key:repr()

    -- 忽略修饰键（Shift/Ctrl/Alt），否则按 Shift 准备打 > 时会重置状态
    if repr:find("_L") then
        return 2
    end

    if repr == "Shift+greater" and env.last_key == "minus" then
        env.last_key = nil
        env.engine:commit_text(">")
        return 1
    end

    env.last_key = repr == "minus" and "minus" or nil
    return 2
end

return M
