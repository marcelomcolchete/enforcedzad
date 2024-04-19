local combat = Combat()
local dash = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SLASH)
combat:setFormula(COMBAT_FORMULA_DAMAGE, 600, 0, 600, 0)

local area = createCombatArea({
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 3, 0, 0 },
})
combat:setArea(area)

local condition = Condition(CONDITION_BLEEDING)
condition:setParameter(CONDITION_PARAM_DELAYED, 10)
--addDamage(rounds,time,value)
condition:addDamage(4, 2000, -25)
combat:addCondition(condition)

--combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")

local function doCombat(combat, creatureId, var)
	local creature = Creature(creatureId)
	if not creature then
		return false
	end
	combat:execute(creature, var)
	local direction = creature:getDirection()
	for i =1 , 5, 1 do
		local position = creature:getPosition()
		position:getNextPosition(direction, 1)
		local tile = Tile(position)
		if tile:isWalkable(false, false, false, true) then
			creature:move(direction)
		end
	end
	
end
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

function spell.onCastSpell(creature, var)
	creature:setMoveLocked(true)
	creature:setDirectionLocked(true)
	addEvent(doCombat, 0, combat, creature:getId(), var)
	addEvent(eventRemoveFreeze, 100, creature:getId())
	return true
end

spell:group("attack")
spell:id(5001)
spell:name("Final Slash")
spell:words("final slash")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIRE_WAVE)
spell:level(1)
spell:mana(0)
spell:needDirection(true)
spell:cooldown(25 * 1000)
spell:groupCooldown(0.1 * 1000)
spell:needLearn(false)
spell:vocation("samurai;true")
spell:register()
