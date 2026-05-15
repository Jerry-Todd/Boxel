local a={...}local b={}local c=require require=function(d)local e=d:gsub('%.'
,'_')if b[e]then return b[e]()end return c(d)end function b.boxelAPI(...)local
monitor=peripheral.find("monitor")local f if monitor then monitor.setTextScale(
0.5)monitor.clear()monitor.setCursorPos(1,1)f=0 function Log(g)local h=term
.current()term.redirect(monitor)f=f+1 print(f..': '..tostring(g))term.redirect(
h)end else function Log(g)end end local i={}j={}k={}l={}m={peripheral.find(
'minecraft:chest')}Log(#m)local n=peripheral.getName(peripheral.find('minecraft:barrel'
))or nil if not n then print("Please connect a barrel")end function i.ItemList(
)k=nil for u,t in ipairs(j)do k[t]=t.count end end local function z(w,aa)for
ah,ai in pairs(j)do if ai.chests and ai.chests[tostring(aa)]then for at,count
in pairs(ai.chests[tostring(aa)])do ai.total=ai.total-count end ai.chests[tostring(
aa)]=nil if next(ai.chests)==nil then j[ah]=nil end end end local list=w.list(
)for at,t in pairs(list)do local au=t.name if not j[au]then j[au]={total=0,
chests={}}end j[au].total=j[au].total+t.count if not j[au].chests[tostring(
aa)]then j[au].chests[tostring(aa)]={}end j[au].chests[tostring(aa)][tostring(
at)]=t.count end end function i.CheckChests(onChange)local bg={}for u,w in pairs(
m)do bg[u]=w end for u,w in pairs(bg)do local bh=textutils.serialiseJSON(w.
list())local bi=""if l[u]then bi=textutils.serialiseJSON(l[u])end if bh~=bi
then Log("chest update")z(w,u)l[u]=w.list()if onChange then onChange()end end
end end function i.TakeStack(name)Log('taking '..name)Log(n)if not j[name]then
Log('none found')return nil,"Item not found"end local ai=j[name]local bn=64
local bp=0 for bu,bv in pairs(ai.chests)do if bp>=bn then Log('enough')break
end local w=m[tonumber(bu)]local chestName=peripheral.getName(w)if w and chestName
then for at,count in pairs(bv)do if bp>=bn then Log('Done with chest early'
)break end local needed=bn-bp local ca=math.min(needed,count)local cb=w.pushItems(
n,tonumber(at),ca)Log('chest: '..chestName..' slot: '..at..' toTake: '..ca..
' taken: '..tostring(cb))if cb>0 then bp=bp+cb end end end end Log('Total taken: '
..bp)return bp end function i.DepositAll(cm)local interfacePeripheral=peripheral
.wrap(n)if not interfacePeripheral then Log('Interface not found')return 0 end
local totalDeposited=0 while true do local interfaceItems=interfacePeripheral
.list()local hasItems=false for at,t in pairs(interfaceItems)do hasItems=true
local ah=t.name local cl=false if j[ah]and j[ah].chests then for bu,chestSlots
in pairs(j[ah].chests)do local moved=interfacePeripheral.pushItems(peripheral
.getName(m[tonumber(bu)]),tonumber(at))if moved and moved>0 then Log('Deposited '
..tostring(moved)..' '..ah..' into chest '..tostring(bu))totalDeposited=totalDeposited
+moved cl=true break end end end if not cl and not cm.sortonly then for id,
w in ipairs(m)do local chestName=peripheral.getName(w)if chestName then local
moved=interfacePeripheral.pushItems(chestName,tonumber(at))if moved and moved
>0 then Log('Deposited '..tostring(moved)..' '..ah..' into chest '..tostring(
id))totalDeposited=totalDeposited+moved cl=true break end end end end if not
cl and cm.sortonly then Log('Storage full! Could not deposit '..ah)end end if
not hasItems or cm.sortonly then break end end Log('Total deposited: '..totalDeposited
)return totalDeposited end function i.DisplayName(name)local display_key=name
local colon_pos=string.find(display_key,":")if colon_pos then display_key=string
.sub(display_key,colon_pos+1)end display_key=string.gsub(display_key,"_"," "
)if#display_key>0 then display_key=string.upper(string.sub(display_key,1,1)
)..string.sub(display_key,2)end return display_key end function i.GetItems(
)return j end function i.GetChestCache()return l end function i.ClearCache(
)l={}end function i.GetChests()return m end function i.Log(...)return Log(...
)end return i end function b.install(...)function Write_File(path,p)fs.delete(
path)local file=fs.open(path,"w")if file then file.write(p)file.close()print(
" - "..path)return true end print("File failed to create")return false end function
Github_Download(path,githubPath)local url="https://raw.githubusercontent.com/Jerry-Todd/Boxel/main/"
local cacheBuster=os.epoch("utc")local file=http.get(url..githubPath.."?t="
..cacheBuster)if file then file=file.readAll()if not Write_File(path,file)then
return false end return true else print("Github / Cant get file: "..githubPath
)return false end end local x,db=term.getCursorPos()local input=""while true
do term.setCursorPos(x,db)write('Start boxel when computer starts?\nY/N/C - Yes/No/Cancel'
)local event,au=os.pullEvent("key")input=string.lower(keys.getName(au))if input
=='y'or input=='n'then break elseif input=='c'then print("Canceled install."
)return end end term.clear()term.setCursorPos(1,1)if Github_Download("boxel.lua"
,"build/app.lua")then fs.delete("boxelAPI.lua")print("Boxel installed")if input
=='y'then print("Boxel will start automatically")Write_File("startup.lua","shell.run('boxel')"
)end sleep(2)os.reboot()else print("Boxel failed to install")end end function
b.main(...)dt,ed=term.getSize()if not fs.exists("basalt.lua")then print('Basalt not found, installing...'
)shell.run("wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua -f"
)end local dg=require("basalt")local dh=require("boxelAPI")cm={sortonly=false
}local di="data.dat"local function dj()local dk=fs.open(di,"w")if not dk then
return end dk.write(textutils.serialise(cm))dk.close()end local function dl(
)if not fs.exists(di)then return end local dk=fs.open(di,"r")if not dk then
return end local p=textutils.unserialise(dk.readAll())dk.close()if type(p)==
"table"then for dm,dn in pairs(p)do cm[dm]=dn end end end dl()function dr(ds
)ds:addLabel():setText("Boxel - "):setPosition(1,1):setSize(8,3):setForeground(
colors.white)ds:addButton():setText("Quit"):setSize(4,1):setBackground(colors
.red):setForeground(colors.white):setPosition(dt-3,1):onClick(function()dg.
stop()sleep(0.1)os.exit()end)ds:addButton():setText("Reload"):setSize(6,1):
setBackground(colors.gray):setForeground(colors.white):setPosition(dt-10,1)
:onClick(function()dh.ClearCache()end)local du=ds:addButton():setText("Search"
):setSize(6,1):setBackground(colors.blue):setForeground(colors.white):setPosition(
9,1)local dv=ds:addButton():setText("Info"):setSize(4,1):setBackground(colors
.gray):setForeground(colors.white):setPosition(16,1)local dw=ds:addButton()
:setText("Config"):setSize(6,1):setBackground(colors.gray):setForeground(colors
.white):setPosition(21,1)dv:onClick(function()dx(dy)dv:setBackground(colors
.blue)du:setBackground(colors.gray)dw:setBackground(colors.gray)end)du:onClick(
function()dx(dz)du:setBackground(colors.blue)dv:setBackground(colors.gray)dw
:setBackground(colors.gray)end)dw:onClick(function()dx(ea)dw:setBackground(
colors.blue)du:setBackground(colors.gray)dv:setBackground(colors.gray)end)ds
:addLabel():setText(string.rep("=",dt)):setPosition(1,2):setSize(dt,1):setForeground(
colors.white)end function ec(ds)ds:setPosition(1,3):setSize(dt,ed-2)ee=ds:addButton(
):setText("Deposit"):setPosition(dt-9,2):setSize(9,1):setBackground(colors.
gray):setForeground(colors.white):onClick(function()ee:setForeground(colors
.yellow)ee:setText("Working")dh.DepositAll(cm)ee:setForeground(colors.white
)ee:setText("Deposit")end)local ItemList=ds:addScrollFrame():setPosition(2,
4):setSize(dt-3,ed-6):setBackground(colors.black)eb=ds:addInput():setPosition(
2,2):setSize(dt-15,1):setForeground(colors.white):setBackground(colors.gray
):setPlaceholder("search..."):setPlaceholderColor(colors.lightGray):onChange(
"text",function(ef,text)ItemList:setOffset(0,0)end)ds:addButton():setText("X"
):setPosition(dt-13,2):setSize(3,1):setBackground(colors.red):setForeground(
colors.white):onClick(function()eb:setText("")ItemList:setOffset(0,0)end)local
function eg(eh,offsetY)offsetY=ItemList.offsetY local ej={}local y=dh.GetItems(
)if not y or next(y)==nil then ItemList:clear()ItemList:addLabel():setText(
"Storage is empty"):setSize(20,1):setPosition(1,1):setForeground(colors.white
)return end for au,ek in pairs(dh.GetItems())do local el=dh.DisplayName(au)
if string.find(el:lower(),eh:lower())then ej[au]=ek.total end end if not ej
or next(ej)==nil then ItemList:clear()ItemList:addLabel():setText("Nothing found"
):setSize(20,1):setPosition(1,1):setForeground(colors.white)return end local
eo={}for name,count in pairs(ej)do table.insert(eo,{name=name,count=count,displayName=
dh.DisplayName(name)})end table.sort(eo,function(ax,ep)return ax.displayName
:lower()<ep.displayName:lower()end)ItemList:clear()local er,es=ItemList:getSize(
)local et=math.max(#eo,es*4)ItemList:addLabel():setText(""):setPosition(1,et
):setSize(1,1)local eu=math.min(#eo,offsetY+es)for db=offsetY+1,eu do local
t=eo[db]if not t then break end local text=t.displayName.." x"..t.count local
ev=ItemList:addButton():setText("Take"):setSize(6,1):setPosition(1,db):onClick(
function()dh.TakeStack(t.name)eg(eb.text)end)local ew=ItemList:addLabel():setText(
text):setSize(#text,1):setPosition(8,db):setForeground(colors.white)if db%2
==1 then ev:setBackground(colors.lightGray):setForeground(colors.black)ew:setForeground(
colors.white)else ev:setBackground(colors.gray):setForeground(colors.white)
ew:setForeground(colors.lightGray)end end end eg(eb.text)eb:onChange("text"
,function(ef,text)eg(text)end)ItemList:onChange("offsetY",function(ef,ex)eg(
eb.text)end)return eg end function ez(ds)ds:setPosition(1,3):setSize(dt,ed-
2)ds:addLabel():setText("Boxel by Jerry"):setPosition(2,ed-2):setSize(40,1)
local fa=ds:addLabel():setText("GUI powered by Basalt 2"):setSize(40,1)fa:setPosition(
dt-#fa.text,ed-2)ds:addLabel():setText("Storage:"):setPosition(2,2):setSize(
40,1)ds:addLabel():setText("Chest count: "..#dh.GetChests()):setPosition(3,
4):setSize(40,1)local fb=ds:addLabel():setText("Estimated usage: Loading..."
):setPosition(3,6):setSize(40,1)local bv=ds:addLabel():setText("Total slots: Loading..."
):setPosition(3,8):setSize(40,1)local fc=ds:addLabel():setText("Used slots: Loading..."
):setPosition(3,10):setSize(40,1)return{fb,bv,fc}end function fd(ds)ds:setPosition(
1,3):setSize(dt,ed-2)ds:addLabel():setText("Config:"):setPosition(2,2)local
fe=ds:addSwitch():setPosition(3,4):setSize(4,1)ds:addLabel():setPosition(8,
4):setText("Sort only")fe.checked=cm.sortonly fe:onChange("checked",function(
ef,checked)if checked then cm.sortonly=true else cm.sortonly=false end dh.Log(
"Config - Sort only ->"..tostring(cm.sortonly))dj()end)return end function dx(
ds)dz:setSize(0,ed-2)dy:setSize(0,ed-2)ea:setSize(0,ed-2)ds:setSize(dt,ed-2
)end fi=dg.getMainFrame()fi:setBackground(colors.black)dr(fi)dz=fi:addFrame(
)local eg=ec(dz)dy=fi:addFrame()local fb=ez(dy)ea=fi:addFrame()local fk=fd(
ea)dx(dz)parallel.waitForAny(dg.run,function()while true do dh.CheckChests(
function()eg(eb.text)end)end end,function()while true do sleep(0.25)eg(eb.text
)end end,function()sleep(1)while true do local ci,fo,bv,fc=0,0,0,0 for u,dd
in pairs(dh.GetChests())do bv=bv+dd.size()ci=bv*64 local list=dd.list()fc=fc
+#dd.list()for at,t in pairs(list)do fo=fo+t.count end end fb[1]:setText("Estimated usage: "
..math.floor((fo/ci)*100).."%")fb[2]:setText("Total slots: "..bv)fb[3]:setText(
"Used slots: "..fc)sleep(1)end sleep(9999)end)end b.main(a)