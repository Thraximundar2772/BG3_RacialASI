local deps = {
    VCModule_UUID           = "f97b43be-7398-4ea5-8fe2-be7eb3d4b5ca",
    MCMModule_UUID          = "755a8a72-407f-4f0d-9a33-274ac0f0b53d",
    ModUninstaller_UUID     = "163484d1-8511-4a95-8061-1ede8838b28b",
    Framework_FM_UUID       = "ff9844a0-a097-4149-bbca-ee0da5b937d7", -- FM Framework
    Framework_WotD_UUID     = "4806bd2a-929b-406e-b1d4-2e0e9cc23bb2", -- WOT AAsimaSE
    ASTRL_Elvens_UUID       = "66b20233-cf0a-44bb-9bcf-32c0e0b09c19", -- ASTRLElvens
    ASTRL_Tieflings_UUID    = "167b846f-0a0b-4e0c-a9d0-df448be1320a", -- ASTRLTieflings
    Framework_UUID          = "67fbbd53-7c7d-4cfa-9409-6d737b4d92a9" -- CompatibilityFramework
}

if Ext.Mod.IsModLoaded(deps.ModUninstaller_UUID) then
    setmetatable(Mods.ModUninstaller, { __index = Mods.VolitionCabinet })
end

DevelReady = Ext.Utils:Version() >= 17 or Ext.Debug.IsDeveloperMode()



if not Ext.Mod.IsModLoaded(deps.VCModule_UUID) then
    Ext.Utils.Print(
        "Volition Cabinet is missing and is a hard requirement. PLEASE MAKE SURE IT IS ENABLED IN YOUR MOD MANAGER.")
end

if not Ext.Mod.IsModLoaded(deps.MCMModule_UUID) then
    Ext.Utils.Print(
        "BG3 Mod Configuration Menu is missing and is a hard requirement. PLEASE MAKE SURE IT IS ENABLED IN YOUR MOD MANAGER.")
end

if not Ext.Mod.IsModLoaded(deps.ModUninstaller_UUID) then
    Ext.Utils.Print(
        "BG3 Mod Uninstaller is missing and is a hard requirement. PLEASE MAKE SURE IT IS ENABLED IN YOUR MOD MANAGER.")
end

if not Ext.Mod.IsModLoaded(deps.Framework_UUID) then
    Ext.Utils.Print(
        "BG3 Mod CF is missing and is a hard requirement. PLEASE MAKE SURE IT IS ENABLED IN YOUR MOD MANAGER.")
end

Ext.Require("Shared/_Init.lua")
Ext.Require("ModInfos/_ModInfos.lua")
Ext.Require("Client/_Init.lua")

-- Check if the mod is loaded and load ASI
if Ext.Mod.IsModLoaded(deps.Framework_UUID) and Ext.Mod.IsModLoaded(deps.Framework_FM_UUID) then
    Ext.Require("Client/FantasticalMultiverse.lua")
end

if Ext.Mod.IsModLoaded(deps.Framework_UUID) and Ext.Mod.IsModLoaded(deps.Framework_WotD_UUID) then
    Ext.Require("Client/WotDAasimaSE.lua")
end

if Ext.Mod.IsModLoaded(deps.Framework_UUID) then 
    Ext.Require("Client/CustomClasses.lua")
end

if Ext.Mod.IsModLoaded(deps.Framework_UUID) then 
    Ext.Require("Client/CustomRaces.lua")
end

if Ext.Mod.IsModLoaded(deps.Framework_UUID) and Ext.Mod.IsModLoaded(deps.ASTRL_Elvens_UUID) then
    Ext.Require("Client/ASTRLElvens.lua")
end

if Ext.Mod.IsModLoaded(deps.Framework_UUID) and Ext.Mod.IsModLoaded(deps.ASTRL_Tieflings_UUID) then
    Ext.Require("Client/ASTRLTieflings.lua")
end



if Ext.Mod.IsModLoaded(deps.MCMModule_UUID) then

-- implement mcm https://wiki.bg3.community/Tutorials/Mod-Frameworks/mod-configuration-menu#mcm-demo
    -- Insert a tab into MCM
    -- Listening to MCM events
    -- This is how you can listen to MCM events and react to theM. This is useful if you want to react to changes in settings or other events.
    -- This is a client-side event, so it should be placed in the BootstrapClient.lua file.
    Ext.RegisterNetListener("MCM_Saved_Setting", function(call, payload)
        local data = Ext.Json.Parse(payload)
        -- Always check if the data is valid and is related to your mod (unless for some reason you want to listen to other mods' events)
        if not data or data.modGUID ~= ModuleUUID or not data.settingId then
            return
        end
    end)
end