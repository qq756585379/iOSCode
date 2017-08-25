//
//  OTSNotificationDefine.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#define MSG_IM_MSG_IMG_STATUS_CHANGE             	@"Msg_Im_MSG_IMG_STATUS_CHANGE"//接受图片状态更新通知
//省份切换
#define OTS_ADDRESS_CHANGED               		 	@"OTS_ADDRESS_CHANGED"//省份切换成功
//地址变更通知
#define OTS_ADDRESS_CHANGED                 		@"OTS_ADDRESS_CHANGED"//地址变更成功
// 切换地址页三级地址变更通知
#define OTS_PROVINCESWITCH_ADDRESS_CHANGED          @"OTS_PROVINCESWITCH_ADDRESS_CHANGED"//切换地址页三级地址变更通知
// 列表页三级地址变更通知
#define OTS_ProductList_ADDRESS_CHANGED             @"OTS_ProductList_ADDRESS_CHANGED"//列表页三级地址变更通知
//二三级地址切换,结算页价格改变通知
#define OTS_CHECKOUT_PRICE_CHANGED          		@"OTS_CHECKOUT_PRICE_CHANGED"
//品牌团分类切换
#define OTS_BRAND_CHANGED                   		@"OTS_BRAND_CHANGED"//品牌团分类成功
//团购首页金牌秒杀数据更新
#define OTS_GROUPONHOMEOLOCK_CHANGED         		@"OTS_GROUPONHOMEOLOCK_CHANGED"
//详情进入属性选择页面
#define OTS_PRODUCT_DETAIL_SERIES_SELECT_PC  		@"OTS_PRODUCT_DETAIL_SERIES_SELECT_PC"
//详情进入组合购买页面
#define OTS_PRODUCT_DETAIL_COMBINE_SELECT_PC  		@"OTS_PRODUCT_DETAIL_COMBINE_SELECT_PC"
//详情进入一品多商页面
#define OTS_PRODUCT_DETAIL_MERCHANTS_SELECT_PC  	@"OTS_PRODUCT_DETAIL_MERCHANTS_SELECT_PC"
//详情选择地址
#define OTS_PRODUCT_DETAIL_SELECT_ADDRESS  			@"OTS_PRODUCT_DETAIL_SELECT_ADDRESS"
//加载各省份数据
#define OTS_ALLPROVINCES_LOADED           	 		@"OTS_ALLPROVINCES_LOADED"
//后台进入调用定位接口
#define OTS_ENTERAPP_STARTLOCATION            		@"OTS_ENTERAPP_STARTLOCATION"
//监测到晃动
#define OTS_NOTIFICATION_SHAKE              		@"OTS_NOTIFICATION_SHAKE"//监测到晃动
//刮刮卡
#define OTS_SCRATCH_SUCCESS                 		@"OTS_SCRATCH_SUCCESS"//刮刮卡成功刮出
#define OTS_SCRATCH_BEGIN                   		@"OTS_SCRATCH_BEGIN"//刮刮卡开始刮
#define OTS_SCRATCH_ADDCART_BEGIN           		@"OTS_SCRATCH_ADDCART_BEGIN" //领取LP商品开始加入购物车
//我的1号店
#define OTS_REFESH_MY_YHD_ACCOUNT           		@"OTS_REFESH_MY_YHD_ACCOUNT"//刷新我们1号店
#define OTS_FAVORATE_NEEDUPDATE  					@"OTS_FAVORATE_NEEDUPDATE" //收藏状态更新通知
#define OTS_REFESH_MY_YHD_BROWSE_HISTORY 			@"OTS_REFESH_MY_YHD_BROWSE_HISTORY"//刷新我的收藏中购物足迹

//app
#define OTS_APP_WILL_RESIGN_ACTIVE          UIApplicationWillResignActiveNotification
#define OTS_APP_DID_ENTER_BACKGROUND        UIApplicationDidEnterBackgroundNotification
#define OTS_APP_WILL_ENTER_FOREGROUND       UIApplicationWillEnterForegroundNotification
#define OTS_APP_DID_BECOME_ACTIVE           UIApplicationDidBecomeActiveNotification

