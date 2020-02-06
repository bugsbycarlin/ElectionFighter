
local composer = require("composer")

local scene = composer.newScene()

local effects_class = require("Source.Utilities.effects")

candidates = {}
candidates["warren"] = require("Source.Candidates.warren")
candidates["trump"] = require("Source.Candidates.trump")
candidates["biden"] = require("Source.Candidates.biden")
candidates["sanders"] = require("Source.Candidates.sanders")

local effects

local title_music = audio.loadStream("Sound/intro_sound.mp3")

local animationTimer

local speed_line_width = 800
local max_speed_lines = 100
local speed_line_backdrop_height = 180
local speed_line_min_height = 1
local speed_line_max_height = 15
local speed_line_min_x_vel = 60
local speed_line_max_x_vel = 80
local speed_line_center = 120

local blue_color = {r=106/255, g=175/255, b=226/255}
local red_color = {r=224/255, g=29/255, b=39/255}
local white_color = {r=1, g=1, b=1}
local colors = {red_color, white_color, blue_color}

local beat_number

local start_time

local white_screen
local title_card
local press_start

local function gotoSelect()
  composer.gotoScene("Source.Scenes.select")
end

local function addSpeedLine(color, direction, y)
  height = math.random(speed_line_min_height, speed_line_max_height)
  x_vel = math.random(speed_line_min_x_vel, speed_line_max_x_vel)
  color_tint = math.random(8, 12) / 10
  speed_line = display.newImageRect(backgroundGroup, "Art/block.png", speed_line_width, height)
  if direction > 0 then
    speed_line.x = -1 * speed_line_width / 2 - 200 + math.random(1, 200)
  else
    speed_line.x = display.contentWidth + speed_line_width / 2 + 200 - math.random(1, 200)
  end
  speed_line.y = y - speed_line_backdrop_height/2 + math.random(speed_line_backdrop_height)
  if speed_line.y + height / 2 > y + speed_line_backdrop_height / 2 then
    speed_line.y = y + speed_line_backdrop_height / 2 - height / 2 - 1
  end
  if speed_line.y - height / 2 < y - speed_line_backdrop_height / 2 then
    speed_line.y = y - speed_line_backdrop_height / 2 + height / 2 + 1
  end
  speed_line.x_vel = x_vel
  new_color = {
    r = math.min(color.r * color_tint, 1),
    g = math.min(color.g * color_tint, 1),
    b = math.min(color.b * color_tint, 1),
  }
  speed_line:setFillColor(new_color.r, new_color.g, new_color.b)
  function speed_line:update()
    if direction > 0 then
      self.x = self.x + self.x_vel
    else
      self.x = self.x - self.x_vel
    end
  end
  function speed_line:finished()
    if direction > 0 then
      return (self.x - speed_line_width / 2 > display.contentWidth)
    else
      return (self.x + speed_line_width / 2 < 0)
    end
  end

  effects:add(speed_line)
end

local function addRandomSpeedLine()
  direction = 1
  if math.random(1,1000) > 500 then
    direction = -1
  end
  addSpeedLine(colors[math.random(1,3)], direction, speed_line_center)
end

local function animation()

  effects:update()

  if beat_number == 1 then
    addRandomSpeedLine()
    white_screen.alpha = white_screen.alpha * 0.9
    if white_screen.alpha < 0.2 then
      white_screen.isVisible = false
    end
  elseif beat_number == 2 then
  elseif beat_number == 3 then
    press_start.alpha = math.min(1, press_start.alpha + 0.1)
  end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

  local sceneGroup = self.view
  -- Code here runs when the scene is first created but has not yet appeared on screen

  backgroundGroup = display.newGroup()
  sceneGroup:insert(backgroundGroup)
  mainGroup = display.newGroup()
  sceneGroup:insert(mainGroup)
  foregroundGroup = display.newGroup()
  sceneGroup:insert(foregroundGroup)

  white_screen = display.newImageRect(mainGroup, "Art/white_screen.png", 1024, 1024)
  white_screen.x = display.contentCenterX
  white_screen.y = display.contentCenterY
  white_screen.alpha = 0

  title_card = display.newImageRect(mainGroup, "Art/title_card.png", 568, 320)
  title_card.x = display.contentCenterX
  title_card.y = display.contentCenterY
  title_card.isVisible = false

  press_start = display.newImageRect(mainGroup, "Art/press_start.png", 568, 320)
  press_start.x = display.contentCenterX
  press_start.y = display.contentCenterY
  press_start.isVisible = false


  effects = effects_class:create()

  beat_number = 0

  timer.performWithDelay(10567, function() 
    beat_number = 1
    title_card.isVisible = true
    white_screen.alpha = 1
    for i = 1,40,1 do
      addRandomSpeedLine()
    end
  end)
  timer.performWithDelay(11300, function()
    beat_number = 2
  end)
  timer.performWithDelay(13000, function()
    press_start.isVisible = true
    press_start.alpha = 0
    beat_number = 3
    press_start:addEventListener("tap", gotoSelect)
  end)
end


-- show()
function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is still off screen (but is about to come on screen)
    animationTimer = timer.performWithDelay(33, animation, 0)
    audio.play(title_music, { channel=1, loops=0 })

  elseif ( phase == "did" ) then
    -- Code here runs when the scene is entirely on screen

  end
end


-- hide()
function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is on screen (but is about to go off screen)

  elseif ( phase == "did" ) then
    -- Code here runs immediately after the scene goes entirely off screen
    composer.removeScene("Source.Scenes.title_alt")
  end
end


-- destroy()
function scene:destroy( event )

  -- Code here runs prior to the removal of scene's view
  if animationTimer ~= nil then
    timer.cancel(animationTimer)
  end
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
