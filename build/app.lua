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
)end return i end function b.main(...)de,dp=term.getSize()if not fs.exists(
"basalt.lua")then print('Basalt not found, installing...')shell.run("wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua -f"
)end local cs=require("basalt")local ct=require("boxelAPI")cm={sortonly=false
}local cu="data.dat"local function cv()local cw=fs.open(cu,"w")if not cw then
return end cw.write(textutils.serialise(cm))cw.close()end local function cx(
)if not fs.exists(cu)then return end local cw=fs.open(cu,"r")if not cw then
return end local p=textutils.unserialise(cw.readAll())cw.close()if type(p)==
"table"then for cy,cz in pairs(p)do cm[cy]=cz end end end cx()function dc(dd
)dd:addLabel():setText("Boxel - "):setPosition(1,1):setSize(8,3):setForeground(
colors.white)dd:addButton():setText("Quit"):setSize(4,1):setBackground(colors
.red):setForeground(colors.white):setPosition(de-3,1):onClick(function()cs.
stop()sleep(0.1)os.exit()end)dd:addButton():setText("Reload"):setSize(6,1):
setBackground(colors.gray):setForeground(colors.white):setPosition(de-10,1)
:onClick(function()ct.ClearCache()end)local df=dd:addButton():setText("Search"
):setSize(6,1):setBackground(colors.blue):setForeground(colors.white):setPosition(
9,1)local dg=dd:addButton():setText("Info"):setSize(4,1):setBackground(colors
.gray):setForeground(colors.white):setPosition(16,1)local dh=dd:addButton()
:setText("Config"):setSize(6,1):setBackground(colors.gray):setForeground(colors
.white):setPosition(21,1)dg:onClick(function()di(dj)dg:setBackground(colors
.blue)df:setBackground(colors.gray)dh:setBackground(colors.gray)end)df:onClick(
function()di(dk)df:setBackground(colors.blue)dg:setBackground(colors.gray)dh
:setBackground(colors.gray)end)dh:onClick(function()di(dl)dh:setBackground(
colors.blue)df:setBackground(colors.gray)dg:setBackground(colors.gray)end)dd
:addLabel():setText(string.rep("=",de)):setPosition(1,2):setSize(de,1):setForeground(
colors.white)end function dn(dd)dd:setPosition(1,3):setSize(de,dp-2)dq=dd:addButton(
):setText("Deposit"):setPosition(de-9,2):setSize(9,1):setBackground(colors.
gray):setForeground(colors.white):onClick(function()dq:setForeground(colors
.yellow)dq:setText("Working")ct.DepositAll(cm)dq:setForeground(colors.white
)dq:setText("Deposit")end)local ItemList=dd:addScrollFrame():setPosition(2,
4):setSize(de-3,dp-6):setBackground(colors.black)dm=dd:addInput():setPosition(
2,2):setSize(de-15,1):setForeground(colors.white):setBackground(colors.gray
):setPlaceholder("search..."):setPlaceholderColor(colors.lightGray):onChange(
"text",function(dr,text)ItemList:setOffset(0,0)end)dd:addButton():setText("X"
):setPosition(de-13,2):setSize(3,1):setBackground(colors.red):setForeground(
colors.white):onClick(function()dm:setText("")ItemList:setOffset(0,0)end)local
function ds(dt,offsetY)offsetY=ItemList.offsetY local dv={}local y=ct.GetItems(
)if not y or next(y)==nil then ItemList:clear()ItemList:addLabel():setText(
"Storage is empty"):setSize(20,1):setPosition(1,1):setForeground(colors.white
)return end for au,dw in pairs(ct.GetItems())do local dx=ct.DisplayName(au)
if string.find(dx:lower(),dt:lower())then dv[au]=dw.total end end if not dv
or next(dv)==nil then ItemList:clear()ItemList:addLabel():setText("Nothing found"
):setSize(20,1):setPosition(1,1):setForeground(colors.white)return end local
ea={}for name,count in pairs(dv)do table.insert(ea,{name=name,count=count,displayName=
ct.DisplayName(name)})end table.sort(ea,function(ax,eb)return ax.displayName
:lower()<eb.displayName:lower()end)ItemList:clear()local ed,ee=ItemList:getSize(
)local ef=math.max(#ea,ee*4)ItemList:addLabel():setText(""):setPosition(1,ef
):setSize(1,1)local eg=math.min(#ea,offsetY+ee)for eh=offsetY+1,eg do local
t=ea[eh]if not t then break end local text=t.displayName.." x"..t.count local
ei=ItemList:addButton():setText("Take"):setSize(6,1):setPosition(1,eh):onClick(
function()ct.TakeStack(t.name)ds(dm.text)end)local ej=ItemList:addLabel():setText(
text):setSize(#text,1):setPosition(8,eh):setForeground(colors.white)if eh%2
==1 then ei:setBackground(colors.lightGray):setForeground(colors.black)ej:setForeground(
colors.white)else ei:setBackground(colors.gray):setForeground(colors.white)
ej:setForeground(colors.lightGray)end end end ds(dm.text)dm:onChange("text"
,function(dr,text)ds(text)end)ItemList:onChange("offsetY",function(dr,ek)ds(
dm.text)end)return ds end function em(dd)dd:setPosition(1,3):setSize(de,dp-
2)dd:addLabel():setText("Boxel by Jerry"):setPosition(2,dp-2):setSize(40,1)
local en=dd:addLabel():setText("GUI powered by Basalt 2"):setSize(40,1)en:setPosition(
de-#en.text,dp-2)dd:addLabel():setText("Storage:"):setPosition(2,2):setSize(
40,1)dd:addLabel():setText("Chest count: "..#ct.GetChests()):setPosition(3,
4):setSize(40,1)local eo=dd:addLabel():setText("Estimated usage: Loading..."
):setPosition(3,6):setSize(40,1)local bv=dd:addLabel():setText("Total slots: Loading..."
):setPosition(3,8):setSize(40,1)local ep=dd:addLabel():setText("Used slots: Loading..."
):setPosition(3,10):setSize(40,1)return{eo,bv,ep}end function eq(dd)dd:setPosition(
1,3):setSize(de,dp-2)dd:addLabel():setText("Config:"):setPosition(2,2)local
er=dd:addSwitch():setPosition(3,4):setSize(4,1)dd:addLabel():setPosition(8,
4):setText("Sort only")er.checked=cm.sortonly er:onChange("checked",function(
dr,checked)if checked then cm.sortonly=true else cm.sortonly=false end ct.Log(
"Config - Sort only ->"..tostring(cm.sortonly))cv()end)return end function di(
dd)dk:setSize(0,dp-2)dj:setSize(0,dp-2)dl:setSize(0,dp-2)dd:setSize(de,dp-2
)end ev=cs.getMainFrame()ev:setBackground(colors.black)dc(ev)dk=ev:addFrame(
)local ds=dn(dk)dj=ev:addFrame()local eo=em(dj)dl=ev:addFrame()local ex=eq(
dl)di(dk)parallel.waitForAny(cs.run,function()while true do ct.CheckChests(
function()ds(dm.text)end)end end,function()while true do sleep(0.25)ds(dm.text
)end end,function()sleep(1)while true do local ci,fc,bv,ep=0,0,0,0 for u,fd
in pairs(ct.GetChests())do bv=bv+fd.size()ci=bv*64 local list=fd.list()ep=ep
+#fd.list()for at,t in pairs(list)do fc=fc+t.count end end eo[1]:setText("Estimated usage: "
..math.floor((fc/ci)*100).."%")eo[2]:setText("Total slots: "..bv)eo[3]:setText(
"Used slots: "..ep)sleep(1)end sleep(9999)end)end b.main(a)