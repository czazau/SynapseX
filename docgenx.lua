-- docgenx.lua
-- automatically builds our documentation into /docs
-- written by Louka --> https://github.com/LoukaMB

local docgen = {}

docgen.header =
[[
<html>
	<head>
		<title>Synapse X - API Documentation</title>
		<style>
			%s
		</style>
	</head>
	<body>
		%s
	</body>
</html>
]]

docgen.entry =
[[
	
]]

function docgen.tree()
	local tree = {}
	tree.categories = {}
	return tree
end

function docgen.category(tree, name)
	tree.categories[name] = {}
	return tree.categories[name]
end

function docgen.method(f_name, f_return, f_arguments)
	local method = {}
	method.name = f_name
	method.retn = f_return
	method.args = f_arguments
	return method
end

function docgen.entry(category, name, method)
	category[name] = method
end

function docgen.filestr(path)
	local io_f = io.open(path, "r")
	local f_str = io_f:read("*a")
	io_f:close()
	return f_str
end

function docgen.build(tree)
	local document = docgen.header
	local css = docgen.filestr("docstyle.css")
	local body = ""

	for cname, cval in pairs(tree.categories) do
		-- do something with categories. for now, not necessary
		for mname, mval in pairs(cval) do
			local methodargs = ""
			local bodyentry =
[[
<div>
	<p class="CodeDefinition">
		<span class="CodeTypename">%s</span> %s(%s)
	</p>
</div>
]]
			if mval.args:len() ~= 0 then -- build argument list
				for argvt, argvn in mval.args:gmatch("([%w,<>]+) (%w+)") do
					methodargs = methodargs .. ("<span class=\"CodeTypename\">%s</span> %s,"):format(argvt, argvn)
				end
				methodargs = methodargs:gsub(",$", "") -- erase extra comma
			else
				-- void argument list
				methodargs = "<span class=\"CodeTypename\">void</span>"
			end

			bodyentry = bodyentry:format(mval.retn, mval.name, methodargs)
			body = body .. bodyentry
		end
	end

	document = document:format(css, body)
	return document
end

function docgen.main(path)
	assert(path, "path to api definition is missing")
	local api = require(path)
	local tree = docgen.tree()
	for k1, v1 in pairs(api) do
		local category = docgen.category(tree, k)
		for k2, v2 in pairs(v1) do
			local f_name, f_retn, f_args = v2[1], v2[2], v2[3]
			docgen.entry(category, f_name, docgen.method(f_name, f_retn, f_args))
		end
	end
end

return docgen.main(...)