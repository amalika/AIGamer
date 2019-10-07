require("init")
require("game")
require("MyLib")
require("interfaceList")

GetOk = false
globalIndex = "未知页面"

everydayTaskList = {
	主页1 = { "主页", { { 2019, 905, 2019 + 139, 905 + 174 },
			"0|0|0xffeb9e,-10|10|0x293136,-3|18|0xffe397,-18|24|0xffe699,4|51|0xfec77d,-3|44|0xf8c57c,12|45|0xfec87e,26|28|0xffca80,29|16|0xf4ca83",80 } },
	-- 主页面2 全屏页面
	主页2 = { "主页", {
			{ 2019, 905, 2019 + 139, 905 + 174 },
			"0|0|0xffca7f,6|-2|0xf8c27a,-7|10|0x575445,-4|26|0x454236,7|33|0xffea9d,-2|32|0xffeb9e,10|45|0x28302e,30|43|0xecda94,40|29|0x9e8251,34|15|0xf2c37c",80 },
	},
	活动页面 = { "活动页面", {
			{ 659, 18, 1498, 117 },
			"0|0|0xeaf2ff,21|3|0x89654e,17|-2|0x997c6c,17|6|0xeef4ff,18|12|0x7d5438,13|17|0xf5f9ff,22|19|0xc3b4ac,22|22|0x7d5236,16|32|0x7e5438,51|27|0x95745e,41|-1|0x896750,38|-6|0xe2ecfb,47|4|0xecf3ff,35|6|0xedf3fe",80 }
	},
	人物属性页面 = { "人物属性页面", { { 738, 22, 1476, 91 }, "0|0|0x784c2e,0|10|0x774b2d,-18|33|0x7a5032,-1|33|0xf9f9f9,17|33|0x7b5134,33|33|0x8e6a51,28|30|0xfafafa,27|2|0x794f31,47|3|0x825b3f,59|3|0x845c41",80 } },
	活力界面 = { "活力界面", { { 947, 64, 1243, 138 }, "0|0|0x7d4a28,0|5|0xf3f8fe,-2|9|0x7f4c2c,10|13|0xf7fafd,10|9|0x733a16,11|0|0x784320,24|3|0xeff2f7,46|5|0x7c4827,47|2|0xf3f8fe,56|10|0xf3f4f7",80 } },
	
	
}
executeQueue = {
	--[[
	1.师门任务
	2.秘境
	3.宝图
	4.运镖
	5.三本
	6.科举 和 三界
	]]
	师门任务 = 1,
	秘境 = 2,
	宝图 = 3,
	运镖 = 4,
	琉璃碎侠士 = 5,
	绿茵如梦侠士 = 6,
	绿茵如梦普通 = 7,
	琉璃碎普通 = 8,
	科举 = 9,
	三界 = 10,
	捉鬼任务 = 30
	
}
taskTageList = {
	宝图 = { "宝图", { { 487, 325, 1066, 454 },
			"0|0|0x4ab672,3|8|0x61ce97,13|-1|0xfa5c58,16|8|0xf26055,36|27|0xf4e079,44|12|0x99c962,45|-3|0xfff7af,54|-23|0x70b43c,54|-34|0xfae97f,112|-16|0x6b513c,108|-43|0xebdece,110|-43|0x998470,115|-43|0xf0e3d3,96|-36|0x775f4a,100|-40|0x765e49,115|-39|0x7b634f,123|-39|0x7b634f", } },
	师门任务 = { "师门任务", { { 487, 325, 1066, 454 },
			"0|0|0xfee46c,2|20|0xe49518,-18|52|0xd0c88b,-50|59|0xe0851f,-51|42|0xf4ae0d,-35|36|0xf4b10d,-20|35|0xc25c17,-10|34|0xdd7207,38|-15|0x836c58,38|-4|0x806855,41|0|0xd8c8b8,41|11|0x6f5540,46|9|0xe9dccc,53|-19|0x664c36,67|-19|0x674d37", } },
	--{ "平定安邦", {{469, 314, 1072, 864},
	--		   "0|0|0x2d0b70,-29|21|0xfff8ff,-42|52|0x450579,-12|52|0x38094b,4|31|0x411558,7|17|0x3d1c7f,53|-16|0x907965,60|-16|0x8f7865,68|-18|0xe5d7c7,75|-9|0xc4b2a1,50|-3|0xf0e3d3,52|8|0xf0e3d3,66|8|0x624732,70|15|0xf0e3d3,89|-14|0x775f4b",}},
	捉鬼任务 = { "捉鬼任务", { { 487, 325, 1066, 454 },
			"0|0|0x5353c6,-35|13|0xf8f6eb,-45|20|0x6e3b2b,-56|34|0x4f35a4,-19|51|0x7f5d22,40|-20|0x765e49,42|-22|0xcbbaa9,44|-7|0x735b46,39|3|0x947e6a,92|-26|0x6a4f3a,96|-13|0xeee0d0,92|-19|0x654a35,97|-19|0xe6d8c8", } },
	运镖 = { "运镖", { { 487, 325, 1066, 454 },
			"0|0|0xd1dddd,-21|30|0x8fa7b8,-46|34|0x6f7f89,-14|40|0x677c89,12|28|0x628394,12|8|0xbdbdce,-11|14|0xa6cdd7,69|-36|0xb3a08e,77|-36|0x6c523d,83|-37|0x8c7663,60|-26|0x846c58,61|-22|0xd8c9b8,64|-19|0x694e39,67|-17|0xe8dbca,64|-10|0x553a24,64|-4|0xf0e3d3", } },
	秘境 = { "秘境", { { 487, 325, 1066, 454 },
			"0|0|0x259c36,0|7|0xb0fea1,5|6|0x95f88d,15|1|0x48b959,17|0|0x188f29,21|15|0x4baf59,11|22|0x178328,-8|49|0x127856,-7|59|0xa27e5f,12|49|0x146c61", } },
	绿茵如梦普通 = { "绿茵如梦普通", { { 487, 325, 1066, 454 },
			"0|0|0x8ccbb2,-37|20|0x25b996,-32|-9|0xa7e662,-8|-20|0xa0f8e0,5|-26|0x957959,-3|23|0x7c6249,-62|26|0x927356,217|-59|0xe6d8c8,212|-55|0xe8dbca,238|-31|0x6d533e", } },
	绿茵如梦侠士 = { "绿茵如梦侠士", { { 487, 325, 1066, 454 },
			"0|0|0xb2ecda,-33|16|0x73c543,-45|17|0xaee398,-35|41|0x13b086,-59|45|0xb58d6a,6|41|0x6f5841,8|16|0xaaedd6,226|-38|0x6b513d,220|-33|0xf0e3d3,220|-20|0xefe2d2,240|-13|0xeee1d1,238|-23|0x624731,245|-18|0xecdfce", } },
	琉璃碎普通 = { "琉璃碎普通", { { 487, 325, 1066, 454 },
			"0|0|0x5db25d,-1|19|0x80644b,-13|24|0x957456,-6|36|0x59b064,-42|39|0x87d45a,-43|25|0xae8866,-27|37|0x9adc61,190|-46|0xb4a18f,187|-43|0xe3d5c4,212|-22|0x5b3f29,193|-18|0xeadecd,199|-20|0x79604b", } },
	琉璃碎侠士 = { "琉璃碎侠士", { { 487, 325, 1066, 454 },
			"0|0|0x933161,30|0|0x54ae64,19|13|0x786146,14|29|0x95d951,24|32|0x3c5e2d,43|-35|0xfceeed,218|-38|0xdbccbc,218|-41|0x694f3a,217|-44|0xdbcbbb,229|-53|0x735a45,243|-53|0x735a45,240|-55|0xeaddcc,180|-55|0xe2d4c3,183|-54|0x674c37", } },
	海马 = { "海马", { { 487, 325, 1066, 454 },
			"0|0|0xf54fa2,6|-6|0xbb3c71,15|-5|0x8c0726,29|14|0xf9c4b6,25|31|0xcceeaa,-14|44|0xfdedd4,-13|53|0xf2d9a0,6|69|0xdd5e73,-36|31|0xe48ca4", } },
	
}
-- 活了使用按钮 1632,385,1710,420
-- 活动按钮标识
activityTage = { { 473, 1, 473 + 123, 1 + 124 },
	"0|0|0x531219,-10|-11|0xfdebb6,3|-19|0xfdf3c3,3|-12|0x4a0d18,-6|71|0xd3b770,-3|47|0xece5c0,19|72|0xe1c475,-3|53|0x523232,29|56|0xd4c196,29|48|0xd7cdac", }