//启动多图
#define OTS_LAUNCH_PAGE_DISAPPER            @"OTS_LAUNCH_PAGE_DISAPPER"//启动多图消失
//订单评论
#define OTS_COMMENTFINIAH_ALLPRODUCT        @"OTS_COMMENTFINIAH_ALLPRODUCT"//订单评论完成
//晒图通知
#define OTS_COMMENTSHARE_DIDSELECTED        @"OTS_COMMENTSHARE_DIDSELECTED"//晒图通知
//宝宝中心
#define OTS_BABY_STATUS                     @"OTS_BABY_STATUS"//宝宝资料状态更新
//客服中心
#define OTS_RECEIVE_MSG                     @"OTS_RECEIVE_MSG"//收到消息
//首页
#define OTS_UPDATE_HOMEPAGE                 @"OTS_UPDATE_HOMEPAGE"//首页更新通知
#define OTS_DAY_SIGN_IN                     @"OTS_DAY_SIGN_IN"//首页每日签到更新通知
#define OTS_FIRST_DAY_SIGN_IN              	@"OTS_FIRST_DAY_SIGN_IN"//第一次登陆悬浮窗显示
#define OTS_OCLOCK_GROUPON                	@"OTS_OCLOCK_GROUPON"//首页整点抢时间更新通知
#define OTS_OCLOCK_DOUSHOU                 	@"OTS_OCLOCK_DOUSHOU"//首页剁手价时间更新通知

//问卷
#define OTS_GETREWADPRIZE_SUCCESS           @"OTS_GETREWADPRIZE_SUCCESS"//问卷,获取奖励成功的通知

//每日惠
#define OTS_DAILYBUY_ACTIVITY               @"OTS_DAILYBUY_ACTIVITY"//每日惠订阅操作通知

//网络
#define OTS_SHOW_ERROR_VIEW                 @"OTS_SHOW_ERROR_VIEW"//显示错误界面(无网络连接，或者服务器忙)

#define OTS_HIDE_NO_CONNECT_ERROR_VIEW      @"OTS_HIDE_NO_CONNECT_ERROR_VIEW"//隐藏无网络错误界面

#define OTS_SHOW_NETWORK_FORCE              @"OTS_SHOW_NETWORK_FORCE"//显示网络强制提示

#define OTS_HOMEPAGE_SHOW_NOWORK            @"OTS_HOMEPAGE_SHOW_NOWORK" //首页无网络提示

#define OTS_HOMEPAGE_SHOW_SHOPFOOTPRINTER 	@"OTS_HOMEPAGE_SHOW_SHOPFOOTPRINTER"//首页是否显示购物足迹
//cart
#define OTS_UPDATE_SHOPPING_CART            @"OTS_UPDATE_SHOPPING_CART"//刷新购物车
#define OTS_SERIES_ADDTOCARTSUCESS          @"OTS_SERIES_ADDTOCARTSUCESS"//系列属性选择页面加入购物车成功发送通知
#define OTS_CARTCOUNT_NEED_UPDATED          @"OTS_CARTCOUNT_NEED_UPDATED"//购物车需要刷新数量
#define OTS_CARTCOUNT_UPDATED               @"OTS_CARTCOUNT_UPDATED"//购物车里面购物数量发生更新
#define OTS_UPDATE_CART_COUNT               @"OTS_UPDATE_CART_COUNT"//通知购物车重新获取商品数量

//商品详情
#define OTS_UPDATE_PRODUCT_DETAIL           @"OTS_UPDATE_PRODUCT_DETAIL"//商品数据需要更新
//团购详情开团提醒
#define OTS_DEAD_TIMER_STOP                 @"OTS_DEAD_TIMER_STOP"
//预售结束
#define OTS_PRESELL_DEAD_TIMER_STOP         @"OTS_PRESELL_DEAD_TIMER_STOP"

#define OTS_SHOWDETAILVC_PRODUCT_DETAIL     @"OTS_SHOWDETAILVC_PRODUCT_DETAIL" // 展示详情控制器
#define OTS_MOREMERCHANT_REFRESH            @"OTS_MOREMERCHANT_REFRESH"  // 一品多商刷新数据

//闪购
#define OTS_FLASH_BUY_REMAINED              @"OTS_FLASH_BUY_REMAINED"//闪购支付提醒
#define OTS_UPDATE_FLASHPRODUCT_DETAIL      @"OTS_UPDATE_FLASHPRODUCT_DETAIL"  //闪购详情时间倒计时切换

