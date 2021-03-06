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

local hoveringmainbar = false;
local hoveringleft = false;
local hoveringright = false;
local SpellFlyout = SpellFlyout;
local FlyoutShown = false;
local FlyoutName = "none";
local FlyoutUpdated = false;
local StatusTrackingBarNames = {};
local StatusLoaded = false;
-- end Variables
-- functions

-- Setting variables from saved
function Fade:setupVariables ()

	options = SavedSettings;
	if incombat == true then
		currentfadeopacity = options["combatfadeopacity"];
		currenthoveropacity = options["combathoveropacity"];
	else
		currentfadeopacity = options["fadeopacity"];
		currenthoveropacity = options["hoveropacity"];
	end
MultiBarLeft:EnableMouse(true)
core.Anim:UIFrameFadeIn(MultiBarLeft:GetName(), options["fadeintime"], MultiBarLeft:GetAlpha(), currentfadeopacity)
MultiBarRight:EnableMouse(true)
core.Anim:UIFrameFadeIn(MultiBarRight:GetName(), options["fadeintime"], MultiBarRight:GetAlpha(), currentfadeopacity)
MainMenuBar:EnableMouse(true);
	if options["fademenubar"] == true then
		core.Anim:UIFrameFadeIn(MainMenuBar:GetName(), options["fadeintime"], MainMenuBar:GetAlpha(), currentfadeopacity)
	else 
		core.Anim:UIFrameFadeIn(MainMenuBar:GetName(), options["fadeintime"], MainMenuBar:GetAlpha(), 1)
	end

end


function SpellFlyoutOnShow ()
	
	local parent = SpellFlyout:GetParent();
	local barparent = parent:GetParent();

	FlyoutName = barparent:GetName();
	FlyoutShown = true;

end
function SpellFlyoutOnHide ()
	local parent = SpellFlyout:GetParent();
	local barparent = parent:GetParent();	
	FlyoutShown = false;
	FlyoutUpdated = false;
	FlyoutName = "none";
	Fade:updateCurrentVariables();
	
end

function SpellFlyoutUpdate ()
	local barparent = SpellFlyout:GetParent():GetParent();
	
	if FlyoutName ~= barparent:GetName() and FlyoutUpdated == false then
		FlyoutName = barparent:GetName();
		Fade:updateCurrentVariables();
		FlyoutUpdated = true;	
	elseif FlyoutName == barparent:GetName() then
		FlyoutUpdated = false;
	end
		
end
-------------------------------------------------------



-------------------------------------------------------
--Set for combat opacity -- Called from event handler
-------------------------------------------------------
function Fade:combatVariables()
		
	if options["setfadecombat"] == true then
		currentfadeopacity = options["combatfadeopacity"];
		currenthoveropacity = options["combathoveropacity"];
		
		core.Anim:UIFrameFadeOut(MultiBarLeft:GetName(), options["fadeouttime"], MultiBarLeft:GetAlpha(), currentfadeopacity);
		core.Anim:UIFrameFadeOut(MultiBarRight:GetName(), options["fadeouttime"], MultiBarRight:GetAlpha(), currentfadeopacity);
		if options["fademenubar"] == true then
			currentmenubaropacity = options["combatfadeopacity"];
			core.Anim:UIFrameFadeOut(MainMenuBar:GetName(), options["fadeouttime"], MainMenuBar:GetAlpha(), currentmenubaropacity);
		else 
			core.Anim:UIFrameFadeOut(MainMenuBar:GetName(), options["fadeouttime"], MainMenuBar:GetAlpha(), 1);
		end
	end
	incombat = true;
	
return
end

