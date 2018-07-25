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
	
	MultiBarLeft:SetAlpha(currentfadeopacity);
	MultiBarRight:SetAlpha(currentfadeopacity);
		if options["fademenubar"] == true then
			UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity);
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
	
	MultiBarLeft:SetAlpha(currentfadeopacity);
	MultiBarRight:SetAlpha(currentfadeopacity);
		if options["fademenubar"] == true then
			UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity);
			--MainMenuBar:SetAlpha(currentfadeopacity);
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
	end

	MultiBarLeft:SetAlpha(currentfadeopacity);
	MultiBarRight:SetAlpha(currentfadeopacity);
	
	if options["fademenubar"] == true then
		UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity);
		--MainMenuBar:SetAlpha(currentfadeopacity);
	else 
		UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), 1);
		--MainMenuBar:SetAlpha(1);
	end
	
end


-----------------------------------------------

MultiBarLeft:HookScript("OnEnter", function(self) UIFrameFadeIn(MultiBarLeft, options["fadeintime"], MultiBarLeft:GetAlpha(), currenthoveropacity) end)
MultiBarLeft:HookScript("OnLeave", function(self) UIFrameFadeOut(MultiBarLeft, options["fadeouttime"], MultiBarLeft:GetAlpha(), currentfadeopacity) end)


local function showbar1()
	UIFrameFadeIn(MultiBarLeft, options["fadeintime"], MultiBarLeft:GetAlpha(), currenthoveropacity)

end

local function hidebar1()
	UIFrameFadeOut(MultiBarLeft, options["fadeouttime"], MultiBarLeft:GetAlpha(), options["fadeopacity"])
end



 for btn=1,12 do
    _G["MultiBarLeftButton"..btn]:HookScript("OnEnter",showbar1)
    _G["MultiBarLeftButton"..btn]:HookScript("OnLeave",hidebar1)
 end
--Left Bar Start End

--RightBar Start

MultiBarRight:HookScript("OnEnter", function(self) UIFrameFadeIn(MultiBarRight, options["fadeintime"], MultiBarRight:GetAlpha(), currenthoveropacity) end)
MultiBarRight:HookScript("OnLeave", function(self) UIFrameFadeOut(MultiBarRight, options["fadeouttime"], MultiBarRight:GetAlpha(), currentfadeopacity) end)

local function showbar2()
	UIFrameFadeIn(MultiBarRight, options["fadeintime"], MultiBarRight:GetAlpha(), currenthoveropacity)
end
	
local function hidebar2()
	UIFrameFadeOut(MultiBarRight, options["fadeouttime"], MultiBarRight:GetAlpha(), currentfadeopacity)
end

for btn=1,12 do
    _G["MultiBarRightButton"..btn]:HookScript("OnEnter",showbar2)
    _G["MultiBarRightButton"..btn]:HookScript("OnLeave",hidebar2)
end

--RightBar End

local function showmenubar1()
	UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity)
end

local function hidemenubar1()
	UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity)
end




MainMenuBar:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
MainMenuBar:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
MainMenuBarArtFrame:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
MainMenuBarArtFrame:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
MultiBarBottomLeft:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
MultiBarBottomLeft:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
MultiBarBottomRight:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
MultiBarBottomRight:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
MicroButtonAndBagsBar:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
MicroButtonAndBagsBar:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
MainMenuBarBackpackButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
MainMenuBarBackpackButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
CharacterMicroButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
CharacterMicroButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
SpellbookMicroButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
SpellbookMicroButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
TalentMicroButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
TalentMicroButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
TalentMicroButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
TalentMicroButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
AchievementMicroButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
AchievementMicroButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
QuestLogMicroButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
QuestLogMicroButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
GuildMicroButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
GuildMicroButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
LFDMicroButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
LFDMicroButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
CollectionsMicroButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
CollectionsMicroButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
EJMicroButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
EJMicroButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
StoreMicroButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
StoreMicroButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
MainMenuMicroButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
MainMenuMicroButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
MainMenuBarBackpackButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
MainMenuBarBackpackButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
ActionBarUpButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
ActionBarUpButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
ActionBarDownButton:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
ActionBarDownButton:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
MainMenuBarArtFrame:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
MainMenuBarArtFrame:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
-- ReputationBarMixin:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
-- ReputationBarMixin:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
-- StatusTrackingBarManager.SingleBarLargeUpper:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
-- StatusTrackingBarManager.SingleBarLargeUpper:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
-- StatusTrackingBarManager.SingleBarSmall:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
-- StatusTrackingBarManager.SingleBarSmall:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);
-- StatusTrackingBarManager.SingleBarSmallUpper:HookScript("OnEnter", function(self) UIFrameFadeIn(MainMenuBar, options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity) end);
-- StatusTrackingBarManager.SingleBarSmallUpper:HookScript("OnLeave", function(self) UIFrameFadeOut(MainMenuBar, options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity) end);


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


--function events:PLAYER_ENTER_COMBAT()