local a={...}local b={}local c=require require=function(d)local e=d:gsub('%.'
,'_')if b[e]then return b[e]()end return c(d)end function b.boxel(...)f,g=term
.getSize()if not fs.exists("basalt.lua")then print('Basalt not found, installing...'
)shell.run("wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua -f"
)end local m=require("basalt")local n=require("boxelAPI")o={sortonly=false}
local p="data.dat"local function q()local r=fs.open(p,"w")if not r then return
end r.write(textutils.serialise(o))r.close()end local function s()if not fs
.exists(p)then return end local r=fs.open(p,"r")if not r then return end local
t=textutils.unserialise(r.readAll())r.close()if type(t)=="table"then for u,
v in pairs(t)do o[u]=v end end end s()function x(y)y:addLabel():setText("Boxel - "
):setPosition(1,1):setSize(8,3):setForeground(colors.white)y:addButton():setText(
"Quit"):setSize(4,1):setBackground(colors.red):setForeground(colors.white):
setPosition(f-3,1):onClick(function()m.stop()sleep(0.1)os.exit()end)y:addButton(
):setText("Reload"):setSize(6,1):setBackground(colors.gray):setForeground(colors
.white):setPosition(f-10,1):onClick(function()n.ClearCache()end)local z=y:addButton(
):setText("Search"):setSize(6,1):setBackground(colors.blue):setForeground(colors
.white):setPosition(9,1)local aa=y:addButton():setText("Info"):setSize(4,1)
:setBackground(colors.gray):setForeground(colors.white):setPosition(16,1)local
ab=y:addButton():setText("Config"):setSize(6,1):setBackground(colors.gray):
setForeground(colors.white):setPosition(21,1)aa:onClick(function()ac(ad)aa:
setBackground(colors.blue)z:setBackground(colors.gray)ab:setBackground(colors
.gray)end)z:onClick(function()ac(ae)z:setBackground(colors.blue)aa:setBackground(
colors.gray)ab:setBackground(colors.gray)end)ab:onClick(function()ac(af)ab:
setBackground(colors.blue)z:setBackground(colors.gray)aa:setBackground(colors
.gray)end)y:addLabel():setText(string.rep("=",f)):setPosition(1,2):setSize(
f,1):setForeground(colors.white)end function ah(y)y:setPosition(1,3):setSize(
f,g-2)ai=y:addButton():setText("Deposit"):setPosition(f-9,2):setSize(9,1):setBackground(
colors.gray):setForeground(colors.white):onClick(function()ai:setForeground(
colors.yellow)ai:setText("Working")n.DepositAll(o)ai:setForeground(colors.white
)ai:setText("Deposit")end)local ItemList=y:addScrollFrame():setPosition(2,4
):setSize(f-3,g-6):setBackground(colors.black)ag=y:addInput():setPosition(2
,2):setSize(f-15,1):setForeground(colors.white):setBackground(colors.gray):
setPlaceholder("search..."):setPlaceholderColor(colors.lightGray):onChange(
"text",function(aj,text)ItemList:setOffset(0,0)end)y:addButton():setText("X"
):setPosition(f-13,2):setSize(3,1):setBackground(colors.red):setForeground(
colors.white):onClick(function()ag:setText("")ItemList:setOffset(0,0)end)local
function ak(al,offsetY)offsetY=ItemList.offsetY local ao={}local an=n.GetItems(
)if not an or next(an)==nil then ItemList:clear()ItemList:addLabel():setText(
"Storage is empty"):setSize(20,1):setPosition(1,1):setForeground(colors.white
)return end for ap,aq in pairs(n.GetItems())do local ar=n.DisplayName(ap)if
string.find(ar:lower(),al:lower())then ao[ap]=aq.total end end if not ao or
next(ao)==nil then ItemList:clear()ItemList:addLabel():setText("Nothing found"
):setSize(20,1):setPosition(1,1):setForeground(colors.white)return end local
au={}for name,count in pairs(ao)do table.insert(au,{name=name,count=count,displayName=
n.DisplayName(name)})end table.sort(au,function(av,aw)return av.displayName
:lower()<aw.displayName:lower()end)ItemList:clear()local ay,az=ItemList:getSize(
)local ba=math.max(#au,az*4)ItemList:addLabel():setText(""):setPosition(1,ba
):setSize(1,1)local bb=math.min(#au,offsetY+az)for bc=offsetY+1,bb do local
bd=au[bc]if not bd then break end local text=bd.displayName.." x"..bd.count
local be=ItemList:addButton():setText("Take"):setSize(6,1):setPosition(1,bc
):onClick(function()n.TakeStack(bd.name)ak(ag.text)end)local bf=ItemList:addLabel(
):setText(text):setSize(#text,1):setPosition(8,bc):setForeground(colors.white
)if bc%2==1 then be:setBackground(colors.lightGray):setForeground(colors.black
)bf:setForeground(colors.white)else be:setBackground(colors.gray):setForeground(
colors.white)bf:setForeground(colors.lightGray)end end end ak(ag.text)ag:onChange(
"text",function(aj,text)ak(text)end)ItemList:onChange("offsetY",function(aj
,bg)ak(ag.text)end)return ak end function bi(y)y:setPosition(1,3):setSize(f
,g-2)y:addLabel():setText("Boxel by Jerry"):setPosition(2,g-2):setSize(40,1
)local bj=y:addLabel():setText("GUI powered by Basalt 2"):setSize(40,1)bj:setPosition(
f-#bj.text,g-2)y:addLabel():setText("Storage:"):setPosition(2,2):setSize(40
,1)y:addLabel():setText("Chest count: "..#n.GetChests()):setPosition(3,4):setSize(
40,1)local bk=y:addLabel():setText("Estimated usage: Loading..."):setPosition(
3,6):setSize(40,1)local bl=y:addLabel():setText("Total slots: Loading..."):
setPosition(3,8):setSize(40,1)local bm=y:addLabel():setText("Used slots: Loading..."
):setPosition(3,10):setSize(40,1)return{bk,bl,bm}end function bn(y)y:setPosition(
1,3):setSize(f,g-2)y:addLabel():setText("Config:"):setPosition(2,2)local bo=
y:addSwitch():setPosition(3,4):setSize(4,1)y:addLabel():setPosition(8,4):setText(
"Sort only")bo.checked=o.sortonly bo:onChange("checked",function(aj,checked
)if checked then o.sortonly=true else o.sortonly=false end n.Log("Config - Sort only ->"
..tostring(o.sortonly))q()end)return end function ac(y)ae:setSize(0,g-2)ad:
setSize(0,g-2)af:setSize(0,g-2)y:setSize(f,g-2)end bs=m.getMainFrame()bs:setBackground(
colors.black)x(bs)ae=bs:addFrame()local ak=ah(ae)ad=bs:addFrame()local bk=bi(
ad)af=bs:addFrame()local bu=bn(af)ac(ae)parallel.waitForAny(m.run,function(
)while true do n.CheckChests(function()ak(ag.text)end)end end,function()while
true do sleep(0.25)ak(ag.text)end end,function()sleep(1)while true do local
ca,cb,bl,bm=0,0,0,0 for cc,cd in pairs(n.GetChests())do bl=bl+cd.size()ca=bl
*64 local list=cd.list()bm=bm+#cd.list()for ce,bd in pairs(list)do cb=cb+bd
.count end end bk[1]:setText("Estimated usage: "..math.floor((cb/ca)*100)..
"%")bk[2]:setText("Total slots: "..bl)bk[3]:setText("Used slots: "..bm)sleep(
1)end sleep(9999)end)end function b.boxelAPI(...)local monitor=peripheral.find(
"monitor")local cf if monitor then monitor.setTextScale(0.5)monitor.clear()
monitor.setCursorPos(1,1)cf=0 function Log(cg)local ch=term.current()term.redirect(
monitor)cf=cf+1 print(cf..': '..tostring(cg))term.redirect(ch)end else function
Log(cg)end end local ci={}cj={}ck={}cl={}cm={peripheral.find('minecraft:chest'
)}Log(#cm)local cn=peripheral.getName(peripheral.find('minecraft:barrel'))or
nil if not cn then print("Please connect a barrel")end function ci.ItemList(
)ck=nil for cc,bd in ipairs(cj)do ck[bd]=bd.count end end local function cv(
ct,cw)for dd,de in pairs(cj)do if de.chests and de.chests[tostring(cw)]then
for ce,count in pairs(de.chests[tostring(cw)])do de.total=de.total-count end
de.chests[tostring(cw)]=nil if next(de.chests)==nil then cj[dd]=nil end end
end local list=ct.list()for ce,bd in pairs(list)do local ap=bd.name if not cj
[ap]then cj[ap]={total=0,chests={}}end cj[ap].total=cj[ap].total+bd.count if
not cj[ap].chests[tostring(cw)]then cj[ap].chests[tostring(cw)]={}end cj[ap
].chests[tostring(cw)][tostring(ce)]=bd.count end end function ci.CheckChests(
onChange)local ea={}for cc,ct in pairs(cm)do ea[cc]=ct end for cc,ct in pairs(
ea)do local eb=textutils.serialiseJSON(ct.list())local ec=""if cl[cc]then ec=
textutils.serialiseJSON(cl[cc])end if eb~=ec then Log("chest update")cv(ct,
cc)cl[cc]=ct.list()if onChange then onChange()end end end end function ci.TakeStack(
name)Log('taking '..name)Log(cn)if not cj[name]then Log('none found')return
nil,"Item not found"end local de=cj[name]local eh=64 local ej=0 for eo,bl in
pairs(de.chests)do if ej>=eh then Log('enough')break end local ct=cm[tonumber(
eo)]local chestName=peripheral.getName(ct)if ct and chestName then for ce,count
in pairs(bl)do if ej>=eh then Log('Done with chest early')break end local needed=
eh-ej local es=math.min(needed,count)local et=ct.pushItems(cn,tonumber(ce),
es)Log('chest: '..chestName..' slot: '..ce..' toTake: '..es..' taken: '..tostring(
et))if et>0 then ej=ej+et end end end end Log('Total taken: '..ej)return ej
end function ci.DepositAll(o)local interfacePeripheral=peripheral.wrap(cn)if
not interfacePeripheral then Log('Interface not found')return 0 end local fg=
0 while true do local interfaceItems=interfacePeripheral.list()local hasItems=
false for ce,bd in pairs(interfaceItems)do hasItems=true local dd=bd.name local
fc=false if cj[dd]and cj[dd].chests then for eo,chestSlots in pairs(cj[dd].
chests)do local moved=interfacePeripheral.pushItems(peripheral.getName(cm[tonumber(
eo)]),tonumber(ce))if moved and moved>0 then Log('Deposited '..tostring(moved
)..' '..dd..' into chest '..tostring(eo))fg=fg+moved fc=true break end end end
if not fc and not o.sortonly then for id,ct in ipairs(cm)do local chestName=
peripheral.getName(ct)if chestName then local moved=interfacePeripheral.pushItems(
chestName,tonumber(ce))if moved and moved>0 then Log('Deposited '..tostring(
moved)..' '..dd..' into chest '..tostring(id))fg=fg+moved fc=true break end
end end end if not fc and o.sortonly then Log('Storage full! Could not deposit '
..dd)end end if not hasItems or o.sortonly then break end end Log('Total deposited: '
..fg)return fg end function ci.DisplayName(name)local fm=name local fn=string
.find(fm,":")if fn then fm=string.sub(fm,fn+1)end fm=string.gsub(fm,"_"," "
)if#fm>0 then fm=string.upper(string.sub(fm,1,1))..string.sub(fm,2)end return
fm end function ci.GetItems()return cj end function ci.GetChestCache()return
cl end function ci.ClearCache()cl={}end function ci.GetChests()return cm end
function ci.Log(...)return Log(...)end return ci end b.main(a)