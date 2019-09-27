require ("init")
require ("game")
require ("MyLib")
require ("interfaceList")



-- ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓全局是否移动标识 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

-- 使用物品
useGoods = false;
goodName = "未知页面"

-- 移动
isMove = false;

-- 战斗
isCombat = false;



oldIndex = "";
-- 全局orc 识别
local width,height = getScreenSize()
sysLog("code = " .. width .. ", height = "..height )
ocr, msg = createOCR({
    type = "tesseract", -- 指定tesseract引擎
    path = "[external]", -- 使用开发助手/叉叉助手的扩展字库
    lang = "chi_sim" -- 使用英文增强字库(注意需要提前下载好)
})
if ocr ~= nil then
    -- ocr 创建成功，使用该实例进行后续识别操作（参见下面函数文档）
    sysLog("createOCR succeed: Tesseract-OCR v" .. msg)
else
    -- ocr 创建失败，根据msg提示调整
    toast("createOCR failed: " .. tostring(msg))
end

-- 物品弹窗标识
goodsTag={
    {"物品弹窗标识",{{1748, 541, 2028, 954}, "0|0|0x844c1a,-7|14|0x8a521e,-2|15|0x804717,-7|21|0xecbe5f,1|20|0xeabc5f,-6|34|0xecb95d,0|37|0xecb75c,20|31|0x844c1a,126|-270|0xb50900,138|-273|0xf3e8cb"}}
}

-- 物品标识列表
userGoodsList={
    {"宝图",{{1730,537,1730+311,537+417},"0|0|0xb48c69,9|2|0xa7eb87,27|4|0xb58d6a,46|8|0x62be48,21|24|0xef6154,11|27|0x4eb172,9|40|0xb48c69,-6|71|0x937d69,18|78|0xede0cf,22|86|0x6f5540",}},
    {"红碗",{{1730,537,1730+311,537+417},"0|0|0xad8561,4|80|0xb58d6a,15|45|0xfdb472,34|56|0xda5230,66|49|0xc54028,2|126|0x7b624e,-4|134|0x87705b,1|132|0xd9c8b6,-4|139|0xe4d6c3",}},
    --	{"蓝碗",{{1698,508,1698+349,508+435},}},
    {"洛阳铲",{{1730,537,1730+311,537+417},"0|0|0x785f4a,-1|2|0xe6d7c5,-2|4|0x87705b,-2|7|0xeadcca,-2|11|0xeadcc9,-2|13|0xccbba8,1|14|0xe3d4c2,7|13|0xede0cf,9|3|0xe4d6c5",}},
    {"星辰碎片",{{1730,537,1730+311,537+417},"0|0|0xb58d6a,31|-4|0xb38b69,-8|20|0xb79170,33|22|0x41ebfe,41|46|0x197de4,3|68|0x5cb2ff,-34|123|0x7d644f,-36|131|0xeadbc7,-31|143|0xe5d6c2",}},
    --	{"月桂露",{{1698,508,1698+349,508+435},}},
    --	{"祝融果",{{1698,508,1698+349,508+435},}},
    --	{"忘川石",{{1698,508,1698+349,508+435},}},
    --	{"玄女水",{{1698,508,1698+349,508+435},}},
    --	{"西天雀灵",{{1698,508,1698+349,508+435},}},
    --	{"西天雀灵",{{1698,508,1698+349,508+435},}},
    {"不老根",{{1730,537,1730+311,537+417}, "0|0|0xeee1a9,17|13|0xc89f3f,48|28|0xb58d6a,-5|59|0xe6d7c5,-7|60|0x8d7561,-7|62|0xddcebc,-7|68|0xe9dac8,-6|72|0xe1d2c0,-2|72|0xede0cf,13|69|0xd0c1af",}},
}
-- 对话框标识列表
dialogList={}
-- 检查移动参数
indexRange = {
    {113,51,113+89,51+23},{"0xaeacb3-0x000000","0xbcb8b9-0x000000","0xc3bfbb-0x000000"},"0123456789,()"
}
-- ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑全局是否移动标识↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑


-- 长安城地图标识
camapTag={
    {1,1,126,129},"0|0|0x7b502d,5|-7|0xd28f21,38|-7|0xe5a723,39|3|0x8f5d1b,9|19|0xf09726,27|37|0x683322,8|48|0x3c2a23,-27|69|0x45230b,-1|76|0xc6cdc5,4|89|0x8a5c36"
}

