local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local Event = ReplicatedStorage.Remotes.ServerEvents
local ClientEvent = ReplicatedStorage.Remotes.ClientEvents

local DOT_SPEED = 0.125
local TYPE_SPEED = 0.045
local MAX_PHRASE_LENGTH = 20
local PICKUP_WAIT = 1.25
local DOTS_ENABLED = true

local executionSound = Instance.new("Sound")
executionSound.Name = "OthHubExecutionSound"
executionSound.SoundId = "rbxassetid://2866718318"
executionSound.Volume = 1
executionSound.Parent = SoundService

pcall(function()
    executionSound:Play()
end)

executionSound.Ended:Connect(function()
    executionSound:Destroy()
end)

local ColorIndex = require(
    ReplicatedStorage
        :WaitForChild("Modules")
        :WaitForChild("Index")
        :WaitForChild("ColorIndex")
)

local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("TypeGUI")

if oldGui then
    oldGui:Destroy()
end

local function removeOldFunnyTools()
    local backpack = player:FindFirstChildOfClass("Backpack")

    if backpack then
        local oldTool = backpack:FindFirstChild("AHHHIMDYINGXD")

        if oldTool then
            oldTool:Destroy()
        end
    end

    local character = player.Character

    if character then
        local oldTool = character:FindFirstChild("AHHHIMDYINGXD")

        if oldTool then
            oldTool:Destroy()
        end
    end
end

removeOldFunnyTools()

pcall(function()
    firesignal(
        ClientEvent.OnClientEvent,
        "Hint",
        "othhub on top"
    )
end)

local PhraseCategories = {
    Normal = {
        "Hello there!",
        "How are you?",
        "What happened?",
        "Wait, what?",
        "Never mind.",
        "That's weird.",
        "Hello everyone!",
        "I have returned.",
        "Well, this is odd.",
        "Are we there yet?",
        "Don't worry.",
        "Interesting...",
        "What's going on?",
        "I forgot.",
        "Be right back!",
        "Goodbye!",
        "See you later!",
        "Anyone here?",
        "Give me a second."
    },

    Scary = {
        "Did you hear that?",
        "Something is wrong.",
        "Who's watching us?",
        "Don't look behind.",
        "Something moved.",
        "Did you see that?",
        "We need to leave.",
        "Why is it quiet?",
        "I heard something.",
        "Someone is here.",
        "Stay close to me.",
        "That wasn't me.",
        "Who's there?",
        "I saw something.",
        "Turn around slowly.",
        "Did that just move?",
        "Keep it closed."
    },

    Anxious = {
        "What do I do?",
        "Is everyone okay?",
        "Something feels off.",
        "Can we leave?",
        "Wait, wait...",
        "I'm getting nervous.",
        "Are you sure?",
        "I don't like this.",
        "What's happening?",
        "Please don't.",
        "Can we go back?",
        "Bad feeling...",
        "Are we safe?",
        "Stay calm.",
        "Something isn't right.",
        "Maybe we should go."
    },

    Confused = {
        "What?",
        "What just happened?",
        "I don't understand.",
        "Where are we?",
        "Why are we here?",
        "Wait... what?",
        "Did I miss something?",
        "What's going on?",
        "Who did that?",
        "Where did they go?",
        "Is this normal?",
        "I'm so confused.",
        "What are we doing?",
        "Why did that happen?",
        "Did anyone see that?",
        "What's happening?"
    },

    Angry = {
        "What are you doing?",
        "Stop it!",
        "Leave me alone.",
        "Seriously?",
        "Are you kidding?",
        "Don't touch that.",
        "Stop right now.",
        "Back off.",
        "What was that for?",
        "Enough already.",
        "Why did you do that?",
        "Just stop.",
        "Don't do that.",
        "Can you stop?",
        "That's enough.",
        "Leave it alone."
    },

    Sad = {
        "I miss them.",
        "I don't know.",
        "Nothing feels right.",
        "I want to go home.",
        "I don't feel like it.",
        "Things are different.",
        "I wish I knew.",
        "Maybe we should leave.",
        "I don't want to stay.",
        "I feel so lost.",
        "I wish things changed.",
        "I don't know why.",
        "Maybe it's too late.",
        "I wish you were here."
    },

    Mysterious = {
        "They know.",
        "It's too late.",
        "Don't ask questions.",
        "I wouldn't go there.",
        "Something is waiting.",
        "Keep your voice down.",
        "We shouldn't be here.",
        "You saw nothing.",
        "Don't tell anyone.",
        "They're watching.",
        "Don't trust anyone.",
        "You'll understand.",
        "It's not what you think.",
        "Something happened here.",
        "They're listening.",
        "Forget you saw that."
    }
}

for categoryName, phrases in pairs(PhraseCategories) do
    for index, phrase in ipairs(phrases) do
        PhraseCategories[categoryName][index] =
            string.sub(phrase, 1, MAX_PHRASE_LENGTH)
    end
end

