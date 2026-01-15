gg.setVisible(false)

-- ===== CONFIG =====
LOCAL_VERSION = "1.0"
PASSWORD = "1234"

VERSION_URL = "https://raw.githubusercontent.com/FoysalAhammad/REPO/main/version.txt"
SCRIPT_URL  = "https://raw.githubusercontent.com/FoysalAhammad/REPO/main/main.lua"

SCRIPT_PATH = gg.getFile():match("(.*/)")
SCRIPT_FILE = SCRIPT_PATH .. "main.lua"

-- ===== PASSWORD (HIDDEN) =====
local p = gg.prompt(
  {"Enter Password"},
  {""},
  {"password"}
)

if p == nil or p[1] ~= PASSWORD then
  gg.alert("❌ Wrong Password")
  os.exit()
end

gg.toast("✅ Login Success")

-- ===== CHECK UPDATE =====
local v = gg.makeRequest(VERSION_URL)
if v and v.content then
  ONLINE_VERSION = v.content:gsub("%s+", "")
else
  ONLINE_VERSION = LOCAL_VERSION
end

if ONLINE_VERSION ~= LOCAL_VERSION then
  local c = gg.alert(
    "🔄 Update Available\n\nLocal: "..LOCAL_VERSION..
    "\nOnline: "..ONLINE_VERSION,
    "Update", "Skip"
  )

  if c == 1 then
    local s = gg.makeRequest(SCRIPT_URL)
    if s and s.content then
      local f = io.open(SCRIPT_FILE, "w")
      f:write(s.content)
      f:close()
      gg.alert("✅ Update Done\nRestarting Script")
      dofile(SCRIPT_FILE)
      os.exit()
    else
      gg.alert("❌ Update Failed")
    end
  end
end

-- ===== TEST MENU =====
function menu()
  local m = gg.choice({
    "Test Option 1",
    "Test Option 2",
    "Exit"
  }, nil, "🔐 Test Script")

  if m == 1 then gg.alert("Option 1 OK") end
  if m == 2 then gg.alert("Option 2 OK") end
  if m == 3 then os.exit() end
end

while true do
  if gg.isVisible(true) then
    gg.setVisible(false)
    menu()
  end
end
