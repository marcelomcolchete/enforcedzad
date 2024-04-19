local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_HASTE)
condition:setParameter(CONDITION_PARAM_TICKS, 2000)
--setFormula(mina,minb,maxa,maxb) Formula pra Condition speed
local x = 2
local formula = x * 40
condition:setFormula(x, formula, x, formula)
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	local summons = creature:getSummons()
	if summons and type(summons) == "table" and #summons > 0 then
		for i = 1, #summons do
			local summon = summons[i]
			local summon_t = summon:getType()
			if summon_t and summon_t:familiar() then
				local deltaSpeed = math.max(creature:getBaseSpeed() - summon:getBaseSpeed(), 0)
				local FamiliarSpeed = ((summon:getBaseSpeed() + deltaSpeed) * 0.3) - 24
				local FamiliarHaste = Condition(CONDITION_HASTE)
				FamiliarHaste:setParameter(CONDITION_PARAM_TICKS, 2000)
				FamiliarHaste:setParameter(CONDITION_PARAM_SPEED, FamiliarSpeed)
				summon:addCondition(FamiliarHaste)
			end
		end
	end
	return combat:execute(creature, variant)
end

spell:name("arqueiro impulse")
spell:words("arqueiro impulse")
spell:group("support")
spell:vocation("arqueiro;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_HASTE)
spell:id(5013)
spell:cooldown(5 * 1000)
spell:groupCooldown(0.1 * 1000)
spell:level(1)
spell:mana(0)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()
