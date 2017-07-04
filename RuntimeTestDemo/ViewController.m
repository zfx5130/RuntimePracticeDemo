//
//  ViewController.m
//  RuntimeTestDemo
//
//  Created by 赵富星 on 2017/7/4.
//  Copyright © 2017年 thomas. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"
#include <objc/runtime.h>
#import <objc/message.h>


@interface ViewController ()

@end

@implementation ViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self outputPersonIvarName];
    [self outputPersonPropertyName];
    [self outputPersionMethodName];
    [self outputPersonProtocolName];
    [self testPersonEncode];
    
    [self testSendmessage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Test

//获取一个类的全部成员变量名
- (void)outputPersonIvarName {
    
    unsigned int count;
    
    //定义对象的实例变量，包括类型和名字。
    Ivar *ivars = class_copyIvarList([Person class], &count);
    
    for (int i = 0; i < count; i++) {
        
        Ivar ivar = ivars[i];
        
        const char *name = ivar_getName(ivar);
        
        NSString *nameString = [NSString stringWithUTF8String:name];
        
        NSLog(@"propertyname:::::%@",nameString);
        
    }
    free(ivars);
    NSLog(@"------------------------------------");
}


//获取一个类所有的属性名
- (void)outputPersonPropertyName {
    
    unsigned int count;
    
    objc_property_t *properties = class_copyPropertyList([Person class], &count);
    
    for (int i = 0; i < count; i++) {
        
        objc_property_t property = properties[i];
       
        const char *name = property_getName(property);
        
        NSString *propertyName = [NSString stringWithUTF8String:name];
        
        NSLog(@"propertyName::::%@",propertyName);
        
    }
    free(properties);
    NSLog(@"------------------------------------");
}

- (void)outputPersionMethodName {
    
    unsigned int count;
    
    Method *methods = class_copyMethodList([Person class], &count);
    
    for (int i = 0 ; i < count; i++) {
        
        //获取该类方法的一个指针
        Method method = methods[i];
        //获取方法
        SEL methodName = method_getName(method);
        //将方法转换成C字符串
        const char *methodString = sel_getName(methodName);
        //将C语言字符串转换成OC字符串
        NSString *methodStr = [NSString stringWithUTF8String:methodString];
        
        int arguments = method_getNumberOfArguments(method);
        
        NSLog(@"argumentsCount:::::%@:::methodStr:::::%@",@(arguments),methodStr);
        
    }
    free(methods);
    NSLog(@"------------------------------------");
}


//获取这个类遵循的所有协议
- (void)outputPersonProtocolName {
    
    unsigned int count;
    
    __unsafe_unretained Protocol **protocols = class_copyProtocolList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        
        Protocol *protocol = protocols[i];
        
        const char *name = protocol_getName(protocol);
        
        NSString *protocolName = [NSString stringWithUTF8String:name];
        NSLog(@"protocolName:::::%@",protocolName);
    }
    
    free(protocols);
    NSLog(@"-------------------------------------");
    
}


- (void)testPersonEncode {
    
    Person *person = [[Person alloc] init];
    
    person.name = @"张三";
    person.job = @"搬砖";
    person.age = 10;
    person.address = @"月球";
    person.sex = @"男";
    person.education = @"小学";
    
    NSString *path = [NSString stringWithFormat:@"%@/archive",NSHomeDirectory()];
    [NSKeyedArchiver archiveRootObject:person toFile:path];
    
    Person *unArchivePerson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSLog(@"person:::::%@",unArchivePerson);
    NSLog(@"path:::::%@",path);
}

- (void)testSendmessage {
    Person *person = [[Person alloc] init];
}


@end
