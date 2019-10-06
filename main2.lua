require("init")
require("game")
require("MyLib")
require("interfaceList")


--screen.init(screen.PORTRAIT) -- 在下
--screen.init(screen.LANDSCAPE_RIGHT) -- 在右
-- ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓全局是否移动标识 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

-- 使用物品
useGoods = false;
goodName = "未知页面"

-- 移动
isMove = false;

-- 战斗
isCombat = false;

oldIndex = "-1";
local size = screen.getSize()
sysLog(size.width .. "总长度<---" .. size.height)

-- 全局orc 识别
local width, height = getScreenSize()
sysLog("width = " .. width .. ", height = " .. height)


-- 物品弹窗标识
goodsTag = {
    { "物品弹窗标识", { { 1748, 541, 2028, 954 }, "0|0|0x844c1a,-7|14|0x8a521e,-2|15|0x804717,-7|21|0xecbe5f,1|20|0xeabc5f,-6|34|0xecb95d,0|37|0xecb75c,20|31|0x844c1a,126|-270|0xb50900,138|-273|0xf3e8cb" } }
}

-- 物品标识列表
userGoodsList = {
    { "宝图", { { 1730, 537, 1730 + 311, 537 + 417 }, "0|0|0xb48c69,9|2|0xa7eb87,27|4|0xb58d6a,46|8|0x62be48,21|24|0xef6154,11|27|0x4eb172,9|40|0xb48c69,-6|71|0x937d69,18|78|0xede0cf,22|86|0x6f5540", } },
    { "红碗", { { 1730, 537, 1730 + 311, 537 + 417 }, "0|0|0xad8561,4|80|0xb58d6a,15|45|0xfdb472,34|56|0xda5230,66|49|0xc54028,2|126|0x7b624e,-4|134|0x87705b,1|132|0xd9c8b6,-4|139|0xe4d6c3", } },
    --	{"蓝碗",{{1698,508,1698+349,508+435},}},
    { "洛阳铲", { { 1730, 537, 1730 + 311, 537 + 417 }, "0|0|0x785f4a,-1|2|0xe6d7c5,-2|4|0x87705b,-2|7|0xeadcca,-2|11|0xeadcc9,-2|13|0xccbba8,1|14|0xe3d4c2,7|13|0xede0cf,9|3|0xe4d6c5", } },
    { "星辰碎片", { { 1730, 537, 1730 + 311, 537 + 417 }, "0|0|0xb58d6a,31|-4|0xb38b69,-8|20|0xb79170,33|22|0x41ebfe,41|46|0x197de4,3|68|0x5cb2ff,-34|123|0x7d644f,-36|131|0xeadbc7,-31|143|0xe5d6c2", } },
    --	{"月桂露",{{1698,508,1698+349,508+435},}},
    --	{"祝融果",{{1698,508,1698+349,508+435},}},
    --	{"忘川石",{{1698,508,1698+349,508+435},}},
    --	{"玄女水",{{1698,508,1698+349,508+435},}},
    --	{"西天雀灵",{{1698,508,1698+349,508+435},}},
    --	{"西天雀灵",{{1698,508,1698+349,508+435},}},
    { "不老根", { { 1730, 537, 1730 + 311, 537 + 417 }, "0|0|0xeee1a9,17|13|0xc89f3f,48|28|0xb58d6a,-5|59|0xe6d7c5,-7|60|0x8d7561,-7|62|0xddcebc,-7|68|0xe9dac8,-6|72|0xe1d2c0,-2|72|0xede0cf,13|69|0xd0c1af", } },
}
-- 对话框标识列表
dialogList = {}


-- ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑全局是否移动标识↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

-- 全局进度显示
myHUDid = createHUD()

-- 长安城地图标识
camapTag = {
    { 1, 1, 126, 129 }, "0|0|0x7b502d,5|-7|0xd28f21,38|-7|0xe5a723,39|3|0x8f5d1b,9|19|0xf09726,27|37|0x683322,8|48|0x3c2a23,-27|69|0x45230b,-1|76|0xc6cdc5,4|89|0x8a5c36"
}

