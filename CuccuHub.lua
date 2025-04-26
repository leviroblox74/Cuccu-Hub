#CuccuHub.lua
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

BossFarmTab = Window:CreateTab("Boss Farm", 4483362465)
BossFarmTab:CreateButton({
    Name = "Farm All Bosses",
    Callback = function()
        for _,v in pairs(workspace.Enemies:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
                repeat task.wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
                    for _,tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if tool:IsA("Tool") then
                            tool.Parent = game.Players.LocalPlayer.Character
                            tool:Activate()
                        end
                    end
                until not v or v.Humanoid.Health <= 0
            end
        end
    end,
})

DevilFruitTab:CreateToggle({
    Name = "Devil Fruit ESP",
    CurrentValue = false,
    Callback = function(state)
        while state and task.wait(5) do
            for _,v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("Tool") and string.find(v.Name, "Fruit") then
                    local esp = Instance.new("BillboardGui", v)
                    esp.Size = UDim2.new(0,100,0,40)
                    esp.AlwaysOnTop = true
                    local label = Instance.new("TextLabel", esp)
                    label.Text = v.Name
                    label.TextColor3 = Color3.fromRGB(255,0,0)
                    label.Size = UDim2.new(1,0,1,0)
                end
            end
        end
    end
})

DevilFruitTab:CreateButton({
    Name = "Sniper Fruit (Mua Tự Động)",
    Callback = function()
        local fruitShop = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("BuyDevilFruit")
        if fruitShop then
            fruitShop:InvokeServer("Random") -- hoặc nhập tên fruit cụ thể
        end
    end
})

RaidTab:CreateToggle({
    Name = "Auto Start Raid",
    CurrentValue = false,
    Callback = function(val)
        while val and task.wait(3) do
            game:GetService("ReplicatedStorage").Remotes:FindFirstChild("StartRaid"):FireServer("Flame") -- ví dụ
        end
    end
})

RaidTab:CreateToggle({
    Name = "Auto Awaken Skill",
    CurrentValue = false,
    Callback = function(val)
        while val and task.wait(1) do
            local remote = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("AwakenSkill")
            if remote then
                remote:FireServer("Z") -- skill Z awaken
            end
        end
    end
})

ESPTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Callback = function(state)
        while state and task.wait(2) do
            for _,player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    local esp = Instance.new("Highlight", player.Character)
                    esp.FillColor = Color3.fromRGB(255, 50, 50)
                    esp.OutlineColor = Color3.fromRGB(0,0,0)
                end
            end
        end
    end
})

SettingsTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end
})

SettingsTab:CreateButton({
    Name = "Hop Server",
    Callback = function()
        local ts = game:GetService("TeleportService")
        ts:Teleport(game.PlaceId)
    end
})

-- Anti AFK
SettingsTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = true,
    Callback = function(v)
        if v then
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
        end
    end
})

