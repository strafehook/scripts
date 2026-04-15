-- strafehook loader
-- https://discord.gg/ZFNnh9Rsgt

pcall(function()
    local requestFunc = (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request) or http_request or request
    local DiscordInvite = "ZFNnh9Rsgt"
    HttpService = game:GetService("HttpService")
    if requestFunc then
        requestFunc({
            Url = 'http://127.0.0.1:6463/rpc?v=1',
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json',
                Origin = 'https://discord.com'
            },
            Body = HttpService:JSONEncode({
                cmd = 'INVITE_BROWSER',
                nonce = HttpService:GenerateGUID(false),
                args = {code = DiscordInvite}
            })
        })
    end
end)


local GAMES = {
    {
        name     = "Murderers VS Sheriffs DUELS",
        placeIds = { 12355337193 },
        script   = "mvsd.lua",
    },
    {
        name     = "Flick",
        placeIds = { 136801880565837 },
        script   = "flick.lua",
    },
    {
        name     = "OneShot",
        placeIds = { 105241313130846 },
        script   = "oneshot.lua",
    },
}

local BASE_URL = "https://raw.githubusercontent.com/strafehook/scripts/main/scripts/"

local currentPlaceId = game.PlaceId

for _, game_def in ipairs(GAMES) do
    for _, pid in ipairs(game_def.placeIds) do
        if currentPlaceId == pid then
            local url = BASE_URL .. game_def.script
            local ok, result = pcall(function()
                return game:HttpGet(url)
            end)
            if ok and result and result ~= "" then
                local loaded, err = pcall(loadstring(result))
                if not loaded then
                    warn("[strafehook] script error: " .. tostring(err))
                end
            else
                warn("[strafehook] failed to fetch: " .. url)
            end
            return
        end
    end
end

warn("[strafehook] no script found for place " .. tostring(currentPlaceId))
