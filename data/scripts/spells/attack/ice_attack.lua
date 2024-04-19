local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLICE)
combat:setFormula(COMBAT_FORMULA_DAMAGE, 60, 0, 60, 0)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 1000)
local x = 0.8
condition:setFormula(x, x * 40, x, x * 40)
combat:addCondition(condition)





combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(5016)
spell:name("Ice Attack")
spell:words("ice attack")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_ICE_STRIKE)
spell:level(1)
spell:mana(0)
spell:range(4)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(3 * 1000)
spell:groupCooldown(0.1 * 1000)
spell:needLearn(false)
spell:vocation("ice mage;true")
spell:register()
