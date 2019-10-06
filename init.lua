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
isCombat = false
function myShowHUD(v)
    showHUD(myHUDid, v, 28, "0xFFFF00FF", "my.png", 2, 0, w - 60, 900, 60)
end


ocr, msg = createOCR({
    psm = 3,
    type = "tesseract", -- 指定tesseract引擎
    path = "[external]", -- 使用开发助手/叉叉助手的扩展字库
    lang = "chi_sim" -- 使用英文增强字库(注意需要提前下载好)
})

oldIndex=""
isMove = false
if ocr ~= nil then
    -- ocr 创建成功，使用该实例进行后续识别操作（参见下面函数文档）
    sysLog("createOCR succeed: Tesseract-OCR v" .. msg)
else
    -- ocr 创建失败，根据msg提示调整
    toast("createOCR failed: " .. tostring(msg))
end