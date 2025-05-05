local services = setmetatable({}, {
	__index = function(_, serviceName)
		local success, service = pcall(function()
			return game:GetService(serviceName)
		end)

		return success and service or nil
	end
})



local window = {}

window.Loading = Instance.new("ScreenGui")
window.LoadingFrame = Instance.new("Frame")
window.Title = Instance.new("TextLabel")
window.Cover = Instance.new("Frame")
window.UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
window.UICorner = Instance.new("UICorner")
window.UIStroke = Instance.new("UIStroke")
window.username_box = Instance.new("TextBox")
window.UICorner_2 = Instance.new("UICorner")
window.UIStroke_2 = Instance.new("UIStroke")
window.UIPadding = Instance.new("UIPadding")
window.SignIn = Instance.new("TextButton")
window.UICorner_3 = Instance.new("UICorner")
window.UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
window.UICorner_4 = Instance.new("UICorner")
window.Description = Instance.new("TextLabel")
window.Username = Instance.new("TextLabel")
window.Password = Instance.new("TextLabel")
window.password_box = Instance.new("TextBox")
window.UICorner_6 = Instance.new("UICorner")
window.UIStroke_3 = Instance.new("UIStroke")
window.UIPadding_3 = Instance.new("UIPadding")
window.ForgotPassword = Instance.new("TextButton")
window.SignUp = Instance.new("TextButton")

-- Properties:

window.Loading.Name = "Loading"
if services.RunService:IsStudio() then
	window.Loading.Parent = services.Players.LocalPlayer:WaitForChild("PlayerGui")
else
	window.Loading.Parent = gethui and gethui() or game.CoreGui
end

window.LoadingFrame.Name = "LoadingFrame"
window.LoadingFrame.Parent = window.Loading
window.LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
window.LoadingFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
window.LoadingFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
window.LoadingFrame.ClipsDescendants = true
window.LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

window.Title.Name = "Title"
window.Title.Parent = window.LoadingFrame
window.Title.AnchorPoint = Vector2.new(0.5, 0.5)
window.Title.BackgroundTransparency = 1.000
window.Title.Position = UDim2.new(0.499999851, 0, 0.0886776373, 0)
window.Title.Size = UDim2.new(0.75000006, 0, 0.100056775, 0)
window.Title.Font = Enum.Font.SourceSans
window.Title.Text = "Login"
window.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
window.Title.TextSize = 48.000
window.Title.TextWrapped = true
window.Title.TextXAlignment = Enum.TextXAlignment.Left

window.Cover.Name = "Cover"
window.Cover.Parent = window.LoadingFrame
window.Cover.AnchorPoint = Vector2.new(0.5, 0.5)
window.Cover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
window.Cover.ClipsDescendants = true
window.Cover.Position = UDim2.new(0.499800801, 0, 0.5, 0)
window.Cover.Size = UDim2.new(1, 0, 1, 0)
window.Cover.ZIndex = 2

window.UIAspectRatioConstraint.Parent = window.Cover
window.UIAspectRatioConstraint.AspectRatio = 0.855

window.UICorner.CornerRadius = UDim.new(0.0500000007, 0)
window.UICorner.Parent = window.Cover

window.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
window.UIStroke.Color = Color3.fromRGB(161, 161, 161)
window.UIStroke.Transparency = 0.48
window.UIStroke.Parent = window.Cover

window.username_box.Name = "username_box"
window.username_box.Parent = window.LoadingFrame
window.username_box.AnchorPoint = Vector2.new(0.5, 0)
window.username_box.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
window.username_box.Position = UDim2.new(0.49999997, 0, 0.365305871, 0)
window.username_box.Size = UDim2.new(0.750000298, 0, 0.0626437292, 0)
window.username_box.Font = Enum.Font.SourceSans
window.username_box.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
window.username_box.PlaceholderText = "Username"
window.username_box.Text = ""
window.username_box.TextColor3 = Color3.fromRGB(255, 255, 255)
window.username_box.TextSize = 15.000
window.username_box.TextWrapped = true
window.username_box.TextXAlignment = Enum.TextXAlignment.Left

window.UICorner_2.CornerRadius = UDim.new(0, 5)
window.UICorner_2.Parent = window.username_box

