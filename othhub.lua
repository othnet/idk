local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 10)
local Event = Remotes and Remotes:WaitForChild("ServerEvents", 10)
local ClientEvent = Remotes and Remotes:WaitForChild("ClientEvents", 10)

local DOT_SPEED = 0.125
local TYPE_SPEED = 0.045
local MAX_PHRASE_LENGTH = 20
local PICKUP_WAIT = 1.25
local DOTS_ENABLED = true

local selectedCategory = "Normal"
local selectedPickupCategory = "Smooth"

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



local sayButton
local randomButton
local pickupButton
local pickupPreview
local ahhhButton
local ahhhStatus
local colorsParagraph

local function setElementText(element, text)
    if not element then
        return
    end

    pcall(function()
        element:Set(text)
    end)
end

function setSayButton(text)
    setElementText(sayButton, text)
end

function setRandomButton(text)
    setElementText(randomButton, text)
end

function setPickupButton(text)
    setElementText(pickupButton, text)
end

function setPickupPreview(text)
    setElementText(pickupPreview, text)
end

function setAhhhButton(text)
    setElementText(ahhhButton, text)
end

function setAhhhStatus(text)
    setElementText(ahhhStatus, text)
end

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

    setAhhhStatus("Tool added. Equip it to play.")
    setAhhhButton("Remove Tool")

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

    setSayButton("Typing...")
    setRandomButton("Typing...")
    setPickupButton("Typing...")

    typeMessage(message)

    typing = false

    setSayButton("Say!")
    setRandomButton("Random " .. selectedCategory .. " phrase!")
    setPickupButton("Random Pickup Line")
end

local function sendPickupSequence(sequence)
    if typing then
        return
    end

    if not sequence or #sequence == 0 then
        return
    end

    typing = true
    setPickupButton("Sending...")

    for index, line in ipairs(sequence) do

        setPickupPreview(line)

        typeMessage(line)

        if index < #sequence then
            task.wait(PICKUP_WAIT)
        end
    end

    do
        task.wait(PICKUP_WAIT)

        pcall(function()
            Event:FireServer("ChangeName", "·")
        end)

        setPickupPreview("·")
    end

    typing = false
    setPickupButton("Random Pickup Line")
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



--------------------------------------------------------------------------------
-- OthHub UI (no external libraries)
--------------------------------------------------------------------------------

local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local Theme = {
    Background = Color3.fromRGB(14, 12, 22),
    Panel = Color3.fromRGB(19, 16, 30),
    Element = Color3.fromRGB(26, 22, 40),
    ElementHover = Color3.fromRGB(36, 30, 56),
    Stroke = Color3.fromRGB(52, 42, 82),
    Accent = Color3.fromRGB(176, 108, 255),
    Accent2 = Color3.fromRGB(255, 110, 196),
    Text = Color3.fromRGB(240, 236, 255),
    SubText = Color3.fromRGB(160, 150, 190),
    Dim = Color3.fromRGB(70, 62, 96)
}

local FONT = Enum.Font.Gotham
local FONT_MEDIUM = Enum.Font.GothamMedium
local FONT_BOLD = Enum.Font.GothamBold

local WINDOW_SIZE = Vector2.new(560, 360)
local TOPBAR_HEIGHT = 44
local SIDEBAR_WIDTH = 150

local CONFIG_FOLDER = "OthHub"
local CONFIG_FILE = CONFIG_FOLDER .. "/UIConfig.json"

local connections = {}

local function track(connection)
    connections[#connections + 1] = connection
    return connection
end

local function tween(object, duration, properties)
    local animation = TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        properties
    )

    animation:Play()

    return animation
end

local function create(className, properties, children)
    local instance = Instance.new(className)

    for key, value in pairs(properties or {}) do
        if key ~= "Parent" then
            instance[key] = value
        end
    end

    for _, child in ipairs(children or {}) do
        child.Parent = instance
    end

    if properties and properties.Parent then
        instance.Parent = properties.Parent
    end

    return instance
end

local function corner(radius)
    return create("UICorner", {
        CornerRadius = UDim.new(0, radius or 8)
    })
end

local function stroke(color, transparency)
    return create("UIStroke", {
        Color = color or Theme.Stroke,
        Thickness = 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })
end

local function padding(top, right, bottom, left)
    return create("UIPadding", {
        PaddingTop = UDim.new(0, top),
        PaddingRight = UDim.new(0, right or top),
        PaddingBottom = UDim.new(0, bottom or top),
        PaddingLeft = UDim.new(0, left or right or top)
    })
end

