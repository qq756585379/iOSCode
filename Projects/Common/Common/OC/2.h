/*
 一、保存图片到【自定义相册】
 1.保存图片到【相机胶卷】
 1> C语言函数UIImageWriteToSavedPhotosAlbum
 2> AssetsLibrary框架
 3> Photos框架
 
 2.拥有一个【自定义相册】
 1> AssetsLibrary框架
 2> Photos框架
 
 3.添加刚才保存的图片到【自定义相册】
 1> AssetsLibrary框架
 2> Photos框架
 */
-(void)animate{
    [UIView animateWithDuration:2.0 animations:^{
        self.view.frame = CGRectMake(0, 0, 100, 100);
    } completion:^(BOOL finished) {
        
    }];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    self.view.frame = CGRectMake(0, 0, 100, 100);
    [UIView commitAnimations];
}
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    
}

-(void)save{
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(a:b:c:), nil);
}
- (void)a:(UIImage *)image b:(NSError *)error c:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
}

/*
 错误信息：-[NSInvocation setArgument:atIndex:]: index (2) out of bounds [-1, 1]
 错误解释：参数越界错误，方法的参数个数和实际传递的参数个数不一致
 */


/*
 二、Photos框架须知
 1.PHAsset : 一个PHAsset对象就代表相册中的一张图片或者一个视频
 1> 查 : [PHAsset fetchAssets...]
 2> 增删改 : PHAssetChangeRequest(包括图片\视频相关的所有改动操作)
 
 2.PHAssetCollection : 一个PHAssetCollection对象就代表一个相册
 1> 查 : [PHAssetCollection fetchAssetCollections...]
 2> 增删改 : PHAssetCollectionChangeRequest(包括相册相关的所有改动操作)
 
 3.对相片\相册的任何【增删改】操作，都必须放到以下方法的block中执行
 -[PHPhotoLibrary performChanges:completionHandler:]
 -[PHPhotoLibrary performChangesAndWait:error:]
 */

/*
 Foundation和Core Foundation的数据类型可以互相转换，比如NSString *和CFStringRef
 NSString *string = (__bridge NSString *)kCFBundleNameKey;
 CFStringRef string = (__bridge CFStringRef)@"test";
 
 获得相机胶卷相册
 [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil]
 */

/*
 错误信息：This method can only be called from inside of -[PHPhotoLibrary performChanges:completionHandler:] or -[PHPhotoLibrary performChangesAndWait:error:]
 */

-(void)done{
    // 异步执行修改操作
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"保存失败！"];
        } else {
            [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
        }
    }];
    
    // 同步执行修改操作,执行完才往下执行
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
    } error:&error];
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
}