-- 收集任务页面列表
gatherTaskTable = {
    长安页面 = {
        n = "长安页面",
        range = { { 1, 1, 126, 129 }, "0|0|0x7b502d,5|-7|0xd28f21,38|-7|0xe5a723,39|3|0x8f5d1b,9|19|0xf09726,27|37|0x683322,8|48|0x3c2a23,-27|69|0x45230b,-1|76|0xc6cdc5,4|89|0x8a5c36" },
        tap = {}
    },
    地图页面 = {
        n = "地图页面",
        range = { { 280, 0, 1890, 1080 }, "0|0|0x78e41e,1505|-13|0xe64327,1285|255|0xe2709a,1495|935|0x71391a,1496|-87|0x84431c,40|-85|0x763c1b", },
        tap = {}
    },
    活动页面 = {
        n = "活动页面",
        range = { { 983, 601, 983 + 77, 601 + 69 }, "0|0|0x7b502d,5|-7|0xd28f21,38|-7|0xe5a723,39|3|0x8f5d1b,9|19|0xf09726,27|37|0x683322,8|48|0x3c2a23,-27|69|0x45230b,-1|76|0xc6cdc5,4|89|0x8a5c36" },
        tap = {}
    },
    游戏页面 = {
        n = "活动页面",
        range = { { 983, 601, 983 + 77, 601 + 69 }, "0|0|0x7b502d,5|-7|0xd28f21,38|-7|0xe5a723,39|3|0x8f5d1b,9|19|0xf09726,27|37|0x683322,8|48|0x3c2a23,-27|69|0x45230b,-1|76|0xc6cdc5,4|89|0x8a5c36" },
        tap = {}
    },
}


-- 检查是否使用物品
function FUserGood()
    print("2222222>FUserGood 执行<222222")
    -- 多点找色 确定是否物品弹窗
    local page = F获取指定当前页面(goodsTag)
    if page ~= "未知页面" then
        -- 确认什么物品
        good = F获取指定当前页面(userGoodsList)
        sysLog(" 识别物品是: " .. good)
        useGoods = true;
        task.execTimer(2000, FUserGood)
    else
        useGoods = false;
        task.execTimer(200, FUserGood)
    end
end

-- 检查对话框
function FDialog()
    print("=>=>=>FDialog 执行<=<=<=<=")
    -- 遍历弹框列表 确定是否弹窗
    local page = F获取指定当前页面(closeList)
    if page ~= "未知页面" then
        sysLog("********有弹窗*************")
        -- 确认是什么弹窗
        useGoods = true;

    else
        useGoods = false;
        task.execTimer(200, FDialog)
    end
end
local t = 0


-- 战斗页面检查
function FCombat(v)
    -- 目前是右下角 单点检查

    sysLog(v .. "********战斗情况*************" .. isCombat)
    local x, y = F多点找色({ { 2019, 905, 2019 + 139, 905 + 174 }, "0|0|0xf6cca1,34|-12|0xf7ba7e,33|22|0xd07745,11|52|0xb54017,50|53|0x912b17,74|42|0xaa6a84", })
    if x > -1 and y > -1 then

        --t = t + 1;
        isCombat = true
        task.execTimer(800, FCombat, "第二次")
    else
        isCombat = false
        task.execTimer(500, FCombat, "第二次")
    end
end

local function showA()
    print("++++++showA 执行++++++++")
    id = createHUD()     --创建一个HUD
    showHUD(id, "欢迎使用叉叉脚本" .. t, 12, "0xffff0000", "0xffffffff", 0, 100, 0, 228, 32)      --显示HUD内容
    mSleep(2000)
    task.execTimer(2000, showA)
end

function FGather()
    local i = 0;
    sysLog("**********")
    --[[
    1. 确认在长安城
    2.打开活动按钮
    3. 收集活动
    4.退出收集, 继续下一步
    ]]
    -- 收集任务
    while true do
        mSleep(math.random(300, 500))
        local var = FFindPageByTable(gatherTaskTable)
        if var == "长安页面" then
            -- 点击活动按钮
            globalX, globalY = 500, 35
            F单击()
            mSleep(math.random(300, 500))
        elseif var == "地图页面" then
            -- 长安城位置
            globalX, globalY = 944, 615
            F单击()
            mSleep(math.random(300, 500))
        elseif var == "活动页面" then
            -- 收集任务
            exit()
        else
            -- 无法识别的页面  最好关闭所有页面
            -- 遍历所有的吗?
            F关闭所有页面()
            mSleep(math.random(300, 500))
        end
        --[[        -- 确认是否是长安
        local x,y = F多点找色(camapTag)
        if x == -1 and y == -1 then
            -- 不是的话, 切换地图到长安
            globalX,globalY = 20,20
            F单击()
            mSleep(math.random(500,800))
            globalX,globalY = 944,615
            F单击()
        else
            local x,y = F多点找色(activityTage) -- 识别活动按钮
            if x > -1 and y > -1 then
                -- 找到
                F单击()
            else
                if i >= 3  then
                    toast("循环查找活动失败...")
                    sysLog("循环查找活动失败...")
                    return
                end
                i = i + 1;
            end
            end]]
    end