local function listLayout(spacing)
    return create("UIListLayout", {
        Padding = UDim.new(0, spacing or 0),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
end

local function accentGradient(rotation)
    return create("UIGradient", {
        Color = ColorSequence.new(Theme.Accent, Theme.Accent2),
        Rotation = rotation or 0
    })
end

local function text(properties)
    local defaults = {
        BackgroundTransparency = 1,
        Font = FONT,
        TextSize = 13,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        RichText = false
    }

    for key, value in pairs(properties) do
        defaults[key] = value
    end

    return create("TextLabel", defaults)
end

local function addHover(button, normal, hover)
    button.MouseEnter:Connect(function()
        tween(button, 0.15, { BackgroundColor3 = hover or Theme.ElementHover })
    end)

    button.MouseLeave:Connect(function()
        tween(button, 0.15, { BackgroundColor3 = normal or Theme.Element })
    end)
end

local function makeDraggable(handle, target)
    local dragging = false
    local dragInput
    local dragStart
    local startPosition

    handle.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1
            and input.UserInputType ~= Enum.UserInputType.Touch
        then
            return
        end

        dragging = true
        dragStart = input.Position
        startPosition = target.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        then
            dragInput = input
        end
    end)

    track(UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart

            target.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end))
end

-- Config ----------------------------------------------------------------------

local Config = {}
local flagSetters = {}

local function canUseFiles()
    return type(writefile) == "function"
        and type(readfile) == "function"
        and type(isfile) == "function"
end

local function saveConfig()
    if not canUseFiles() then
        return
    end

    pcall(function()
        if type(isfolder) == "function"
            and type(makefolder) == "function"
            and not isfolder(CONFIG_FOLDER)
        then
            makefolder(CONFIG_FOLDER)
        end

        writefile(CONFIG_FILE, HttpService:JSONEncode(Config))
    end)
end

local function loadConfig()
    if not canUseFiles() then
        return
    end

    local success, data = pcall(function()
        if not isfile(CONFIG_FILE) then
            return nil
        end

        return HttpService:JSONDecode(readfile(CONFIG_FILE))
    end)

    if not success or type(data) ~= "table" then
        return
    end

    for flag, value in pairs(data) do
        local setter = flagSetters[flag]

        if setter then
            pcall(setter, value)
        end
    end
end

local function setFlag(flag, value)
    if not flag then
        return
    end

    Config[flag] = value
    saveConfig()
end

-- ScreenGui -------------------------------------------------------------------

local function getGuiParent()
    local success, hiddenUi = pcall(function()
        return gethui and gethui()
    end)

    if success and hiddenUi then
        return hiddenUi
    end

    local coreSuccess = pcall(function()
        local probe = Instance.new("Folder")
        probe.Parent = game:GetService("CoreGui")
        probe:Destroy()
    end)

    if coreSuccess then
        return game:GetService("CoreGui")
    end

    return playerGui
end

local guiParent = getGuiParent()

for _, container in ipairs({ guiParent, playerGui }) do
    pcall(function()
        local existing = container:FindFirstChild("OthHubUI")

        if existing then
            existing:Destroy()
        end
    end)
end

local screenGui = create("ScreenGui", {
    Name = "OthHubUI",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

local guiParented = pcall(function()
    screenGui.Parent = guiParent
end)

if not guiParented then
    screenGui.Parent = playerGui
end

-- Window ----------------------------------------------------------------------

local main = create("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(WINDOW_SIZE.X, WINDOW_SIZE.Y),
    BackgroundColor3 = Color3.new(1, 1, 1),
    ClipsDescendants = true,
    Parent = screenGui
}, {
    corner(12),
    create("UIGradient", {
        Color = ColorSequence.new(
            Color3.fromRGB(22, 18, 36),
            Theme.Background
        ),
        Rotation = 90
    })
})

local mainStroke = create("UIStroke", {
    Color = Color3.new(1, 1, 1),
    Thickness = 1.5,
    Transparency = 0.35,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Parent = main
}, {
    accentGradient(45)
})

local windowScale = create("UIScale", { Parent = main })

local viewportScale = 1
local openAmount = 0

local function applyScale()
    windowScale.Scale = viewportScale * (0.92 + 0.08 * openAmount)
end

local function updateViewportScale()
    local camera = workspace.CurrentCamera

    if not camera then
        return
    end

    local viewport = camera.ViewportSize

    viewportScale = math.clamp(
        math.min(
            (viewport.X - 24) / WINDOW_SIZE.X,
            (viewport.Y - 24) / WINDOW_SIZE.Y
        ),
        0.5,
        1
    )

    applyScale()
end

updateViewportScale()

if workspace.CurrentCamera then
    track(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateViewportScale))
end

-- Topbar

local topbar = create("Frame", {
    Name = "Topbar",
    Size = UDim2.new(1, 0, 0, TOPBAR_HEIGHT),
    BackgroundTransparency = 1,
    Parent = main
})

create("Frame", {
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 0, 1, 0),
    Size = UDim2.new(1, 0, 0, 1),
    BackgroundColor3 = Theme.Stroke,
    BorderSizePixel = 0,
    Parent = topbar
})

local logo = create("Frame", {
    AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.new(0, 12, 0.5, 0),
    Size = UDim2.fromOffset(26, 26),
    BackgroundColor3 = Color3.new(1, 1, 1),
    Parent = topbar
}, {
    corner(8),
    accentGradient(45)
})

text({
    Size = UDim2.fromScale(1, 1),
    Font = FONT_BOLD,
    TextSize = 15,
    Text = "O",
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = logo
})

local titleLabel = text({
    Position = UDim2.new(0, 46, 0, 7),
    Size = UDim2.new(0, 200, 0, 18),
    Font = FONT_BOLD,
    TextSize = 15,
    Text = "OthHub",
    TextColor3 = Color3.new(1, 1, 1),
    Parent = topbar
})

