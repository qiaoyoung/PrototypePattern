//
//  UserObject.m
//  PrototypePatternDemo
//
//  Created by Joeyoung on 2018/4/8.
//  Copyright © 2018年 Joeyoung. All rights reserved.
//

#import "UserObject.h"

@implementation UserObject

- (instancetype)initWithName:(NSString *)name
                         sex:(NSString *)sex
{
    self = [super init];
    if (self) {
        _name = name;
        _sex = sex;
    }
    return self;
}

// copy修饰符的实现方法是 copyWithZone：
/**
 以前开发程序时，会据此把内存分成不同的“区”(zone）,而对象会创建在某个区里面。
 现在不用了，每个程序只有一个区：“默认区”（default zone）.
 */
- (id)copyWithZone:(NSZone *)zone {
    UserObject *copyUser = [[[self class] allocWithZone:zone] initWithName:_name
                                                                       sex:_sex];
    return  copyUser;
}

@end
