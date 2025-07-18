--[[
~~~~~~~~ hello ! ~~~~~~~~

credits to markedengine for making the sprite for the keystrokes
modified my uwenalil, i modified it alot :p

please do credit me if you use it on a mod and gameplay :p

]] -- Configuration
-- local keystrokes = true -- ture = enabled (default), false = disabled
local coolkeystrokeanimation = true -- ture = cool animation on (default), false = cool animaton off
xkeystroke = 90 -- default: 90
ykeystroke = 580 -- default: 330
keystrokecomebackanim = 1.5 -- default: 1.5
keystrokegoanim = 10 -- default: 10
fadeoutkeystroke = 0.15 -- default: 0.15, no anim: 0.001
upbuttoncolorkeystroke = '12FA05' -- default: '12FA05'
downbuttoncolorkeystroke = '00FFFF' -- default: '00FFFF'
leftbuttoncolorkeystroke = 'C24B99' -- default: 'C24B99'
rightbuttoncolorkeystroke = 'F9393F' -- default: 'F9393F'
keystrokecamera = 'other' -- Default: 'other', other values: 'camHud' and 'camGame'

-- actual code
-- DO NOT TOUCH!!! UNLESS YOU KNOW WHAT YOU ARE DOING!!!
function onCreatePost()
        makeLuaSprite('upButton', nil, xkeystroke, ykeystroke)
        makeGraphic('upButton', 44, 44, upbuttoncolorkeystroke)

        addLuaSprite('upButton', true)
        setObjectCamera('upButton', keystrokecamera)
        setProperty('upButton.alpha', UEkeyA)

        makeLuaSprite('downButton', nil, xkeystroke, ykeystroke + 47)
        makeGraphic('downButton', 44, 44, downbuttoncolorkeystroke)

        addLuaSprite('downButton', true)
        setObjectCamera('downButton', keystrokecamera)
        setProperty('downButton.alpha', UEkeyA)

        makeLuaSprite('leftButton', nil, xkeystroke - 47, ykeystroke + 47)
        makeGraphic('leftButton', 44, 44, leftbuttoncolorkeystroke)

        addLuaSprite('leftButton', true)
        setObjectCamera('leftButton', keystrokecamera)
        setProperty('leftButton.alpha', UEkeyA)

        makeLuaSprite('rightButton', nil, xkeystroke + 47, ykeystroke + 47)
        makeGraphic('rightButton', 44, 44, rightbuttoncolorkeystroke)

        addLuaSprite('rightButton', true)
        setObjectCamera('rightButton', keystrokecamera)
        setProperty('rightButton.alpha', UEkeyA)
end

function onUpdate(elapsed)
        if keyPressed('up') then
            setProperty('upButton.alpha', 1)
            cancelTween('upFade')

            if coolkeystrokeanimation then
                setProperty("upButton.y", ykeystroke - keystrokegoanim)
                doTweenY("KSupButtonthingY", "upButton", ykeystroke, crochet / 1000 * 4 / keystrokecomebackanim, "expoOut")
            end
        else
            doTweenAlpha('upFade', 'upButton', UEkeyA, UEkeyFT, 'linear')
        end

        if keyPressed('down') then
            setProperty('downButton.alpha', 1)
            cancelTween('downFade')

            if coolkeystrokeanimation then
                setProperty("downButton.y", ykeystroke + 47 + keystrokegoanim)
                doTweenY("KSdownButtonthingY", "downButton", ykeystroke + 47, crochet / 1000 * 4 / keystrokecomebackanim,
                    "expoOut")
            end
        else
            doTweenAlpha('downFade', 'downButton', UEkeyA, UEkeyFT, 'linear')
        end

        if keyPressed('left') then
            setProperty('leftButton.alpha', 1)
            cancelTween('leftFade')

            if coolkeystrokeanimation then
                setProperty("leftButton.x", xkeystroke - 47 - keystrokegoanim)
                doTweenX("KSleftButtonthingx", "leftButton", xkeystroke - 47, crochet / 1000 * 4 / keystrokecomebackanim,
                    "expoOut")
            end
        else
            doTweenAlpha('leftFade', 'leftButton', UEkeyA, UEkeyFT, 'linear')
        end

        if keyPressed('right') then
            setProperty('rightButton.alpha', 1)
            cancelTween('rightFade')

            if coolkeystrokeanimation then
                setProperty("rightButton.x", xkeystroke + 47 + keystrokegoanim)
                doTweenX("KSrightButtonthingx", "rightButton", xkeystroke + 47, crochet / 1000 * 4 / keystrokecomebackanim,
                    "expoOut")
            end
        else
            doTweenAlpha('rightFade', 'rightButton', UEkeyA, UEkeyFT, 'linear')
        end
    if not botPlay then
        doTweenAlpha('upFadeBot', 'upButton', UEkeyFT, 0.5, 'linear')
        doTweenAlpha('downFadeBot', 'downButton', UEkeyFT, 0.5, 'linear')
        doTweenAlpha('leftFadeBot', 'leftButton', UEkeyFT, 0.5, 'linear')
        doTweenAlpha('rightFadeBot', 'rightButton', UEkeyFT, 0.5, 'linear')
    end
end