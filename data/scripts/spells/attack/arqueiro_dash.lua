local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ARROW)
combat:setFormula(COMBAT_FORMULA_DAMAGE, 100, 0, 100, 0)

local area = createCombatArea({
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 1, 3, 1, 0 },
})
combat:setArea(area)

local spell = Spell("instant")

local function doCombat(combat, creatureId, var)
	local creature = Creature(creatureId)
	if not creature then
		return false
	end
	combat:execute(creature, var)
	local direction = creature:getDirection()
	local player = creature:getPlayer()
	-- 0-north 1-east 2-south 3-west
	if direction == 0 then
		direction = 2
	elseif direction == 2 then
		direction = 0
	elseif direction == 1 then
		direction = 3
	elseif direction == 3 then
		direction = 1
	end
	for i =1 , 3, 1 do
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
	local direction = creature:getDirection()
	local player = creature:getPlayer()
	if direction == 0 then
		player:setDirection(DIRECTION_SOUTH)
	elseif direction == 2 then
		player:setDirection(DIRECTION_NORTH)
	elseif direction == 1 then
		player:setDirection(DIRECTION_WEST)
	elseif direction == 3 then
		player:setDirection(DIRECTION_EAST)
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
spell:id(5011)
spell:name("Arqueiro Dash")
spell:words("arqueiro dash")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIRE_WAVE)
spell:level(1)
spell:mana(0)
spell:needDirection(true)
spell:cooldown(10 * 1000)
spell:groupCooldown(0.1 * 1000)
spell:needLearn(false)
spell:vocation("arqueiro;true")
spell:register()
