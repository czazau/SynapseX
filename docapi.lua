
-- Synapse X API dictionary, formatted for Lua scripts
-- Last update: October 19, 2019

return
{
	["Environment Library"] =
	{
		{ "table", "syn_getgenv", "", "Returns the environment that will be applied to each script ran by Synapse." };
		{ "table", "syn_getrenv", "", "Returns the global Roblox environment for the LocalScript context." };
		{ "variant<table/nil>", "syn_getsenv", "object<LocalScript/ModuleScript> Script", "Returns Script's environments. Returns nil if Script isn't running."};
		{ "table", "syn_getreg", "", "Returns the Lua registry." };
		{ "table", "syn_getgc", "", "Returns the Lua GC list. This can very easily leak memory if not used correctly." };
		{ "table", "syn_getinstances", "", "Returns a list of all instances within the game." };
		{ "table", "syn_getnilinstances", "", "Returns a list of all instances parented to nil within the game." };
		{ "table", "syn_getscripts", "", "Returns a list of all scripts within the game." };
		{ "table", "syn_getloadedmodules", "", "Returns a list of all ModuleScripts within the game." };
		{ "table", "syn_getconnections", "", "Returns a list of all connections within the game." };
		{ "variant<LocalScript/ModuleScript/nil>", "syn_getcallingscript", "", "Returns the script calling the current function." };
	};

	["Table Extensions"] =
	{
		{ "variant<table/nil>", "getrawmetatable", "variant<table/userdata> Value", "Retrieves the metatable of value if it exists, or return nil." };
		{ "void", "table.lock", "table T", "Locks T, preventing modifications." };
		{ "void", "table.unlock", "table T", "Unlocks T, allowing modifications." };
		{ "bool", "table.islock", "table T", "Returns true or false depending if T is locked or not." };
	};

	["Keyboard/Mouse Library"] =
	{
		{ "bool", "syn_isactive", "", "Returns true if the user is focused on the game window." };
		{ "void", "syn_keypress", "int Keycode", 'Simulates a keypress for the specified keycode. For more information, <a href="https://docs.microsoft.com/en-us/windows/desktop/inputdev/virtual-key-codes" target="_blank">click here.</a>'};
		{ "void", "syn_keyrelease", "int Keycode", "Simulates a key release for the specified keycode." };
		{ "void", "syn_mouse1click", "", "Simulates a full left mouse button press and release." };
		{ "void", "syn_mouse1press", "", "Simulates a left mouse button press." };
		{ "void", "syn_mouse1release", "", "Simulates a left mouse button release." };
		{ "void", "syn_mouse2click", "", "Simulates a full right mouse button press and release." };
		{ "void", "syn_mouse2press", "", "Simulates a right mouse button press." };
		{ "void", "syn_mouse2release", "", "Simulates a right mouse button release." };
		{ "void", "syn_mousescroll", "int Pixels", "Scrolls the mouse wheel virtually by Pixels pixels." };
		{ "void", "syn_mousemoverel", "int X, int Y", "Moves the mouse cursor relatively by the specified coordinates." };
	};

	["Clipboard Library"] =
	{
		{ "void", "syn_clipboard_set", "string Content", "Set the system's clipboard to Content" };
		{ "string", "syn_clipboard_get", "", "Return the clipboard's content" };
	};

	["Hooking Library"] =
	{
		{ "function", "syn_hookfunction", "function Target, function Hook", "Hooks Target and replaces it with Hook. Returns the unhooked function." };
		{ "function", "syn_newcclosure", "function Fn", "Pushes a CClosure that invokes Fn. Used for metatable hooks." };
	};

	["IO Library"] =
	{
		{ "string", "syn_io_read", "string Filepath", "Reads the contents at filepath Filepath and returns it as an ASCII string." };
		{ "void", "syn_io_write", "string Filepath, string Data", "Writes Data at Filepath and creates the file if it doesn't exist." };
		{ "void", "syn_io_append", "string Filepath, string Data", "Appends Data to the file located at Filepath." };
	};

	["Reflection and Engine Library"] =
	{
		{ "bool", "syn_checkcaller", "", "Returns true if the current thread is owned by Synapse X. " };
		{ "bool", "syn_islclosure", "function Fn", "Returns true if Fn is a Lua function." };
		{ "string", "syn_dumpstring", "string Script", "Dumps the bytecode for the Script chunk." };
		{ "string", "syn_decompile", "variant<function, LocalScript, ModuleScript> Script, bool Bytecode", "Decompiles Script and returns the decompiled script, or its bytecode if Bytecode is true." };
		{ "void", "syn_obj_override", "object Object, string PropertyName, any Value", "Overrides field PropertyName in Object to Value and prevents its replication." };
		{ "table", "syn_obj_specialinfo", "object Object", "Returns a list of special properties for certain instances, such as MeshParts, UnionOperations or Terrain." };
		{ "void", "syn_obj_save", "table Flags", "Saves the current game to your workspace folder. Flags is a table containing two fields: noscripts, a boolean specifying whether scripts are to be decompiled automatically, and mode, which is a string that sets the serialization mode." };
	};
}