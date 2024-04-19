VOCATION = {
	ID = {
		NONE = 0,
		SORCERER = 1,
		DRUID = 2,
		PALADIN = 3,
		KNIGHT = 4,
		MASTER_SORCERER = 5,
		ELDER_DRUID = 6,
		ROYAL_PALADIN = 7,
		ELITE_KNIGHT = 8,
		SAMURAI = 9,
		ARQUEIRO = 10,
		ICEMAGE = 11
	},
	CLIENT_ID = {
		NONE = 0,
		KNIGHT = 1,
		PALADIN = 2,
		SORCERER = 3,
		DRUID = 4,
		ELITE_KNIGHT = 11,
		ROYAL_PALADIN = 12,
		MASTER_SORCERER = 13,
		ELDER_DRUID = 14,
		SAMURAI = 20,
		ARQUEIRO = 21,
		ICEMAGE = 22
	},
	BASE_ID = {
		NONE = 0,
		SORCERER = 1,
		DRUID = 2,
		PALADIN = 3,
		KNIGHT = 4,
		SAMURAI = 5,
		ARQUEIRO = 6,
		ICEMAGE = 7
	},
}

function Vocation.getBase(self)
	local base = self
	while base:getDemotion() do
		base = base:getDemotion()
	end
	return base
end
