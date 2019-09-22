-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.admin.index", package.seeall)
local debugger = require "luci.debugger"

-- Shellfire Box modifications index function
--[[
function index()
	local root = node()
	if not root.target then
		root.target = alias("admin")
		root.index = true
	end

	local page   = node("admin")
	page.target  = firstchild()
	page.title   = _("Administration")
	page.order   = 10
	page.sysauth = "root"
	page.sysauth_authenticator = "htmlauth"
	page.ucidata = true
	page.index = true

	-- Empty services menu to be populated by addons
	entry({"admin", "services"}, firstchild(), _("Services"), 40).index = true

	entry({"admin", "logout"}, call("action_logout"), _("Logout"), 90)
end
--]]

function index()
	local root = node()
	if not root.target then
		root.target = alias("admin")
		root.index = true
	end

	local page	 = node("admin")
	page.target	= alias("admin", "services", "shellfirebox")
	page.title	 = _("Administration")
	page.order	 = 10
	
	local shellfirebox = require "luci.shellfirebox"
	if luci.sys.user.getpasswd("root") then
		page.sysauth = "root"
		page.sysauth_authenticator = "htmlauth"
		entry({"admin", "logout"}, call("action_logout"), _("Logout"), 90)	
	else
		page.sysauth = false
	end
	
	page.ucidata = true
	page.index = true

	-- Empty services menu to be populated by addons
	entry({"admin", "services"}, firstchild(), _("Services"), 40).index = true
end


function action_logout()
	-- Shellfire Box modiciations below
	-- following 2 lines inserted (+ added tabs in if ... statement)
	local shellfirebox = require "luci.shellfirebox"
	if shellfirebox.isAdvancedMode() then

		local dsp = require "luci.dispatcher"
		local utl = require "luci.util"
		local sid = dsp.context.authsession
	
		if sid then
			utl.ubus("session", "destroy", { ubus_rpc_session = sid })
	
			luci.http.header("Set-Cookie", "sysauth=%s; expires=%s; path=%s/" %{
				sid, 'Thu, 01 Jan 1970 01:00:00 GMT', dsp.build_url()
			})
		end
	-- Shellfire Box modification below
	-- following line inserted
	end
	luci.http.redirect(dsp.build_url())
end
