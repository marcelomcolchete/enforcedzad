local combatProtect = Combat()
combatProtect:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
combatProtect:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local effect = Combat()
effect:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
effect:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

-- Condition pra imortalidade
local skill = Condition(CONDITION_ATTRIBUTES)
skill:setParameter(CONDITION_PARAM_TICKS, 5000)
skill:setParameter(CONDITION_PARAM_BUFF_DAMAGERECEIVED, 1)
combatProtect:addCondition(skill)
-- Condition pra cura
local condition = Condition(CONDITION_REGENERATION)
condition:setParameter(CONDITION_PARAM_TICKS, 5000)
condition:setParameter(CONDITION_PARAM_HEALTHGAIN, 50)
condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 1000) -- 1sec
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
combatProtect:addCondition(condition)

local stun = Condition(CONDITION_STUNNED)
stun:setParameter(CONDITION_PARAM_TICKS, 5000)
combatProtect:addCondition(stun)


local function eventRemoveFreeze(creatureid)
	local creature = Creature(creatureid)
	if not creature then
		return
	end

	if creature:isMoveLocked() then
		creature:setMoveLocked(false)
	end

	if creature:isDirectionLocked() then
		creature:setDirectionLocked(false)
	end
end

local function doCombat(combat, creatureId, var)
	local creature = Creature(creatureId)
	if not creature then
		return false
	end
	combat:execute(creature, var)
end

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	--creature:setMoveLocked(true)
	--creature:setDirectionLocked(true)
	combatProtect:execute(creature, variant)
	local effectTime = 500
	for i = 1 , 9 do
		addEvent(doCombat, effectTime, effect, creature:getId(), variant)
		effectTime = effectTime + 500
	end
	addEvent(eventRemoveFreeze, 5000, creature:getId())
    return true
end
-- SEM O GROUP COLDOWN TU AINDA CONSEGUE USAR SKILLS MESMO ENQUANTO TÁ CONGELADO
spell:name("Ice Protect")
spell:words("ice protect")
spell:group("attack")
spell:vocation("ice mage;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_HASTE)
spell:id(5014)
spell:cooldown(20 * 1000)
spell:groupCooldown(0.1 * 1000)
spell:level(1)
spell:mana(0)
spell:isSelfTarget(true)
spell:isAggressive(true)
spell:needLearn(false)
spell:register()
