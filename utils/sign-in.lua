-- Services --
local Services = {
	RunService = cloneref(game:GetService("RunService")),
	Players = cloneref(game:GetService("Players")),
	TweenService = cloneref(game:GetService("TweenService")),
}


--- Sign In UI ---

getgenv().SIGNING_IN = true
local window = {}

-- Instances:

window.Loading = Instance.new("ScreenGui")
window.LoadingFrame = Instance.new("Frame")
window.UIStroke_4 = Instance.new("UIStroke")
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
window.SignUp_2 = Instance.new("TextLabel")
window.Close = Instance.new("ImageButton")
window.UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")

-- Properties:

window.Loading.Name = "Loading"
if Services.RunService:IsStudio() then
	window.Loading.Parent = Services.Players.LocalPlayer:WaitForChild("PlayerGui")
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

window.UIStroke_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
window.UIStroke_4.Color = Color3.fromRGB(161, 161, 161)
window.UIStroke_4.Transparency = 0.48
window.UIStroke_4.Parent = window.LoadingFrame

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
window.username_box.TextScaled = true
window.username_box.TextSize = 15.000
window.username_box.ClearTextOnFocus = false
window.username_box.TextWrapped = true
window.username_box.TextXAlignment = Enum.TextXAlignment.Left

window.UICorner_2.CornerRadius = UDim.new(0, 5)
window.UICorner_2.Parent = window.username_box

window.UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
window.UIStroke_2.Color = Color3.fromRGB(161, 161, 161)
window.UIStroke_2.Transparency = 0.48
window.UIStroke_2.Parent = window.username_box

window.UIPadding.Parent = window.username_box
window.UIPadding.PaddingLeft = UDim.new(0.035, 0)
window.UIPadding.PaddingBottom = UDim.new(0.15, 0)
window.UIPadding.PaddingTop = UDim.new(0.15, 0)

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
window.Description.TextScaled = true
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
window.password_box.TextScaled = true
window.password_box.TextSize = 15.000
window.password_box.ClearTextOnFocus = false
window.password_box.TextWrapped = true
window.password_box.TextXAlignment = Enum.TextXAlignment.Left

window.UICorner_6.CornerRadius = UDim.new(0, 5)
window.UICorner_6.Parent = window.password_box

window.UIStroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
window.UIStroke_3.Color = Color3.fromRGB(161, 161, 161)
window.UIStroke_3.Transparency = 0.48
window.UIStroke_3.Parent = window.password_box

window.UIPadding_3.Parent = window.password_box
window.UIPadding_3.PaddingLeft = UDim.new(0.035, 0)
window.UIPadding_3.PaddingBottom = UDim.new(0.15, 0)
window.UIPadding_3.PaddingTop = UDim.new(0.15, 0)

window.ForgotPassword.Name = "ForgotPassword"
window.ForgotPassword.Parent = window.LoadingFrame
window.ForgotPassword.AnchorPoint = Vector2.new(0.5, 0.5)
window.ForgotPassword.BackgroundTransparency = 1.000
window.ForgotPassword.BorderColor3 = Color3.fromRGB(0, 0, 0)
window.ForgotPassword.BorderSizePixel = 0
window.ForgotPassword.Position = UDim2.new(0.704445958, 0, 0.739839017, 0)
window.ForgotPassword.Size = UDim2.new(0.341108143, 0, 0.0460000001, 0)
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
window.SignUp.Position = UDim2.new(0.721704364, 0, 0.93137908, 0)
window.SignUp.Size = UDim2.new(0.156591237, 0, 0.0460000001, 0)
window.SignUp.Font = Enum.Font.SourceSans
window.SignUp.Text = ""
window.SignUp.TextColor3 = Color3.fromRGB(167, 167, 167)
window.SignUp.TextScaled = true
window.SignUp.TextSize = 14.000
window.SignUp.TextStrokeColor3 = Color3.fromRGB(167, 167, 167)
window.SignUp.TextWrapped = true