userButton = {
	{ 1571, 333, 1571 + 208, 333 + 126 }, "0|0|0xe5cebd,3|0|0xa87f4b,6|0|0xd2b598,15|0|0xe0c7b1,17|0|0xb89468,19|0|0xa27740,18|23|0x9c6e35,14|21|0xe1c5ba,11|15|0xd9bcaa,2|31|0x9b6c33",
}
-- 前往 按钮标识
activityNotOkTage = {
	{ 875, 326, 1062, 448 }, "0|0|0xf0c666,0|3|0x7c5f34,15|1|0xf0c666,15|4|0x583e25,30|4|0x583f25,20|11|0x745730,30|10|0x6b4f2d,6|10|0x624729,6|13|0xd8ae59,6|21|0xeabb5e",
}

-- 购买标识 或者完成标识
activityIsOkTage = {
	--购买标识
	"0|0|0xf0c565,6|12|0x684b2b,6|-4|0xf1c767,11|8|0x4e3520,11|3|0xe6bc60,17|3|0x573d24,23|23|0x6a4e2b,27|6|0xe6bb60,26|10|0x583e25",
	--完成标识
	"0|0|0xe3e3e2,0|2|0x5ea11c,0|8|0xd1dac8,-5|17|0x68a22e,-5|20|0xdee0da,-5|23|0x669f30,-1|33|0xd3d8c7,-1|27|0xced7c4,0|30|0x5a9321",
}

