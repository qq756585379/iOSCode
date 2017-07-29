//
//  NSOperationTestVC.m
//  Demos
//
//  Created by 杨俊 on 2017/7/28.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "NSOperationTestVC.h"
#import "DownloadOperation.h"

@interface NSOperationTestVC ()
@property (nonatomic, strong) NSOperationQueue *queue;//队列
@property (nonatomic, strong) NSMutableDictionary *dicCacheOperation;//操作缓存池
@property (nonatomic, strong) NSMutableDictionary *dicCacheImage;//图片缓存池
@end

@implementation NSOperationTestVC

#pragma mark -  lazyLoading
- (NSMutableDictionary *)dicCacheImage{
    if (_dicCacheImage == nil) {
        _dicCacheImage = [NSMutableDictionary dictionary];
    }
    return _dicCacheImage;
}
- (NSMutableDictionary *)dicCacheOperation{
    if (_dicCacheOperation == nil) {
        _dicCacheOperation = [NSMutableDictionary dictionary];
    }
    return _dicCacheOperation;
}
- (NSOperationQueue *)queue{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
}

#pragma mark  dataSource数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"app";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row];

//    UIImage *image = self.dicCacheImage[app.icon];
//    if (image) { // 如果图片缓存中有图片 直接加载到
//        cell.imageView.image = image;
//    }else{ // 如果缓存中没有数据
//        cell.imageView.image = [UIImage imageNamed:@"57437179_42489b0"];
//        
//        // 创建自定义的operation 先根据当前要显示图片的url从队列中找到operation 看是否正在下载中
//        DownloadOperation *operationDown = self.operationQueue[app.icon];
//        if (!operationDown) { // 如果下载operation不存在 就创建 并添加到队列中
//            operationDown = [[XBOperation alloc] init];
//            operationDown.delegate = self; // 设置代理
//            operationDown.indexPath = indexPath; // 把每个cell与一个operation绑定
//            operationDown.url = app.icon;
//            // 把operation添加到队列中 会自动调用start方法 然后调用operation的main的方法
//            [self.queue addOperation:operationDown];
//            // 把operation这个下载任务添加到operation的字典中 防止重复下载
//            self.operationQueue[app.icon] = operationDown;
//        }
//    }
    return cell;
}

// 实现代理方法
//-(void)operation:(XBOperation *)operation didFinishDownloadImage:(UIImage *)image{
//    // 必须清楚当前operation 防止由于网络等原因造成的下载失败 而operation还在字典中 这样永远下载不了
//    [self.operationQueue removeObjectForKey:operation.url];
//    
//    if (image) {
//        // 将图片放在缓存字典中
//        self.imageCache[operation.url] = image;
//        
//        // 刷新表格 单行刷新
//        [self.tableView reloadRowsAtIndexPaths:@[operation.indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.dicCacheImage removeAllObjects];
    [self.dicCacheOperation removeAllObjects];
    [self.queue cancelAllOperations];
}

@end
