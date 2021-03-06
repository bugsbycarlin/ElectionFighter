
candidate = {}
candidate.__index = candidate

local whooping_threshold = 7

local function distance(x1, y1, x2, y2)
  return math.sqrt((x1-x2)^2 + (y1 - y2)^2)
end

function candidate:create(x, y, group, min_x, max_x, effects_thingy, sprite_offset)
  local tim = display.newGroup()

  tim.name = "tim"
  tim.short_name = "tim"

  tim.effects_thingy = effects_thingy

  tim.parent_group = group
  tim.parent_group:insert(tim)

  tim.x = x
  tim.y_offset = sprite_offset
  tim.x_vel = 0
  tim.y_vel = 0
  tim.y = y + tim.y_offset
  tim.rotation_vel = 0

  -- default values if none other are supplied
  tim.gravity = 4
  tim.resting_rate = 60
  tim.action_rate = 40
  tim.automatic_rate = 500
  tim.max_x_velocity = 20
  tim.max_y_velocity = 35
  tim.action_window = 1500
  tim.power = 10
  tim.knockback = 12
  tim.blocking_max_frames = 30

  tim.max_health = 100
  tim.health = tim.max_health
  tim.visible_health = tim.max_health

  tim.ko_frame = 1

  tim.swipe_history = {}

  tim.min_x = min_x
  tim.max_x = max_x

  tim.action = "resting"

  tim.damage_timer = 0
  tim.damage_in_a_row = 0

  tim.ground_target = display.contentCenterY + tim.y_offset

  tim.animationTimer = nil
  tim.physicsTimer = nil

  tim.frame = 1

  tim.target = nil
  tim.fighters = nil

  tim.enabled = false

  tim.animations = {}

  tim.attack = nil

  function tim:setMaxHealth(max_health)
    self.max_health = max_health
    self.health = max_health
    self.visible_health = max_health
  end

  function tim:enable()
    self.enabled = true
    self.animationTimer = timer.performWithDelay(self.resting_rate, function() self:animationLoop() end, 0)
    self.physicsTimer = timer.performWithDelay(33, function() self:physicsLoop() end, 0)
  end

  function tim:disable()
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

  function tim:enableAutomatic()
    self.automaticActionTimer = timer.performWithDelay(self.automatic_rate, function() self:automaticAction() end, 0)
  end

  function tim:disableAutomatic()
    self.enabled = false
    if self.automaticActionTimer ~= nil then
      timer.cancel(self.automaticActionTimer)
    end
  end

  function tim:automaticAction()
    
  end

  function tim:punchingAction()
    if self.action == "resting" then
      self.frame = 1
      self.animationTimer._delay = self.action_rate
      self.action = "punching"
      self.attack = {power=tim.power, knockback=tim.knockback}
    elseif self.action == "jumping" then
      self:jumpAttackAction()
    end
  end

  function tim:kickingAction()
    if self.action == "resting" then
      self.frame = 1
      self.animationTimer._delay = self.action_rate
      self.action = "kicking"
      self.attack = {power=tim.power, knockback=tim.knockback}
    elseif self.action == "jumping" then
      self:jumpAttackAction()
    end
  end

  function tim:jumpingAction()
    self.action = "jumping"
  end

  function tim:jumpAttackAction()
    self.action = "jump_kicking"
    self.frame = 1
    self.attack = {power=tim.power, knockback=tim.knockback}
  end

  function tim:specialAction()

  end

  function tim:checkSpecialAction()

  end

  function tim:moveAction(x_vel, y_vel)
    if self.action ~= "resting" then
      return
    end

    self:forceMoveAction(x_vel, y_vel)
  end

  function tim:forceMoveAction(x_vel, y_vel)
    -- Set velocity in the direction of the touch
    self.x_vel = math.max(-1 * self.max_x_velocity, math.min(self.max_x_velocity, x_vel))
    self.y_vel = math.max(-1 * self.max_y_velocity, math.min(self.max_y_velocity, y_vel))
    -- to do: only do this on voluntary moves.
    table.insert(self.swipe_history, {x_vel=self.x_vel, y_vel=self.y_vel, time=system.getTimer()})

    if self:checkSpecialAction(x_vel, y_vel) then
      return
    end
    
    -- check if there's substantial upward velocity, and if so, make this a jump
    if self.y_vel < -1 * self.max_y_velocity / 2 then
      self:jumpingAction()
    elseif math.abs(self.y_vel) < self.max_y_velocity / 6 then
      self.y_vel = 0
    end
  end

  function tim:adjustVelocity(x_vel_delta, y_vel_delta)
    -- Add velocity to existing velocity
    self.x_vel = math.max(-1 * self.max_x_velocity, math.min(self.max_x_velocity, self.x_vel + x_vel_delta))
    self.y_vel = math.max(-1 * self.max_y_velocity, math.min(self.max_y_velocity, self.y_vel + y_vel_delta))

    -- check if there's substantial upward velocity, and if so, make this a jump
    -- if self.y_vel < -1 * self.max_y_velocity / 2 then
    --   self:jumpingAction()
    -- elseif math.abs(self.y_vel) < self.max_y_velocity / 6 then
    --   self.y_vel = 0
    -- end
  end

  function tim:blockingAction()
    self.sprite:setFrame(self.blocking_frames[1])
    self.after_image.isVisible = false
    self.animationTimer._delay = self.resting_rate
    self.rotation = 0
    self.action = "blocking"
  end

  function tim:damageAction(type, damage_value, knockback, y_vel, rotation)
    self.after_image.isVisible = false
    self.health = self.health - damage_value
    self:adjustVelocity(knockback * -1 * self.xScale, y_vel)
    self.rotation = rotation * self.xScale
    self.animationTimer._delay = self.resting_rate
    
    if type == "damaged" then
      self.sprite:setFrame(self.damaged_frames[1])
      self.damage_timer = 4
      self.action = "damaged"
      if self.damage_in_a_row >= whooping_threshold or self.health <= 0 then
        self:koAction()
      end
    elseif type == "knockback" then
      self.sprite:setFrame(self.blocking_frames[1])
      self.action = "knockback"
    end
  end

  -- function tim:damageAction(actor, extra_vel)
  --   self.sprite:setFrame(self.damaged_frames[1])
  --   self.after_image.isVisible = false
  --   self.x_vel = -20 * self.xScale
  --   if extra_vel ~= nil then
  --     self.x_vel = self.x_vel + extra_vel * self.xScale
  --   end
  --   self.y_vel = -5
  --   self.rotation = 15 * self.xScale
  --   self.damage_timer = 4
  --   self.health = self.health - actor.power
  --   self.damage_in_a_row = self.damage_in_a_row + 1
  --   self.action = "damaged"
  --   if self.damage_in_a_row > 3 or self.health <= 0 then
  --     self:koAction()
  --   end
  -- end

  function tim:koAction()
    self.action = "ko"
    self.damage_timer = 55
    self.y_vel = -20
    self.x_vel = -25 * self.xScale
  end

  function tim:dizzyAction()
    if self.action == "ko" then
      self.y = self.y - 60
    end
    self.action = "dizzy"
    self.animations["dizzy"](self)
    self.damage_timer = 45
    self.damage_in_a_row = 0
    for i = 1, 3, 1 do
      self.effects_thingy:addDizzyTwit(self, self, 0, -110 + math.random(1,20), 40 + math.random(1,20), 2250)
    end
  end

  function tim:celebratingAction()
    self.frame = 1
    self.after_image.isVisible = false
    self.animationTimer._delay = self.resting_rate
    self.rotation = 0
    self.action = "celebrating"
  end

  function tim:restingAction()
    self.frame = 1
    self.after_image.isVisible = false
    self.animationTimer._delay = self.resting_rate
    self.rotation = 0
    self.action = "resting"
  end

  function tim:animationLoop()
    if self.animations[self.action] ~= nil then
      self.animations[self.action](self)
    end

    if (self.damage_timer > 0) then
      self.damage_timer = self.damage_timer - 1  
      if self.damage_timer <= 0 and self.health > 0 then
        if self.action == "ko" then
          self:dizzyAction()
        else
          self:restingAction()
        end
      end
    end
  end

  tim.animations["resting"] = function(self)
    self.sprite:setFrame(resting_frames[self.frame])
    self.frame = self.frame + 1
    if (self.frame > #resting_frames) then
      self.frame = 1
    end
  end

  tim.animations["blocking"] = function(self)
    self.sprite:setFrame(self.blocking_frames[1])
    self.frame = self.frame + 1
    if self.frame > self.blocking_max_frames then
      self:restingAction()
    end
  end

  tim.animations["knockback"] = function(self)
    self.sprite:setFrame(self.blocking_frames[1])
  end

  function tim:physicsLoop()
    if #self.swipe_history > 0 
      and system.getTimer() - self.swipe_history[#self.swipe_history].time > self.action_window then
      self.swipe_history = {}
    end

    if self.x + self.x_vel > self.min_x and self.x + self.x_vel < self.max_x then
      self.x = self.x + self.x_vel
    end
    if self.action ~= "pre_jumping" then
      self.y = self.y + self.y_vel
    end

    if math.abs(self.y_vel) < self.max_y_velocity / 4 and self.action ~= "ultra_punching" then
      self.x_vel = self.x_vel * 0.8
    else
      self.x_vel = self.x_vel * 0.9
    end

    if (self.action == "jumping" or self.action == "jump_kicking") and math.abs(self.rotation_vel) > 0 then
      self.rotation = self.rotation + self.rotation_vel
    end

    local current_ground_target = self.ground_target
    if self.action == "ko" then
      current_ground_target = current_ground_target + 60
    end

    if self.action == "knockback" and math.abs(self.x_vel) < self.max_x_velocity / 10 then
      self:restingAction()
    end

    if (self.y < current_ground_target) then
      if self.action ~= "ultra_punching" then
        self.y_vel = self.y_vel + self.gravity
      else
        self.y_vel = self.y_vel + self.gravity / 2
      end
    elseif (self.y >= current_ground_target and self.y_vel > 0) then
      self.y = current_ground_target
      self.y_vel = 0
      if self.action ~= "dizzy" then
        self.rotation_vel = 0
        self.rotation = 0
      end
      if self.action == "jumping" or self.action == "jump_kicking" then
        self:restingAction()
      end
      if self.action == "ko" then
        self.rotation = 0
        self.sprite:setFrame(self.ko_frame)
      end
    end

    if self.target ~= nil then
      if self.x > self.target.x + 10 and self.xScale == 1 and self.action == "resting" then
        self.xScale = -1
      end

      if self.x < self.target.x - 10 and self.xScale == -1 and self.action == "resting" then
        self.xScale = 1
      end
    end

    self:hitDetection()
  end

  function tim:hitDetection()
    -- Each sprite frame has a covering of circles marked "attack", "vulnerability", or "defense".
    -- A collision happens when Alice's circles touch Bob's circles.
    -- But it's necessary to resolve all the different touch points at once, symmetrically.
    -- That is, Alice is doing several things to Bob and Bob is doing several things to Alice,
    -- and these must all be boiled down to a result for Alice and a result for Bob.

    -- The priority list of results is as follows.
    -- Highest: recieve full damage and full knockback, action set to "damaged"
    -- recieve partial damage and partial knockback, action set to "knockback"
    -- recieve full knockback, action set to "knockback"
    -- recieve partial knockback, action unchanged (eg "block")
    -- Lowest: slow approach velocity, action unchanged
    -- priority = {
    --   5="full_damage",
    --   4="partial_damage",
    --   3="full_knockback",
    --   2="partial_knockback",
    --   1="slowdown",
    -- }

    -- For each other fighter, all collisions are examined. Each collision generates a result for Alice and a result for Bob.
    -- For instance, if Alice's attack touches Bob's vulnerability, the result is that Bob recieves full damage and full knockback,
    -- and his action is set to "damaged".
    -- Or, if Alice's attack touches Bob's attack, the result is both Alice and Bob recieve partial damage and partial knockback.

    -- The highest priority effect is chosen for each fighter independent of the other.

    -- To prevent a single attack landing multiple times, if any attack surface is touching, the fighter's attack is *deactivated*.
    -- If the fighter's attack is deactivated, attack circles are ignored. It will take a new attack to reactivate and deal damage again.

    -- Note that since there are potentially more than two fighters, a player can potentially collide multiple times.

    -- first, get the list of fighters, using {self.target} if necessary, and return if it's empty. 
    hit_list = self.fighters
    if hit_list == nil then
      hit_list = {self.target}
    end
    if hit_list == nil then
      return
    end

    -- then, get the hit detection circles for the fighter's current frame
    frame = self.sprite.frame
    hitIndex = self.hitIndex[frame]
    if hitIndex == nil then
      return
    end

    -- determines how much the circles have to touch before it counts as a collision. higher value prevents over-sensitive collisions.
    local insensitivity = 4

    -- Loop through fighters (skipping self)
    for i = 1, #hit_list do
      opponent = hit_list[i]

      fighter_result = -1
      opponent_result = -1

      if opponent ~= self and (self.ally == nil or self.ally ~= opponent) and (opponent.ally == nil or opponent.ally ~= self) then
        -- Get the opponent's hit detection circles
        opponent_frame = opponent.sprite.frame
        opponent_hitIndex = opponent.hitIndex[opponent_frame]

        -- if self.name == "bro" then
        --   print("ally")
        --   print(self.ally.name)
        --   print("opponent")
        --   print(opponent.name)
        --   print(self.ally == opponent)
        -- end

        for j = 1, #hitIndex do
          for k = 1, #opponent_hitIndex do
            x1, y1 = self:localToContent(hitIndex[j].x, hitIndex[j].y)
            x2, y2 = opponent:localToContent(opponent_hitIndex[k].x, opponent_hitIndex[k].y)
            if distance(x1, y1, x2, y2) < hitIndex[j].radius + opponent_hitIndex[k].radius - insensitivity then
              -- a collision has occured. Determine the consequence based on the type.
              if self.attack ~= nil and hitIndex[j].purpose == "attack" and opponent_hitIndex[k].purpose == "vulnerability" then
                -- Alice hits Bob in his vulnerability. Full damage to Bob and nothing to Alice.
                opponent_result = math.max(opponent_result, 5)
              elseif self.attack ~= nil and hitIndex[j].purpose == "attack" and opponent.attack ~= nil and opponent_hitIndex[k].purpose == "attack" then
                -- Alice and Bob punch each other in the fists. Partial damage each.
                fighter_result = math.max(fighter_result, 4)
                opponent_result = math.max(opponent_result, 4)
              elseif self.attack ~= nil and hitIndex[j].purpose == "attack" and opponent_hitIndex[k].purpose == "defense" then
                -- Alice punches Bob in his defense surface. Full knockback for Alice, partial knockback for Bob.
                fighter_result = math.max(fighter_result, 3)
                opponent_result = math.max(opponent_result, 2)
              elseif hitIndex[j].purpose == "defense" and opponent.attack ~= nil and opponent_hitIndex[k].purpose == "attack" then
                -- Bob punches Alice in her defense surface. Full knockback for Bob, partial knockback for Alice.
                fighter_result = math.max(fighter_result, 2)
                opponent_result = math.max(opponent_result, 3)
              elseif hitIndex[j].purpose == "defense" and opponent_hitIndex[k].purpose == "defense" then
                -- defense on defense contact is made. Slow approach velocities for both.
                fighter_result = math.max(fighter_result, 1)
                opponent_result = math.max(opponent_result, 1)
              elseif hitIndex[j].purpose == "defense" and opponent_hitIndex[k].purpose == "vulnerability" then
                -- defense on vulnerability contact is made. Slow approach velocities for both.
                fighter_result = math.max(fighter_result, 1)
                opponent_result = math.max(opponent_result, 1)
              elseif hitIndex[j].purpose == "vulnerability" and opponent.attack ~= nil and opponent_hitIndex[k].purpose == "attack" then
                -- Bob hits alice in her vulnerability. Full damage to Alice and nothing to Bob.
                fighter_result = math.max(fighter_result, 5)
              elseif hitIndex[j].purpose == "vulnerability" and opponent_hitIndex[k].purpose == "defense" then
                -- defense on vulnerability contact is made. Slow approach velocities for both.
                fighter_result = math.max(fighter_result, 1)
                opponent_result = math.max(opponent_result, 1)
              elseif hitIndex[j].purpose == "vulnerability" and opponent_hitIndex[k].purpose == "vulnerability" then
                -- Vulnerability on vulnerability contact is made. Slow approach velocities for both.
                fighter_result = math.max(fighter_result, 1)
                opponent_result = math.max(opponent_result, 1)
              end
            end
          end
        end

        -- Now we have planned results for both the fighter and the opponent. Time to resolve the results.
        symmetric_pair = {
          {fighter_result, self, opponent},
          {opponent_result, opponent, self},
        }
        if fighter_result >= 1 or opponent_result >= 1 then
          print("new collision frame")
        end
        for p = 1, #symmetric_pair do
          local result = symmetric_pair[p][1]
          local A = symmetric_pair[p][2]
          local B = symmetric_pair[p][3]
          if result >= 1 then
            print(A.name .. " gets " .. result)
          end
        
          if result == 5 then
            -- full damage and full knockback for the fighter
            A.effects_thingy:randomDamageSound()
            B.damage_in_a_row = 0
            A.damage_in_a_row = A.damage_in_a_row + 1
            A:damageAction("damaged", B.attack.power, B.attack.knockback, -5, 15)
          elseif result == 4 then
            -- partial damage and partial knockback for the fighter
            -- (note this is one sided, because what happens to the other fighter is independent)
            A.effects_thingy:randomDamageSound()
            B.damage_in_a_row = 0
            A:damageAction("knockback", B.attack.power / 2, A.attack.knockback / 2, 0, 0)
          elseif result == 3 then
            -- full knockback for the fighter
            A.effects_thingy:randomDamageSound()
            -- A:damageAction("knockback", 0, A.attack.knockback, 0, 0)
            A:adjustVelocity(A.attack.knockback * -2 * A.xScale, 0)
          elseif result == 2 then
            -- partial knockback for the fighter
            A.effects_thingy:randomDamageSound()
            -- A:damageAction("knockback", 0, B.attack.knockback / 2, 0, 0)
            -- A:adjustVelocity(B.attack.knockback * -0.5 * A.xScale, 0)
            A:damageAction("knockback", B.attack.power / 8, B.attack.knockback * 0.5, 0, 0)
          elseif result == 1 then
            -- if the fighter's x velocity is approaching the opponent, curtail it.
            -- BUT WHAT ABOUT ULTRA PUNCHING?
            if A.x < B.x and A.x_vel > 0 then
              A.x_vel = A.x_vel * 0.6
            elseif A.x > B.x and A.x_vel < 0 then
              A.x_vel = A.x_vel * 0.6
            end
          end
        end

        if opponent_result >= 4 or opponent_result == 2  or fighter_result == 3 then
          self.attack = nil
        end
        if fighter_result >= 4 or fighter_result == 2  or opponent_result == 3 then
          opponent_attack = nil
        end
      end
    end

  end

  return tim
end

return candidate