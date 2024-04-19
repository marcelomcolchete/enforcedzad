
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SLASH)
combat:setFormula(COMBAT_FORMULA_DAMAGE, 100, 0, 100, 0)


local area = createCombatArea({
	{ 0, 0, 0 },
	{ 0, 1, 0 },
	{ 1, 3, 1 },
})
combat:setArea(area)

local condition = Condition(CONDITION_BLEEDING)
condition:setParameter(CONDITION_PARAM_DELAYED, 10)
condition:addDamage(4, 2000, -25)
combat:addCondition(condition)


local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(5002)
spell:name("Horizontal Slash")
spell:words("horizontal slash")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIRE_WAVE)
spell:level(1)
spell:mana(0)
spell:needDirection(true)
spell:cooldown(3 * 1000)
spell:groupCooldown(0.1 * 1000)
spell:needLearn(false)
spell:vocation("samurai;true")
spell:register()