--活动页面标识
activityPageTage = {
	{ 659, 18, 1498, 117 },
	"0|0|0xeaf2ff,21|3|0x89654e,17|-2|0x997c6c,17|6|0xeef4ff,18|12|0x7d5438,13|17|0xf5f9ff,22|19|0xc3b4ac,22|22|0x7d5236,16|32|0x7e5438,51|27|0x95745e,41|-1|0x896750,38|-6|0xe2ecfb,47|4|0xecf3ff,35|6|0xedf3fe",
}
smExecuteTage = {
	去完成 = {{ 638, 656, 638+1199, 656+110 },
		"0|0|0xe4caab,3|0|0x7c4520,5|0|0xd8b999,6|7|0xf3dabb,3|7|0x7e4721,0|7|0xedd2b3,-11|24|0xf0d3ad,-11|27|0x94613b,-11|32|0xf3d6ae,-11|-23|0xd88f21",80},
	自选={{ 638, 656, 638+1199, 656+110  },"0|0|0xa47955,0|7|0xf6debf,0|11|0x79411b,-1|14|0xf0d5b4,-2|28|0xeacaa5,-2|30|0xa2734c,1|32|0xe5c59e,4|27|0x7d461f,40|-2|0xf8e2c3,40|1|0x8a5833,36|10|0xf7debf,44|10|0xf1d6b7,41|13|0x8d5b35,37|19|0x7c451f,36|22|0xf1d4b1,36|30|0x855029",80}
}

-- 全局进度显示
myHUDid = createHUD()
testHUDid = createHUD()


