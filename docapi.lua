
-- Synapse X API definitions for docgenx.lua
-- Last update: October 17, 2019

return
{
	["Clipboard Library"] =
	{
		{ "void", "syn_clipboard_set", "string Content", "Set the system's clipboard to Content" };
		{ "string", "syn_clipboard_get", "", "Return the clipboard's content" };
	};
}