local PickupCategories = {
    Smooth = {
        {
            "yoo 👀",
            "had to say hi lol"
        },
        {
            "u seem really cool",
            "wanna talk?"
        },
        {
            "u caught my eye",
            "so i had to say hi"
        },
        {
            "u seem nice :)",
            "wanna be friends?"
        },
        {
            "u seem fun ngl",
            "what do u go by?"
        },
        {
            "ur kinda adorable",
            "can i say hi?"
        },
        {
            "u seem chill fr",
            "wanna chat?"
        },
        {
            "i like ur vibe",
            "wanna talk?"
        },
        {
            "ur energy is nice",
            "can we be friends?"
        },
        {
            "u seem worth it",
            "so hey lol"
        },
        {
            "u seem so chill",
            "mind if i talk?"
        },
        {
            "ur vibe caught me",
            "had to say hi"
        }
    },

    Funny = {
        {
            "nice avatar",
            "where'd u get it?"
        },
        {
            "cool username lol",
            "i respect it"
        },
        {
            "sooo hey",
            "hru lol 👀"
        },
        {
            "u seem cutie",
            "actually though"
        },
        {
            "whaddup buttercup",
            "how u doing"
        },
        {
            "ok ur funny",
            "had to say hi"
        },
        {
            "u a cutie lol 👀",
            "i cant lie"
        },
        {
            "sooo hyd lol👀👀",
            "whats up?"
        },
        {
            "ok quick question",
            "are u always funny?"
        },
        {
            "i need ur opinion",
            "do i seem cool"
        },
        {
            "whats goin on here",
            "lemme get in on ts"
        },
        {
            "i was gonna say hi",
            "then i got nervous"
        }
    },

    Cheesy = {
        {
            "are u always cute?",
            "or just today?"
        },
        {
            "u seem interesting",
            "whats ur name?"
        },
        {
            "u seem pretty fun",
            "wanna play sometime?"
        },
        {
            "i like ur style",
            "u got good taste"
        },
        {
            "u seem too nice",
            "is this real?"
        },
        {
            "yo bro ngl",
            "we should be friends"
        },
        {
            "u seem familiar",
            "have we met?"
        },
        {
            "u got good vibes",
            "whats ur secret?"
        },
        {
            "u seem coolio",
            "can i say hi?"
        },
        {
            "quick question",
            "whats ur name?"
        },
        {
            "u seem pretty cool",
            "mind if i chat?"
        },
        {
            "is this fate",
            "or good timing?"
        }
    },

    Compliments = {
        {
            "ur really cute",
            "had to tell u"
        },
        {
            "u have good vibes",
            "i like ur energy"
        },
        {
            "ur pretty chill",
            "thats actually rare"
        },
        {
            "ur genuinely cool",
            "respect honestly"
        },
        {
            "u seem really nice",
            "had to say hi"
        },
        {
            "i like ur style",
            "it looks really good"
        },
        {
            "ur vibe is great",
            "wanna talk?"
        },
        {
            "u seem super chill",
            "can we chat?"
        },
        {
            "u got great energy",
            "had to say hi"
        },
        {
            "ur personality seems",
            "really cool tbh"
        },
        {
            "u seem easygoing",
            "i like that"
        },
        {
            "u seem really fun",
            "wanna talk?"
        }
    }
}

for categoryName, sequences in pairs(PickupCategories) do
    for sequenceIndex, sequence in ipairs(sequences) do
        for lineIndex, line in ipairs(sequence) do
            PickupCategories[categoryName][sequenceIndex][lineIndex] =
                string.sub(line, 1, MAX_PHRASE_LENGTH)
        end
    end
end

