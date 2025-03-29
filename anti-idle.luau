--!nocheck
--!nolint

local environment = type(getgenv) == 'function' and getgenv() or _G or shared
local firesignal = firesignal

if type(firesignal) == 'function' and type(environment) == 'table' then
    local c = environment.noIdleConnection
    if typeof(c) == 'RBXScriptConnection' and c.Connected then
        c:Disconnect()
    end
    
    environment.noIdleConnection = nil

    local cloneref = type(cloneref) == 'function' and cloneref or function(value) return value end
    local UserInputService = cloneref(game:GetService('UserInputService'))

    local function fakeCaptureFocus()
        task.wait()
        firesignal(UserInputService.WindowFocused)
    end

    environment.noIdleConnection = UserInputService.WindowFocusReleased:Connect(fakeCaptureFocus)
end