window.UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
window.UIStroke_2.Color = Color3.fromRGB(161, 161, 161)
window.UIStroke_2.Transparency = 0.48
window.UIStroke_2.Parent = window.username_box

window.UIPadding.Parent = window.username_box
window.UIPadding.PaddingLeft = UDim.new(0, 10)

window.SignIn.Name = "SignIn"
window.SignIn.Parent = window.LoadingFrame
window.SignIn.AnchorPoint = Vector2.new(0.5, 0)
window.SignIn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
window.SignIn.Position = UDim2.new(0.499999851, 0, 0.79655242, 0)
window.SignIn.Size = UDim2.new(0.75000006, 0, 0.0788909867, 0)
window.SignIn.Font = Enum.Font.SourceSans
window.SignIn.Text = "Sign In"
window.SignIn.TextColor3 = Color3.fromRGB(0, 0, 0)
window.SignIn.TextSize = 24.000
window.SignIn.TextWrapped = true

window.UICorner_3.CornerRadius = UDim.new(0.200000003, 0)
window.UICorner_3.Parent = window.SignIn

window.UIAspectRatioConstraint_2.Parent = window.LoadingFrame
window.UIAspectRatioConstraint_2.AspectRatio = 0.855

window.UICorner_4.CornerRadius = UDim.new(0.0500000007, 0)
window.UICorner_4.Parent = window.LoadingFrame

window.Description.Name = "Description"
window.Description.Parent = window.LoadingFrame
window.Description.AnchorPoint = Vector2.new(0.5, 0.5)
window.Description.BackgroundTransparency = 1.000
window.Description.Position = UDim2.new(0.499999851, 0, 0.197644725, 0)
window.Description.Size = UDim2.new(0.75000006, 0, 0.0818955973, 0)
window.Description.Font = Enum.Font.SourceSans
window.Description.Text = "Enter your Cheap Keys username and password below to login."
window.Description.TextColor3 = Color3.fromRGB(167, 167, 167)
window.Description.TextSize = 16.000
window.Description.TextWrapped = true
window.Description.TextXAlignment = Enum.TextXAlignment.Left

window.Username.Name = "Username"
window.Username.Parent = window.LoadingFrame
window.Username.AnchorPoint = Vector2.new(0.5, 0.5)
window.Username.BackgroundTransparency = 1.000
window.Username.Position = UDim2.new(0.499999851, 0, 0.322502851, 0)
window.Username.Size = UDim2.new(0.75000006, 0, 0.0546538271, 0)
window.Username.Font = Enum.Font.SourceSans
window.Username.Text = "Username"
window.Username.TextColor3 = Color3.fromRGB(255, 255, 255)
window.Username.TextScaled = true
window.Username.TextSize = 16.000
window.Username.TextWrapped = true
window.Username.TextXAlignment = Enum.TextXAlignment.Left

window.Password.Name = "Password"
window.Password.Parent = window.LoadingFrame
window.Password.AnchorPoint = Vector2.new(0.5, 0.5)
window.Password.BackgroundTransparency = 1.000
window.Password.Position = UDim2.new(0.499999851, 0, 0.540436983, 0)
window.Password.Size = UDim2.new(0.75000006, 0, 0.0546538271, 0)
window.Password.Font = Enum.Font.SourceSans
window.Password.Text = "Password"
window.Password.TextColor3 = Color3.fromRGB(255, 255, 255)
window.Password.TextScaled = true
window.Password.TextSize = 16.000
window.Password.TextWrapped = true
window.Password.TextXAlignment = Enum.TextXAlignment.Left

window.password_box.Name = "password_box"
window.password_box.Parent = window.LoadingFrame
window.password_box.AnchorPoint = Vector2.new(0.5, 0)
window.password_box.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
window.password_box.Position = UDim2.new(0.49999997, 0, 0.583240032, 0)
window.password_box.Size = UDim2.new(0.750000298, 0, 0.0626437292, 0)
window.password_box.Font = Enum.Font.SourceSans
window.password_box.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
window.password_box.Text = ""
window.password_box.TextColor3 = Color3.fromRGB(255, 255, 255)
window.password_box.TextSize = 15.000
window.password_box.TextWrapped = true
window.password_box.TextXAlignment = Enum.TextXAlignment.Left

window.UICorner_6.CornerRadius = UDim.new(0, 5)
window.UICorner_6.Parent = window.password_box

