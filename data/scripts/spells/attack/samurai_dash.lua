local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
local checkCharge = 2;
local spell = Spell("instant")

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
function resetSpellCooldown(player, spellId)
    -- procura uma spell existente com o id
	
    local spellreset = Spell(spellId)
    -- caso não seja encontrada um spell com esse id nada acontece
    --if not spellreset or not player then
        --return
    --end
    -- busca a condição de cooldown específicia daquela spell e retira do jogador
    player:removeCondition(CONDITION_SPELLCOOLDOWN, CONDITIONID_DEFAULT, spellId)
end

function resetCharges(creatureid)
	local creature = Creature(creatureid)
	if not creature then
		return
	end
	local player = creature:getPlayer()
	resetSpellCooldown(player, 5000)
	checkCharge = checkCharge + 1
end


function spell.onCastSpell(creature, variant)
	
	creature:setMoveLocked(true)
	creature:setDirectionLocked(true)
	
	if checkCharge == 2 then
		spell:cooldown(1)
		addEvent(resetCharges, 8000, creature:getId())
		checkCharge = 1
	elseif checkCharge == 1 then
		spell:cooldown(8 * 1000)
		addEvent(resetCharges, 8000, creature:getId())
		checkCharge = 0
	end

	local time = 1
	local direction = creature:getDirection()
	for i =1 , 4, 1 do
		addEvent(function()
			local position = creature:getPosition()
			position:getNextPosition(direction, 1)
			local tile = Tile(position)
			if tile:isWalkable(true, false, false, true) then
				creature:move(direction)
			end
		end, time)
		time = time + 100
	end
	addEvent(eventRemoveFreeze, 450, creature:getId())
	return combat:execute(creature, variant)
end


spell:name("Samurai Dash")
spell:words("samurai dash")
spell:group("attack")
spell:vocation("samurai;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_LIGHT)
spell:id(5000)
spell:cooldown(8 * 1000)
spell:groupCooldown(0.4 * 1000)
spell:level(1)
spell:mana(0)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()