//雷购
#define OTS_RAYBUY_DELETE_ADDRESS           @"OTS_DELETE_RAYADDRESS" //雷购时删除地址
#define OTS_REFRESH_RAYBUY_HOMEPAGE         @"OTS_REFRESH_RAYBUY_HOMEPAGE" //雷购首页刷新
#define OTS_RAYBUY_PRODUCTCOUNT_UPDATE      @"OTS_RAYBUY_PRODUCTCOUNT_UPDATE" //雷购商品数量更新通知

//结算
#define OTS_CHECK_ORDER_CLOSE_KEYBOARD      @"OTS_CHECK_ORDER_CLOSE_KEYBOARD"//结算收起键盘
#define OTS_CHECK_ORDER_UPDATE              @"OTS_CHECK_ORDER_UPDATE"//刷新结算
#define OTS_CHECK_ORDER_BIND_PHONE          @"OTS_CHECK_ORDER_BIND_PHONE"//刷新结算

//发票
#define OTS_INVOICE_CLOSE_KEYBOARD          @"OTS_INVOICE_CLOSE_KEYBOARD"//发票界面 收起键盘
//route
#define OTS_ROUTE_TO_URL                    @"OTS_ROUTE_TO_URL"//route到指定的url
#define OTS_SHOW_VERSION_UPDATE             @"OTS_SHOW_VERSION_UPDATE"//显示版本更新空态界面
#define OTS_RAYBUY_PRODUCTCOUNT_UPDATE      @"OTS_RAYBUY_PRODUCTCOUNT_UPDATE"
#define OTS_MESSAGE_SEND_MERCHANTINFO 		@"OTS_MESSAGE_SEND_MERCHANTINFO"  // 历史消息获取商家名字
#define OTS_MESSAGE_SEND_SESSIONINFO  		@"OTS_MESSAGE_SEND_SESSIONINFO"   // 发送商家名字

//消息
#define OTS_GLOBAL_SHOW_MESSAGE       		@"OTS_GLOBAL_SHOW_MESSAGE"        // 会话里获取商家名字
#define OTS_GLOBAL_HIDEN_MESSAGE       		@"OTS_GLOBAL_HIDEN_MESSAGE"        // 隐藏全局消息展示
#define OTS_GLOBAL_CAN_SHOW_MESSAGE    		@"OTS_GLOBAL_CAN_SHOW_MESSAGE"        //是否可以展示全局消息展示

#define OTS_GET_ALL_UNREADNUM        			@"OTS_GET_ALL_UNREADNUM"          // 获得所有未读数
#define OTS_REFRESH_PRODUCTURL        			@"OTS_REFRESH_PRODUCTURL"         // 刷新url可视化
#define OTS_CALLCENTER_UPDATE_MESSAGE_COUNT 	@"OTS_CALLCENTER_UPDATE_MESSAGE_COUNT"  // 更新消息数字
#define OTS_CALLCENTER_FOOTERORDER    			@"OTS_CALLCENTER_FOOTERORDER"     // 订单或足迹

#define OTS_UNION_LOGIN_BACK                	@"OTS_UNION_LOGIN_BACK"//联合登录返回

#define OTS_GET_PRODUCT_DETAIL_FOR_CALL_MSG_VO  @"OTS_GET_PRODUCT_DETAIL_FOR_CALL_MSG_VO"

#define OTS_CHANGE_STATUSBAR_FRAME      		@"UIApplicationDidChangeStatusBarFrameNotification" //app状态栏发送变化，主要是打电话

#define OTS_HOMEPAGE_ACTIVITY   				@"OTS_HOMEPAGE_ACTIVITY" //首页活动通知(导航栏、刷新背景、功能入口、tabbar)

#define OTS_HOMEPAGE_TABBAR_ITEM   				@"OTS_HOMEPAGE_TABBAR_ITEM" //首页tabbar item

#define OTS_CDN_LOG                         	@"OTS_CDN_LOG"//cdn日志
#define OTS_CMS_LOG                         	@"OTS_CMS_LOG"//CMS日志

#define OTSRayBuyAddressDidChangeNotification   @"OTSRayBuyAddressDidChangeNotification" //雷购地址发生变化通知

#define OTS_UPDATE_RAYBUYCART            @"OTS_UPDATE_RAYBUYCART "//刷新雷购购物车
#define OTS_GOTO_RAYBUYHOMEVC            @"OTS_GOTO_RAYBUYHOMEVC" //跳转到o2o首页







