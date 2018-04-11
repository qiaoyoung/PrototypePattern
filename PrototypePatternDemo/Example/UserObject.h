//
//  UserObject.h
//  PrototypePatternDemo
//
//  Created by Joeyoung on 2018/4/8.
//  Copyright © 2018年 Joeyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObject : NSObject<NSCopying>

/** 姓名 */
@property(nonatomic, copy) NSString *name;
/** 性别 */
@property(nonatomic, copy) NSString *sex;


/**
 构造函数

 @param name 姓名
 @param sex 性别
 @return 实例化对象
 */
- (instancetype)initWithName:(NSString *)name
                         sex:(NSString *)sex;

@end
