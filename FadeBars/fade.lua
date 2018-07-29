--No Idea What I Am Doing
local _, core = ...;
core.Fade = {};

local Fade = core.Fade;

--Fallback Variables  Replaced After Load
options = {
	["fadeopacity"] = 0.1,
	["hoveropacity"] = 1,
	["combatfadeopacity"] = 0.5,
	["combathoveropacity"] = 1,
	["fadeintime"] = 0.25,
	["fadeouttime"] = 0.5,
	["fademenubar"] = true,
	["setfadecombat"] = true;
	
}
local incombat = false;

local currentfadeopacity = 0.1;
local currenthoveropacity = 1;
local currentmenubaropacity = 1;

-- end Variables
-- functions

-- Setting variables from saved
function Fade:setupVariables ()
	
	
	--print(SavedSettings);	
	options = SavedSettings;
	if incombat == true then
		currentfadeopacity = options["combatfadeopacity"];
		currenthoveropacity = options["combathoveropacity"];
	else
		currentfadeopacity = options["fadeopacity"];
		currenthoveropacity = options["hoveropacity"];
	end
MultiBarLeft:EnableMouse(true)
MultiBarLeft:SetAlpha(currentfadeopacity);
MultiBarRight:EnableMouse(true)
MultiBarRight:SetAlpha(currentfadeopacity);
MainMenuBar:EnableMouse(true);
if options["fademenubar"] == true then
		MainMenuBar:SetAlpha(currentfadeopacity);
	else 
		MainMenuBar:SetAlpha(1);
end

end
-------------------------------------------------------



-------------------------------------------------------
--Set for combat opacity -- Called from event handler
-------------------------------------------------------
function Fade:combatVariables()
	
	--print("called combatVariables function");
	
	if options["setfadecombat"] == true then
		currentfadeopacity = options["combatfadeopacity"];
		currenthoveropacity = options["combathoveropacity"];
		UIFrameFadeOut(MultiBarLeft, options["fadeouttime"], MultiBarLeft:GetAlpha(), currentfadeopacity);
		UIFrameFadeOut(MultiBarRight, options["fadeouttime"], MultiBarRight:GetAlpha(), currentfadeopacity);
		--MultiBarLeft:SetAlpha(currentfadeopacity);
		--MultiBarRight:SetAlpha(currentfadeopacity);
		if options["fademenubar"] == true then
			currentmenubaropacity = options["combatfadeopacity"];
			UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentmenubaropacity);
			--MainMenuBar:SetAlpha(currentfadeopacity);
		else 
			UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), 1);
			--MainMenuBar:SetAlpha(1);
		end
	end
	incombat = true;
	
return
end

function Fade:endcombatVariables()
	
	--print("called ENDcombatVariables function");
	
	
	if options["setfadecombat"] == true then
	
		currentfadeopacity = options["fadeopacity"];
		currenthoveropacity = options["hoveropacity"];
		UIFrameFadeOut(MultiBarLeft, options["fadeouttime"], MultiBarLeft:GetAlpha(), currentfadeopacity);
		UIFrameFadeOut(MultiBarRight, options["fadeouttime"], MultiBarRight:GetAlpha(), currentfadeopacity);
		if options["fademenubar"] == true then
			currentmenubaropacity = options["fadeopacity"];
			UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentmenubaropacity);
		else 
			UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), 1);
			--MainMenuBar:SetAlpha(1);
		end
	end
	incombat = false;
	
return
end