accentGradient(0).Parent = titleLabel

text({
    Position = UDim2.new(0, 46, 0, 24),
    Size = UDim2.new(0, 200, 0, 14),
    TextSize = 11,
    Text = "v2  ·  by oth",
    TextColor3 = Theme.SubText,
    Parent = topbar
})

local function topbarButton(symbol, offset)
    local button = create("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, offset, 0.5, 0),
        Size = UDim2.fromOffset(28, 28),
        BackgroundColor3 = Theme.Element,
        BackgroundTransparency = 1,
        AutoButtonColor = false,
        Font = FONT_BOLD,
        TextSize = 16,
        Text = symbol,
        TextColor3 = Theme.SubText,
        Parent = topbar
    }, {
        corner(8)
    })

    button.MouseEnter:Connect(function()
        tween(button, 0.15, { BackgroundTransparency = 0, TextColor3 = Theme.Text })
    end)

    button.MouseLeave:Connect(function()
        tween(button, 0.15, { BackgroundTransparency = 1, TextColor3 = Theme.SubText })
    end)

    return button
end

local closeButton = topbarButton("×", -10)
local minimizeButton = topbarButton("–", -42)

makeDraggable(topbar, main)

-- Sidebar

local sidebar = create("Frame", {
    Name = "Sidebar",
    Position = UDim2.new(0, 0, 0, TOPBAR_HEIGHT),
    Size = UDim2.new(0, SIDEBAR_WIDTH, 1, -TOPBAR_HEIGHT),
    BackgroundTransparency = 1,
    Parent = main
})

create("Frame", {
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, 0, 0, 0),
    Size = UDim2.new(0, 1, 1, 0),
    BackgroundColor3 = Theme.Stroke,
    BorderSizePixel = 0,
    Parent = sidebar
})

local tabList = create("ScrollingFrame", {
    Size = UDim2.new(1, -1, 1, -56),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 0,
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    Parent = sidebar
}, {
    padding(10, 8, 10, 8),
    listLayout(4)
})

local profile = create("Frame", {
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 8, 1, -8),
    Size = UDim2.new(1, -17, 0, 40),
    BackgroundColor3 = Theme.Element,
    Parent = sidebar
}, {
    corner(8),
    stroke()
})

local avatar = create("ImageLabel", {
    AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.new(0, 6, 0.5, 0),
    Size = UDim2.fromOffset(28, 28),
    BackgroundColor3 = Theme.ElementHover,
    Image = "",
    Parent = profile
}, {
    create("UICorner", { CornerRadius = UDim.new(1, 0) })
})

text({
    Position = UDim2.new(0, 40, 0, 5),
    Size = UDim2.new(1, -46, 0, 16),
    Font = FONT_MEDIUM,
    TextSize = 12,
    Text = player.DisplayName,
    TextTruncate = Enum.TextTruncate.AtEnd,
    Parent = profile
})

text({
    Position = UDim2.new(0, 40, 0, 20),
    Size = UDim2.new(1, -46, 0, 14),
    TextSize = 10,
    Text = "@" .. player.Name,
    TextColor3 = Theme.SubText,
    TextTruncate = Enum.TextTruncate.AtEnd,
    Parent = profile
})

task.spawn(function()
    local success, image = pcall(function()
        return Players:GetUserThumbnailAsync(
            player.UserId,
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size48x48
        )
    end)

    if success and image then
        avatar.Image = image
    end
end)

-- Content

local content = create("Frame", {
    Name = "Content",
    Position = UDim2.new(0, SIDEBAR_WIDTH, 0, TOPBAR_HEIGHT),
    Size = UDim2.new(1, -SIDEBAR_WIDTH, 1, -TOPBAR_HEIGHT),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    Parent = main
})

-- Notifications ---------------------------------------------------------------

local notificationHolder = create("Frame", {
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -16, 1, -16),
    Size = UDim2.new(0, 260, 1, -32),
    BackgroundTransparency = 1,
    Parent = screenGui
}, {
    create("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom
    })
})

local notificationCount = 0

local function notify(title, message, duration)
    duration = duration or 3
    notificationCount += 1

    if not notificationHolder.Parent then
        return
    end

    local wrapper = create("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = notificationCount,
        Parent = notificationHolder
    })

    local card = create("Frame", {
        Position = UDim2.new(1, 40, 0, 0),
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Theme.Panel,
        ClipsDescendants = true,
        Parent = wrapper
    }, {
        corner(10),
        stroke()
    })

    create("Frame", {
        Size = UDim2.new(0, 3, 1, 0),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Parent = card
    }, {
        accentGradient(90)
    })

    local inner = create("Frame", {
        Position = UDim2.new(0, 14, 0, 0),
        Size = UDim2.new(1, -26, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Parent = card
    }, {
        padding(10, 0, 12, 0),
        listLayout(3)
    })

    text({
        Size = UDim2.new(1, 0, 0, 16),
        Font = FONT_BOLD,
        TextSize = 13,
        Text = title,
        LayoutOrder = 1,
        Parent = inner
    })

    text({
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextSize = 12,
        TextWrapped = true,
        Text = message,
        TextColor3 = Theme.SubText,
        LayoutOrder = 2,
        Parent = inner
    })

    local progress = create("Frame", {
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, 2),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Parent = card
    }, {
        accentGradient(0)
    })

    tween(card, 0.4, { Position = UDim2.new(0, 0, 0, 0) })

    TweenService:Create(
        progress,
        TweenInfo.new(duration, Enum.EasingStyle.Linear),
        { Size = UDim2.new(0, 0, 0, 2) }
    ):Play()

    task.delay(duration, function()
        if not wrapper.Parent then
            return
        end

        tween(card, 0.35, { Position = UDim2.new(1, 40, 0, 0) })
        task.wait(0.35)
        wrapper:Destroy()
    end)
