//
//  GCDTestVC.m
//  Demos
//
//  Created by 杨俊 on 2017/7/28.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "GCDTestVC.h"

#define YJGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface GCDTestVC ()
{
    dispatch_queue_t _concurrentQueue;
}
@end

@implementation GCDTestVC

//http://www.cnblogs.com/ziyi--caolu/p/4900650.html

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _concurrentQueue = dispatch_queue_create("com.person.syncQueue", DISPATCH_QUEUE_SERIAL);
    
//    [self test1];
//    [self test2];
//    [self test3];
//    [self test4];
//    [self test5];
//    [self test6];
    [self test7];
}

-(void)test1{
    dispatch_barrier_async(_concurrentQueue, ^{
        sleep(5);
        NSLog(@"任务一完成%@",[NSThread currentThread]);
    });
    dispatch_barrier_async(_concurrentQueue, ^{
        sleep(4);
        NSLog(@"任务二完成%@",[NSThread currentThread]);
    });
    dispatch_barrier_async(_concurrentQueue, ^{
        sleep(6);
        NSLog(@"任务三完成%@",[NSThread currentThread]);
    });
    dispatch_barrier_async(_concurrentQueue, ^{
        sleep(3);
        NSLog(@"任务四完成%@",[NSThread currentThread]);
    });
}

-(void)test2{
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_async(dispatchGroup, _concurrentQueue, ^(){
        sleep(5);
        NSLog(@"任务一完成%@",[NSThread currentThread]);
    });
    dispatch_group_async(dispatchGroup, _concurrentQueue, ^(){
        sleep(10);
        NSLog(@"任务二完成%@",[NSThread currentThread]);
    });
    dispatch_group_async(dispatchGroup, _concurrentQueue, ^(){
        sleep(6);
        NSLog(@"任务三完成%@",[NSThread currentThread]);
    });
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        NSLog(@"notify：任务都完成了%@",[NSThread currentThread]);
    });
}

-(void)test3{
    dispatch_async(_concurrentQueue, ^{
        NSLog(@"--------%@", [NSThread currentThread]);
        dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
        dispatch_sync(globalQueue, ^{
            sleep(5);
            NSLog(@"-----下载图片1---%@", [NSThread currentThread]);
        });
        dispatch_sync(globalQueue, ^{
            sleep(8);
            NSLog(@"-----下载图片2---%@", [NSThread currentThread]);
        });
        dispatch_sync(globalQueue, ^{
            sleep(2);
            NSLog(@"-----下载图片3---%@", [NSThread currentThread]);
        });
        dispatch_sync(globalQueue, ^{
            sleep(3);
            NSLog(@"-----下载图片4---%@", [NSThread currentThread]);
        });
        dispatch_sync(globalQueue, ^{
            sleep(6);
            NSLog(@"-----下载图片5---%@", [NSThread currentThread]);
        });
    });
}

-(void)test4{
    dispatch_async(_concurrentQueue, ^{
        sleep(6);
        NSLog(@"-----下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_async(_concurrentQueue, ^{
        sleep(2);
        NSLog(@"-----下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_async(_concurrentQueue, ^{
        sleep(4);
        NSLog(@"-----下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_async(_concurrentQueue, ^{
        sleep(5);
        NSLog(@"-----下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_async(_concurrentQueue, ^{
        sleep(1);
        NSLog(@"-----下载图片5---%@", [NSThread currentThread]);
    });
}

//如果group中包含异步操作,用这个方式
-(void)test5{
    dispatch_group_t getDataGroup = dispatch_group_create();
    dispatch_group_enter(getDataGroup);
    dispatch_async(_concurrentQueue, ^{
        sleep(5);
        NSLog(@"-----下载图片1---%@", [NSThread currentThread]);
        dispatch_group_leave(getDataGroup);
    });
    
    dispatch_group_enter(getDataGroup);
    dispatch_async(_concurrentQueue, ^{
        sleep(2);
        NSLog(@"-----下载图片2---%@", [NSThread currentThread]);
        dispatch_group_leave(getDataGroup);
    });
    
    dispatch_group_enter(getDataGroup);
    dispatch_async(_concurrentQueue, ^{
        sleep(4);
        NSLog(@"-----下载图片3---%@", [NSThread currentThread]);
        dispatch_group_leave(getDataGroup);
    });
    
    dispatch_group_enter(getDataGroup);
    dispatch_async(_concurrentQueue, ^{
        sleep(1);
        NSLog(@"-----下载图片4---%@", [NSThread currentThread]);
        dispatch_group_leave(getDataGroup);
    });
    
    dispatch_group_notify(getDataGroup, dispatch_get_main_queue(), ^{
        NSLog(@"-----结束了---%@", [NSThread currentThread]);
    });
}

-(void)test6{
    dispatch_group_t getDataGroup = dispatch_group_create();
    dispatch_group_async(getDataGroup, _concurrentQueue, ^(){
        sleep(5);
        NSLog(@"任务1完成%@",[NSThread currentThread]);
    });
    dispatch_group_async(getDataGroup, _concurrentQueue, ^(){
        sleep(2);
        NSLog(@"任务2完成%@",[NSThread currentThread]);
    });
    dispatch_group_async(getDataGroup, _concurrentQueue, ^(){
        sleep(4);
        NSLog(@"任务3完成%@",[NSThread currentThread]);
    });
    dispatch_group_async(getDataGroup, _concurrentQueue, ^(){
        sleep(3);
        NSLog(@"任务4完成%@",[NSThread currentThread]);
    });
    
    // 不阻塞当前线程，getDataGroup执行完他就执行
//    dispatch_group_notify(getDataGroup, dispatch_get_main_queue(), ^{
//        NSLog(@"队列执行完毕---------");
//    });
    
    // 阻塞当前线程，目前在主线程，主线程被阻塞，从上个页面跳转进来需要这个方法走完才进的来，（需要放子线程中，阻塞子线程）
    dispatch_group_wait(getDataGroup, DISPATCH_TIME_FOREVER);
    NSLog(@"dispatch_group_wait队列执行完毕---------");
}

-(void)test7{
    dispatch_group_t getDataGroup = dispatch_group_create();
    
    dispatch_group_async(getDataGroup, YJGlobalQueue, ^(){
        sleep(5);
        NSLog(@"任务1完成%@",[NSThread currentThread]);
    });
    dispatch_group_async(getDataGroup, YJGlobalQueue, ^(){
        sleep(2);
        NSLog(@"任务2完成%@",[NSThread currentThread]);
    });
    dispatch_group_async(getDataGroup, YJGlobalQueue, ^(){
        sleep(4);
        NSLog(@"任务3完成%@",[NSThread currentThread]);
    });
    dispatch_group_async(getDataGroup, YJGlobalQueue, ^(){
        sleep(3);
        NSLog(@"任务4完成%@",[NSThread currentThread]);
    });
    
    // 不阻塞当前线程，getDataGroup执行完他就执行
    dispatch_group_notify(getDataGroup, dispatch_get_main_queue(), ^{
        NSLog(@"队列执行完毕---------");
    });
    NSLog(@"没被阻塞---------");
    
    // 阻塞当前线程，目前在主线程，主线程被阻塞，从上个页面跳转进来需要这个方法走完才进的来，（需要放子线程中，阻塞子线程）
//    dispatch_group_wait(getDataGroup, DISPATCH_TIME_FOREVER);
//    NSLog(@"dispatch_group_wait队列执行完毕---------");
}

@end













