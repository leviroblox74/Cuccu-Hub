local autofarm = false
AutoFarmTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Flag = "AutoFarmLevel",
    Callback = function(value)
        autofarm = value
        while autofarm and task.wait() do
            pcall(function()
                local quest = "get quest logic here" -- bạn cần bổ sung phần tìm quest theo level
                local mob = "get mob name here"
                local mobPos = CFrame.new(0,0,0) -- thay đổi theo vị trí mob
                if game:GetService("Players").LocalPlayer.Character then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mobPos
                    -- đánh quái
                    for _,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                        if v:IsA("Tool") then
                            v:Activate()
                        end
                    end
                end
            end)
        end
    end,
})

TeleportTab:CreateDropdown({
    Name = "Chọn Địa Điểm",
    Options = {"Jungle", "Pirate Village", "Marine Fortress", "Sky Island"},
    CurrentOption = "Jungle",
    Flag = "TeleportIsland",
    Callback = function(option)
        local pos = {
            ["Jungle"] = CFrame.new(100, 30, -300),
            ["Pirate Village"] = CFrame.new(-200, 10, 500),
            ["Marine Fortress"] = CFrame.new(-1000, 100, 1200),
            ["Sky Island"] = CFrame.new(-500, 500, -800)
        }
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos[option]
    end,
})