end

-- Tabs & elements ---------------------------------------------------------------

local tabs = {}
local currentTab

local Tab = {}
Tab.__index = Tab

local function selectTab(tab)
    if currentTab == tab then
        return
    end

    for _, other in ipairs(tabs) do
        local selected = other == tab

        tween(other.button, 0.2, { BackgroundTransparency = selected and 0 or 1 })
        tween(other.indicator, 0.2, { Size = UDim2.fromOffset(3, selected and 16 or 0) })
        tween(other.nameLabel, 0.2, { TextColor3 = selected and Theme.Text or Theme.SubText })

        other.page.Visible = selected
    end

    currentTab = tab

    tab.page.Position = UDim2.fromOffset(0, 12)
    tween(tab.page, 0.3, { Position = UDim2.fromOffset(0, 0) })
end

local function createTab(name, icon)
    local tab = setmetatable({ order = 0 }, Tab)

    tab.button = create("TextButton", {
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = Theme.ElementHover,
        BackgroundTransparency = 1,
        AutoButtonColor = false,
        Text = "",
        LayoutOrder = #tabs + 1,
        Parent = tabList
    }, {
        corner(8)
    })

    tab.indicator = create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.fromOffset(3, 0),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Parent = tab.button
    }, {
        corner(2),
        accentGradient(90)
    })

    text({
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(0, 20, 1, 0),
        TextSize = 14,
        Text = icon or "",
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = tab.button
    })

    tab.nameLabel = text({
        Position = UDim2.new(0, 36, 0, 0),
        Size = UDim2.new(1, -40, 1, 0),
        Font = FONT_MEDIUM,
        Text = name,
        TextColor3 = Theme.SubText,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = tab.button
    })

    tab.page = create("ScrollingFrame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Theme.Accent,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
        Parent = content
    }, {
        padding(12, 14, 14, 12),
        listLayout(8)
    })

    tab.button.MouseEnter:Connect(function()
        if currentTab ~= tab then
            tween(tab.nameLabel, 0.15, { TextColor3 = Theme.Text })
        end
    end)

    tab.button.MouseLeave:Connect(function()
        if currentTab ~= tab then
            tween(tab.nameLabel, 0.15, { TextColor3 = Theme.SubText })
        end
    end)

    tab.button.Activated:Connect(function()
        selectTab(tab)
    end)

    tabs[#tabs + 1] = tab

    if #tabs == 1 then
        selectTab(tab)
    end

    return tab
end

function Tab:nextOrder()
    self.order += 1
    return self.order
end

function Tab:Section(title)
    text({
        Size = UDim2.new(1, 0, 0, 20),
        Font = FONT_BOLD,
        TextSize = 11,
        Text = string.upper(title),
        TextColor3 = Theme.Accent,
        TextYAlignment = Enum.TextYAlignment.Bottom,
        LayoutOrder = self:nextOrder(),
        Parent = self.page
    })
end

function Tab:Divider()
    create("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = Theme.Stroke,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        LayoutOrder = self:nextOrder(),
        Parent = self.page
    })
end

function Tab:Label(message)
    local frame = create("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Theme.Element,
        BackgroundTransparency = 0.5,
        LayoutOrder = self:nextOrder(),
        Parent = self.page
    }, {
        corner(8),
        padding(9, 12)
    })

    local label = text({
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextWrapped = true,
        Text = message,
        TextColor3 = Theme.SubText,
        Parent = frame
    })

    return {
        Set = function(_, newText)
            label.Text = tostring(newText)
        end
    }
end

function Tab:Paragraph(title, message)
    local frame = create("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Theme.Element,
        LayoutOrder = self:nextOrder(),
        Parent = self.page
    }, {
        corner(8),
        stroke(),
        padding(10, 12),
        listLayout(4)
    })

    local titleText = text({
        Size = UDim2.new(1, 0, 0, 16),
        Font = FONT_BOLD,
        Text = title,
        LayoutOrder = 1,
        Parent = frame
    })

    local bodyText = text({
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextSize = 12,
        TextWrapped = true,
        Text = message,
        TextColor3 = Theme.SubText,
        LineHeight = 1.15,
        LayoutOrder = 2,
        Parent = frame
    })

    return {
        Set = function(_, newTitle, newMessage)
            if newTitle then
                titleText.Text = tostring(newTitle)
            end

            if newMessage then
                bodyText.Text = tostring(newMessage)
            end
        end
    }