end

-- 执行任务
function FExecuteTask()
    sysLog("**********")
    --[[
    1. 收集任务
    2.开始执行
    ]]
    FGather()
    -- 执行任务

    -- 确认任务完成

end

-- 检查是否登陆游戏
function FIsLogin()
    --[[
    1. 循环获取页面
    2. 做相应的动作
    3.登陆页面之后就可以继续下一步 执行任务   确保是游戏内页面
    ]]
    while true do
        --
        local var = F获取指定当前页面(loginList)
        if true then
            -- 登陆页面列表做相应操作
            return -- 说明进入游戏了  可以返回 继续执行下一步
        else
            return -- 说明进入游戏了  可以返回 继续执行下一步
        end
    end
end

-- 获取战斗结束后的奖励toast 提示
function FGetResult(v)
    local x, y = F多点找色(v)
    sysLog(x .. "-----" .. y)
    if x > -1 and y > -1 then
        return true
    end
    return false
end



-- ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓抓鬼活动↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
IsGetTask = false
SpecialColseTage = {
    "战斗结束", { { 1686, 156, 1686 + 92, 156 + 104 }, "0|0|0xfeea9d,8|-10|0xf4e097,10|-15|0x544f40,23|3|0xffe396,24|12|0xffd68a,34|9|0xfed286,32|17|0xffca80,6|35|0xedb973,10|26|0xd0a769,13|43|0x524d3e,2|13|0x575140", },
    -- 任务栏抓鬼标识
    { { 1777, 257, 1777 + 383, 257 + 520 }, "0|0|0xd2cc1f,-3|5|0xd6cf1e,2|6|0xe5de1d,-3|27|0xdcd61e,1|25|0xdcd51f,8|6|0xdbd41e,8|0|0xcbc620,8|15|0xe4dd1d,22|4|0xc8c320,15|13|0xe3dd1e,15|24|0xe8e01e,43|2|0xf9f01c,32|8|0xe8e01e,32|14|0xdbd51f,31|27|0xd6d021", }
}