local gui = Instance.new("ScreenGui")
gui.Name = "TypeGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 400, 0, 400)
frame.Position = UDim2.new(0.5, -200, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.BorderSizePixel = 0
title.Text = "OthHub V1 [QOL]"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 22
title.Font = Enum.Font.SourceSansBold
title.Parent = frame

local function createTab(text, position)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(0.2, -4, 0, 35)
    tab.Position = position
    tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tab.BorderSizePixel = 0
    tab.Text = text
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.TextSize = 14
    tab.Font = Enum.Font.SourceSansBold
    tab.Parent = frame

    return tab
end

local slowTypeTab = createTab(
    "Slow Type",
    UDim2.new(0, 0, 0, 40)
)

local colorsTab = createTab(
    "Colors",
    UDim2.new(0.2, 1, 0, 40)
)

local funnyTab = createTab(
    "Extra Tab",
    UDim2.new(0.4, 2, 0, 40)
)

local pickupTab = createTab(
    "Pickup Lines",
    UDim2.new(0.6, 3, 0, 40)
)

local settingsTab = createTab(
    "Settings",
    UDim2.new(0.8, 4, 0, 40)
)

local function createPage(name)
    local page = Instance.new("Frame")
    page.Name = name
    page.Size = UDim2.new(1, 0, 1, -75)
    page.Position = UDim2.new(0, 0, 0, 75)
    page.BackgroundTransparency = 1
    page.Parent = frame

    return page
end

local slowTypePage = createPage("SlowTypePage")
local colorsPage = createPage("ColorsPage")
local funnyPage = createPage("FunnyPage")
local pickupPage = createPage("PickupPage")
local settingsPage = createPage("SettingsPage")

colorsPage.Visible = false
funnyPage.Visible = false
pickupPage.Visible = false
settingsPage.Visible = false

local messageBox = Instance.new("TextBox")
messageBox.Name = "MessageBox"
messageBox.Size = UDim2.new(1, -40, 0, 50)
messageBox.Position = UDim2.new(0, 20, 0, 20)
messageBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
messageBox.BorderSizePixel = 0
messageBox.PlaceholderText = "Type what you wanna say!"
messageBox.PlaceholderColor3 = Color3.fromRGB(160, 160, 160)
messageBox.Text = ""
messageBox.TextColor3 = Color3.fromRGB(255, 255, 255)
messageBox.TextSize = 16
messageBox.ClearTextOnFocus = false
messageBox.Parent = slowTypePage

local preview = Instance.new("TextLabel")
preview.Size = UDim2.new(1, -40, 0, 35)
preview.Position = UDim2.new(0, 20, 0, 80)
preview.BackgroundTransparency = 1
preview.Text = "..."
preview.TextColor3 = Color3.fromRGB(200, 200, 200)
preview.TextSize = 18
preview.Font = Enum.Font.SourceSansItalic
preview.TextTruncate = Enum.TextTruncate.AtEnd
preview.Parent = slowTypePage

messageBox:GetPropertyChangedSignal("Text"):Connect(function()
    if #messageBox.Text > MAX_PHRASE_LENGTH then
        messageBox.Text =
            string.sub(messageBox.Text, 1, MAX_PHRASE_LENGTH)
    end

    preview.Text =
        messageBox.Text ~= "" and messageBox.Text or "..."
end)

local button = Instance.new("TextButton")
button.Name = "SayButton"
button.Size = UDim2.new(1, -40, 0, 45)
button.Position = UDim2.new(0, 20, 0, 125)
button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
button.BorderSizePixel = 0
button.Text = "Say!"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 18
button.Font = Enum.Font.SourceSansBold
button.Parent = slowTypePage

local randomButton = Instance.new("TextButton")
randomButton.Name = "RandomButton"
randomButton.Size = UDim2.new(1, -40, 0, 45)
randomButton.Position = UDim2.new(0, 20, 0, 180)
randomButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
randomButton.BorderSizePixel = 0
randomButton.Text = "Random Normal phrase!"
randomButton.TextColor3 = Color3.fromRGB(255, 255, 255)
randomButton.TextSize = 18
randomButton.Font = Enum.Font.SourceSansBold
randomButton.Parent = slowTypePage

local phraseTabs = Instance.new("ScrollingFrame")
phraseTabs.Name = "PhraseTabs"
phraseTabs.Size = UDim2.new(1, -40, 0, 50)
phraseTabs.Position = UDim2.new(0, 20, 0, 235)
phraseTabs.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
phraseTabs.BorderSizePixel = 0
phraseTabs.ScrollBarThickness = 4
phraseTabs.ScrollingDirection = Enum.ScrollingDirection.X
phraseTabs.CanvasSize = UDim2.new(0, 0, 0, 0)
phraseTabs.Parent = slowTypePage

local phraseTabLayout = Instance.new("UIListLayout")
phraseTabLayout.FillDirection = Enum.FillDirection.Horizontal
phraseTabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
phraseTabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
phraseTabLayout.Padding = UDim.new(0, 5)
phraseTabLayout.Parent = phraseTabs

local phraseTabPadding = Instance.new("UIPadding")
phraseTabPadding.PaddingLeft = UDim.new(0, 5)
phraseTabPadding.PaddingRight = UDim.new(0, 5)
phraseTabPadding.Parent = phraseTabs

local selectedCategory = "Normal"
local categoryButtons = {}

local function updatePhraseTabCanvas()
    phraseTabs.CanvasSize = UDim2.new(
        0,
        phraseTabLayout.AbsoluteContentSize.X + 10,
        0,
        0
    )
end

phraseTabLayout:GetPropertyChangedSignal(
    "AbsoluteContentSize"
):Connect(updatePhraseTabCanvas)

local function updatePhraseTabs()
    for categoryName, tab in pairs(categoryButtons) do
        tab.BackgroundColor3 =
            categoryName == selectedCategory
            and Color3.fromRGB(70, 70, 70)
            or Color3.fromRGB(40, 40, 40)
    end

    randomButton.Text =
        "Random " .. selectedCategory .. " phrase!"
end

local categoryOrder = {
    "Normal",
    "Scary",
    "Anxious",
    "Confused",
    "Angry",
    "Sad",
    "Mysterious"
}

for index, categoryName in ipairs(categoryOrder) do
    local tab = Instance.new("TextButton")
    tab.Name = categoryName .. "Tab"
    tab.Size = UDim2.new(0, 90, 0, 35)
    tab.LayoutOrder = index
    tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tab.BorderSizePixel = 0
    tab.Text = categoryName
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.TextSize = 15
    tab.Font = Enum.Font.SourceSansBold
    tab.Parent = phraseTabs

    categoryButtons[categoryName] = tab

    tab.MouseButton1Click:Connect(function()
        selectedCategory = categoryName
        updatePhraseTabs()
    end)
end

updatePhraseTabCanvas()
updatePhraseTabs()

local pickupTitle = Instance.new("TextLabel")
pickupTitle.Size = UDim2.new(1, -40, 0, 40)
pickupTitle.Position = UDim2.new(0, 20, 0, 15)
pickupTitle.BackgroundTransparency = 1
pickupTitle.Text = "Pickup Lines"
pickupTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
pickupTitle.TextSize = 24
pickupTitle.Font = Enum.Font.SourceSansBold
pickupTitle.TextXAlignment = Enum.TextXAlignment.Left
pickupTitle.Parent = pickupPage

local pickupPreview = Instance.new("TextLabel")
pickupPreview.Size = UDim2.new(1, -40, 0, 70)
pickupPreview.Position = UDim2.new(0, 20, 0, 60)
pickupPreview.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
pickupPreview.BorderSizePixel = 0
pickupPreview.Text = "Press a button..."
pickupPreview.TextColor3 = Color3.fromRGB(220, 220, 220)
pickupPreview.TextSize = 18
pickupPreview.TextWrapped = true
pickupPreview.Font = Enum.Font.SourceSans
pickupPreview.Parent = pickupPage

local pickupCategoryFrame = Instance.new("ScrollingFrame")
pickupCategoryFrame.Size = UDim2.new(1, -40, 0, 45)
pickupCategoryFrame.Position = UDim2.new(0, 20, 0, 145)
pickupCategoryFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
pickupCategoryFrame.BorderSizePixel = 0
pickupCategoryFrame.ScrollBarThickness = 4
pickupCategoryFrame.ScrollingDirection = Enum.ScrollingDirection.X
pickupCategoryFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
pickupCategoryFrame.Parent = pickupPage

local pickupLayout = Instance.new("UIListLayout")
pickupLayout.FillDirection = Enum.FillDirection.Horizontal
pickupLayout.VerticalAlignment = Enum.VerticalAlignment.Center
pickupLayout.Padding = UDim.new(0, 5)
pickupLayout.Parent = pickupCategoryFrame

local pickupPadding = Instance.new("UIPadding")
pickupPadding.PaddingLeft = UDim.new(0, 5)
pickupPadding.PaddingRight = UDim.new(0, 5)
pickupPadding.Parent = pickupCategoryFrame

local selectedPickupCategory = "Smooth"
local pickupCategoryButtons = {}

local pickupOrder = {
    "Smooth",
    "Funny",
    "Cheesy",
    "Compliments"
}

local function updatePickupCanvas()
    pickupCategoryFrame.CanvasSize = UDim2.new(
        0,
        pickupLayout.AbsoluteContentSize.X + 10,
        0,
        0
    )
end

pickupLayout:GetPropertyChangedSignal(
    "AbsoluteContentSize"
):Connect(updatePickupCanvas)

local function updatePickupCategories()
    for categoryName, tab in pairs(pickupCategoryButtons) do
        tab.BackgroundColor3 =
            categoryName == selectedPickupCategory
            and Color3.fromRGB(70, 70, 70)
            or Color3.fromRGB(40, 40, 40)
    end
end

for index, categoryName in ipairs(pickupOrder) do
    local tab = Instance.new("TextButton")
    tab.Name = categoryName .. "Tab"
    tab.Size = UDim2.new(0, 100, 0, 35)
    tab.LayoutOrder = index
    tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tab.BorderSizePixel = 0
    tab.Text = categoryName
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.TextSize = 15
    tab.Font = Enum.Font.SourceSansBold
    tab.Parent = pickupCategoryFrame

    pickupCategoryButtons[categoryName] = tab

    tab.MouseButton1Click:Connect(function()
        selectedPickupCategory = categoryName
        updatePickupCategories()
    end)
end

updatePickupCanvas()
updatePickupCategories()

local pickupButton = Instance.new("TextButton")
pickupButton.Name = "PickupButton"
pickupButton.Size = UDim2.new(1, -40, 0, 50)
pickupButton.Position = UDim2.new(0, 20, 0, 210)
pickupButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
pickupButton.BorderSizePixel = 0
pickupButton.Text = "Random Pickup Line"
pickupButton.TextColor3 = Color3.fromRGB(255, 255, 255)
pickupButton.TextSize = 18
pickupButton.Font = Enum.Font.SourceSansBold
pickupButton.Parent = pickupPage

local pickupInfo = Instance.new("TextLabel")
pickupInfo.Size = UDim2.new(1, -40, 0, 55)
pickupInfo.Position = UDim2.new(0, 20, 0, 270)
pickupInfo.BackgroundTransparency = 1
pickupInfo.Text = "Sends line 1 → waits → line 2 → (Blank)"
pickupInfo.TextColor3 = Color3.fromRGB(150, 150, 150)
pickupInfo.TextSize = 14
pickupInfo.Font = Enum.Font.SourceSans
pickupInfo.TextWrapped = true
pickupInfo.Parent = pickupPage

local funnyTitle = Instance.new("TextLabel")
funnyTitle.Size = UDim2.new(1, -40, 0, 40)
funnyTitle.Position = UDim2.new(0, 20, 0, 15)
funnyTitle.BackgroundTransparency = 1
funnyTitle.Text = "RVVZ ASS EMOTE LMAO (Crim V3?)"
funnyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
funnyTitle.TextSize = 22
funnyTitle.Font = Enum.Font.SourceSansBold
funnyTitle.TextXAlignment = Enum.TextXAlignment.Left
funnyTitle.Parent = funnyPage

local ahhhButton = Instance.new("TextButton")
ahhhButton.Size = UDim2.new(1, -40, 0, 50)
ahhhButton.Position = UDim2.new(0, 20, 0, 70)
ahhhButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ahhhButton.BorderSizePixel = 0
ahhhButton.Text = "AHHHIMDYINGXD"
ahhhButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ahhhButton.TextSize = 18
ahhhButton.Font = Enum.Font.SourceSansBold
ahhhButton.Parent = funnyPage

local ahhhStatus = Instance.new("TextLabel")
ahhhStatus.Size = UDim2.new(1, -40, 0, 30)
ahhhStatus.Position = UDim2.new(0, 20, 0, 125)
ahhhStatus.BackgroundTransparency = 1
ahhhStatus.Text = "Tool not added."
ahhhStatus.TextColor3 = Color3.fromRGB(160, 160, 160)
ahhhStatus.TextSize = 15
ahhhStatus.Font = Enum.Font.SourceSans
ahhhStatus.TextXAlignment = Enum.TextXAlignment.Left
ahhhStatus.Parent = funnyPage

local funnyToolEnabled = false
local funnyTool = nil
local animationTrack = nil
local animationObject = nil
local animationLoopId = 0

local function stopAHHH()
    animationLoopId += 1

    if animationTrack then
        pcall(function()
            animationTrack:Stop(0)
        end)

        animationTrack = nil
    end

    if animationObject then
        pcall(function()
            animationObject:Destroy()
        end)

        animationObject = nil
    end
end

local function destroyFunnyTool()
    stopAHHH()

    if funnyTool then
        pcall(function()
            funnyTool:Destroy()
        end)

        funnyTool = nil
    end

    local backpack = player:FindFirstChildOfClass("Backpack")

    if backpack then
        local existing = backpack:FindFirstChild("AHHHIMDYINGXD")

        if existing then
            existing:Destroy()
        end
    end

    local character = player.Character

    if character then
        local existing = character:FindFirstChild("AHHHIMDYINGXD")

        if existing then
            existing:Destroy()
        end
    end
end

local function getHumanoid()
    local character = player.Character

    if not character then
        return nil
    end

    return character:FindFirstChildWhichIsA("Humanoid")
end

local function playAHHHAnimation(tool, humanoid)
    animationLoopId += 1

    local currentLoop = animationLoopId

    task.spawn(function()
        while currentLoop == animationLoopId
            and funnyTool == tool
            and tool.Parent
            and humanoid
            and humanoid.Parent
            and humanoid.Health > 0
        do
            local animator =
                humanoid:FindFirstChildOfClass("Animator")

            if not animator then
                animator = Instance.new("Animator")
                animator.Parent = humanoid
            end

            local isR15 =
                humanoid.RigType == Enum.HumanoidRigType.R15

            animationObject = Instance.new("Animation")

            animationObject.AnimationId =
                isR15
                and "rbxassetid://698251653"
                or "rbxassetid://72042024"

            local success, track = pcall(function()
                return animator:LoadAnimation(animationObject)
            end)

            if not success or not track then
                animationObject:Destroy()
                animationObject = nil
                task.wait(0.5)
                continue
            end

            animationTrack = track

            pcall(function()
                animationTrack.Priority =
                    Enum.AnimationPriority.Action

                animationTrack:Play(0)

                animationTrack:AdjustSpeed(
                    isR15 and 0.7 or 0.65
                )

                animationTrack.TimePosition = 0.6
            end)

            task.wait(0.1)

            while animationTrack
                and currentLoop == animationLoopId
                and funnyTool == tool
                and tool.Parent
                and humanoid.Health > 0
                and animationTrack.TimePosition <
                    (isR15 and 0.7 or 0.65)
            do
                task.wait(0.03)
            end

            if animationTrack then
                pcall(function()
                    animationTrack:Stop(0)
                end)

                animationTrack = nil
            end

            if animationObject then
                animationObject:Destroy()
                animationObject = nil
            end

            task.wait()
        end
    end)
end

local function createAHHHTool()
    local character = player.Character
    local humanoid = getHumanoid()
    local backpack = player:FindFirstChildOfClass("Backpack")

    if not character or not humanoid or not backpack then
        return false
    end

    destroyFunnyTool()

    local tool = Instance.new("Tool")
    tool.Name = "AHHHIMDYINGXD"
    tool.ToolTip = "Yeah."
    tool.RequiresHandle = false
    tool.CanBeDropped = false
    tool.Parent = backpack

    funnyTool = tool
    funnyToolEnabled = true

    ahhhStatus.Text = "Tool added. Equip it to play."
    ahhhButton.Text = "Remove Tool"

    tool.Equipped:Connect(function()
        if funnyTool ~= tool then
            return
        end

        stopAHHH()
        playAHHHAnimation(tool, humanoid)
    end)

    tool.Unequipped:Connect(function()
        if funnyTool == tool then
            stopAHHH()
        end
    end)

    humanoid.Died:Connect(function()
        if funnyTool == tool then
            stopAHHH()
        end
    end)

    return true
end

ahhhButton.MouseButton1Click:Connect(function()
    if funnyToolEnabled and funnyTool then
        funnyToolEnabled = false
        destroyFunnyTool()

        ahhhButton.Text = "AHHHIMDYINGXD"
        ahhhStatus.Text = "Tool removed."

        return
    end

    if createAHHHTool() then
        ahhhButton.Text = "Remove Tool"
        ahhhStatus.Text = "Tool added. Equip it to play."
    else
        ahhhStatus.Text = "Character is not ready."
    end
end)

player.CharacterAdded:Connect(function(character)
    stopAHHH()

    task.wait(0.5)

    if not funnyToolEnabled then
        return
    end

    local humanoid =
        character:FindFirstChildWhichIsA("Humanoid")

    if not humanoid then
        humanoid =
            character:WaitForChild("Humanoid", 5)
    end

    local backpack =
        player:WaitForChild("Backpack", 5)

    if not humanoid or not backpack then
        return
    end

    destroyFunnyTool()

    task.wait(0.2)

    if funnyToolEnabled then
        createAHHHTool()
    end
end)

local colorsTitle = Instance.new("TextLabel")
colorsTitle.Size = UDim2.new(1, -20, 0, 35)
colorsTitle.Position = UDim2.new(0, 10, 0, 5)
colorsTitle.BackgroundTransparency = 1
colorsTitle.Text = "Player Soulmate Colors"
colorsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
colorsTitle.TextSize = 20
colorsTitle.Font = Enum.Font.SourceSansBold
colorsTitle.TextXAlignment = Enum.TextXAlignment.Left
colorsTitle.Parent = colorsPage

local playerList = Instance.new("ScrollingFrame")
playerList.Name = "PlayerList"
playerList.Size = UDim2.new(1, -20, 1, -50)
playerList.Position = UDim2.new(0, 10, 0, 45)
playerList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
playerList.BorderSizePixel = 0
playerList.ScrollBarThickness = 6
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.Parent = colorsPage

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 5)
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.Parent = playerList