end

function Tab:Button(name, callback)
    local button = create("TextButton", {
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = Theme.Element,
        AutoButtonColor = false,
        Text = "",
        LayoutOrder = self:nextOrder(),
        Parent = self.page
    }, {
        corner(8)
    })

    local buttonStroke = stroke()
    buttonStroke.Parent = button

    local label = text({
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -40, 1, 0),
        Font = FONT_MEDIUM,
        Text = name,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = button
    })

    text({
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(16, 20),
        Font = FONT_BOLD,
        TextSize = 18,
        Text = "›",
        TextColor3 = Theme.Accent,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = button
    })

    addHover(button)

    button.Activated:Connect(function()
        buttonStroke.Color = Theme.Accent
        tween(buttonStroke, 0.5, { Color = Theme.Stroke })

        if callback then
            task.spawn(callback)
        end
    end)

    return {
        Set = function(_, newText)
            label.Text = tostring(newText)
        end
    }
end

function Tab:Toggle(name, default, callback, flag)
    local value = default and true or false

    local button = create("TextButton", {
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = Theme.Element,
        AutoButtonColor = false,
        Text = "",
        LayoutOrder = self:nextOrder(),
        Parent = self.page
    }, {
        corner(8),
        stroke()
    })

    text({
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -70, 1, 0),
        Font = FONT_MEDIUM,
        Text = name,
        Parent = button
    })

    local switch = create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(38, 20),
        BackgroundColor3 = Theme.Dim,
        Parent = button
    }, {
        corner(10)
    })

    local knob = create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 2, 0.5, 0),
        Size = UDim2.fromOffset(16, 16),
        BackgroundColor3 = Color3.new(1, 1, 1),
        Parent = switch
    }, {
        corner(8)
    })

    local function render(duration)
        tween(switch, duration, { BackgroundColor3 = value and Theme.Accent or Theme.Dim })
        tween(knob, duration, {
            Position = value
                and UDim2.new(1, -18, 0.5, 0)
                or UDim2.new(0, 2, 0.5, 0)
        })
    end

    local function set(newValue)
        value = newValue and true or false
        render(0.2)
        setFlag(flag, value)

        if callback then
            task.spawn(callback, value)
        end
    end

    render(0)
    addHover(button)

    button.Activated:Connect(function()
        set(not value)
    end)

    if flag then
        flagSetters[flag] = function(saved)
            if type(saved) == "boolean" then
                set(saved)
            end
        end
    end

    return { Set = function(_, newValue) set(newValue) end }
end

function Tab:Slider(name, min, max, increment, default, suffix, callback, flag)
    local value = default
    local decimals = 0
    local fraction = tostring(increment):match("%.(%d+)")

    if fraction then
        decimals = #fraction
    end

    local frame = create("Frame", {
        Size = UDim2.new(1, 0, 0, 52),
        BackgroundColor3 = Theme.Element,
        LayoutOrder = self:nextOrder(),
        Parent = self.page
    }, {
        corner(8),
        stroke()
    })

    text({
        Position = UDim2.new(0, 12, 0, 8),
        Size = UDim2.new(1, -100, 0, 16),
        Font = FONT_MEDIUM,
        Text = name,
        Parent = frame
    })

    local valueLabel = text({
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -12, 0, 8),
        Size = UDim2.fromOffset(90, 16),
        Font = FONT_BOLD,
        TextSize = 12,
        TextColor3 = Theme.Accent,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = frame
    })

    local bar = create("TextButton", {
        Position = UDim2.new(0, 12, 0, 34),
        Size = UDim2.new(1, -24, 0, 6),
        BackgroundColor3 = Theme.Dim,
        AutoButtonColor = false,
        Text = "",
        Parent = frame
    }, {
        corner(3)
    })

    local fill = create("Frame", {
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Parent = bar
    }, {
        corner(3),
        accentGradient(0)
    })

    local knob = create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromOffset(14, 14),
        BackgroundColor3 = Color3.new(1, 1, 1),
        Parent = bar
    }, {
        corner(7),
        stroke(Theme.Accent)
    })

    local function snap(raw)
        local snapped = min + math.floor((raw - min) / increment + 0.5) * increment
        return math.clamp(snapped, min, max)
    end

    local function render(duration)
        local alpha = (value - min) / (max - min)

        tween(fill, duration, { Size = UDim2.fromScale(alpha, 1) })
        tween(knob, duration, { Position = UDim2.fromScale(alpha, 0.5) })

        valueLabel.Text = string.format("%." .. decimals .. "f", value) .. (suffix or "")
    end

    local function set(newValue, save)
        local snapped = snap(newValue)
        local changed = snapped ~= value

        value = snapped
        render(0.08)

        if changed and callback then
            task.spawn(callback, value)
        end

        if save then
            setFlag(flag, value)
        end
    end

    local dragging = false

    local function updateFromInput(input)
        local alpha = math.clamp(
            (input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X,
            0,
            1
        )

        set(min + (max - min) * alpha, false)
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
        then
            dragging = true
            updateFromInput(input)
        end
    end)

    track(UserInputService.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            updateFromInput(input)
        end
    end))

    track(UserInputService.InputEnded:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            dragging = false
            setFlag(flag, value)
        end
    end))

    render(0)

    if flag then
        flagSetters[flag] = function(saved)
            if type(saved) == "number" then
                set(saved, true)
            end
        end
    end

    return { Set = function(_, newValue) set(newValue, true) end }
