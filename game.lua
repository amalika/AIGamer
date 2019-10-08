-- 切换账号标志
changeAccountTage = false;
globalX = -1;
globalY = -1;
-- 当前任务 名称?
currentTask = "";
-- 结构说明 表格 还是数组
allTask = {};

function appInit()

    -- 获取屏幕分辨率
    height, width = getScreenSize();
    -- appId
    appId = "com.netease.my";
    init(appId, 1);
    -- app 是否在运行
    local isRun = appIsRunning(appId);
    -- 前置appID
    local page = frontAppName();

    sysLog(isRun);
    sysLog(page);

    if (isRun == 0) or (page ~= appId) then
        toast("当前程序不是目标程序, 准备启动....");
        runApp(appId)
        mSleep(1000 * 2)
    end
    toast("游戏运行中....");
    mSleep(1000 * 2)
end
--[[
1. 关闭所有的弹窗, (公告和守则 账号弹窗)
2. 判断是否换号
换号切换账号, 然后到登录页面
3. 点击登录. 等待登录界面
4. 返回
]]
-- 登录方法
function login()

    -- 2019年9月14日01:00:18 桶切换账号逻辑优化
    while true do
        -- 获取当前页面
        mSleep(math.random(600, 800))
        local page,x1,y1 = F获取指定当前页面(loginList)
        if page == "登录页面有效" then
            -- 登录游戏
            F单击(x1,y1)
            local a = 0;
            while a < 50 do
                local x, y = F多点找色(loginingVerify)
                if x >= 0 and y >= 0 then
                    F单击(x, y)
                    return
                else
                    a = a + 1
                    print("识别参数" .. a)
                    mSleep(500)
                end

            end
        elseif page == "登录页面无效" then
            F单击(x1, y1) -- 打开账号列表
        elseif page == "账号弹窗" then
            if changeAccountTage then
                F单击(1152,429) -- 打开账号列表
                changeAccountTage = false
            else
                F单击(933,933) -- 选定账号, 点击登录到登录页面
            end
        elseif page == "账号底限" then
            F单击(1037,726) -- 选择最后一个账号, 然后账号列表收起 到弹窗页面
        elseif page == "账号展开" then
            mSleep(math.random(100, 250))
            print("切换账号 滑动.....")
            touchDown(1, 1391, 479)
            mSleep(math.random(100, 250))
            touchMove(1, 1391, 279)
            mSleep(math.random(100, 250))
            touchUp(1, 1391, 279)
            mSleep(math.random(100, 250))
        else
            print("账号阶段识别出现问题...")

        end


    end













    --登录操作
    --[[	while true do
    --local page = F获取当前页面()
    local page = F获取指定当前页面(loginList)
    if changeAccountTage then
        if(page == '选择账号') then
            -- 可能是游戏中切换,直接点击展开账号列表
            globalX = 1152;
            globalY = 429;
            F单击()
            while true do
                mSleep(math.random(100,150))
                local accountPage = F获取指定当前页面(accountList)
                if accountPage == "选择账号" then
                    --当前页面是账号低页
                    globalX = 1037;
                    globalY = 726;
                    F单击()
                    changeAccountTage = false
                    globalX = 933;
                    globalY = 628;
                    F单击()
                    return
                elseif accountPage == "选定账号" then
                    globalX = 1152;
                    globalY = 429;
                    F单击()
                    mSleep(math,random(200,300))
                else
                    mSleep(math.random(100,250))
                    print("切换账号 滑动.....")
                    touchDown(1, 1391,479)
                    mSleep(math.random(100,250))
                    touchMove(1, 1391, 279)
                    mSleep(math.random(100,250))
                    touchUp(1, 1391, 279)
                    mSleep(math.random(100,250))
                end
            end
        end

    end

    -- 这里只是到了登录主页面 只需要点击登录按钮

    if page == '登录页面' then
        -- 点击登录按钮
        F单击();
        -- 延迟两面的登录页面
        while true do
            mSleep(1000*2)
            return
        end
    else
        F关闭所有页面()
    end

    end]]
end


--[[
1. 获取所有可参与的活动
优先级 1.师门 秘境 宝图 押镖 副本 侠士 抓鬼
]]


function shimenTask()
    -- 查找师门按钮位置
    while true do
        local page = F获取指定当前页面(shimenPaheList)

    end

end

function changeAccount()
    changeAccountTage = true -- 设置切换账号标识
    F关闭所有页面()

    -- 2019年9月13日23:33:27 优化
    -- 遍历切换账号列表 然后做事情
    while true do
        mSleep(math.random(500, 800))
        local page,x1,y1 = F获取指定当前页面(changeAccountList)
        if page == "关闭状态" then
            F单击(x1,y1) -- 打开工具栏
        elseif page == "开启状态" then
            local x, y = F多点找色(sysSettingTag)
            if x >= 0 and y >= 0 then
                F单击(x,y) -- 打开系统设置
            end
        elseif page == "基础设置" then
            F单击(587,898) -- 点击切换账号
        elseif page == "退出弹窗" then
            F单击(x1,y1) -- 点击退出
            --local a = 0
            --while a < 10 do
            --    -- 这里应该死循环查找账号页面 然后return
            --    local x, y = F多点找色(accountVerify)
            --    if x >= 0 and y >= 0 then
            --        --globalX, globalY = x, y;
            --        --切换账号结束
            --        print("切换账号结束.")
            --        mSleep(math.random(1000, 1500))
            --        return
            --    else
            --        a = a + 1;
            --        mSleep(1000)
            --    end
            --end
        elseif page == "账号选择弹窗" then
        else
            print("changeAccount >>>> 识别出现错误.....")
        end
    end

    --[[	]]--[[
	-- 退出账号到登录页面
	1. 检测工具栏状态
	2. 点击退出账号
	]]--[[
	while true do
		print("开始切换账号----------")
		while true do
			F关闭所有页面() -- 到主页
			print("进入工具栏检测循环>>>>>>")
			local tootlStatus = F获取指定当前页面(tootlsTag)
			if tootlStatus == "关闭状态" then
				F单击() -- 打开工具栏
			end
			mSleep(math.random(400,600))
			local x,y = F多点找色(sysSettingTag); -- 查找齿轮按钮
			if x>=0 and y>=0 then
				globalX = x;
				globalY = y;
				F单击()
				mSleep(math.random(300,500))
				print("退出工具栏检测循环<<<<<")
				break
			end
		end
		while true do
			print("进入属性页面****************")
			local page = F获取指定当前页面(属性页面)
			if page ~= "基础属性" then
				break;
			else
				globalX = 587;
				globalY = 898;
				F单击()
				mSleep(math.random(400,600))
				globalX,globalY =1143,593
				F单击()
				print("退出属性页面****************")
				print("退出切换账号----------")
				return
			end
		end
		end]]
end
	
	
	
	
	
	
	
	
	