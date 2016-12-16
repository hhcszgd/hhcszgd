//
//  NSArray+LogMsg.m
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "NSArray+LogMsg.h"
#import "zjlao-Swift.h"
@implementation NSArray (LogMsg)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    //遍历取出每一个元素,并保存抱一个可变字符串里, 最后返回这个字符串即可
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    return strM;
}

- (NSString *)description
{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    //遍历取出每一个元素,并保存抱一个可变字符串里, 最后返回这个字符串即可
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [HomeVC new];
    [strM appendString:@")"];
    return strM;
}

@end

@implementation NSDictionary (LogMsg)

- (NSString *)description
{
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    //遍历取出每一个键值对,并保存抱一个可变字符串里, 最后返回这个字符串即可
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    //遍历取出每一个键值对,并保存抱一个可变字符串里, 最后返回这个字符串即可
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}

    
    -(void)test
    {
//        NSLocalizedStringWithDefaultValue(<#key#>, <#tbl#>, <#bundle#>, <#val#>, <#comment#>)
    }
    
@end