function Fade:endcombatVariables()
		if options["setfadecombat"] == true then
		
			currentfadeopacity = options["fadeopacity"];
			currenthoveropacity = options["hoveropacity"];
			
			
			if FlyoutShown == true and FlyoutName == "MultiBarLeft" then
				core.Anim:UIFrameFadeOut(MultiBarLeft:GetName(), options["fadeouttime"], MultiBarLeft:GetAlpha(), 1);
			elseif FlyoutName ~= "MultiBarLeft" or FlyoutShown == false then
				core.Anim:UIFrameFadeOut(MultiBarLeft:GetName(), options["fadeouttime"], MultiBarLeft:GetAlpha(), currentfadeopacity);
			end
			if FlyoutShown == true and FlyoutName == "MultiBarRight" then
				core.Anim:UIFrameFadeOut(MultiBarRight:GetName(), options["fadeouttime"], MultiBarRight:GetAlpha(), 1);	 
			elseif FlyoutName ~= "MultiBarRight" or FlyoutShown == false then
				core.Anim:UIFrameFadeOut(MultiBarRight:GetName(), options["fadeouttime"], MultiBarRight:GetAlpha(), currentfadeopacity);
			end
			
				
			
			if options["fademenubar"] == true then
				currentmenubaropacity = options["fadeopacity"];
				core.Anim:UIFrameFadeOut(MainMenuBar:GetName(), options["fadeouttime"], MainMenuBar:GetAlpha(), currentmenubaropacity);
			else 
				core.Anim:UIFrameFadeOut(MainMenuBar:GetName(), options["fadeouttime"], MainMenuBar:GetAlpha(), 1);
			end
			
			if FlyoutShown == true and FlyoutName == "MainMenuBarArtFrame" then
				core.Anim:UIFrameFadeOut(MainMenuBar:GetName(), options["fadeouttime"], MainMenuBar:GetAlpha(), 1);
			elseif FlyoutShown == true and FlyoutName == "MultiBarBottomLeft" then
				core.Anim:UIFrameFadeOut(MainMenuBar:GetName(), options["fadeouttime"], MainMenuBar:GetAlpha(), 1);
			elseif FlyoutShown == true and FlyoutName == "MultiBarBottomRight" then
				core.Anim:UIFrameFadeOut(MainMenuBar:GetName(), options["fadeouttime"], MainMenuBar:GetAlpha(), 1);
			
			end
		end
	incombat = false;
	
return
end


-- function getStatusBars ()
	
	-- if #StatusTrackingBarNames == 0 then
		-- print("RUNNING");
		-- for i, bar in ipairs(StatusTrackingBarManager.bars) do
			-- --
			-- tinsert(StatusTrackingBarNames,i,strlower(strsub(tostring(bar),13)));
		-- end
	
		-- for i, bar in ipairs(StatusTrackingBarNames) do
			-- print(bar);
						
		-- end
		-- for i, v in ipairs(StatusTrackingBarNames) do
			-- -- StatusTrackingBarManager.v:HookScript("OnEnter",showmenubar1);
			-- -- StatusTrackingBarManager.v:HookScript("OnLeave",hidemenubar1);
		-- end
		
		-- local bars = StatusTrackingBarManager.bars;
		-- for i, v in ipairs(bars) do
			-- print(v);
		-- end
		
	-- end
	
-- end

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
	
	if hoveringleft == false then core.Anim:UIFrameFadeOut(MultiBarLeft:GetName(), options["fadeouttime"], MultiBarLeft:GetAlpha(), currentfadeopacity);	end
	
	if hoveringright == false then core.Anim:UIFrameFadeOut(MultiBarRight:GetName(), options["fadeouttime"], MultiBarRight:GetAlpha(), currentfadeopacity); end
	
	if options["fademenubar"] == true then
		currentmenubaropacity = currentfadeopacity;
		if hoveringmainbar == false then core.Anim:UIFrameFadeOut(MainMenuBar:GetName(), options["fadeouttime"], MainMenuBar:GetAlpha(), currentmenubaropacity); end

	else 
		currentmenubaropacity = 1;
		core.Anim:UIFrameFadeOut(MainMenuBar:GetName(), options["fadeouttime"], MainMenuBar:GetAlpha(), 1);

	end
	
end


-----------------------------------------------

local function showbar1()
	hoveringleft = true;
	core.Anim:UIFrameFadeIn(MultiBarLeft:GetName(), options["fadeintime"], MultiBarLeft:GetAlpha(), currenthoveropacity)
end

