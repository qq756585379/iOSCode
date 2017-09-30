//
//  TableViewController.m
//  OpenGL
//
//  Created by 杨俊 on 2017/9/30.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "TableViewController.h"
#import "GLKitViewController.h"
#import "ShaderViewController.h"

@interface MBExample : NSObject
@property (nonatomic,   copy) NSString *title;
@property (nonatomic, assign) SEL selector;
@end

@implementation MBExample

+ (instancetype)exampleWithTitle:(NSString *)title selector:(SEL)selector {
    MBExample *example = [[self class] new];
    example.title = title;
    example.selector = selector;
    return example;
}
@end

@interface TableViewController ()
@property (nonatomic, strong) NSArray<MBExample *>*examples;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    self.examples = @[[MBExample exampleWithTitle:@"01-GLKit" selector:@selector(GLKitExample)],
                      [MBExample exampleWithTitle:@"02-Shader" selector:@selector(ShaderExample)],
                      [MBExample exampleWithTitle:@"03-RotateEarth" selector:@selector(RotateEarthExample)]
                      
                      ];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView reloadData];
}

-(void)GLKitExample{
    GLKitViewController *vc = [GLKitViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)ShaderExample{
    ShaderViewController *vc = [ShaderViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)RotateEarthExample{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.examples.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MBExample *example = self.examples[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = example.title;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = [cell.textLabel.textColor colorWithAlphaComponent:0.1f];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MBExample *example = self.examples[indexPath.row];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:example.selector];
#pragma clang diagnostic pop
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
}

@end