-- 抓鬼用到的页面
FSpecialTaskList = {
    -- 战斗页面 等待操作按钮
    { "战斗页面", { { 2019, 905, 2019 + 139, 905 + 174 }, "0|0|0xf6cca1,34|-12|0xf7ba7e,33|22|0xd07745,11|52|0xb54017,50|53|0x912b17,74|42|0xaa6a84", } },
    -- 主页面1 正常页面
    { "主页", { { 2019, 905, 2019 + 139, 905 + 174 }, "0|0|0xffeb9e,-10|10|0x293136,-3|18|0xffe397,-18|24|0xffe699,4|51|0xfec77d,-3|44|0xf8c57c,12|45|0xfec87e,26|28|0xffca80,29|16|0xf4ca83", } },
    -- 主页面2 全屏页面
    { "主页", { { 2019, 905, 2019 + 139, 905 + 174 }, "0|0|0xffca7f,6|-2|0xf8c27a,-7|10|0x575445,-4|26|0x454236,7|33|0xffea9d,-2|32|0xffeb9e,10|45|0x28302e,30|43|0xecda94,40|29|0x9e8251,34|15|0xf2c37c", } },
    -- 最后一个鬼, 会弹窗
    { "领任务", { {695, 357, 695+773, 357+371}, "0|0|0x6f522e,1|-12|0x70532e,6|3|0xe9bc5f,18|-8|0xcea656,9|6|0x5a3f25,9|19|0x573d24,1|16|0x6a4d2b,13|-6|0x4f3621,-413|-140|0xa88259,-413|-118|0x9f764a,-428|-122|0x9f764b,-424|-122|0xe4d2bc,-424|-110|0x936536,-424|-112|0xe2cfb9", } },
    -- 最后一个鬼, 会弹窗
    { "弹窗", { { 1586,198,1586+570,198+626}, "0|0|0x82664e,0|5|0x5f432d,-3|7|0x81654c,-3|16|0xe4c8a6,0|18|0x5f432c,-3|21|0x5e422b,-4|25|0xf2d5ac,0|28|0x61452d,-3|34|0x664930", } }
}
local number = 1        -- 本轮第多少个
local trainNumber = 1    -- 第多少轮
local allNumber = 0    -- 总共数量
-- 抓鬼活动
function FSpecialTask()
local ii = 0
    while true do
        mSleep(800)
        --识别页面搞事情
        local var = F获取指定当前页面(FSpecialTaskList)-- 获取当前页面
        if var == "战斗页面" then
			ii = 0
            showHUD(myHUDid, "等待战斗结束. 当前第(" .. trainNumber .. ")轮鬼, 第(" .. number .. ")个" .. allNumber, 28, "0xFFFF00FF", "my.png", 2, 0, width - 60, 900, 60)
            local isOK = false;
            local checkCombat = true
            -- 战斗中的话, 就一直检查  直到战斗结束, 然后计算抓鬼次数
            -- 再来一次检查队伍情况
            repeat
                mSleep(500)
                if checkCombat then
                    --队伍状态检查
                    --************************
                    checkCombat = false
                end
                -- 检查战斗结束弹窗
                --************************
                sysLog("检查中...")
                if FGetResult(SpecialColseTage[2]) then
                    isOK = true
                end

            until (not isCombat)
            -- 全局抓鬼次数 +1
            number = number + 1
            allNumber = allNumber + 1
			
			mSleep(500)
        elseif var == "主页" then
			ii = 0
            -- 执行任务跟踪 或者领取任务
            repeat
                FTracking()
                mSleep(300, 600)
            until ( isCombat or IsGetTask)
			mSleep(500)
        elseif var == "领任务" then
			IsGetTask = true
			ii = 0
            globalX,globalY = 1154,598
            F单击()
			mSleep(500)
            trainNumber = trainNumber +1
			number = 1
        elseif var == "弹窗" then
			ii = 0
            globalX,globalY = 1694,364
            F单击()
			IsGetTask = false
			
			mSleep(500)
        else
			ii = ii+1
            mSleep(1000)
			if ii>3 then
				globalX,globalY = 1403,375
				F单击()
			end
        end
    end
end
-- ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑抓鬼活动↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

function FClickTask(v)
    local x, y = F多点找色(v)  -- 确认快捷任务的开启
    if x > -1 and y > -1 then
        globalX, globalY = x, y
        -- 打开状态, 查找抓鬼任务
        -- 点击任务
        F单击()
        return true
    else
        return false
    end
end

function FOpenAndClickTask(v)
	local ii = 0;
    while not isCombat do
        mSleep(800)
        local x, y = F多点找色(v[2])  -- 确认快捷任务的开启
        if x > -1 and y > -1 then
			ii=0
            -- 打开状态, 查找抓鬼任务
            if FClickTask(v[3]) then
                -- 点击任务
                return
            end
        else
            -- 确认活动快捷是关闭的 才去点击 不然可能是选中队伍模式
            -- 展开任务快捷栏
--            globalX, globalY = 2092, 192
--            F单击()
            return
        end
    end
end

--点击任务
function FTouchTask(v)
    sysLog("*********停止后点击事件*********")
    -- 查找抓鬼任务
    FOpenAndClickTask(v) -- 打开任务快捷栏
end
-- 任务追踪
function FTracking()
    while not isCombat do
        mSleep(300, 800)
        FIsMove()
        if not isMove then
            FTouchTask(SpecialColseTage) -- 停止后的操作
            return
        end
        mSleep(300, 800)
        showHUD(myHUDid, "移动中", 28, "0xFFFF00FF", "my.png", 2, 0, width - 60, 900, 60)
    end
end

task.execTimer(800, FCombat, "第一次") -- 一直检查是否战斗


FSpecialTask()-- 抓鬼活动
--appInit() -- 启动app
--while true do
--    mSleep(00)
--    --FUserGood()
--    --mSleep(math.random(500,1000))
--    --mSleep(math.random(500,1000))
--    --FIsLogin()
--    --mSleep(math.random(500,1000))
--    --FTracking()
--    --mSleep(math.random(500,1000))
----    FSpecialTask()
--    --changeAccount() -- 切换账号
--end