----------------------------------------------
--Update Variables and SavedSettings
----------------------------------------------
function Fade:updateCurrentVariables()
	if incombat == false then
	currentfadeopacity = options["fadeopacity"];
	currenthoveropacity = options["hoveropacity"];
	elseif incombat == true  and options["setfadecombat"] == true then
	currentfadeopacity = options["combatfadeopacity"];
	currenthoveropacity = options["combathoveropacity"];
	elseif incombat == true and options["setfadecombat"] == false then
		currentfadeopacity = options["fadeopacity"];
		currenthoveropacity = options["hoveropacity"];
	end

	UIFrameFadeOut(MultiBarLeft, options["fadeouttime"], MultiBarLeft:GetAlpha(), currentfadeopacity);
	UIFrameFadeOut(MultiBarRight, options["fadeouttime"], MultiBarRight:GetAlpha(), currentfadeopacity);
	
	if options["fademenubar"] == true then
		currentmenubaropacity = currentfadeopacity;
		UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentmenubaropacity);
		--MainMenuBar:SetAlpha(currentfadeopacity);

	else 
		currentmenubaropacity = 1;
		UIFrameFadeOut(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), 1);
		--MainMenuBar:SetAlpha(1);

	end
	
end


-----------------------------------------------

local function showbar1()
	UIFrameFadeIn(MultiBarLeft, options["fadeintime"], MultiBarLeft:GetAlpha(), currenthoveropacity)

end

local function hidebar1()
	UIFrameFadeOut(MultiBarLeft, options["fadeouttime"], MultiBarLeft:GetAlpha(), options["fadeopacity"])
end


MultiBarLeft:HookScript("OnEnter", showbar1)
MultiBarLeft:HookScript("OnLeave", hidebar1)



 for btn=1,12 do
    _G["MultiBarLeftButton"..btn]:HookScript("OnEnter", showbar1)
    _G["MultiBarLeftButton"..btn]:HookScript("OnLeave", hidebar1)
 end
--Left Bar Start End

--RightBar Start


local function showbar2()
	UIFrameFadeIn(MultiBarRight, options["fadeintime"], MultiBarRight:GetAlpha(), currenthoveropacity)
end
	
local function hidebar2()
	UIFrameFadeOut(MultiBarRight, options["fadeouttime"], MultiBarRight:GetAlpha(), currentfadeopacity)
end

MultiBarRight:HookScript("OnEnter", showbar2)
MultiBarRight:HookScript("OnLeave", hidebar2)

for btn=1,12 do
    _G["MultiBarRightButton"..btn]:HookScript("OnEnter", showbar2)
    _G["MultiBarRightButton"..btn]:HookScript("OnLeave", hidebar2)
end

--RightBar End

local function showmenubar1()
	
	
			UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), 1);
			--print("Showing Bar");
			--MainMenuBar:SetAlpha(1);
			
	--UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity)
end

local function hidemenubar1()
	if options["fademenubar"] == true then
			currentmenubaropacity = currentfadeopacity;
			UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentmenubaropacity);
			--MainMenuBar:SetAlpha(currentfadeopacity);
			--print("fading");
		else 
			UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), 1);
			--MainMenuBar:SetAlpha(1);
			--print("Should still be showing bar even if hide function");
		end
	
	--UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity)
end




