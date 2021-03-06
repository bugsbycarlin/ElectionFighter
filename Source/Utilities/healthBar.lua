local frayingSpriteInfo =
{
    frames = {
        {
            -- frame_1
            x=0,
            y=0,
            width=240,
            height=20,

        },
        {
            -- frame_2
            x=0,
            y=20,
            width=240,
            height=20,

        },
        {
            -- frame_3
            x=0,
            y=40,
            width=240,
            height=20,
        },
    },

    sheetContentWidth = 240,
    sheetContentHeight = 60
}

healthBar = {}
healthBar.__index = healthBar

function healthBar:create(x, y, xScale, group)
  local object = {}
  setmetatable(object, healthBar)

  local bargroup = display.newGroup()
  group:insert(bargroup)

  object.background_bar = display.newImageRect(bargroup, "Art/black_background_bar.png", 244, 24)
  object.background_bar.x = x - 2 * xScale
  object.background_bar.y = y - 2 * xScale
  object.background_bar.xScale = xScale
  object.background_bar.anchorX = 0
  object.background_bar.anchorY = 0
  object.foreground_bar = display.newImageRect(bargroup, "Art/flag_health_bar.png", 240, 20)
  object.foreground_bar.x = x
  object.foreground_bar.y = y
  object.foreground_bar.xScale = xScale
  object.foreground_bar.anchorX = 0
  object.foreground_bar.anchorY = 0
  local sheet = graphics.newImageSheet("Art/fray.png", frayingSpriteInfo)
  object.overlay_bar = display.newSprite(bargroup, sheet, {frames={1,2,3}})
  -- object.overlay_bar = display.newImageRect(group, "Art/black_fraying_bar.png", 240, 20)
  object.overlay_bar.x = x + 240 * xScale
  object.overlay_bar.y = y
  object.overlay_bar.anchorX = 1
  object.overlay_bar.anchorY = 0
  object.overlay_bar.xScale = xScale
  object.overlay_bar.isVisible = false
  object.health_percent = 100
  return object
end

function healthBar:setHealth(health_percent)
  self.health_percent = health_percent
  self.overlay_bar.isVisible = false
  self.foreground_bar.isVisible = true
  if (self.health_percent < 100) then
    self.overlay_bar.isVisible = true
    self.overlay_bar:setFrame(math.random(1, 3))
    self.overlay_bar.xScale = self.foreground_bar.xScale * (100 - self.health_percent) / 100.0
    if (self.health_percent < 1) then
      self.foreground_bar.isVisible = false
      self.overlay_bar.isVisible = false
    end
  end
end

return healthBar