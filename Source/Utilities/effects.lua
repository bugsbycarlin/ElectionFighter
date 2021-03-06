
effects = {}
effects.__index = effects

local dizzyTwit = require("Source.Utilities.dizzyTwit")
local projectile = require("Source.Utilities.projectile")

sounds = {}
sounds["punch"] = audio.loadSound("Sound/punch.wav")
sounds["swing_1"] = audio.loadSound("Sound/swing_1.wav")
sounds["swing_2"] = audio.loadSound("Sound/swing_2.wav")
sounds["swing_3"] = audio.loadSound("Sound/swing_3.wav")
sounds["whip_swing"] = audio.loadSound("Sound/whip_swing.wav")
sounds["whip_crack"] = audio.loadSound("Sound/whip_crack.wav")
sounds["block"] = audio.loadSound("Sound/block.wav")
sounds["damage_1"] = audio.loadSound("Sound/damage_1.wav")
sounds["damage_2"] = audio.loadSound("Sound/damage_2.wav")
sounds["damage_3"] = audio.loadSound("Sound/damage_3.wav")
sounds["damage_4"] = audio.loadSound("Sound/damage_4.wav")
sounds["damage_5"] = audio.loadSound("Sound/damage_5.wav")
sounds["damage_6"] = audio.loadSound("Sound/damage_6.wav")

function effects:create()

  local object = {}
  setmetatable(object, effects)

  object.effect_list = {}

  fighters = nil

  return object
end

function effects:update()
  copy_effect_list = {}
  for i = 1, #self.effect_list do
    self.effect_list[i]:update()
  end
  for i = 1, #self.effect_list do
    if self.effect_list[i]:finished() ~= true then
      table.insert(copy_effect_list, self.effect_list[i])
    else
      display.remove(self.effect_list[i].sprite)
    end
  end
  self.effect_list = copy_effect_list
end

function effects:addDizzyTwit(group, originator, x_center, y_center, width, period, duration)
  local twit = dizzyTwit:create(group, originator, x_center, y_center, width, period, duration)
  self:add(twit)
end

projectileTwit_x_vel = 18
projectileTwit_y_vel_max = 2
function effects:addProjectileTwit(group, originator, x, y, xScale)
  local x_vel = projectileTwit_x_vel * xScale
  local y_vel = (math.random(1,200) - 100) / (100 / projectileTwit_y_vel_max)
  local p = projectile:create("twit", group, originator, self.fighters, x, y, xScale, x_vel, y_vel)
  self:add(p)
end

projectileSteak_x_vel = 30
projectileSteak_y_vel_max = 2
function effects:addProjectileSteak(group, originator, x, y, xScale)
  local x_vel = projectileSteak_x_vel * xScale
  local y_vel = (math.random(1,200) - 100) / (100 / projectileSteak_y_vel_max)
  local p = projectile:create("steak", group, originator, self.fighters, x, y, xScale, x_vel, y_vel)
  p.sprite.xScale = xScale / 2
  p.sprite.yScale = 1/2
  p.hit_radius = p.hit_radius / 1.5
  p.gravity = 2
  p.rotation_vel = 10 * xScale
  self:add(p)
end

projectileGoldBar_x_vel = 28
projectileGoldBar_y_vel_max = 2
function effects:addProjectileGoldBar(group, originator, x, y, xScale)
  local x_vel = projectileGoldBar_x_vel * xScale
  local y_vel = (math.random(1,200) - 100) / (100 / projectileGoldBar_y_vel_max)
  local p = projectile:create("gold_bar", group, originator, self.fighters, x, y, xScale, x_vel, y_vel)
  p.sprite.xScale = xScale / 1.5
  p.sprite.yScale = 1/1.5
  p.hit_radius = p.hit_radius / 1.25
  p.gravity = 2
  p.y_vel = -8
  p.rotation_vel = 10 * xScale
  self:add(p)
end

projectilePhone_x_vel = 30
projectilePhone_y_vel_max = 2
function effects:addProjectilePhone(group, originator, x, y, xScale)
  local x_vel = projectilePhone_x_vel * xScale
  local y_vel = (math.random(1,200) - 100) / (100 / projectilePhone_y_vel_max)
  local p = projectile:create("phone", group, originator, self.fighters, x, y, xScale, x_vel, y_vel)
  p.sprite.xScale = xScale / 2
  p.sprite.yScale = 1/2
  p.hit_radius = p.hit_radius / 1.5
  p.gravity = 2
  p.rotation_vel = 10 * xScale
  self:add(p)
end

projectileSoda_x_vel = 30
projectileSoda_y_vel_max = 2
function effects:addProjectileSoda(group, originator, x, y, xScale)
  local x_vel = projectileSoda_x_vel * xScale
  local y_vel = (math.random(1,200) - 100) / (100 / projectileSoda_y_vel_max)
  local p = projectile:create("soda", group, originator, self.fighters, x, y, xScale, x_vel, y_vel)
  p.sprite.xScale = xScale / 2
  p.sprite.yScale = 1/2
  p.hit_radius = p.hit_radius / 1.5
  p.gravity = 2
  p.y_vel = -5
  p.rotation_vel = 10 * xScale
  self:add(p)
end

function effects:addBro(group, player, x_center, y_center, x_vel, y_vel, min_x, max_x)
  print("Adding a bro")
  if self.fighters == nil then
    print("Actually, can't add a bro because the effects system doesn't have a list of fighers.")
    return
  end
  local fighter = candidates["bro"]:create(x_center, y_center, group, min_x, max_x, self)
  fighter.target = player.target
  fighter.x_vel = x_vel
  fighter.y_vel = y_vel
  fighter.ally = player
  fighter.action = "jumping"
  fighter:enable()
  fighter:enableAutomatic()
  table.insert(self.fighters, fighter)
end

function effects:add(effect)
  table.insert(self.effect_list, effect)
end

function effects:playSound(sound)
  audio.play(sounds[sound], 0)
end

function effects:randomSwing()
  audio.play(sounds["swing_" .. math.random(1,3)], 0)
end

function effects:randomDamageSound()
  audio.play(sounds["damage_" .. math.random(1,6)], 0)
end

return effects