MainMenuBar:HookScript("OnEnter",showmenubar1);
MainMenuBar:HookScript("OnLeave",hidemenubar1);
MainMenuBarArtFrame:HookScript("OnEnter",showmenubar1);
MainMenuBarArtFrame:HookScript("OnLeave",hidemenubar1);
MultiBarBottomLeft:HookScript("OnEnter",showmenubar1);
MultiBarBottomLeft:HookScript("OnLeave",hidemenubar1);
MultiBarBottomRight:HookScript("OnEnter",showmenubar1);
MultiBarBottomRight:HookScript("OnLeave",hidemenubar1);
MicroButtonAndBagsBar:HookScript("OnEnter",showmenubar1);
MicroButtonAndBagsBar:HookScript("OnLeave",hidemenubar1);
MainMenuBarBackpackButton:HookScript("OnEnter",showmenubar1);
MainMenuBarBackpackButton:HookScript("OnLeave",hidemenubar1);
CharacterMicroButton:HookScript("OnEnter",showmenubar1);
CharacterMicroButton:HookScript("OnLeave",hidemenubar1);
SpellbookMicroButton:HookScript("OnEnter",showmenubar1);
SpellbookMicroButton:HookScript("OnLeave",hidemenubar1);
TalentMicroButton:HookScript("OnEnter",showmenubar1);
TalentMicroButton:HookScript("OnLeave",hidemenubar1);
TalentMicroButton:HookScript("OnEnter",showmenubar1);
TalentMicroButton:HookScript("OnLeave",hidemenubar1);
AchievementMicroButton:HookScript("OnEnter",showmenubar1);
AchievementMicroButton:HookScript("OnLeave",hidemenubar1);
QuestLogMicroButton:HookScript("OnEnter",showmenubar1);
QuestLogMicroButton:HookScript("OnLeave",hidemenubar1);
GuildMicroButton:HookScript("OnEnter",showmenubar1);
GuildMicroButton:HookScript("OnLeave",hidemenubar1);
LFDMicroButton:HookScript("OnEnter",showmenubar1);
LFDMicroButton:HookScript("OnLeave",hidemenubar1);
CollectionsMicroButton:HookScript("OnEnter",showmenubar1);
CollectionsMicroButton:HookScript("OnLeave",hidemenubar1);
EJMicroButton:HookScript("OnEnter",showmenubar1);
EJMicroButton:HookScript("OnLeave",hidemenubar1);
StoreMicroButton:HookScript("OnEnter",showmenubar1);
StoreMicroButton:HookScript("OnLeave",hidemenubar1);
MainMenuMicroButton:HookScript("OnEnter",showmenubar1);
MainMenuMicroButton:HookScript("OnLeave",hidemenubar1);
MainMenuBarBackpackButton:HookScript("OnEnter",showmenubar1);
MainMenuBarBackpackButton:HookScript("OnLeave",hidemenubar1);
ActionBarUpButton:HookScript("OnEnter",showmenubar1);
ActionBarUpButton:HookScript("OnLeave",hidemenubar1);
ActionBarDownButton:HookScript("OnEnter",showmenubar1);
ActionBarDownButton:HookScript("OnLeave",hidemenubar1);
MainMenuBarArtFrame:HookScript("OnEnter",showmenubar1);
MainMenuBarArtFrame:HookScript("OnLeave",hidemenubar1);
PetActionBarFrame:HookScript("OnEnter",showmenubar1);
PetActionBarFrame:HookScript("OnLeave",hidemenubar1);
ExtraActionButton1:HookScript("OnEnter",showmenubar1);
ExtraActionButton1:HookScript("OnLeave",hidemenubar1);
--ExtraActionButton2:HookScript("OnEnter",showmenubar1);
--ExtraActionButton2:HookScript("OnLeave",hidemenubar1);
----Testing StatusTrackingBarManager.SingleBarSmall:HookScript("OnEnter",showmenubar1);
---- StatusTrackingBarManager.SingleBarSmall:HookScript("OnLeave",hidemenubar1);

for btn=1,12 do
    _G["MultiBarBottomLeftButton"..btn]:HookScript("OnEnter",showmenubar1)
    _G["MultiBarBottomLeftButton"..btn]:HookScript("OnLeave",hidemenubar1)
end

for btn=1,12 do
    _G["MultiBarBottomRightButton"..btn]:HookScript("OnEnter",showmenubar1)
    _G["MultiBarBottomRightButton"..btn]:HookScript("OnLeave",hidemenubar1)
end

for btn=1,12 do
    _G["ActionButton"..btn]:HookScript("OnEnter",showmenubar1)
    _G["ActionButton"..btn]:HookScript("OnLeave",hidemenubar1)
	
end

for btn=0,3 do
    _G["CharacterBag"..btn.."Slot"]:HookScript("OnEnter",showmenubar1)
    _G["CharacterBag"..btn.."Slot"]:HookScript("OnLeave",hidemenubar1)
end

for btn=1,10 do
	_G["PetActionButton"..btn]:HookScript("OnEnter",showmenubar1)
	_G["PetActionButton"..btn]:HookScript("OnLeave",showmenubar1)
end