-- 收集日常
function FGatherTask()
	--日常
	while not GetOk do
		mSleep(600)
		local var = F获取指定当前页面(everydayTaskList)
		
		if var == "主页1" or var == "主页2" or var == "主页" then
			showHUD(myHUDid, "收集任务->主页", 28, "0xFFFF00FF", "my.png", 2, 0, w - 60, 900, 60)
			-- 打开活动收集未完成的活动
			F单击(2037, 20)
		elseif var == "人物属性页面" then
			showHUD(myHUDid, "收集任务->人物属性页面", 28, "0xFFFF00FF", "my.png", 2, 0, w - 60, 900, 60)
			-- 点击活力使用按钮
			local x, y = F多点找色(userButton)
			if x > -1 and y > -1 then
				F单击(x, y)
			end
		elseif var == "活力界面" then
			showHUD(myHUDid, "收集任务->人物属性页面->活力页面", 28, "0xFFFF00FF", "my.png", 2, 0, w - 60, 900, 60)
			local index = 0
			-- 收集任务
			while not GetOk do
				mSleep(500)
				local x, y = F多点找色(activityNotOkTage)
				--                sysLog(index .. " 次识别坐标:" .. table.concat(activityNotOkTage[1], "***"))
				if x > -1 and y > -1 then
					index = index + 1
					mSleep(1000)
					local var = F获取指定当前页面(taskTageList)
					-- 插入成功
					if myInsert(allTask, var) then
						--						showHUD(myHUDid, table.concat(allTask,"***"), 28, "0xFFFF00FF", "my.png", 0, taskTageList[var][2][1][1], taskTageList[var][2][1][2], 569,123)
						if index < 4 then
							--activityNotOkTage[1][1] = activityNotOkTage[1][1] + 140
							activityNotOkTage[1][2] = activityNotOkTage[1][2] + 140
							--activityNotOkTage[1][3] = activityNotOkTage[1][1] + 140
							activityNotOkTage[1][4] = activityNotOkTage[1][4] + 140
							
							for k, v in pairs(taskTageList) do
								v[2][1][2] = v[2][1][2] + 140
								v[2][1][4] = v[2][1][4] + 140
							end
						else
							--滑动一个单位
							local loaclX, loaclY = math.random(502, 512), math.random(427, 430)
							touchDown(1, loaclX, loaclY)
							mSleep(800)
							touchMove(1, loaclX, loaclY - 135)
							mSleep(1000)
							touchUp(1, loaclX, loaclY - 135)
							mSleep(500)
						end
					end
					mSleep(1000)
					--                    sysLog("活力页面............")
					myRemove(taskTageList, var)
				else
					for i = 1, 2 do
						mSleep(500)
						local myTag = { activityNotOkTage[1], activityIsOkTage[i] }
						local x, y = F多点找色(myTag)
						if x > -1 and y > -1 then
							GetOk = true
							return
						end
					end
					myTag = { activityNotOkTage[1], activityIsOkTage[1] }
				end
			end
		elseif var == "活动页面" then
			showHUD(myHUDid, "执行任务->活动页面", 28, "0xFFFF00FF", "my.png", 2, 0, w - 60, 900, 60)
		end
	end
	
end


-- 删除table中的元素
function myRemove(tagTab, pv)
	--    print("连接后的字符串 ", table.concat(tagTab, "******"))
	local newTbl = {}
	--使用while循环剔除不需要的元素
	for k, v in pairs(tagTab) do
		if k ~= pv then
			table.insert(newTbl, v)
		end
	end
	tagTab = newTbl
end

--唯一插入是否成功
function myInsert(tagTab, pV)
	if type(tagTab) ~= 'table' then
		return false
	else
		--		for i,v in ipairs(t) do
		
		--        end
		
		for k, v in pairs(tagTab) do
			if v == pV then
				return false
			end
		end
		table.insert(tagTab, pV)
		return true
	end
end

function mySort(a, b)
	local av = executeQueue[a]
	local bv = executeQueue[b]
	if av < bv then
		return true
	else
		return false
	end
