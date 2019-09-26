require ("init")
require ("game")
require ("MyLib")
require ("interfaceList")


init("0", 1);
-- ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓全局是否移动标识 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

-- 使用物品
useGoods = false;
goodName = "未知页面"

-- 移动
isMove = false;
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
    sysLog("createOCR failed: " .. tostring(msg))
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
    {191,86,343,122},{"0xaaa6b7-0x000000","0xbeb7bd-0x000000","0xb6b0b8-0x000000"},"0123456789,"
}
-- ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑全局是否移动标识↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

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
            sysLog("没有移动, 三秒后继续..." )
        else
            isMove = true
            oldIndex = text;
            task.execTimer(1, FIsMove)
        end

    else
        sysLog(" 识别失败, 重新刷................" )
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


while true do
    FUserGood()
    --	FDialog()
    mSleep(1000)
    --    -- 异步检查移动
    --    task.execTimer(2000, FIsMove)
    --    -- 异步检查商品
    --    task.execTimer(2000, FUserGood)
    --    -- 异步showHUD
    --    task.execTimer(2000, showA)
    --    mSleep(1000)
    --    print("-------while 循环中-------")
    --    t = t + 1
end


