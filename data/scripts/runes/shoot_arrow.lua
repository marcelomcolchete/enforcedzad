local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ARROW)
combat:setFormula(COMBAT_FORMULA_DAMAGE, 80, 0, 80, 0)


local rune = Spell("rune")

function rune.onCastSpell(creature, var, isHotkey)
	local player = creature:getPlayer()
	return combat:execute(creature, var)
end

rune:id(5010)
rune:group("attack")
rune:name("Shoot Arrow")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_ICICLE_RUNE)
rune:runeId(44780)
rune:allowFarUse(true)
rune:charges(0)
--rune:level(28)
--rune:magicLevel(4)
rune:cooldown(1 * 1000)
rune:groupCooldown(0.1 * 1000)
--rune:needTarget(true) -- True = Solid / False = Creature
rune:register()
