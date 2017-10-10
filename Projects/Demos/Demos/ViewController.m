//
//  ViewController.m
//  Demos
//
//  Created by 杨俊 on 2017/7/28.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "ViewController.h"
#import "GCDTestVC.h"
#import "MHGradientColorView.h"
#import "RACViewController.h"

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

@interface ViewController ()
@property (nonatomic, strong) NSArray<MBExample *>*examples;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.examples = @[[MBExample exampleWithTitle:@"Indeterminate mode" selector:@selector(indeterminateExample)],
                      [MBExample exampleWithTitle:@"With label" selector:@selector(labelExample)],
                      [MBExample exampleWithTitle:@"With details label" selector:@selector(detailsLabelExample)],
                      ];
    MHGradientColorView *view = [[MHGradientColorView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.view addSubview:view];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //    [self.navigationController pushViewController:[GCDTestVC new] animated:YES];
    [self.navigationController pushViewController:[RACViewController new] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.examples.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MBExample *example = self.examples[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MBExampleCell" forIndexPath:indexPath];
    cell.textLabel.text = example.title;
    cell.textLabel.textColor = self.view.tintColor;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = [cell.textLabel.textColor colorWithAlphaComponent:0.1f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MBExample *example = self.examples[indexPath.section][indexPath.row];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:example.selector];
#pragma clang diagnostic pop
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
}

@end