end

function Tab:Input(name, placeholder, maxLength, callback)
    local frame = create("Frame", {
        Size = UDim2.new(1, 0, 0, 66),
        BackgroundColor3 = Theme.Element,
        LayoutOrder = self:nextOrder(),
        Parent = self.page
    }, {
        corner(8),
        stroke()
    })

    text({
        Position = UDim2.new(0, 12, 0, 8),
        Size = UDim2.new(1, -80, 0, 16),
        Font = FONT_MEDIUM,
        Text = name,
        Parent = frame
    })

    local counter = text({
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -12, 0, 8),
        Size = UDim2.fromOffset(60, 16),
        TextSize = 11,
        Text = maxLength and ("0/" .. maxLength) or "",
        TextColor3 = Theme.SubText,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = frame
    })

    local box = create("TextBox", {
        Position = UDim2.new(0, 10, 0, 30),
        Size = UDim2.new(1, -20, 0, 26),
        BackgroundColor3 = Theme.Background,
        ClearTextOnFocus = false,
        ClipsDescendants = true,
        Font = FONT,
        TextSize = 13,
        Text = "",
        PlaceholderText = placeholder or "",
        PlaceholderColor3 = Theme.Dim,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = frame
    }, {
        corner(6),
        padding(0, 8, 0, 8)
    })

    local boxStroke = stroke()
    boxStroke.Parent = box

    box.Focused:Connect(function()
        tween(boxStroke, 0.2, { Color = Theme.Accent })
    end)

    box.FocusLost:Connect(function()
        tween(boxStroke, 0.2, { Color = Theme.Stroke })
    end)

    box:GetPropertyChangedSignal("Text"):Connect(function()
        if maxLength and #box.Text > maxLength then
            box.Text = string.sub(box.Text, 1, maxLength)
            return
        end

        if maxLength then
            counter.Text = #box.Text .. "/" .. maxLength
            counter.TextColor3 = #box.Text >= maxLength and Theme.Accent2 or Theme.SubText
        end

        if callback then
            callback(box.Text)
        end
    end)

    return { Set = function(_, newText) box.Text = tostring(newText) end }
end

function Tab:Dropdown(name, options, default, callback, flag)
    local OPTION_HEIGHT = 28
    local HEADER_HEIGHT = 36
    local selected = default
    local isOpen = false
    local listHeight = #options * OPTION_HEIGHT + math.max(#options - 1, 0) * 4

    local frame = create("Frame", {
        Size = UDim2.new(1, 0, 0, HEADER_HEIGHT),
        BackgroundColor3 = Theme.Element,
        ClipsDescendants = true,
        LayoutOrder = self:nextOrder(),
        Parent = self.page
    }, {
        corner(8),
        stroke()
    })

    local header = create("TextButton", {
        Size = UDim2.new(1, 0, 0, HEADER_HEIGHT),
        BackgroundTransparency = 1,
        Text = "",
        Parent = frame
    })

    text({
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(0.5, -12, 1, 0),
        Font = FONT_MEDIUM,
        Text = name,
        Parent = header
    })

    local valueLabel = text({
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -32, 0, 0),
        Size = UDim2.new(0.5, -32, 1, 0),
        Font = FONT_MEDIUM,
        TextSize = 12,
        TextColor3 = Theme.Accent,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = header
    })

    local arrow = text({
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.fromOffset(16, 16),
        Font = FONT_BOLD,
        TextSize = 12,
        Text = "▼",
        TextColor3 = Theme.SubText,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = header
    })

    local list = create("Frame", {
        Position = UDim2.new(0, 6, 0, HEADER_HEIGHT),
        Size = UDim2.new(1, -12, 0, listHeight),
        BackgroundTransparency = 1,
        Parent = frame
    }, {
        listLayout(4)
    })

    local optionButtons = {}

    local function render()
        valueLabel.Text = tostring(selected or "")

        for option, optionButton in pairs(optionButtons) do
            local isSelected = option == selected

            optionButton.BackgroundColor3 = isSelected and Theme.ElementHover or Theme.Background
            optionButton.TextColor3 = isSelected and Theme.Accent or Theme.SubText
        end
    end

    local function setOpen(open)
        isOpen = open

        tween(frame, 0.25, {
            Size = UDim2.new(
                1,
                0,
                0,
                open and (HEADER_HEIGHT + listHeight + 6) or HEADER_HEIGHT
            )
        })

        tween(arrow, 0.25, { Rotation = open and 180 or 0 })
    end

    local function set(option)
        if not table.find(options, option) then
            return
        end

        selected = option
        render()
        setFlag(flag, selected)

        if callback then
            task.spawn(callback, selected)
        end
    end

    for index, option in ipairs(options) do
        local optionButton = create("TextButton", {
            Size = UDim2.new(1, 0, 0, OPTION_HEIGHT),
            BackgroundColor3 = Theme.Background,
            AutoButtonColor = false,
            Font = FONT,
            TextSize = 13,
            Text = option,
            TextColor3 = Theme.SubText,
            LayoutOrder = index,
            Parent = list
        }, {
            corner(6)
        })

        optionButton.Activated:Connect(function()
            set(option)
            setOpen(false)
        end)

        optionButtons[option] = optionButton
    end

    header.Activated:Connect(function()
        setOpen(not isOpen)
    end)

    render()

    if flag then
        flagSetters[flag] = function(saved)
            set(saved)
        end
    end

    return { Set = function(_, option) set(option) end }
