//
//  Person.m
//  RuntimeTestDemo
//
//  Created by 赵富星 on 2017/7/4.
//  Copyright © 2017年 thomas. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

#pragma mark - Public

- (void)eat:(NSString *)name
      array:(NSArray *)array {
    NSLog(@"吃");
}

- (void)sleep {
    NSLog(@"睡觉");
}

- (void)work {
    NSLog(@"工作");
}

#pragma mark - EncodeCoder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    unsigned int count;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        
        objc_property_t property = properties[i];
        
        const char *name =property_getName(property);
        
        NSString *propertyName = [NSString stringWithUTF8String:name];
        
        NSString *propertyVaule = [self valueForKey:propertyName];
        
        [aCoder encodeObject:propertyVaule forKey:propertyName];
        
    }
    free(properties);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    unsigned int count;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0 ; i < count; i++) {
        
        objc_property_t property = properties[i];
        
        const char *name = property_getName(property);
        
        NSString *propertyName = [NSString stringWithUTF8String:name];
        
        NSString *propertyValue = [aDecoder decodeObjectForKey:propertyName];
        
        [self setValue:propertyValue forKey:propertyName];
    
    }
    free(properties);
    
    return self;
    
}

@end