window.SignUp_2.Name = "SignUp"
window.SignUp_2.Parent = window.LoadingFrame
window.SignUp_2.AnchorPoint = Vector2.new(0.5, 0.5)
window.SignUp_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
window.SignUp_2.BackgroundTransparency = 1.000
window.SignUp_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
window.SignUp_2.BorderSizePixel = 0
window.SignUp_2.Position = UDim2.new(0.5, 0, 0.930999994, 0)
window.SignUp_2.Size = UDim2.new(0.600000024, 0, 0.0460000001, 0)
window.SignUp_2.Font = Enum.Font.SourceSans
window.SignUp_2.Text = "Don't have an account? <u>Sign Up.</u>"
window.SignUp_2.RichText = true
window.SignUp_2.TextColor3 = Color3.fromRGB(167, 167, 167)
window.SignUp_2.TextScaled = true
window.SignUp_2.TextSize = 14.000
window.SignUp_2.TextWrapped = true

window.Close.Name = "Close"
window.Close.Parent = window.LoadingFrame
window.Close.BackgroundTransparency = 1.000
window.Close.Position = UDim2.new(0.873276711, 0, 0.0385925099, 0)
window.Close.Size = UDim2.new(0, 34, 0, 34)
window.Close.Image = "rbxassetid://8445470984"
window.Close.ImageRectOffset = Vector2.new(304, 304)
window.Close.ImageRectSize = Vector2.new(96, 96)

window.UIAspectRatioConstraint_3.Parent = window.Close
window.UIAspectRatioConstraint_3.DominantAxis = Enum.DominantAxis.Height

-- Interactive Styling:
local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

window.username_box.Focused:Connect(function()
	Services.TweenService:Create(window.UIStroke_2, tweenInfo, { Thickness = 2.5 }):Play()
end)

window.username_box.FocusLost:Connect(function()
	Services.TweenService:Create(window.UIStroke_2, tweenInfo, { Thickness = 1 }):Play()
end)

window.password_box.Focused:Connect(function()
	Services.TweenService:Create(window.UIStroke_3, tweenInfo, { Thickness = 2.5 }):Play()
end)

window.password_box.FocusLost:Connect(function()
	Services.TweenService:Create(window.UIStroke_3, tweenInfo, { Thickness = 1 }):Play()
end)

window.ForgotPassword.MouseEnter:Connect(function()
	window.ForgotPassword.Text = "<u>Forgot Password?</u>"
end)

window.ForgotPassword.MouseLeave:Connect(function()
	window.ForgotPassword.Text = "Forgot Password?"
end)

-- Button Presses:

window.ForgotPassword.MouseButton1Click:Connect(function()
	Notifications:new("Link copied! Open it in your browser.", "link")
	setclipboard("https://cheapkeys.cc/forgot-password")
end)

window.SignUp.MouseButton1Click:Connect(function()
	Notifications:new("Link copied! Open it in your browser.", "link")
	setclipboard("https://cheapkeys.cc/signup")
end)

function window:close()
	Services.TweenService:Create(self.Cover, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0 }):Play()
	task.wait(0.4)
	self.LoadingFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.7)
	task.wait(0.7)

	self.Loading:Destroy()
	getgenv().SIGNING_IN = nil
end

window.Close.MouseButton1Click:Connect(function()
	window:close()
end)

-- Load-In Animation:

window.LoadingFrame:TweenSize(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.7)
task.wait(0.5)
Services.TweenService:Create(window.Cover, TweenInfo.new(0.3, Enum.EasingStyle.Circular, Enum.EasingDirection.In), { BackgroundTransparency = 1 }):Play()


--- Launch Script UI ---

