-- docgenx.lua
-- automatically builds our documentation into /docs
-- written by Louka --> https://github.com/LoukaMB

local docgen = {}

function docgen.tree()
	local tree = {}
	tree.categories = {}
	return tree
end

function docgen.category(tree, name)
	tree.categories[name] = {}
	return tree.categories[name]
end

function docgen.method(f_return, f_name, f_arguments, f_description)
	local method = {}
	method.name = f_name
	method.retn = f_return
	method.args = f_arguments
	method.desc = f_description
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
		body = body .. "<h1 class=\"CategoryTitle\">" .. cname .. "</h1>"
		for mname, mval in pairs(cval) do
			local methodargs = ""
			local bodyentry = docgen.entry
			if mval.args:len() ~= 0 then -- build argument list
				for argvt, argvn in mval.args:gmatch("([%w,<>]+) (%w+)") do
					methodargs = methodargs .. ("<span class=\"CodeTypename\">%s</span> %s,"):format(argvt, argvn)
				end
				methodargs = methodargs:gsub(",$", "") -- erase extra comma
			else
				-- void argument list
				methodargs = "<span class=\"CodeTypename\">void</span>"
			end

			bodyentry = bodyentry:format(mval.name, mval.retn, '#' .. mval.name, mval.name, methodargs, mval.desc)
			body = body .. bodyentry
		end
	end

	document = document:format(css, body)
	return document
end

function docgen.loadapidef(path)
	local f = io.open(path, "r")
	local a = f:read("*a")
	local fn, err = loadstring(a)
	if fn then
		f:close()
		return fn()
	else
		f:close()
		error("shit happened, please fix")
	end
end

function docgen.main(path)
	assert(path, "path to api definition is missing")
	local api = docgen.loadapidef(path)
	local tree = docgen.tree()
	for k1, v1 in pairs(api) do
		local category = docgen.category(tree, k1)
		for k2, v2 in pairs(v1) do
			local f_retn, f_name, f_args, f_desc = v2[1], v2[2], v2[3], v2[4]
			docgen.entry(category, f_name, docgen.method(f_retn, f_name, f_args, f_desc))
		end
	end

	docgen.header = docgen.filestr("base_index.html")
	docgen.entry = docgen.filestr("base_entry.html")
	local document_string = docgen.build(tree)
	local out = io.open("docs/index.html", "w")
	out:write(document_string)
	out:close()
end

return docgen.main(...)