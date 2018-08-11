local _, core = ...; -- Namespace

--------------------------------------
-- Custom Slash Command
--------------------------------------
core.commands = {
	["config"] = core.Config.Toggle, -- this is a function (no knowledge of Config object)
	
	["help"] = function()
		print(" ");
		core:Print("List of slash commands:")
		core:Print("|cff00cc66/fadebars config|r - shows config menu");
		core:Print("|cff00cc66/fadebars help|r - shows help info");
		print(" ");
	end,
	
	["example"] = {
		["test"] = function(...)
			core:Print("My Value:", tostringall(...));
		end
	}
};

local function HandleSlashCommands(str)	
	if (#str == 0) then	
		-- User just entered "/fadebars" with no additional args.
		--core.commands.help();
		core.Config.Toggle();
		return;		
	end	
	
	local args = {};
	for _, arg in ipairs({ string.split(' ', str) }) do
		if (#arg > 0) then
			table.insert(args, arg);
		end
	end
	
	local path = core.commands; -- required for updating found table.
	
	for id, arg in ipairs(args) do
		if (#arg > 0) then -- if string length is greater than 0.
			arg = arg:lower();			
			if (path[arg]) then
				if (type(path[arg]) == "function") then				
					-- all remaining args passed to our function!
					path[arg](select(id + 1, unpack(args))); 
					return;					
				elseif (type(path[arg]) == "table") then				
					path = path[arg]; -- another sub-table found!
				end
			else
				-- does not exist!
				core.commands.help();
				return;
			end
		end
	end
end

function core:Print(...)
    local hex = select(4, self.Config:GetThemeColor());
    local prefix = string.format("|cff%s%s|r", hex:upper(), "Fade Bars:");	
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, ...));
end

-- WARNING: self automatically becomes events frame!
function core:init(event, name, arg1)
	if event == "PLAYER_REGEN_DISABLED" then
		-- run set combat variables function
		--print("init file detected combat");
		core.Fade.combatVariables();
		
		
	elseif event == "PLAYER_REGEN_ENABLED" then
		--print("Player exited combat");
		core.Fade.endcombatVariables();
	end
	
	if (name ~= "FadeBars") then return end 

	-- allows using left and right buttons to move through chat 'edit' box
	for i = 1, NUM_CHAT_WINDOWS do
		_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false);
	end
	
	----------------------------------
	-- Register Slash Commands!
	----------------------------------
	-- SLASH_RELOADUI1 = "/rl"; -- new slash command for reloading UI
	-- SlashCmdList.RELOADUI = ReloadUI;

	-- SLASH_FRAMESTK1 = "/fs"; -- new slash command for showing framestack tool
	-- SlashCmdList.FRAMESTK = function()
		-- LoadAddOn("Blizzard_DebugTools");
		-- FrameStackTooltip_Toggle();
	-- end

	SLASH_FadeBars1 = "/fadebars";
	SlashCmdList.FadeBars = HandleSlashCommands;
	
    core:Print("Thank you for using Fade Bars, ", UnitName("player").."!");
	core:Print("/fadebars - For options");
		
	if event == "ADDON_LOADED" and name == "FadeBars" then
		
		--saved variables are ready.  If none, both variables will set to nil.
		
		
		--Load Settings
		if SavedSettings == nil then
			SavedSettings = FadeBarsDefault;
			--print("Defaults Set");
			else
			--print("Found Data");
			core.Fade.setupVariables();
		end
		--print("TESTING LOAD");
		core.Config.LoadSaved();
		
		
		
	end
end

local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:RegisterEvent("PLAYER_LOGOUT");
events:RegisterEvent("PLAYER_ENTERING_WORLD");
events:RegisterEvent("PLAYER_REGEN_DISABLED");
events:RegisterEvent("PLAYER_REGEN_ENABLED");
events:SetScript("OnEvent", core.init);