function window:showLaunchUI(scriptInfo)

	-- Cover the window:

	Services.TweenService:Create(self.Cover, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0 }):Play()
	task.wait(0.4)


	-- Remove 'Sign In' UI Contents:

	window.ForgotPassword:Destroy()
	window.SignIn:Destroy()
	window.SignUp:Destroy()
	window.SignUp_2:Destroy()
	window.username_box:Destroy()
	window.password_box:Destroy()
	window.Username:Destroy()
	window.Password:Destroy()
	window.UICorner_6:Destroy()
	window.UIStroke_3:Destroy()
	window.UIPadding_3:Destroy()
	window.UICorner_3:Destroy()
	window.UICorner_2:Destroy()
	window.UIStroke_2:Destroy()
	window.UIPadding:Destroy()

	-- Change Some Titles:

	window.Title.Text = "Loader"
	window.Description.Text = "Select a script from the list below to run."

	-- Instances:

	window.ScrollingFrame = Instance.new("ScrollingFrame")
	window.UICorner = Instance.new("UICorner")
	window.UIStroke = Instance.new("UIStroke")
	window.UIPadding = Instance.new("UIPadding")
	window.UIListLayout = Instance.new("UIListLayout")
	window.Launch = Instance.new("TextButton")
	window.UICorner_2 = Instance.new("UICorner")

	-- Properties:

	window.ScrollingFrame.Parent = window.LoadingFrame
	window.ScrollingFrame.Active = true
	window.ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	window.ScrollingFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
	window.ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	window.ScrollingFrame.BorderSizePixel = 0
	window.ScrollingFrame.Position = UDim2.new(0.497641504, 0, 0.480091006, 0)
	window.ScrollingFrame.Size = UDim2.new(0.75, 0, 0.394, 0)
	window.ScrollingFrame.ScrollBarThickness = 0
	window.ScrollingFrame.ScrollingEnabled = false

	window.UICorner.CornerRadius = UDim.new(0.0299999993, 0)
	window.UICorner.Parent = window.Cover
	task.wait()
	window.UICorner.Parent = window.ScrollingFrame

	window.UIStroke.Parent = window.ScrollingFrame
	window.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	window.UIStroke.Color = Color3.fromRGB(161, 161, 161)
	window.UIStroke.Transparency = 0.48

	window.UIPadding.Parent = window.ScrollingFrame
	window.UIPadding.PaddingBottom = UDim.new(0.00999999978, 0)
	window.UIPadding.PaddingLeft = UDim.new(0.0299999993, 0)
	window.UIPadding.PaddingRight = UDim.new(0.0299999993, 0)
	window.UIPadding.PaddingTop = UDim.new(0.00999999978, 0)

	window.UIListLayout.Parent = window.ScrollingFrame
	window.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	window.UIListLayout.Padding = UDim.new(0.00700000022, 0)

	window.Launch.Name = "Launch"
	window.Launch.Parent = window.LoadingFrame
	window.Launch.AnchorPoint = Vector2.new(0.5, 0)
	window.Launch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	window.Launch.Position = UDim2.new(0.499999851, 0, 0.79655242, 0)
	window.Launch.Size = UDim2.new(0.75000006, 0, 0.0788909867, 0)
	window.Launch.Font = Enum.Font.SourceSans
	window.Launch.Text = "Launch"
	window.Launch.TextColor3 = Color3.fromRGB(0, 0, 0)
	window.Launch.TextSize = 24.000
	window.Launch.TextWrapped = true

	window.UICorner_2.CornerRadius = UDim.new(0.200000003, 0)
	window.UICorner_2.Parent = window.Launch


	-- Load Each Script Frame:

	window.scriptFrames = {}

	for scriptName, info in pairs(scriptInfo) do
		local newFrame = {}

		newFrame.scriptName = scriptName

		-- Instances:

		newFrame.Frame = Instance.new("TextButton")
		newFrame.UIListLayout_2 = Instance.new("UIListLayout")
		newFrame.Name = Instance.new("TextLabel")
		newFrame.Code = Instance.new("ImageLabel")
		newFrame.UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		newFrame.Info = Instance.new("ImageButton")
		newFrame.UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
		newFrame.Separator = Instance.new("Frame")
		newFrame.UIStroke_2  = Instance.new("UIStroke")

		-- Properties:

		newFrame.Frame.Name = "Frame"
		newFrame.Frame.Parent = window.ScrollingFrame
		newFrame.Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		newFrame.Frame.BackgroundTransparency = 1.000
		newFrame.Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		newFrame.Frame.BorderSizePixel = 0
		newFrame.Frame.Size = UDim2.new(1, 0, 0.0520000011, 0)
		newFrame.Frame.Font = Enum.Font.SourceSans
		newFrame.Frame.Text = ""
		newFrame.Frame.TextColor3 = Color3.fromRGB(0, 0, 0)
		newFrame.Frame.TextSize = 14.000
	
		newFrame.UIListLayout_2.Parent = newFrame.Frame
		newFrame.UIListLayout_2.Padding = UDim.new(0.007, 0)
		newFrame.UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
		newFrame.UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
		newFrame.UIListLayout_2.HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween
		newFrame.UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		newFrame.UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
	
		newFrame.Name.Name = "Name"
		newFrame.Name.Parent = newFrame.Frame
		newFrame.Name.AnchorPoint = Vector2.new(0, 0.5)
		newFrame.Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		newFrame.Name.BackgroundTransparency = 1.000
		newFrame.Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
		newFrame.Name.BorderSizePixel = 0
		newFrame.Name.LayoutOrder = 1
		newFrame.Name.Position = UDim2.new(0.218982369, 0, 0.49999997, 0)
		newFrame.Name.Size = UDim2.new(0.566461384, 0, 0.99999994, 0)
		newFrame.Name.Font = Enum.Font.SourceSans
		newFrame.Name.Text = scriptName
		newFrame.Name.RichText = true
		newFrame.Name.TextColor3 = Color3.fromRGB(255, 255, 255)
		newFrame.Name.TextSize = 32.000
		newFrame.Name.TextWrapped = true
		newFrame.Name.TextXAlignment = Enum.TextXAlignment.Left
	
		newFrame.Code.Name = "Code"
		newFrame.Code.Parent = newFrame.Frame
		newFrame.Code.BackgroundTransparency = 1.000
		newFrame.Code.Size = UDim2.new(1, 0, 1, 0)
		newFrame.Code.Image = "rbxassetid://8445470984"
		newFrame.Code.ImageRectOffset = Vector2.new(204, 304)
		newFrame.Code.ImageRectSize = Vector2.new(96, 96)
	
		newFrame.UIAspectRatioConstraint.Parent = newFrame.Code
		newFrame.UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
	
		newFrame.Info.Name = "Info"
		newFrame.Info.Parent = newFrame.Frame
		newFrame.Info.AnchorPoint = Vector2.new(0.5, 0.5)
		newFrame.Info.BackgroundTransparency = 1.000
		newFrame.Info.LayoutOrder = 1
		newFrame.Info.Position = UDim2.new(0.928323507, 0, 0.477675289, 0)
		newFrame.Info.Size = UDim2.new(0, 32, 0, 33)
		newFrame.Info.Image = "rbxassetid://8445471499"
		newFrame.Info.ImageRectOffset = Vector2.new(204, 304)
		newFrame.Info.ImageRectSize = Vector2.new(96, 96)
	
		newFrame.UIAspectRatioConstraint_2.Parent = newFrame.Info
		newFrame.UIAspectRatioConstraint_2.DominantAxis = Enum.DominantAxis.Height
	
		newFrame.Separator.Name = "Separator"
		newFrame.Separator.Parent = window.ScrollingFrame
		newFrame.Separator.AnchorPoint = Vector2.new(1, 0)
		newFrame.Separator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		newFrame.Separator.BackgroundTransparency = 1
		newFrame.Separator.BorderColor3 = Color3.fromRGB(0, 0, 0)
		newFrame.Separator.BorderSizePixel = 0
		newFrame.Separator.Size = UDim2.new(1, 0, 0, 0)
	
		newFrame.UIStroke_2.Parent = newFrame.Separator
		newFrame.UIStroke_2.Color = Color3.new(1, 1, 1)
		newFrame.UIStroke_2.Thickness = 0.5
		newFrame.UIStroke_2.Transparency = 0.36

		-- Button Presses:

		newFrame.Frame.MouseButton1Click:Connect(function()
			for _, frame in pairs(window.scriptFrames) do
				frame.Name.Text = frame.scriptName
			end

			newFrame.Name.Text = string.format("<b>%s</b>", scriptName)
		end)

		newFrame.Info.MouseButton1Click:Connect(function()
			Notifications:new(info.description, "info")
		end)

		table.insert(window.scriptFrames, newFrame)
	end

	-- Reveal New Contents:

	Services.TweenService:Create(window.Cover, TweenInfo.new(0.3, Enum.EasingStyle.Circular, Enum.EasingDirection.In), { BackgroundTransparency = 1 }):Play()
end

return window