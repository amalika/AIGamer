---------------------------
--初始化库
--by滨州IT疯子
--------------------------
hudId = createHUD()
init("0", 1); --以当前应用 Home 键在右边初始化
w,h=getScreenSize()--获取当前分辨率
B当前页面='' --全局变量当前页面
B记录时间=0  --超时判定
B超时时间=30000 --超时时间判定为30秒
function myShowHUD(v)
    showHUD(myHUDid, v, 28, "0xFFFF00FF", "my.png", 2, 0, w - 60, 900, 60)
end