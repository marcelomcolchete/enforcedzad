local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ICE)
combat:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_ICEFIELD_PVP_FULL)
combat:setFormula(COMBAT_FORMULA_DAMAGE, 200, 0, 200, 0)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

local rune = Spell("rune")

function rune.onCastSpell(creature, var, isHotkey)
	return combat:execute(creature, var)
end

rune:id(5017)
rune:group("attack")
rune:name("ice field")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_FIRE_BOMB_RUNE)
rune:runeId(44781)
rune:allowFarUse(true)
rune:setPzLocked(true)
rune:charges(0)
rune:level(1)
rune:cooldown(10 * 1000)
rune:groupCooldown(0.1 * 1000)
rune:isBlocking(false) -- True = Solid / False = Creature
rune:register()