end

-- Show / hide / close ---------------------------------------------------------

local visible = true
local minimized = false
local animating = false

local function setOpenAmount(target, duration)
    local driver = Instance.new("NumberValue")
    driver.Value = openAmount

    local connection = driver.Changed:Connect(function(newValue)
        openAmount = newValue
        applyScale()
    end)

    local animation = tween(driver, duration, { Value = target })

    animation.Completed:Connect(function()
        connection:Disconnect()
        driver:Destroy()
    end)
end

local function setVisible(show)
    if animating or show == visible then
        return
    end

    visible = show
    animating = true

    if show then
        main.Visible = true
        setOpenAmount(1, 0.3)
        tween(mainStroke, 0.3, { Transparency = 0.35 })
        task.wait(0.3)
    else
        setOpenAmount(0, 0.2)
        tween(mainStroke, 0.2, { Transparency = 1 })
        task.wait(0.2)
        main.Visible = false
    end

    animating = false
end

local function toggleVisible()
    task.spawn(setVisible, not visible)
end

minimizeButton.Activated:Connect(function()
    minimized = not minimized
    minimizeButton.Text = minimized and "+" or "–"

    tween(main, 0.3, {
        Size = UDim2.fromOffset(
            WINDOW_SIZE.X,
            minimized and TOPBAR_HEIGHT or WINDOW_SIZE.Y
        )
    })
end)

closeButton.Activated:Connect(function()
    for _, connection in ipairs(connections) do
        pcall(function()
            connection:Disconnect()
        end)
    end

    setOpenAmount(0, 0.2)
    tween(mainStroke, 0.2, { Transparency = 1 })
    task.wait(0.2)
    screenGui:Destroy()
end)

track(UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.KeyCode == Enum.KeyCode.K then
        toggleVisible()
    end
end))

-- Floating toggle button for touch devices
if UserInputService.TouchEnabled then
    local floatingButton = create("TextButton", {
        Position = UDim2.fromOffset(16, 70),
        Size = UDim2.fromOffset(44, 44),
        BackgroundColor3 = Color3.new(1, 1, 1),
        AutoButtonColor = false,
        Font = FONT_BOLD,
        TextSize = 18,
        Text = "O",
        TextColor3 = Color3.new(1, 1, 1),
        Parent = screenGui
    }, {
        create("UICorner", { CornerRadius = UDim.new(1, 0) }),
        accentGradient(45)
    })

    local pressPosition

    floatingButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
            or input.UserInputType == Enum.UserInputType.MouseButton1
        then
            pressPosition = input.Position
        end
    end)

    floatingButton.InputEnded:Connect(function(input)
        if pressPosition
            and (input.Position - pressPosition).Magnitude < 8
        then
            toggleVisible()
        end

        pressPosition = nil
    end)

    makeDraggable(floatingButton, floatingButton)
end

-- Open animation
main.Visible = true
mainStroke.Transparency = 1
setOpenAmount(1, 0.4)
tween(mainStroke, 0.4, { Transparency = 0.35 })

--------------------------------------------------------------------------------
-- OthHub tabs
--------------------------------------------------------------------------------

local HomeTab = createTab("Home", "🏠")
local SlowTypeTab = createTab("Slow Type", "💬")
local PickupTab = createTab("Pickup Lines", "💘")
local ColorsTab = createTab("Colors", "🎨")
local ExtraTab = createTab("Extra", "✨")
local SettingsTab = createTab("Settings", "⚙️")

-- Home

HomeTab:Section("Welcome")

HomeTab:Paragraph(
    "hey " .. player.DisplayName .. " 👋",
    "welcome to OthHub. pick a tab on the left and go wild.\nif you see me ingame, say hi :)"
)

HomeTab:Divider()

HomeTab:Label("⌨️  Press K to hide / show the UI")
HomeTab:Label("💾  Settings save automatically")
HomeTab:Label("👑  othhub on top")

-- Slow Type

SlowTypeTab:Section("Slow Type")

local messageText = ""

SlowTypeTab:Input(
    "Message",
    "type what you wanna say...",
    MAX_PHRASE_LENGTH,
    function(newText)
        messageText = string.sub(tostring(newText or ""), 1, MAX_PHRASE_LENGTH)
    end
)

sayButton = SlowTypeTab:Button("Say!", function()
    if typing or messageText == "" then
        return
    end

    slowTypeMessage(messageText)
end)

SlowTypeTab:Divider()
SlowTypeTab:Section("Random Phrases")

