SMODS.DrawStep({
	key = "top_sprite",
	order = 590,
	func = function(self)
		if
			self.config.center.soul_pos
			and self.config.center.soul_pos.top
			and (self.config.center.discovered or self.bypass_discovery_center)
		then
			local scale_mod = 0.07 + 0.01*math.cos(1.8*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
			local rotate_mod = 0.04*math.cos(0.9*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL)*math.pi*4)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
			if not self.config.center.soul_pos.top.no_shadow then
                self.children.top_sprite:draw_shader(
                    "dissolve",
                    0,
                    nil,
                    nil,
                    self.children.center,
                    scale_mod,
                    rotate_mod,
                    nil,
                    0.1, -- + 0.03*math.cos(1.8*G.TIMERS.REAL),
                    nil,
                    0.6
                )
            end
			self.children.top_sprite:draw_shader(
				"dissolve",
				nil,
				nil,
				nil,
				self.children.center,
				scale_mod,
				rotate_mod
			)
		end
	end,
	conditions = { vortex = false, facing = "front" },
})
SMODS.draw_ignore_keys.top_sprite = true

local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
	set_spritesref(self, _center, _front)
	if _center and _center.soul_pos and _center.soul_pos.top then
		self.children.top_sprite = Sprite(
			self.T.x,
			self.T.y,
			self.T.w,
			self.T.h,
			G.ASSET_ATLAS[_center.atlas or _center.set],
			_center.soul_pos.top
		)
		self.children.top_sprite.role.draw_major = self
		self.children.top_sprite.states.hover.can = false
		self.children.top_sprite.states.click.can = false
	end
end