end
--师门任务页面集合
smTageList = {
	{ "使用物品", { { 1788,817,1788+188,817+93}, "0|0|0xefc465,-1|16|0x7c4314,81|4|0xe9bd5f,6|10|0xdfb058,4|36|0xdea954,4|32|0x804617,10|29|0xe9b85d,10|32|0x7f4516,86|33|0x814717,95|28|0xecbc5e,94|2|0x945e26,81|-2|0xf0c665,81|4|0xe9bd5f,78|4|0x73380f,74|5|0xeec363",75 } },
	{ "战斗页面", { { 2019, 905, 2019 + 139, 905 + 174 }, "0|0|0xf6cca1,34|-12|0xf7ba7e,33|22|0xd07745,11|52|0xb54017,50|53|0x912b17,74|42|0xaa6a84",80 } },
	{ "主页", { { 2019, 905, 2019 + 139, 905 + 174 },
			"0|0|0xffeb9e,-10|10|0x293136,-3|18|0xffe397,-18|24|0xffe699,4|51|0xfec77d,-3|44|0xf8c57c,12|45|0xfec87e,26|28|0xffca80,29|16|0xf4ca83",80 }, },
	-- 主页面2 全屏页面
	{ "主页", {
			{ 2019, 905, 2019 + 139, 905 + 174 },
			"0|0|0xffca7f,6|-2|0xf8c27a,-7|10|0x575445,-4|26|0x454236,7|33|0xffea9d,-2|32|0xffeb9e,10|45|0x28302e,30|43|0xecda94,40|29|0x9e8251,34|15|0xf2c37c",80 },
	},
	{ "师门任务弹窗", { { 328, 249, 328+233,249+ 186 }, "0|0|0xda8e4e,3|0|0xfbecae,3|11|0xd27d3f,3|23|0xd88a52,3|30|0xf3d38d,3|38|0xcc733a,16|38|0xd17e44,16|25|0xfceda6,23|-33|0xfffded,26|-35|0xfcde58",80 } },
	{ "对话弹窗", { { 1580, 0, 2110, 780 }, "0|0|0xc0a788,-25|22|0xc0a788,-24|68|0xc0a788,167|-1|0xc0a788,472|25|0xc0a788,472|66|0xc0a788,7|174|0xba6842,33|176|0xf9ebc8,34|205|0xc87d45,413|206|0xad5735,429|193|0xe2b77f,441|149|0xa96f48,116|29|0xe3d6c5,37|30|0xcfc3b3,19|30|0xebdecc,19|39|0xede0ce,0|39|0xcdc3b3,4|56|0xebdecd", 80} },
	{ "摆摊", { { 770, 5, 770+570, 5+118 }, "0|0|0xbd7d34,0|8|0xfdef7c,173|10|0xfef180,183|10|0xc68b41,91|-9|0xb9792f,93|-13|0xfddd6d,111|-11|0xfddd6f,105|-13|0xb47029,109|1|0xb7762a,103|18|0xb36d24,103|23|0xe9d47f,88|28|0xc68837,91|28|0xecd888,91|35|0xcc903c,94|33|0xfbf8b7",80 } },
	{ "工坊摆摊", { { 770, 5, 770+570, 5+118 }, "0|0|0xa45a1c,0|4|0xe8cc6b,0|8|0xedc369,0|13|0xb6742d,0|17|0xf8e580,0|27|0xb26d27,0|38|0xbe7b35,91|40|0xb87633,91|36|0xfeefb7,95|29|0xaf6b29,93|24|0xfae59a,94|20|0xb06c28,93|16|0xf5d781,93|11|0xbe8339,93|5|0xf3cd71,93|1|0xbc8138,86|-4|0xf3d36a,86|-7|0xa25923",80 } },
	{ "上交物品", { { 1697,173,1697+245,173+51 }, "0|0|0x84674a,3|5|0xe3c498,-5|14|0x765a3e,-5|18|0xe5c699,-1|18|0x5d412a,-1|33|0xe1c295,11|33|0xe8c99b,203|33|0xe8c99b,202|31|0x917454,205|21|0xcfb086,200|21|0xb79973,200|4|0xd5b68b,196|1|0x674b32,160|3|0x8a6d4f,169|0|0xe7c89a,165|11|0x62462e",80 } },
	{ "兵器铺", { { 1008,17,1008+148,17+69}, "0|0|0x927058,3|4|0xe8e1dc,26|-1|0x7a5033,29|-1|0xe6ded9,26|2|0xf3f0ed,26|12|0xfbf9f9,22|12|0x825a3f,19|13|0xeee9e5,41|14|0x7b5134,41|11|0xf4f1ef",80 } },
}

