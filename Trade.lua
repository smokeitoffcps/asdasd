RemoveCallbacks()

local function TradeHook(varlist)
    if varlist[0]:find("OnConsoleMessage") then
        local message = varlist[1]
        local usernameWithColor = nil

        if message:find("`w/trade `(.-)`$") then
            usernameWithColor = message:match("`w/trade `(.-)`$")
            usernameWithColor = RemoveBoostTag(usernameWithColor)
            local tradeCommand = "/trade " .. usernameWithColor
            local tradePacket = string.format("action|input\n|text|%s", tradeCommand)
            SendPacket(2, tradePacket)
        end

        local usernameWithColor, itemAmount = message:match("`1TRADE CHANGE: `` `(.-)`` added `w(%d+)`` Blue Gem Lock")
        if usernameWithColor and itemAmount then
            local colorCode = usernameWithColor:match("`%w")
            local username = RemoveBoostTag(usernameWithColor:gsub("`[%w!@#$^&wobpqrì]+", ""):gsub("`", ""):gsub("^%d+", ""))
            itemAmount = tonumber(itemAmount)

            local file = io.open("C:/Cobalt/purchase_logs.txt", "r")
            local expectedAmount = 0
            if file then
                expectedAmount = tonumber(file:read("*line")) or 0
                file:close()
            end

            if itemAmount and itemAmount ~= expectedAmount then
                local packet = string.format("action|input\n|text|Please enter the correct amount %d Blue Gem Lock", expectedAmount)
                SendPacket(2, packet)
            elseif itemAmount and itemAmount == expectedAmount then
                local acceptPacket = string.format("action|trade_accept\nstatus|1\nitem|7188|%d", expectedAmount)
                SendPacket(2, acceptPacket)
            end
        end
    end
end

function RemoveBoostTag(usernameWithColor)
    local cleanedUsername = usernameWithColor:gsub("`[%w!@#$^&wobpqrì]+", ""):gsub("`", ""):gsub("^%d+", "")
    cleanedUsername = cleanedUsername:gsub("^@", "")
    return cleanedUsername
end

AddCallback("Trade Hook", "OnVarlist", TradeHook)
AddCallback("check talk bubble", "OnVarlist", function(vlist)
    if vlist[0] == "OnTalkBubble" and vlist[2]:find("Trade accepted by other player") then
        local confirmPacket = "action|dialog_return\ndialog_name|trade\nbuttonClicked|confirm_trade"
        SendPacket(2, confirmPacket)
		SendPacket(2, "action|input\n|text|/warp AUTOPURCHASESCRIPT")
		SendPacket(2, "action|input\n|text|Payment Collected")
        local file = io.open("C:/Cobalt/confirmation.txt", "w")
        if file then
            file:write("confirmed")
            file:close()
        end
    end
end)