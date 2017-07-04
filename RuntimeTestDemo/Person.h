//
//  Person.h
//  RuntimeTestDemo
//
//  Created by 赵富星 on 2017/7/4.
//  Copyright © 2017年 thomas. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PersonDelegate <NSObject>

- (void)personDlegateToWork;

@end

@interface Person : NSObject <NSCoding>

@property (assign, nonatomic) id<PersonDelegate> deletage;

@property (copy, nonatomic) NSString *name;

@property (assign, nonatomic) NSInteger age;

@property (copy, nonatomic) NSString *sex;

@property (copy, nonatomic) NSString *job;

@property (copy, nonatomic) NSString *address;

@property (copy, nonatomic) NSString *education;


#pragma mark - Public

- (void)eat:(NSString *)name array:(NSArray *)array;
- (void)work;
- (void)sleep;

@end