local listPadding = Instance.new("UIPadding")
listPadding.PaddingTop = UDim.new(0, 5)
listPadding.PaddingBottom = UDim.new(0, 5)
listPadding.PaddingLeft = UDim.new(0, 5)
listPadding.PaddingRight = UDim.new(0, 5)
listPadding.Parent = playerList

local function updateCanvas()
    playerList.CanvasSize = UDim2.new(
        0,
        0,
        0,
        listLayout.AbsoluteContentSize.Y + 10
    )
end

listLayout:GetPropertyChangedSignal(
    "AbsoluteContentSize"
):Connect(updateCanvas)

local function createPlayerEntry(targetPlayer)
    local entry = Instance.new("Frame")
    entry.Name = targetPlayer.Name
    entry.Size = UDim2.new(1, -10, 0, 65)
    entry.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    entry.BorderSizePixel = 0
    entry.Parent = playerList

    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0, 50, 0, 50)
    avatar.Position = UDim2.new(0, 7, 0, 7)
    avatar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    avatar.BorderSizePixel = 0
    avatar.Parent = entry

    task.spawn(function()
        local success, image = pcall(function()
            return Players:GetUserThumbnailAsync(
                targetPlayer.UserId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size100x100
            )
        end)

        if success and entry.Parent then
            avatar.Image = image
        end
    end)

    local playerName = Instance.new("TextLabel")
    playerName.Size = UDim2.new(1, -145, 0, 30)
    playerName.Position = UDim2.new(0, 65, 0, 8)
    playerName.BackgroundTransparency = 1
    playerName.Text =
        targetPlayer.DisplayName .. " @" .. targetPlayer.Name
    playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
    playerName.TextSize = 15
    playerName.Font = Enum.Font.SourceSansBold
    playerName.TextXAlignment = Enum.TextXAlignment.Left
    playerName.TextTruncate = Enum.TextTruncate.AtEnd
    playerName.Parent = entry

    local colorLabel = Instance.new("TextLabel")
    colorLabel.Size = UDim2.new(1, -145, 0, 20)
    colorLabel.Position = UDim2.new(0, 65, 0, 35)
    colorLabel.BackgroundTransparency = 1
    colorLabel.Text = "Soulmate Color: Loading..."
    colorLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
    colorLabel.TextSize = 13
    colorLabel.TextXAlignment = Enum.TextXAlignment.Left
    colorLabel.Parent = entry

    local colorSwatch = Instance.new("Frame")
    colorSwatch.Size = UDim2.new(0, 55, 0, 45)
    colorSwatch.Position = UDim2.new(1, -65, 0, 10)
    colorSwatch.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    colorSwatch.BorderSizePixel = 0
    colorSwatch.Parent = entry

    task.spawn(function()
        local gameData =
            targetPlayer:WaitForChild("GameData", 10)

        if not gameData or not entry.Parent then
            return
        end

        local soulmateColor =
            gameData:WaitForChild("SoulmateColor", 10)

        if not soulmateColor or not entry.Parent then
            return
        end

        local function updateColor()
            if not entry.Parent then
                return
            end

            local colorName = tostring(soulmateColor.Value)
            local colorData = ColorIndex[colorName]

            if not colorData then
                colorSwatch.BackgroundColor3 =
                    Color3.fromRGB(80, 80, 80)

                colorLabel.Text =
                    "Soulmate Color: " .. colorName

                return
            end

            local actualColor = colorData.RGB_Code

            if typeof(actualColor) == "Color3" then
                colorSwatch.BackgroundColor3 = actualColor
                colorLabel.TextColor3 = actualColor
            else
                local backupColor = colorData.Color3_Code

                if typeof(backupColor) == "Color3" then
                    colorSwatch.BackgroundColor3 = backupColor
                    colorLabel.TextColor3 = backupColor
                end
            end

            colorLabel.Text =
                "Soulmate Color: " .. colorName
        end

        updateColor()

        soulmateColor:GetPropertyChangedSignal(
            "Value"
        ):Connect(updateColor)
    end)

    return entry
