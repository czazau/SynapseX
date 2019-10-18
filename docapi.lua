
-- Synapse X API definitions for docgenx.lua
-- Last update: October 17, 2019

return
{
	["Environment Library"] =
	{
		{ "table", "syn_getgenv", "", "Returns the environment that will be applied to each script ran by Synapse." };
		{ "table", "syn_getrenv", "", "Returns the global Roblox environment for the LocalScript context." };
		{ "table", "syn_getreg", "", "Returns the Lua registry." };
		{ "table", "syn_getgc", "", "Returns the Lua GC list. This can very easily leak memory if not used correctly." };
		{ "table", "syn_getinstances", "", "Returns a list of all instances within the game." };
		{ "table", "syn_getnilinstances", "", "Returns a list of all instances parented to nil within the game." };
		{ "table", "syn_getscripts", "", "Returns a list of all scripts within the game." };
		{ "table", "syn_getloadedmodules", "", "Returns a list of all ModuleScripts within the game." };
		{ "table", "syn_getconnections", "", "Returns a list of all connections within the game." };
	};

	["Keyboard/Mouse Library"] =
	{
		{ "bool", "syn_isactive", "", "Returns true if the user is focused on the game window." };
		{ "void", "syn_keypress", "int Keycode", 'Simulates a keypress for the specified keycode. For more information, <a href="https://docs.microsoft.com/en-us/windows/desktop/inputdev/virtual-key-codes" target="_blank">click here.</a>'}
	};

	["Clipboard Library"] =
	{
		{ "void", "syn_clipboard_set", "string Content", "Set the system's clipboard to Content" };
		{ "string", "syn_clipboard_get", "", "Return the clipboard's content" };
	};
}