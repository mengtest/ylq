--import module

local global = require "global"
local skynet = require "skynet"
local record = require "public.record"

Cmds = {}

Cmds.common = import(service_path("routercmd.common"))
Cmds.backend = import(service_path("routercmd.backend"))
Cmds.pay = import(service_path("routercmd.pay"))
Cmds.kuafu = import(service_path("routercmd.kuafu"))
Cmds.idsupply = import(service_path("routercmd.idsupply"))
Cmds.punish = import(service_path("routercmd.punish"))

function Invoke(sModule, sCmd, mRecord, mData)
    local m = Cmds[sModule]
    if m then
        local f = m[sCmd]
        if f then
            return f(mRecord, mData)
        end
    end
    record.error(string.format("Invoke fail %s %s %s %s", MY_SERVICE_NAME, MY_ADDR, sModule, sCmd))
end