-- Synapse X-Sanctioned Development Compatibility Layer (DCL)
-- https://github.com/LoukaMB/SynapseX/script/compatibility_layer.lua
-- Usage: loadstring(game:HttpGet("https://github.com/LoukaMB/SynapseX/script/compatibility_layer.lua"))()

-- This script provides a standardized API for Lua scripts with environment extensions.
-- Definitions are written in corcondance with https://loukamb.github.io/SynapseX/
-- (Functions start with api.* instead of syn_)

-- Last Update: October 21, 2019

local function flag_to_name(software_flag)
	return
	({

		["unk"]			= "Unknown exploit"
		["ps"]			= "ProtoSmasher";
		["synx"]		= "Synapse X";
		["synx_old"]	= "Synapse X (pre-Holiday update)";
		["syna"]		= "Synapse A";
		["sh"]			= "SirHurt";
		["cl"]			= "Calamari (Windows)";
		["clx"]			= "Calamari (macOS)";

	})[software_flag]
end

local function unsupported(feature, flag)
	return function() error(("api::%s is not supported by %s"):format(feature, flag_to_name(flag))) end
end

return function()
	local api = {}
	local flags = {}

	do -- Calculate Flags
		if pebc_load then					-- is ProtoSmasher
			flags.software = "ps"
		end

		if syn then							-- is Synapse X (unknown version)
			if syn_context_get then			-- is Synapse X (post Holiday update)
				flags.software = "synx"
			else							-- is Synapse X (pre Holiday update)
				flags.software = "synx_old"
			end
		end

		if not flags.software then
			flags.software = "unk"			-- Unknown exploit
		end
	end

	do -- Create Clipboard Library
		if flags.software == "synx" then
			api.clipboard_get = syn_clipboard_get
			api.clipboard_set = syn_clipboard_set
		elseif flags.software == "synx_old" or flags.software == "ps" then
			api.clipboard_get = unsupported("clipboard_get", flags.software)
			api.clipboard_set = setclipboard
		elseif flags.software == "ps" then

		end
	end

	return api
end