window.UIStroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
window.UIStroke_3.Color = Color3.fromRGB(161, 161, 161)
window.UIStroke_3.Transparency = 0.48
window.UIStroke_3.Parent = window.password_box

window.UIPadding_3.Parent = window.password_box
window.UIPadding_3.PaddingLeft = UDim.new(0, 10)

window.ForgotPassword.Name = "ForgotPassword"
window.ForgotPassword.Parent = window.LoadingFrame
window.ForgotPassword.AnchorPoint = Vector2.new(0.5, 0.5)
window.ForgotPassword.BackgroundTransparency = 1.000
window.ForgotPassword.BorderColor3 = Color3.fromRGB(0, 0, 0)
window.ForgotPassword.BorderSizePixel = 0
window.ForgotPassword.Position = UDim2.new(0.499999851, 0, 0.739839017, 0)
window.ForgotPassword.Size = UDim2.new(0.75, 0, 0.0460000001, 0)
window.ForgotPassword.Font = Enum.Font.SourceSans
window.ForgotPassword.Text = "Forgot Password?"
window.ForgotPassword.RichText = true
window.ForgotPassword.TextColor3 = Color3.fromRGB(225, 225, 225)
window.ForgotPassword.TextScaled = true
window.ForgotPassword.TextSize = 14.000
window.ForgotPassword.TextWrapped = true
window.ForgotPassword.TextXAlignment = Enum.TextXAlignment.Right

window.SignUp.Name = "SignUp"
window.SignUp.Parent = window.LoadingFrame
window.SignUp.AnchorPoint = Vector2.new(0.5, 0.5)
window.SignUp.BackgroundTransparency = 1.000
window.SignUp.BorderColor3 = Color3.fromRGB(0, 0, 0)
window.SignUp.BorderSizePixel = 0
window.SignUp.Position = UDim2.new(0.499999851, 0, 0.93137908, 0)
window.SignUp.Size = UDim2.new(0.75, 0, 0.0460000001, 0)
window.SignUp.Font = Enum.Font.SourceSans
window.SignUp.Text = "Don't have an account? <u>Sign Up</u>."
window.SignUp.RichText = true
window.SignUp.TextColor3 = Color3.fromRGB(167, 167, 167)
window.SignUp.TextScaled = true
window.SignUp.TextSize = 14.000
window.SignUp.TextStrokeColor3 = Color3.fromRGB(167, 167, 167)
window.SignUp.TextWrapped = true

-- Interactive Styling:
local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

window.username_box.Focused:Connect(function()
	services.TweenService:Create(window.UIStroke_2, tweenInfo, { Thickness = 2.5 }):Play()
end)

window.username_box.FocusLost:Connect(function()
	services.TweenService:Create(window.UIStroke_2, tweenInfo, { Thickness = 1 }):Play()
end)

window.password_box.Focused:Connect(function()
	services.TweenService:Create(window.UIStroke_3, tweenInfo, { Thickness = 2.5 }):Play()
end)

window.password_box.FocusLost:Connect(function()
	services.TweenService:Create(window.UIStroke_3, tweenInfo, { Thickness = 1 }):Play()
end)

window.ForgotPassword.MouseEnter:Connect(function()
	window.ForgotPassword.Text = "<u>Forgot Password?</u>"
end)

window.ForgotPassword.MouseLeave:Connect(function()
	window.ForgotPassword.Text = "Forgot Password?"
end)

-- Button Presses:

window.ForgotPassword.MouseButton1Click:Connect(function()
	services.StarterGui:SetCore("SendNotification", {
		Title = "Forgot Password",
		Text = "Link copied! Open it in your browser.",
		Duration = 3,
	})
	
	setclipboard("https://cheapkeys.cc/forgot-password")
end)

window.SignUp.MouseButton1Click:Connect(function()
	services.StarterGui:SetCore("SendNotification", {
		Title = "Sign Up",
		Text = "Link copied! Open it in your browser.",
		Duration = 3,
	})
	
	setclipboard("https://cheapkeys.cc/signup")
end)

-- Load-In Animation:

window.LoadingFrame:TweenSize(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.7)
task.wait(0.5)
services.TweenService:Create(window.Cover, TweenInfo.new(0.3, Enum.EasingStyle.Circular, Enum.EasingDirection.In), { BackgroundTransparency = 1 }):Play()

return window