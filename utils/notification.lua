local services = setmetatable({}, {
	__index = function(_, serviceName)
		local success, service = pcall(function()
			return cloneref(game:GetService(serviceName))
		end)

		return success and service or nil
	end
})



local Notifications = {}

Notifications.list = {}

Notifications.icons = {
    info = {
        assetId = "rbxassetid://8445471499",
        rectOffset = Vector2.new(304, 104),
    },
    check = {
        assetId = "rbxassetid://8445471173",
        rectOffset = Vector2.new(404, 604),
    },
    error = {
        assetId = "rbxassetid://8445470559",
        rectOffset = Vector2.new(404, 504),
    },
    bell = {
        assetId = "rbxassetid://8445471332",
        rectOffset = Vector2.new(4, 504),
    },
    link = {
        assetId = "rbxassetid://8445470392",
        rectOffset = Vector2.new(104, 404),
    },
}

function Notifications:new(message: string, icon: "info" | "check"? | "error"? | "bell"?)
    icon = self.icons[icon] or self.icons.info

    local newNotif = {}

    newNotif.Notification = Instance.new("ScreenGui")
    newNotif.Frame = Instance.new("Frame")
    newNotif.UICorner = Instance.new("UICorner")
    newNotif.Icon = Instance.new("ImageLabel")
    newNotif.UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    newNotif.UIPadding = Instance.new("UIPadding")
    newNotif.UIStroke = Instance.new("UIStroke")
    newNotif.message = Instance.new("TextLabel")
    newNotif.mouseLeaveDetection = Instance.new("Frame")
    
    newNotif.Notification.Name = "Notification"
    newNotif.Notification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    if services.RunService:IsStudio() then
        newNotif.Notification.Parent = services.Players.LocalPlayer:WaitForChild("PlayerGui")
    else
        newNotif.Notification.Parent = gethui and gethui() or game.CoreGui
    end
    
    newNotif.Frame.Parent = newNotif.Notification
    newNotif.Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    newNotif.Frame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    newNotif.Frame.BackgroundTransparency = 1
    newNotif.Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    newNotif.Frame.BorderSizePixel = 0
    newNotif.Frame.Position = UDim2.new(0.899999993, 0, 1.03499997, 0)
    newNotif.Frame.Size = UDim2.new(0.150529165, 0, 0.0534090921, 0)
    
    newNotif.UICorner.CornerRadius = UDim.new(0.15, 0)
    newNotif.UICorner.Parent = newNotif.Frame
    
    newNotif.Icon.Name = "Icon"
    newNotif.Icon.Parent = newNotif.Frame
    newNotif.Icon.AnchorPoint = Vector2.new(0.5, 0.5)
    newNotif.Icon.BackgroundTransparency = 1.000
    newNotif.Icon.Position = UDim2.new(-0, 0, 0.5, 0)
    newNotif.Icon.Size = UDim2.new(0.0604347773, 0, 0.47319147, 0)
    newNotif.Icon.Image = icon.assetId
    newNotif.Icon.ImageRectOffset = icon.rectOffset
    newNotif.Icon.ImageRectSize = Vector2.new(96, 96)
    newNotif.Icon.ImageTransparency = 1
    
    newNotif.UIAspectRatioConstraint.Parent = newNotif.Icon
    newNotif.UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
    
    newNotif.UIPadding.Parent = newNotif.Frame
    newNotif.UIPadding.PaddingLeft = UDim.new(0.0799999982, 0)
    
    newNotif.UIStroke.Parent = newNotif.Frame
    newNotif.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    newNotif.UIStroke.Color = Color3.fromRGB(161, 161, 161)
    newNotif.UIStroke.Transparency = 1
    
    newNotif.message.Name = "message"
    newNotif.message.Parent = newNotif.Frame
    newNotif.message.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    newNotif.message.BackgroundTransparency = 1.000
    newNotif.message.BorderColor3 = Color3.fromRGB(0, 0, 0)
    newNotif.message.BorderSizePixel = 0
    newNotif.message.Position = UDim2.new(0.0733131766, 0, 0, 0)
    newNotif.message.Size = UDim2.new(0.866412938, 0, 1, 0)
    newNotif.message.Font = Enum.Font.SourceSansBold
    newNotif.message.Text = message
    newNotif.message.TextColor3 = Color3.fromRGB(255, 255, 255)
    newNotif.message.TextSize = 16.000
    newNotif.message.TextXAlignment = Enum.TextXAlignment.Left
    newNotif.message.TextTransparency = 1

    newNotif.mouseLeaveDetection.Name = "MouseLeaveDetection"
    newNotif.mouseLeaveDetection.Parent = newNotif.Notification
    newNotif.mouseLeaveDetection.AnchorPoint = Vector2.new(0.5, 0.5)
    newNotif.mouseLeaveDetection.BackgroundTransparency = 1
    newNotif.mouseLeaveDetection.BorderSizePixel = 0
    newNotif.mouseLeaveDetection.Position = UDim2.new(0.899999976, 0, 0.886240005, 0)
    newNotif.mouseLeaveDetection.Size = UDim2.new(0.150529161, 0, 0.201000005, 0)
    newNotif.mouseLeaveDetection.ZIndex = 5
    
    newNotif.lifetime = 4.5


    
    function newNotif:destroy(stationary)
        self.destroying = true

        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        if not stationary then
            services.TweenService:Create(self.Icon, tweenInfo, { ImageTransparency = 0 }):Play()
            services.TweenService:Create(self.message, tweenInfo, { TextTransparency = 0 }):Play()
            task.wait(0.3)
        end

        services.TweenService:Create(self.Icon, tweenInfo, { ImageTransparency = 1 }):Play()
        services.TweenService:Create(self.message, tweenInfo, { TextTransparency = 1 }):Play()
        services.TweenService:Create(self.UIStroke, tweenInfo, { Transparency = 1 }):Play()

        local position = self.Frame.Position
        services.TweenService:Create(self.Frame, tweenInfo, {
            Position = not stationary and UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale * 1.05, position.Y.Offset) or nil,
            BackgroundTransparency = 1,
        }):Play()

        task.delay(0.3, function()
            self.Notification:Destroy()
        end)
    end
    
    task.spawn(function()
        while true do
            task.wait(0.5)
    
            if not Notifications.mouseIsOn then
                newNotif.lifetime -= 0.5
    
                if newNotif.lifetime <= 0 then
                    newNotif:destroy()
                    return
                end
            end
        end
    end)



    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    newNotif.Frame.MouseEnter:Connect(function()
        if Notifications.mouseIsOn then
            return
        end

        local originalPosition = Notifications.list[1].Frame.Position
        local originalSize = Notifications.list[1].Frame.Size
        local lastTargetYScale = originalPosition.Y.Scale * 0.928

        Notifications.mouseIsOn = true

        for index, notif in ipairs(Notifications.list) do
            if notif.destroying then
                continue
            end

            if index == 1 then
                lastTargetYScale = originalPosition.Y.Scale * 0.99
            else
                services.TweenService:Create(notif.Icon, tweenInfo, { ImageTransparency = 0 }):Play()
                services.TweenService:Create(notif.message, tweenInfo, { TextTransparency = 0 }):Play()
            end

            services.TweenService:Create(notif.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(originalPosition.X.Scale, originalPosition.X.Offset, lastTargetYScale, originalPosition.Y.Offset),
                Size = originalSize,
            }):Play()

            lastTargetYScale *= 0.928
        end
    end)

    newNotif.mouseLeaveDetection.MouseLeave:Connect(function()
        Notifications.mouseIsOn = false
        
        for index, notif in ipairs(Notifications.list) do
            if notif.destroying then
                continue
            end

            if index > 1 then
                services.TweenService:Create(notif.Icon, tweenInfo, { ImageTransparency = 1 }):Play()
                services.TweenService:Create(notif.message, tweenInfo, { TextTransparency = 1 }):Play()
            end

            services.TweenService:Create(notif.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = notif.currentPosition,
                Size = notif.currentSize,
            }):Play()
        end
    end)

    table.insert(self.list, 1, newNotif)

    for index, notif in ipairs(Notifications.list) do
        local targetPosition = notif.currentPosition or notif.Frame.Position
        local targetSize = notif.currentSize or notif.Frame.Size

        if index == 1 then
            services.TweenService:Create(notif.Icon, tweenInfo, { ImageTransparency = 0 }):Play()
            services.TweenService:Create(notif.message, tweenInfo, { TextTransparency = 0 }):Play()
            services.TweenService:Create(notif.UIStroke, tweenInfo, { Transparency = 0.36 }):Play()

            targetPosition = UDim2.new(0.899999993, 0, 0.955, 0)

            services.TweenService:Create(notif.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = targetPosition,
                BackgroundTransparency = 0,
            }):Play()
        else
            local position = notif.currentPosition
            local size = notif.currentSize

            services.TweenService:Create(notif.Icon, tweenInfo, { ImageTransparency = 1 }):Play()
            services.TweenService:Create(notif.message, tweenInfo, { TextTransparency = 1 }):Play()

            targetPosition = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale * 0.988, position.Y.Offset)
            targetSize = UDim2.new(size.X.Scale * 0.93, size.X.Offset, size.Y.Scale, size.Y.Offset)

            services.TweenService:Create(notif.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = targetPosition,
                Size = targetSize,
            }):Play()
        end

        notif.currentPosition = targetPosition
        notif.currentSize = targetSize

        if index > 3 then
            notif:destroy(true)
        end
    end
end

return Notifications