-- 收集任务页面列表
gatherTaskTable={
    长安页面 = {
        n="长安页面",
        range={{1,1,126,129},"0|0|0x7b502d,5|-7|0xd28f21,38|-7|0xe5a723,39|3|0x8f5d1b,9|19|0xf09726,27|37|0x683322,8|48|0x3c2a23,-27|69|0x45230b,-1|76|0xc6cdc5,4|89|0x8a5c36"},
        tap={}
    },
    地图页面 = {
        n="地图页面",
        range={{280,0,1890,1080},"0|0|0x78e41e,1505|-13|0xe64327,1285|255|0xe2709a,1495|935|0x71391a,1496|-87|0x84431c,40|-85|0x763c1b",},
        tap={}
    },
    活动页面 = {
        n="活动页面",
        range={{983,601,983+77,601+69},"0|0|0x7b502d,5|-7|0xd28f21,38|-7|0xe5a723,39|3|0x8f5d1b,9|19|0xf09726,27|37|0x683322,8|48|0x3c2a23,-27|69|0x45230b,-1|76|0xc6cdc5,4|89|0x8a5c36"},
        tap={}
    },
    游戏页面 = {
        n="活动页面",
        range={{983,601,983+77,601+69},"0|0|0x7b502d,5|-7|0xd28f21,38|-7|0xe5a723,39|3|0x8f5d1b,9|19|0xf09726,27|37|0x683322,8|48|0x3c2a23,-27|69|0x45230b,-1|76|0xc6cdc5,4|89|0x8a5c36"},
        tap={}
    },
}

-- 检查是否移动
function FIsMove()
    print("11111111>FIsMove 执行<111111")
    local code, text = ocr:getText({
        rect = indexRange[1],
        diff = indexRange[2], -- 时间颜色为纯黑
        whitelist = indexRange[3] -- 添加所有可能出现的字符作为白名单
    })
    sysLog("code = " .. tostring(code) .. ", text = "..text )

    if code == 0 then
        if oldIndex == text then
            -- 没有移动
            isMove = false
            task.execTimer(3000, FIsMove)
        else
            isMove = true
            oldIndex = text;
            task.execTimer(1, FIsMove)
        end

    else
        toast("识别失败: "..text)
        task.execTimer(1, FIsMove)
    end
    sysLog("移动状态: ".. isMove)
end

-- 检查是否使用物品
function FUserGood()
    print("2222222>FUserGood 执行<222222")
    -- 多点找色 确定是否物品弹窗
    local page = F获取指定当前页面(goodsTag)
    if page ~= "未知页面" then
        -- 确认什么物品
        good = F获取指定当前页面(userGoodsList)
        sysLog(" 识别物品是: " ..good)
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

-- 战斗页面检查
function FCombat()
    print("->->->FCombat 执行<-<-<-<-")

    -- 目前是右下角 单点检查
    --local page = F多点找色()
    --if page == "战斗页面" then
    if true then
        sysLog("********战斗页面*************")
        task.execTimer(1000, FCombat)
    else
        task.execTimer(200, FCombat)
    end
end



local t = 0
local function showA()
    print("++++++showA 执行++++++++")
    id = createHUD()     --创建一个HUD
    showHUD(id,"欢迎使用叉叉脚本"..t,12,"0xffff0000","0xffffffff",0,100,0,228,32)      --显示HUD内容
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
        mSleep(math.random(100,300))
        local var = FFindPageByTable(gatherTaskTable)
        if var == "长安页面" then
            -- 点击活动按钮
            globalX,globalY = 500,35
            F单击()
        elseif var == "地图页面"  then
            -- 长安城位置
            globalX,globalY = 944,615
            F单击()
        elseif var == "活动页面"  then
            -- 收集任务
        else
            -- 无法识别的页面  最好关闭所有页面\
            F关闭所有页面()
            globalX,globalY = 20,20
            F单击()

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
        if true then -- 登陆页面列表做相应操作
			 return -- 说明进入游戏了  可以返回 继续执行下一步
        else
            return -- 说明进入游戏了  可以返回 继续执行下一步
        end
    end
end


--appInit() -- 启动app
while true do
    mSleep(math.random(500,1000))
    --FUserGood()
    --mSleep(math.random(500,1000))
    --mSleep(math.random(500,1000))
    --FIsLogin()
    --mSleep(math.random(500,1000))
    FExecuteTask() -- 执行任务
    --mSleep(math.random(500,1000))
    --changeAccount() -- 切换账号
end