--快捷栏sm标识
sm2TaskListTage = {
	{ 1773, 151, 1773 + 385, 151 + 599 }, "0|0|0xbdba1c,0|14|0xb1b01b,0|16|0x404a1b,1|24|0x91941b,6|-6|0x696b18,5|-4|0x96981a,27|-4|0xc3b71d,28|3|0x625319,35|23|0xc6b01a,12|3|0xc4b817,37|-5|0xc0b618,43|-3|0x808216,61|-2|0x585d18",75
}
-- 师门对话框选择师门标识
smDialogTask = {
	{ 1580, 0, 2110, 780 },"0|0|0xf7d89f,-3|67|0xd7ccbc,3|64|0xe0ccb5,385|63|0xecc282,385|69|0xecd0b2,413|65|0xd6cfc6,413|-2|0xfffbf3,410|-7|0x715f4b,407|25|0xfbf1d3",75
}

function executeTask(v)
	-- 开启移动检测
	if v == "师门任务" then
		while true do
			if not isMove then
				mSleep(800)
				local var = F获取指定当前页面(smTageList)
				myShowHUD("[师门任务]->查询结果:"..var)
				if var == "师门任务弹窗" then
					-- 去完成
					local x, y = F多点找色(smExecuteTage['去完成'])
					if x > -1 and y > -1 then
						F单击(x, y)
--						mSleep(300)
						myShowHUD("[师门任务]->查询结果:"..var..'查询到 【去完成】.')
					else
						local x, y = F多点找色(smExecuteTage['自选'])
						if x > -1 and y > -1 then
							F单击(776,845) -- 勾选自动选择每日任务
--							mSleep(300)
							F单击(x,y) -- 选择第一个
							myShowHUD("[师门任务]->查询结果:"..var..'查询到自选任务.')
							mSleep(300)
						else
							F关闭所有页面()
							myShowHUD("[师门任务]->查询结果:"..var..'查询师门任务失败....')
						end
						
					end
				elseif var == "对话弹窗" then
					local x, y = F多点找色(smDialogTask)
					if x > -1 and y > -1 then
						F单击(x, y)
						--lua_exit()
						mSleep(300)
						--						F单击(1297, 528)
						mSleep(300)
					else
						F单击(1297, 528)
						mSleep(300)
					end
				elseif var == "使用物品" then
					F单击(1832,844)
					
				elseif var == "主页" then
					local x, y = F多点找色(sm2TaskListTage)
					if x > -1 and y > -1 then
						F单击(x, y)
					else
						FMovePage(1, 2, teamRange)
						mSleep(100)
					end
				elseif var == "摆摊" or var == "工坊摆摊" then
					F单击(1566,962)
				elseif var == "上交物品" then
					F单击(1733,844)
				elseif var == "战斗页面" then
					mSleep(1000)
					elseif var == "兵器铺" then
					F单击(1513,861)
					mSleep(1000)
				else
					F单击(1297, 528)
				end
			end
		end
	elseif true then
		sysLog("其他任务**********************************************")
	end
	
end


--一直获取当前页面
function FGetIndex()
	mSleep(600)
	globalIndex = F获取指定当前页面(everydayTaskList)
	--    sysLog("主页方法识别结果->" .. globalIndex)
	task.execTimer(800, FGetIndex)
end
--task.execTimer(800, FGetIndex(), "第一次") -- 一直检查当前页面
--task.execTimer(800, FGatherTask(), "第一次") -- 收集活动
allTask = { "师门任务" }
task.execTimer(100, FIsMove(), "第一次") -- 一直检查是否战斗

-- 执行收集的任务
while true do
	F关闭所有页面()
	local i = 3
	repeat
		mSleep(900)
		myShowHUD("活动收集完成," .. i .. "秒后开始执行...")
		i = i - 1
	until (i == 0)
	--固定排序日常任务
	table.sort(allTask, mySort)
	for i, v in ipairs(allTask) do
		mSleep(1000)
		myShowHUD("执行日常中, 当前任务->" .. v)
		sysLog(v)
		executeTask(v)
		mSleep(2000)
		myShowHUD("执行日常中," .. v .. "执行完成!")
	end
end
