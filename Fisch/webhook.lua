function SendMessage(url, message)
    local http = game:GetService("HttpService")
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local data = {
        ["content"] = message
    }
    local body = http:JSONEncode(data)
    local response = request({
        Url = url,
        Method = "POST",
        Headers = headers,
        Body = body
    })
    print("Sent")
end

function SendMessageEMBED(url, embed)
    local http = game:GetService("HttpService")
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local data = {
        ["embeds"] = {
            {
                ["title"] = embed.title,
                ["description"] = embed.description,
                ["color"] = embed.color,
                ["fields"] = embed.fields,
                ["footer"] = {
                    ["text"] = embed.footer.text
                }
            }
        }
    }
    local body = http:JSONEncode(data)
    local response = request({
        Url = url,
        Method = "POST",
        Headers = headers,
        Body = body
    })
    print("Sent")
end


--Examples 

local url = "https://discord.com/api/webhooks/1302275486340091934/-aaBrn4Ehr89F5Gen557bJsF99m7mWN22fQdQ0I7TlH-N6rlwFs3uXd-Q4u2Tiy9J6-0"
SendMessage(url, game.JobId)


game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, "d5b82dcf-eaad-4502-b5a4-581ae1b8647e", game.Players.LocalPlayer)

game.Players.LocalPlayer.Character:PivotTo(workspace.world.npcs["Travelling Merchant"]:GetPivot())