SlowTypeTab:Dropdown(
    "Phrase Category",
    {
        "Normal",
        "Scary",
        "Anxious",
        "Confused",
        "Angry",
        "Sad",
        "Mysterious"
    },
    selectedCategory,
    function(value)
        if PhraseCategories[value] then
            selectedCategory = value
        end

        if not typing then
            setRandomButton("Random " .. selectedCategory .. " phrase!")
        end
    end,
    "PhraseCategory"
)

randomButton = SlowTypeTab:Button("Random " .. selectedCategory .. " phrase!", function()
    if typing then
        return
    end

    local phrase = getRandomPhrase()

    if not phrase then
        return
    end

    messageText = phrase
    slowTypeMessage(phrase)
end)

SlowTypeTab:Label("ℹ️  Max length: " .. tostring(MAX_PHRASE_LENGTH) .. " characters")

-- Pickup Lines

PickupTab:Section("Pickup Lines")

pickupPreview = PickupTab:Label("Press Random Pickup Line to preview.")

PickupTab:Dropdown(
    "Pickup Category",
    {
        "Smooth",
        "Funny",
        "Cheesy",
        "Compliments"
    },
    selectedPickupCategory,
    function(value)
        if PickupCategories[value] then
            selectedPickupCategory = value
        end
    end,
    "PickupCategory"
)

pickupButton = PickupTab:Button("Random Pickup Line", function()
    if typing then
        return
    end

    local sequence = getRandomPickupLine()

    if not sequence then
        return
    end

    setPickupPreview(sequence[1] or "")
    sendPickupSequence(sequence)
end)

PickupTab:Divider()
PickupTab:Label("ℹ️  Sends line 1 → waits → line 2 → ·")

-- Colors

ColorsTab:Section("Soulmate Colors")

colorsParagraph = ColorsTab:Paragraph("Players", "Loading...")

local function getPlayerColorText(targetPlayer)
    local prefix = "•  " .. targetPlayer.DisplayName .. " (@" .. targetPlayer.Name .. ")  —  "
    local gameData = targetPlayer:FindFirstChild("GameData")
    local soulmateColor = gameData and gameData:FindFirstChild("SoulmateColor")

    if not soulmateColor then
        return prefix .. "loading..."
    end

    return prefix .. tostring(soulmateColor.Value)
end

local function refreshColors()
    local entries = {}

    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        entries[#entries + 1] = getPlayerColorText(targetPlayer)
    end

    table.sort(entries)

    local body = #entries == 0
        and "No players found."
        or table.concat(entries, "\n")

    pcall(function()
        colorsParagraph:Set("Players (" .. tostring(#entries) .. ")", body)
    end)
end

ColorsTab:Button("Refresh Players", function()
    refreshColors()
    notify("Colors", "Player list refreshed.")
end)

track(Players.PlayerAdded:Connect(function()
    task.wait(0.5)
    refreshColors()
end))

track(Players.PlayerRemoving:Connect(function()
    task.wait()
    refreshColors()
end))

-- Extra

ExtraTab:Section("Extra")

ahhhStatus = ExtraTab:Label("Tool not added.")

ahhhButton = ExtraTab:Button("AHHHIMDYINGXD", function()
    if funnyToolEnabled and funnyTool then
        funnyToolEnabled = false
        destroyFunnyTool()
        setAhhhButton("AHHHIMDYINGXD")
        setAhhhStatus("Tool removed.")
        notify("AHHHIMDYINGXD", "Tool removed.")
        return
    end

    if createAHHHTool() then
        setAhhhButton("Remove Tool")
        setAhhhStatus("Tool added. Equip it to play.")
        notify("AHHHIMDYINGXD", "Tool added. Equip it to play.")
    else
        setAhhhStatus("Character is not ready.")
        notify("AHHHIMDYINGXD", "Character is not ready.")
    end
end)

ExtraTab:Paragraph("AHHHIMDYINGXD", "Adds the original tool. Equip it after adding it.")

-- Settings

SettingsTab:Section("Typing")

SettingsTab:Toggle("Typing dots (...)", DOTS_ENABLED, function(value)
    DOTS_ENABLED = value
end, "TypingDots")

SettingsTab:Slider("Typing Speed", 0.01, 0.15, 0.005, TYPE_SPEED, " sec", function(value)
    TYPE_SPEED = value
end, "TypingSpeed")

SettingsTab:Slider("Dots Speed", 0.05, 0.5, 0.005, DOT_SPEED, " sec", function(value)
    DOT_SPEED = value
end, "DotsSpeed")

SettingsTab:Divider()
SettingsTab:Section("Pickup Lines")

SettingsTab:Slider("Pickup Wait", 0.25, 3, 0.05, PICKUP_WAIT, " sec", function(value)
    PICKUP_WAIT = value
end, "PickupWait")

SettingsTab:Divider()

SettingsTab:Label("ℹ️  Dots appear before typing when enabled.")
SettingsTab:Label("⌨️  K toggles the UI.")

loadConfig()
refreshColors()

notify("OthHub loaded ✦", "welcome back, " .. player.DisplayName .. ". press K to toggle.", 4)
