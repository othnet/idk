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



local sayButton
local randomButton
local pickupButton
local pickupPreview
local ahhhButton
local ahhhStatus

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


local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "OthHub V1",
    Icon = 0,
    LoadingTitle = "OthHub",
    LoadingSubtitle = "by oth",
    Theme = "Default",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "OthHub",
        FileName = "Config"
    }
})

local SlowTypeTab = Window:CreateTab("Slow Type")
local ColorsTab = Window:CreateTab("Colors")
local ExtraTab = Window:CreateTab("Extra")
local PickupTab = Window:CreateTab("Pickup Lines")
local SettingsTab = Window:CreateTab("Settings")

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

SlowTypeTab:CreateSection("Slow Type")

local messageText = ""

SlowTypeTab:CreateInput({
    Name = "Message",
    PlaceholderText = "Type what you wanna say!",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        messageText = string.sub(tostring(text or ""), 1, MAX_PHRASE_LENGTH)
    end,
})

sayButton = SlowTypeTab:CreateButton({
    Name = "Say!",
    Callback = function()
        if typing then
            return
        end

        if messageText == "" then
            return
        end

        slowTypeMessage(messageText)
    end,
})

local categoryDropdown = SlowTypeTab:CreateDropdown({
    Name = "Phrase Category",
    Options = {
        "Normal",
        "Scary",
        "Anxious",
        "Confused",
        "Angry",
        "Sad",
        "Mysterious"
    },
    CurrentOption = {"Normal"},
    MultipleOptions = false,
    Flag = "PhraseCategory",
    Callback = function(option)
        local value = option

        if type(option) == "table" then
            value = option[1]
        end

        if PhraseCategories[value] then
            selectedCategory = value
        end

        setRandomButton("Random " .. selectedCategory .. " phrase!")
    end,
})

randomButton = SlowTypeTab:CreateButton({
    Name = "Random Normal phrase!",
    Callback = function()
        if typing then
            return
        end

        local phrase = getRandomPhrase()

        if not phrase then
            return
        end

        messageText = phrase
        slowTypeMessage(phrase)
    end,
})

SlowTypeTab:CreateLabel("Maximum length: " .. tostring(MAX_PHRASE_LENGTH) .. " characters")

PickupTab:CreateSection("Pickup Lines")

pickupPreview = PickupTab:CreateLabel("Press Random Pickup Line to preview.")

local pickupDropdown = PickupTab:CreateDropdown({
    Name = "Pickup Category",
    Options = {
        "Smooth",
        "Funny",
        "Cheesy",
        "Compliments"
    },
    CurrentOption = {"Smooth"},
    MultipleOptions = false,
    Flag = "PickupCategory",
    Callback = function(option)
        local value = option

        if type(option) == "table" then
            value = option[1]
        end

        if PickupCategories[value] then
            selectedPickupCategory = value
        end
    end,
})

pickupButton = PickupTab:CreateButton({
    Name = "Random Pickup Line",
    Callback = function()
        if typing then
            return
        end

        local sequence = getRandomPickupLine()

        if not sequence then
            return
        end

        setPickupPreview(sequence[1] or "")
        sendPickupSequence(sequence)
    end,
})

PickupTab:CreateLabel("Sends line 1 → waits → line 2 → ·")

ExtraTab:CreateSection("Extra")

ahhhStatus = ExtraTab:CreateLabel("Tool not added.")

ahhhButton = ExtraTab:CreateButton({
    Name = "AHHHIMDYINGXD",
    Callback = function()
        if funnyToolEnabled and funnyTool then
            funnyToolEnabled = false
            destroyFunnyTool()
            setAhhhButton("AHHHIMDYINGXD")
            setAhhhStatus("Tool removed.")
            return
        end

        if createAHHHTool() then
            setAhhhButton("Remove Tool")
            setAhhhStatus("Tool added. Equip it to play.")
        else
            setAhhhStatus("Character is not ready.")
        end
    end,
})

ExtraTab:CreateParagraph({
    Title = "AHHHIMDYINGXD",
    Content = "Adds the original tool. Equip it after adding it."
})

ColorsTab:CreateSection("Player Soulmate Colors")

colorsParagraph = ColorsTab:CreateParagraph({
    Title = "Players",
    Content = "Loading..."
})

local function getPlayerColorText(targetPlayer)
    local gameData = targetPlayer:FindFirstChild("GameData")

    if not gameData then
        return targetPlayer.DisplayName .. " @" .. targetPlayer.Name .. " — Loading..."
    end

    local soulmateColor = gameData:FindFirstChild("SoulmateColor")

    if not soulmateColor then
        return targetPlayer.DisplayName .. " @" .. targetPlayer.Name .. " — Loading..."
    end

    local colorName = tostring(soulmateColor.Value)

    return targetPlayer.DisplayName
        .. " @"
        .. targetPlayer.Name
        .. " — Soulmate Color: "
        .. colorName
end

local function refreshColors()
    local entries = {}

    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        entries[#entries + 1] = getPlayerColorText(targetPlayer)
    end

    table.sort(entries)

    local content

    if #entries == 0 then
        content = "No players found."
    else
        content = table.concat(entries, "\n")
    end

    pcall(function()
        colorsParagraph:Set({
            Title = "Players (" .. tostring(#entries) .. ")",
            Content = content
        })
    end)
end

ColorsTab:CreateButton({
    Name = "Refresh Players",
    Callback = refreshColors,
})

Players.PlayerAdded:Connect(function()
    task.wait(0.5)
    refreshColors()
end)

Players.PlayerRemoving:Connect(function()
    task.wait()
    refreshColors()
end)

SettingsTab:CreateSection("Settings")

SettingsTab:CreateToggle({
    Name = "Typing dots (...)",
    CurrentValue = DOTS_ENABLED,
    Flag = "TypingDots",
    Callback = function(value)
        DOTS_ENABLED = value
    end,
})

SettingsTab:CreateSlider({
    Name = "Typing Speed",
    Range = {0.01, 0.15},
    Increment = 0.005,
    Suffix = " sec",
    CurrentValue = TYPE_SPEED,
    Flag = "TypingSpeed",
    Callback = function(value)
        TYPE_SPEED = value
    end,
})

SettingsTab:CreateSlider({
    Name = "Dots Speed",
    Range = {0.05, 0.5},
    Increment = 0.005,
    Suffix = " sec",
    CurrentValue = DOT_SPEED,
    Flag = "DotsSpeed",
    Callback = function(value)
        DOT_SPEED = value
    end,
})

SettingsTab:CreateSlider({
    Name = "Pickup Wait",
    Range = {0.25, 3},
    Increment = 0.05,
    Suffix = " sec",
    CurrentValue = PICKUP_WAIT,
    Flag = "PickupWait",
    Callback = function(value)
        PICKUP_WAIT = value
    end,
})

SettingsTab:CreateLabel("Dots appear before typing when enabled.")
SettingsTab:CreateLabel("K toggles the Rayfield UI.")

refreshColors()

Rayfield:LoadConfiguration()