end

local refreshing = false

local function refreshPlayerList()
    if refreshing then
        return
    end

    refreshing = true

    for _, child in ipairs(playerList:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        createPlayerEntry(targetPlayer)
    end

    task.wait()
    updateCanvas()

    refreshing = false
end

Players.PlayerAdded:Connect(function()
    task.wait(0.5)
    refreshPlayerList()
end)

Players.PlayerRemoving:Connect(function()
    task.wait()
    refreshPlayerList()
end)

local settingsTitle = Instance.new("TextLabel")
settingsTitle.Size = UDim2.new(1, -40, 0, 40)
settingsTitle.Position = UDim2.new(0, 20, 0, 20)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Text = "Settings"
settingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsTitle.TextSize = 24
settingsTitle.Font = Enum.Font.SourceSansBold
settingsTitle.TextXAlignment = Enum.TextXAlignment.Left
settingsTitle.Parent = settingsPage

local dotsSetting = Instance.new("Frame")
dotsSetting.Size = UDim2.new(1, -40, 0, 65)
dotsSetting.Position = UDim2.new(0, 20, 0, 70)
dotsSetting.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
dotsSetting.BorderSizePixel = 0
dotsSetting.Parent = settingsPage

local dotsLabel = Instance.new("TextLabel")
dotsLabel.Size = UDim2.new(1, -90, 1, 0)
dotsLabel.Position = UDim2.new(0, 15, 0, 0)
dotsLabel.BackgroundTransparency = 1
dotsLabel.Text = "Typing dots (...)"
dotsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
dotsLabel.TextSize = 18
dotsLabel.Font = Enum.Font.SourceSansBold
dotsLabel.TextXAlignment = Enum.TextXAlignment.Left
dotsLabel.Parent = dotsSetting

local dotsToggle = Instance.new("TextButton")
dotsToggle.Size = UDim2.new(0, 60, 0, 35)
dotsToggle.Position = UDim2.new(1, -75, 0.5, -17)
dotsToggle.BorderSizePixel = 0
dotsToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
dotsToggle.TextSize = 15
dotsToggle.Font = Enum.Font.SourceSansBold
dotsToggle.Parent = dotsSetting

local function updateDotsToggle()
    if DOTS_ENABLED then
        dotsToggle.Text = "ON"
        dotsToggle.BackgroundColor3 =
            Color3.fromRGB(70, 70, 70)
    else
        dotsToggle.Text = "OFF"
        dotsToggle.BackgroundColor3 =
            Color3.fromRGB(40, 40, 40)
    end
end

dotsToggle.MouseButton1Click:Connect(function()
    DOTS_ENABLED = not DOTS_ENABLED
    updateDotsToggle()
end)

updateDotsToggle()

local settingsInfo = Instance.new("TextLabel")
settingsInfo.Size = UDim2.new(1, -40, 0, 70)
settingsInfo.Position = UDim2.new(0, 20, 0, 145)
settingsInfo.BackgroundTransparency = 1
settingsInfo.Text =
    "When enabled, messages start with the animated ... effect."
settingsInfo.TextColor3 = Color3.fromRGB(150, 150, 150)
settingsInfo.TextSize = 15
settingsInfo.TextWrapped = true
settingsInfo.Font = Enum.Font.SourceSans
settingsInfo.TextXAlignment = Enum.TextXAlignment.Left
settingsInfo.Parent = settingsPage

local function selectMainTab(tabName)
    slowTypePage.Visible = false
    colorsPage.Visible = false
    funnyPage.Visible = false
    pickupPage.Visible = false
    settingsPage.Visible = false

    slowTypeTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    colorsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    funnyTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    pickupTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    settingsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    if tabName == "SlowType" then
        slowTypePage.Visible = true
        slowTypeTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        title.Text = "Slow Type"

    elseif tabName == "Colors" then
        colorsPage.Visible = true
        colorsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        title.Text = "Colors"
        refreshPlayerList()

    elseif tabName == "Funny" then
        funnyPage.Visible = true
        funnyTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        title.Text = "RVVZ REFERENCE!?"

    elseif tabName == "Pickup" then
        pickupPage.Visible = true
        pickupTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        title.Text = "Pickup Lines"

    elseif tabName == "Settings" then
        settingsPage.Visible = true
        settingsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        title.Text = "Settings"
    end
end

slowTypeTab.MouseButton1Click:Connect(function()
    selectMainTab("SlowType")
end)

colorsTab.MouseButton1Click:Connect(function()
    selectMainTab("Colors")
end)

funnyTab.MouseButton1Click:Connect(function()
    selectMainTab("Funny")
end)

pickupTab.MouseButton1Click:Connect(function()
    selectMainTab("Pickup")
end)

settingsTab.MouseButton1Click:Connect(function()
    selectMainTab("Settings")
end)

local dragging = false
local dragStart
local startPos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch
    then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    then
        local delta = input.Position - dragStart

        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

local typing = false

local function sendDots()
    if not DOTS_ENABLED then
        return
    end

    for i = 1, 3 do
        pcall(function()
            Event:FireServer(
                "ChangeName",
                string.rep(".", i)
            )
        end)

        task.wait(DOT_SPEED)
    end

    task.wait(0.5)
end

local function typeMessage(message)
    if not message or message == "" then
        return false
    end

    message =
        string.sub(message, 1, MAX_PHRASE_LENGTH)

    sendDots()

    for i = 1, #message do
        if not gui.Parent then
            return false
        end

        local currentText =
            string.sub(message, 1, i)

        pcall(function()
            Event:FireServer(
                "ChangeName",
                currentText
            )
        end)

        task.wait(TYPE_SPEED)
    end

    pcall(function()
        Event:FireServer(
            "ChangeName",
            message
        )
    end)

    return true
end

local function slowTypeMessage(message)
    if typing then
        return
    end

    if not message or message == "" then
        return
    end

    typing = true

    button.Text = "Typing..."
    randomButton.Text = "Typing..."
    pickupButton.Text = "Typing..."

    typeMessage(message)

    typing = false

    button.Text = "Say!"
    randomButton.Text =
        "Random " .. selectedCategory .. " phrase!"
    pickupButton.Text = "Random Pickup Line"
end

local function sendPickupSequence(sequence)
    if typing then
        return
    end

    if not sequence or #sequence == 0 then
        return
    end

    typing = true
    pickupButton.Text = "Sending..."

    for index, line in ipairs(sequence) do
        if not gui.Parent then
            break
        end

        pickupPreview.Text = line

        typeMessage(line)

        if index < #sequence then
            task.wait(PICKUP_WAIT)
        end
    end

    if gui.Parent then
        task.wait(PICKUP_WAIT)

        pcall(function()
            Event:FireServer("ChangeName", "·")
        end)

        pickupPreview.Text = "·"
    end

    typing = false
    pickupButton.Text = "Random Pickup Line"
end

local function getRandomPhrase()
    local phrases =
        PhraseCategories[selectedCategory]

    if not phrases or #phrases == 0 then
        return nil
    end

    return phrases[math.random(1, #phrases)]
end

local function getRandomPickupLine()
    local sequences =
        PickupCategories[selectedPickupCategory]

    if not sequences or #sequences == 0 then
        return nil
    end

    return sequences[math.random(1, #sequences)]
end

button.MouseButton1Click:Connect(function()
    slowTypeMessage(messageBox.Text)
end)

randomButton.MouseButton1Click:Connect(function()
    if typing then
        return
    end

    local randomPhrase = getRandomPhrase()

    if not randomPhrase then
        return
    end

    messageBox.Text = randomPhrase
    slowTypeMessage(randomPhrase)
end)

pickupButton.MouseButton1Click:Connect(function()
    local sequence = getRandomPickupLine()

    if not sequence then
        return
    end

    pickupPreview.Text = sequence[1]

    sendPickupSequence(sequence)
end)

selectMainTab("SlowType")
refreshPlayerList()
