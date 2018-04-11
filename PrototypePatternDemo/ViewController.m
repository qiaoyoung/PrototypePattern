//
//  ViewController.m
//  PrototypePatternDemo
//
//  Created by Joeyoung on 2018/4/8.
//  Copyright © 2018年 Joeyoung. All rights reserved.
//

#import "ViewController.h"
#import "UserObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UserObject *user = [[UserObject alloc] initWithName:@"小明" sex:@"男"];
    UserObject *copyUser = [user copy];
    user.name = @"小红";
    NSLog(@"原型对象<%p>的name=%@",user,user.name);
    NSLog(@"克隆对象<%p>的name=%@",copyUser,copyUser.name);
    
}




@end
