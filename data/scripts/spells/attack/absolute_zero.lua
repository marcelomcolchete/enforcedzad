local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
combat:setFormula(COMBAT_FORMULA_DAMAGE, 200, 0, 200, 0)

local stun = Condition(CONDITION_STUNNED)
stun:setParameter(CONDITION_PARAM_TICKS, 2000)
combat:addCondition(stun)

combat:setArea(createCombatArea({{
0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 0, 0},
{1, 1, 1, 1, 2, 1, 1, 1, 1},
{0, 0, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0}}))




local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(5015)
spell:name("Absolute Zero")
spell:words("absolute zero")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_ICE_WAVE)
spell:level(1)
spell:mana(0)
--spell:needDirection(true)
spell:cooldown(30 * 1000)
spell:groupCooldown(0.1 * 1000)
spell:needLearn(false)
spell:vocation("ice mage;true")
spell:register()