local function hidebar1()
	hoveringleft = false;
	if FlyoutShown == true and FlyoutName == "MultiBarLeft" then
		core.Anim:UIFrameFadeOut(MultiBarLeft:GetName(), options["fadeouttime"], MultiBarLeft:GetAlpha(), 1);
	elseif FlyoutName ~= "MultiBarLeft" or FlyoutShown == false then
		core.Anim:UIFrameFadeOut(MultiBarLeft:GetName(), options["fadeouttime"], MultiBarLeft:GetAlpha(), currentfadeopacity);
	end
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
	hoveringright = true;
	core.Anim:UIFrameFadeIn(MultiBarRight:GetName(), options["fadeintime"], MultiBarRight:GetAlpha(), currenthoveropacity)
end
	
local function hidebar2()
	hoveringright = false;
	if FlyoutShown == true and FlyoutName == "MultiBarRight" then
		core.Anim:UIFrameFadeOut(MultiBarRight:GetName(), options["fadeouttime"], MultiBarRight:GetAlpha(), 1);	 
	elseif FlyoutName ~= "MultiBarRight" or FlyoutShown == false then
		core.Anim:UIFrameFadeOut(MultiBarRight:GetName(), options["fadeouttime"], MultiBarRight:GetAlpha(), currentfadeopacity);
	end
end

MultiBarRight:HookScript("OnEnter", showbar2)
MultiBarRight:HookScript("OnLeave", hidebar2)


for btn=1,12 do
    _G["MultiBarRightButton"..btn]:HookScript("OnEnter", showbar2)
    _G["MultiBarRightButton"..btn]:HookScript("OnLeave", hidebar2)
end

--RightBar End

--Main Menu Start (Whole Bottom Bar.  Might separate soon.)

local function showmenubar1()
		hoveringmainbar = true;
			core.Anim:UIFrameFadeIn(MainMenuBar:GetName(), options["fadeintime"], MainMenuBar:GetAlpha(), currenthoveropacity)
end

local function hidemenubar1()
		hoveringmainbar = false;
		if options["fademenubar"] == true then
			currentmenubaropacity = currentfadeopacity;
			if FlyoutShown == true and FlyoutName == "MainMenuBarArtFrame" then
				core.Anim:UIFrameFadeOut(MainMenuBar:GetName(), options["fadeouttime"], MainMenuBar:GetAlpha(), 1);
			elseif FlyoutShown == true and FlyoutName == "MultiBarBottomLeft" then
				core.Anim:UIFrameFadeOut(MainMenuBar:GetName(), options["fadeouttime"], MainMenuBar:GetAlpha(), 1);
			elseif FlyoutShown == true and FlyoutName == "MultiBarBottomRight" then
				core.Anim:UIFrameFadeOut(MainMenuBar:GetName(), options["fadeouttime"], MainMenuBar:GetAlpha(), 1);
			elseif FlyoutName ~= "MainMenuBarArtFrame" or FlyoutShown == false then
				core.Anim:UIFrameFadeOut(MainMenuBar:GetName(), options["fadeouttime"], MainMenuBar:GetAlpha(), currentfadeopacity);
			end
			
		else 
			core.Anim:UIFrameFadeOut(MainMenuBar:GetName(), options["fadeouttime"], MainMenuBar:GetAlpha(), 1)
			
		end
	
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
HelpOpenWebTicketButton:HookScript("OnEnter",showmenubar1);
HelpOpenWebTicketButton:HookScript("OnLeave",hidemenubar1);
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
	_G["PetActionButton"..btn]:HookScript("OnLeave",hidemenubar1)
end

SpellFlyout:HookScript("OnShow", SpellFlyoutOnShow);
SpellFlyout:HookScript("OnUpdate", SpellFlyoutUpdate);
SpellFlyout:HookScript("OnHide", SpellFlyoutOnHide);

-- StatusTrackingBarManager:HookScript("OnUpdate", getStatusBars);
-- local function hookfunc ()
	-- print("Hooked function called!!!!");
-- end

	-- hooksecurefunc(StatusTrackingBar, "ShowText", hookfunc);
