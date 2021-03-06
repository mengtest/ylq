--import module

local global = require "global"
local skynet = require "skynet"

local gamedefines = import(lualib_path("public.gamedefines"))
local pfobj = import(service_path("perform/pfobj"))

function NewCPerform(...)
    local o = CPerform:New(...)
    return o
end

CPerform = {}
CPerform.__index = CPerform
inherit(CPerform, pfobj.CPerform)

function CPerform:New(pfid)
    local o = super(CPerform).New(self,pfid)
    return o
end

function CPerform:Effect_Condition_For_Victim(oVictim,oAttack)
    if not oVictim or oVictim:IsDead() then
        return
    end
    local mArgs = self:GetSkillArgsEnv()
    local iRatio = mArgs["abnormal_ratio"] or 4000
    local iMinRatio = mArgs["min_ratio"] or 0
    local iMaxRatio = mArgs["max_ratio"] or 7500
    local iAbnormalRatio = oAttack:AbnormalRatio(oVictim,iMaxRatio,7500,iMinRatio)
    if in_random(iAbnormalRatio,10000) then
        super(CPerform).Effect_Condition_For_Victim(self,oVictim,oAttack)
    end
end