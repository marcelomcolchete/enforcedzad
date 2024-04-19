local combat1, combat2, combat3, combat4, combat5, combat6 = Combat(), Combat(), Combat(), Combat(), Combat(), Combat()
local combats = {combat1, combat2, combat3, combat4, combat5, combat6}

for _, combat in pairs(combats) do
	combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
	combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)--CONST_ME_HITAREA
	combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ARROW)
	--setsetFormula(type, mina, minb, maxa, maxb) neste caso usar mina e maxa para definir a variação do dano
	combat:setFormula(COMBAT_FORMULA_DAMAGE, 500, 0, 500, 0)
end


local area1 = createCombatArea({
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 3, 0, 0 },
})
local area2 = createCombatArea({
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 2, 0, 0 },
})
local area3 = createCombatArea({
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 2, 0, 0 },
})
local area4 = createCombatArea({
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 2, 0, 0 },
})
local area5 = createCombatArea({
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 2, 0, 0 },
})
local area6 = createCombatArea({
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 2, 0, 0 },
})
combat1:setArea(area1)
combat2:setArea(area2)
combat3:setArea(area3)
combat4:setArea(area4)
combat5:setArea(area5)
combat6:setArea(area6)

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()

	local min = (level / 5) + (skill + attack) * 0.5
	local max = (level / 5) + (skill + attack) * 1.5

	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
end
--combat1:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
--combat2:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
--combat3:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
--combat4:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
--combat5:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
--combat6:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")

local function doCombat(combat, creatureId, var)
	local creature = Creature(creatureId)
	if not creature then
		return false
	end
	combat:execute(creature, var)
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

function spell.onCastSpell(creature, variant)
	creature:setMoveLocked(true)
	creature:setDirectionLocked(true)
	addEvent(doCombat, 0, combat1, creature:getId(), variant)
	addEvent(doCombat, 100, combat2, creature:getId(), variant)
	addEvent(doCombat, 200, combat3, creature:getId(), variant)
	addEvent(doCombat, 300, combat4, creature:getId(), variant)
	addEvent(doCombat, 400, combat5, creature:getId(), variant)
	addEvent(doCombat, 500, combat6, creature:getId(), variant)
	addEvent(eventRemoveFreeze, 501, creature:getId())
	return true
end

spell:group("attack")
spell:id(5012)
spell:name("Final Arrow")
spell:words("final arrow")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIRE_WAVE)
spell:level(1)
spell:mana(0)
spell:needDirection(true)
spell:cooldown(10 * 1000)
spell:groupCooldown(0.5 * 1000)
spell:needLearn(false)
spell:vocation("arqueiro;true")
spell:register()
