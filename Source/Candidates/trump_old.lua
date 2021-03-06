
local trumpSpriteInfo = require("Source.Sprites.trumpSprite")
local trumpSprite = graphics.newImageSheet("Art/trump_sprite.png", trumpSpriteInfo:getSheet())

trump = {}
trump.__index = trump

local gravity = 4
local max_x_velocity = 20
local max_y_velocity = 35

local sprite_offset = 55

local function distance(x1, y1, x2, y2)
  return math.sqrt((x1-x2)^2 + (y1 - y2)^2)
end

function trump:create(x, y, group, min_x, max_x, effects)
  local candidate = display.newGroup()

  candidate.frames = {}
  for i = 1, #trumpSpriteInfo.sheet.frames do
    table.insert(candidate.frames, i)
  end

  candidate.name = "bro"
  candidate.short_name = "warren"

  candidate.parent_group = group
  candidate.parent_group:insert(candidate)

  candidate.sprite = display.newSprite(candidate, trumpSprite, {frames=candidate.frames})
  candidate.frameIndex = trumpSpriteInfo.frameIndex
  candidate.hitIndex = trumpSpriteInfo.hitIndex
  candidate.x = x
  candidate.y_offset = sprite_offset
  candidate.x_vel = 0
  candidate.y_vel = 0
  candidate.y = y + candidate.y_offset

  candidate.ground_target = display.contentCenterY + candidate.y_offset

  candidate.rotation_vel = 0

  candidate.min_x = min_x
  candidate.max_x = max_x

  candidate.after_image = display.newSprite(candidate, trumpSprite, {frames=candidate.frames})
  candidate.after_image.frameIndex = trumpSpriteInfo.frameIndex
  candidate.after_image.alpha = 0.5
  candidate.after_image.isVisible = false

  candidate.health = 30
  candidate.visibleHealth = 30

  candidate.action = nil
  candidate.damage_timer = 0
  candidate.damage_in_a_row = 0

  candidate.power = 10

  candidate.animationTimer = nil
  candidate.physicsTimer = nil

  candidate.frame = 1

  candidate.target = nil
  candidate.other_fighters = nil

  candidate.enabled = false

  function candidate:enable()
    self.enabled = true
    self.animationTimer = timer.performWithDelay(50, function() self:animationLoop() end, 0)
    self.physicsTimer = timer.performWithDelay(33, function() self:physicsLoop() end, 0)
  end

  function candidate:disable()
    self.enabled = false
    if self.animationTimer ~= nil then
      timer.cancel(self.animationTimer)
    end
    if self.physicsTimer ~= nil then
      timer.cancel(self.physicsTimer)
    end
    if self.automaticActionTimer ~= nil then
      timer.cancel(self.automaticActionTimer)
    end
  end

  function candidate:enableAutomatic()
    self.automaticActionTimer = timer.performWithDelay(500, function() self:automaticAction() end, 0)
  end

  function candidate:disableAutomatic()
    self.enabled = false
    if self.automaticActionTimer ~= nil then
      timer.cancel(self.automaticActionTimer)
    end
  end

  function candidate:automaticAction()
    -- do return end
    if self.target == nil then
      return
    end
    if self.target.action ~= "dizzy" and self.target.action ~= "ko" then
      if math.abs(self.x - self.target.x) > 80 then
        if math.random(1, 100) > 40 then
          self:moveAction(10 * self.xScale, 0)
        else
          self:punchingAction()
        end
      else
        if math.random(1, 100) > 90 then
          self:moveAction(10 * self.xScale, 0)
        else
          self:punchingAction()
        end
      end
    else
      local dice = math.random(1, 100)
      if dice > 85 then
        self:moveAction(10 * self.xScale, 0)
      elseif dice > 50 then
        self:moveAction(-10 * self.xScale, 0)
      end
    end
  end

  function candidate:punchingAction()
    if self.action == nil then
      self.frame = 1
      self.animationTimer._delay = 40
      self.action = "punching"
    end
  end

  function candidate:kickingAction()
    if self.action == nil then
      self.frame = 1
      self.animationTimer._delay = 40
      self.action = "kicking"
    end

    if self.action == "jumping" then
      self.action = "jump_kicking"
    end
  end

  function candidate:specialAction()
  end

  function candidate:moveAction(x_vel, y_vel)
    if self.action ~= nil then
      return
    end

    -- Set velocity in the direction of the touch
    self.x_vel = math.max(-1 * max_x_velocity, math.min(max_x_velocity, x_vel))
    self.y_vel = -1 * math.max(0, math.min(max_y_velocity, -1 * y_vel))
    
    -- check if there's substantial upward velocity, and if so, make this a jump
    if math.abs(self.y_vel) > max_y_velocity / 2 then
      self.action = "jumping"

      -- if the time to impact is sufficiently long, then this is a flipping jump
      time_to_impact = -2 * self.y_vel / gravity 
      if math.abs(self.y_vel) > max_y_velocity / 1.2 then
        local alternator = 1
        if self.x_vel < 0 or (self.xScale == -1 and self.x_vel < 0) then
          alternator = -1
        end
        self.rotation_vel = 360.0 / time_to_impact * alternator
      end
    end
  end

  function candidate:damageAction(actor, extra_vel)
    self.sprite:setFrame(self.frameIndex["damage"])
    self.after_image.isVisible = false
    self.x_vel = -15 * self.xScale
    if extra_vel ~= nil then
      self.x_vel = self.x_vel - extra_vel * self.xScale
    end
    self.y_vel = -5
    self.rotation = 15 * self.xScale
    self.damage_timer = 4
    self.health = self.health - actor.power
    self.damage_in_a_row = self.damage_in_a_row + 1
    self.action = "damaged"
    if self.damage_in_a_row > 3 or self.health <= 0 then
      self:koAction()
    end
  end

  function candidate:koAction()
    self.action = "ko"
    self.damage_timer = 55
    self.y_vel = -20
    self.x_vel = -23 * self.xScale
  end

  function candidate:restingAction()
    self.frame = 1
    self.after_image.isVisible = false
    self.animationTimer._delay = 50
    self.rotation = 0
    self.action = nil
  end

  function candidate:animationLoop()
    if self.action == nil then
      self:restingAnimation()
    elseif self.action == "kicking" then
      self:kickingAnimation()
    elseif self.action == "punching" then
      self:punchingAnimation()
    elseif self.action == "jumping" then
      self:jumpingAnimation()
    elseif self.action == "dizzy" then
      self:dizzyAnimation()
    elseif self.action == "ko" then
      self:koAnimation()
    end

    if (self.damage_timer > 0) then
      self.damage_timer = self.damage_timer - 1  
      if self.damage_timer <= 0 and self.health > 0 then
        self:restingAction()
        if self.damage_in_a_row >= 4 then
          self.action = "dizzy"
          self.damage_timer = 45
          self.damage_in_a_row = 0
          self.rotation_vel = -1 * math.random(50, 100) / 30 * self.xScale
        end
      end
    end
  end


  local resting_frames = {
    1
  }
  function candidate:restingAnimation()
    self.sprite:setFrame(resting_frames[self.frame])
    self.frame = self.frame + 1
    if (self.frame > #resting_frames) then
      self.frame = 1
    end
  end

  local kicking_frames = {
    1
  }
  function candidate:kickingAnimation()
  end

  local punching_frames = {
    3, 3, 3, 3,
  }
  function candidate:punchingAnimation()
    self.sprite:setFrame(punching_frames[self.frame])
    self.frame = self.frame + 1
    if (self.frame > #punching_frames) then
      self:restingAction()
    end
  end

  function candidate:jumpingAnimation()
    -- if display.contentCenterY + self.y_offset - self.y > 60 then
    --   self.sprite:setFrame(20) -- flip
    -- elseif self.y_vel < 0 then
    --   self.sprite:setFrame(19) -- go up
    -- elseif self.y_vel > 0 then
    --   self.sprite:setFrame(21) -- go down
    -- end
  end

  function candidate:dizzyAnimation()
    self.sprite:setFrame(2)
    if self.damage_timer % 9 == 0 then
      self.xScale = self.xScale * -1
    end
  end

  function candidate:koAnimation()
    if self.xScale == 1 and self.rotation > -90 and self.y_vel ~= 0 then
      self.rotation = self.rotation - 7
    elseif self.xScale == -1 and self.rotation < 90 and self.y_vel ~= 0 then
      self.rotation = self.rotation + 7
    end
  end

  function candidate:physicsLoop()
    if self.x + self.x_vel > self.min_x and self.x + self.x_vel < self.max_x then
      self.x = self.x + self.x_vel
    end
    self.y = self.y + self.y_vel

    if math.abs(self.y_vel) < max_y_velocity / 4 then
      self.x_vel = self.x_vel * 0.8
    else
      self.x_vel = self.x_vel * 0.9
    end

    if (self.action == "jumping" or self.action == "jump_kicking") and math.abs(self.rotation_vel) > 0 then
      self.rotation = self.rotation + self.rotation_vel
    end

    if self.health <= 0 then
      self.ground_target = 500
    end

    local current_ground_target = self.ground_target
    if self.action == "ko" then
      current_ground_target = current_ground_target + 60
    end

    if (self.y < current_ground_target) then
      self.y_vel = self.y_vel + gravity
    elseif (self.y >= current_ground_target and self.y_vel > 0) then
      self.y = current_ground_target
      self.y_vel = 0
      if self.action ~= "dizzy" then
        self.rotation_vel = 0
        self.rotation = 0
      end
      if self.action == "jumping" or self.action == "jump_kicking" then
        self.action = nil
      end
      if self.action == "ko" then
        self.rotation = 0
        self.sprite:setFrame(2)
      end
    end

    if self.target ~= nil then
      if self.x > self.target.x + 10 and self.xScale == 1 and self.action == nil then
        self.xScale = -1
      end

      if self.x < self.target.x - 10 and self.xScale == -1 and self.action == nil then
        self.xScale = 1
      end
    end

    self:hitDetection()
  end

  -- function candidate:hitDetection()
  --   if self.other_fighters == nil then
  --     return
  --   end
  --   for i = 1, #self.other_fighters do
  --     victim = self.other_fighters[i]
  --     if victim.action ~= "damaged" and victim.action ~= "ko" and self.action == "punching" then
  --       if (self.xScale == 1 and self.x -10 < victim.x and self.x + 105 > victim.x) or
  --         (self.xScale == -1 and self.x + 10 > victim.x and self.x - 105 < victim.x) then
  --         victim:damageAction(self)
  --       end
  --     end
  --   end
  -- end

  function candidate:hitDetection()
    if self.target == nil then
      return
    end

    frame = self.sprite.frame
    hitIndex = self.hitIndex[frame]
    if hitIndex == nil then
      return
    end

    -- for i = 1, #self.other_fighters do
    -- opponent = self.other_fighters[i]
    opponent = self.target
    print(opponent.action)

    if opponent.action ~= "damaged" and opponent.action ~= "ko" then

      opponent_frame = opponent.sprite.frame
      opponent_hitIndex = opponent.hitIndex[opponent_frame]

      collision = nil

      for j = 1, #hitIndex do
        if hitIndex[j].purpose ~= "vulnerability" and opponent_hitIndex ~= nil then
          for k = 1, #opponent_hitIndex do
            x1, y1 = self:localToContent(hitIndex[j].x, hitIndex[j].y)
            x2, y2 = opponent:localToContent(opponent_hitIndex[k].x, opponent_hitIndex[k].y)
            if distance(x1, y1, x2, y2) < hitIndex[j].radius + opponent_hitIndex[k].radius then
              if hitIndex[j].purpose == "attack" and opponent_hitIndex[k].purpose == "vulnerability" then
                collision = "damage"
              elseif collision == nil then
                collision = "reflect"
              end
            end
          end
        end
      end

      print(collision)

      if collision == "reflect" then
        self:moveAction(-15 * self.xScale, -5)
        opponent:moveAction(-15 * opponent.xScale, -5)
      elseif collision == "damage" then
        opponent:damageAction(self, 15 * self.xScale)
      end
    end
    -- end
  end

  return candidate
end

return trump