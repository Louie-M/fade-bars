--------------------------------------
-- Namespaces
--------------------------------------
local _, core = ...;
core.Config = {}; -- adds Config table to addon namespace

local Config = core.Config;
local UIConfig;

--------------------------------------
--Defaults
--------------------------------------

local defaults = {
	--hash variables
	["fadeopacity"] = 0.1,
	["hoveropacity"] = 1,
	["combatfadeopacity"] = 0.5,
	["combathoveropacity"] = 1,
	["fadeintime"] = 0.25,
	["fadeouttime"] = 0.5,
	["fademenubar"] = true,
	["setfadecombat"] = true,
	theme = {
		r = 0, 
		g = 0.8, -- 204/255
		b = 1,
		hex = "00ccff"
	}
}


FadeBarsDefault = {
	["fadeopacity"] = 0.1,
	["hoveropacity"] = 1,
	["combatfadeopacity"] = 0.5,
	["combathoveropacity"] = 1,
	["fadeintime"] = 0.25,
	["fadeouttime"] = 0.5,
	["fademenubar"] = true,
	["setfadecombat"] = true,
	theme = {
		r = 0, 
		g = 0.8, -- 204/255
		b = 1,
		hex = "00ccff"
	}
}

----------------------------------------
--Config Functions
----------------------------------------
---Load From Saved---
function Config:LoadSaved()
	--print("Called Load Config");
	defaults = options;

end

function Config:Toggle()
	local menu = UIConfig or Config:CreateMenu();
	menu:SetShown(not menu:IsShown());
end

function Config:GetThemeColor()
	local c = defaults.theme;
	return c.r, c.g, c.b, c.hex;
end

function Config:CreateButton(point, relativeFrame, relativePoint, yOffset, text)
	local btn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
	btn:SetPoint(point, relativeFrame, relativePoint, 0, yOffset);
	btn:SetSize(80, 20);
	btn:SetText(text);
	btn:SetNormalFontObject("GameFontNormal");
	btn:SetHighlightFontObject("GameFontHighlight");
	return btn;
end

function Config:CreateMenu()
	UIConfig = CreateFrame("Frame", "FadeBarsConfig", UIParent, "BasicFrameTemplateWithInset, ThinGoldEdgeTemplate");
	UIConfig:SetSize(260, 340);
	UIConfig:SetPoint("CENTER"); -- Doesn't need to be ("CENTER", UIParent, "CENTER")
	
	UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY");
	UIConfig.title:SetFontObject("GameFontNormal");
	UIConfig.title:SetPoint("CENTER", UIConfig.TitleBg, "CENTER", 5, 0);
	UIConfig.title:SetText("Fade Bars Options");
	--FadeBarsConfigTitleBG:Show() -- using the name attribute

	
	----------------------------------
	-- Sliders
	----------------------------------
	UIConfig.fadelabel = UIConfig:CreateFontString();
		UIConfig.fadelabel:SetPoint("CENTER", UIConfig, "TOP", 0, -50);
		UIConfig.fadelabel:SetSize(200,20);
		UIConfig.fadelabel:SetFontObject("GameFontNormal");
		UIConfig.fadelabel:SetText("Bar Opacity")
	
	-- Slider 1:
	UIConfig.fadeopacity = CreateFrame("SLIDER", nil, UIConfig, "OptionsSliderTemplate");
	UIConfig.fadeopacity:SetPoint("CENTER", UIConfig, "TOP", 0, -70);
	UIConfig.fadeopacity:SetMinMaxValues(0, 1);
	UIConfig.fadeopacity:SetValue(options["fadeopacity"]);
	UIConfig.fadeopacity:SetValueStep(.05);
	UIConfig.fadeopacity:SetObeyStepOnDrag(true);
	UIConfig.fadeopacity:SetScript("OnValueChanged", function(self)
		local value = self:GetValue();
		--Save the value to saved variables
		options["fadeopacity"] = value;
		--print(value);
		core.Fade.updateCurrentVariables()
	end)
	
	-- Slider 2:
		UIConfig.combatlabel = UIConfig:CreateFontString();
		UIConfig.combatlabel:SetPoint("CENTER", UIConfig.fadeopacity, "TOP", 0, -50);
		UIConfig.combatlabel:SetSize(200,20);
		UIConfig.combatlabel:SetFontObject("GameFontNormal");
		UIConfig.combatlabel:SetText("In Combat Bar Opacity")
	

	UIConfig.combatfadeopacity = CreateFrame("SLIDER", nil, UIConfig, "OptionsSliderTemplate");
	UIConfig.combatfadeopacity:SetPoint("TOP", UIConfig.combatlabel, "BOTTOM", 0, -5);
	UIConfig.combatfadeopacity:SetMinMaxValues(0, 1);
	UIConfig.combatfadeopacity:SetValue(options["combatfadeopacity"]);
	UIConfig.combatfadeopacity:SetValueStep(.05);
	UIConfig.combatfadeopacity:SetObeyStepOnDrag(true);
	UIConfig.combatfadeopacity:SetScript("OnValueChanged", function(self)
		local value = self:GetValue();
		--Save the value to saved variables
		options["combatfadeopacity"] = value;
		--print(value);
		core.Fade.updateCurrentVariables()
	end)
	
	----------------------------------
	-- Check Buttons
	----------------------------------
	-- Check Button 1:
	UIConfig.fademenubar = CreateFrame("CheckButton", nil, UIConfig, "UICheckButtonTemplate");
	UIConfig.fademenubar:SetPoint("TOPLEFT", UIConfig.combatfadeopacity, "BOTTOMLEFT", -10, -50);
	UIConfig.fademenubar.text:SetText("Fade Menu Bar?");
	UIConfig.fademenubar:SetChecked(options["fademenubar"]);
	UIConfig.fademenubar:SetScript("OnClick", function(self)
		--print(self:GetChecked());
		local value = self:GetChecked();
		--Save the value to saved variables
		options["fademenubar"] = value;
		core.Fade.updateCurrentVariables()
	end)
	
	-- Check Button 2:
	UIConfig.setfadecombat = CreateFrame("CheckButton", nil, UIConfig, "UICheckButtonTemplate");
	UIConfig.setfadecombat:SetPoint("TOPLEFT", UIConfig.fademenubar, "BOTTOMLEFT", 0, -10);
	UIConfig.setfadecombat.text:SetText("Set Fade for Combat");
	UIConfig.setfadecombat:SetChecked(options["setfadecombat"]);
	UIConfig.setfadecombat:SetScript("OnClick", function(self)
		--print(self:GetChecked());
		local value = self:GetChecked();
		--Save the value to saved variables
		options["setfadecombat"] = value;
		core.Fade.updateCurrentVariables()
	end)
	
		----------------------------------
	-- Buttons
	----------------------------------
	-- Reload Button:
	UIConfig.reloadBtn = self:CreateButton("CENTER", UIConfig, "TOP", -240, "Reload UI");
	UIConfig.reloadBtn:SetPoint("CENTER", UIConfig, "CENTER", 0, -125);
	UIConfig.reloadBtn:SetScript("OnClick", function(self)
		--print("Clicked Reload Button");
		ReloadUI();
	end)
	
	UIConfig.infolabel = UIConfig:CreateFontString();
		UIConfig.infolabel:SetPoint("CENTER", UIConfig.reloadBtn, "CENTER", 60, -30);
		UIConfig.infolabel:SetSize(200,20);
		UIConfig.infolabel:SetFontObject("GameFontNormalSmall");
		UIConfig.infolabel:SetText("@louiemckeown 0.0.3")
	
	
	UIConfig:Hide();
	return UIConfig;
	
	
end


