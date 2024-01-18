//
//  DefaultHistory.m
//  CalculatorObjC
//
//  Created by Admin on 2024/01/18.
//

#import <Foundation/Foundation.h>
#import "DefaultHistory.h"

@interface DefaultHistory ()

@end

@implementation DefaultHistory

NSUserDefaults *ud;

- (NSUserDefaults*) getDefaults {
    if(ud==nil){ud = [[NSUserDefaults alloc] init];}
    
    return ud;
}

- (NSArray*) getExpressions {return [[self getDefaults] stringArrayForKey:@"expression"];}

- (void) addItem:(NSString *)expression {
    if([[self getDefaults] stringArrayForKey:@"expression"]==nil){[[self getDefaults] setValue:[[NSArray alloc] initWithObjects:@"", nil] forKey:@"expression"];}
    NSMutableArray *arr = [[self getDefaults] stringArrayForKey:@"expression"].mutableCopy;
    if(![arr containsObject:expression]){[arr addObject:expression];}
    
    [[self getDefaults] setObject:arr forKey:@"expression"];
}

- (void) removeItem:(NSString *)expression {
    NSMutableArray *arr = [[self getDefaults] stringArrayForKey:@"expression"].mutableCopy;
    [arr removeObject:expression];
    
    [[self getDefaults] setObject:arr forKey:@"expression"];
}

- (void) removeItemAtIndex:(NSInteger *)index {
    NSMutableArray *arr = [[self getDefaults] stringArrayForKey:@"expression"].mutableCopy;
    [arr removeObjectAtIndex:index];
    
    [[self getDefaults] setObject:arr forKey:@"expression"];
}

- (void) removeDuplicates {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    NSLog(@"%@%@", @"Expression:", [self getExpressions]);
    for(NSString *aStr in [self getExpressions]) {
        NSString *aString = [[aStr stringByReplacingOccurrencesOfString:@"/" withString:@"÷"] stringByReplacingOccurrencesOfString:@"*" withString:@"×"];
        if(![arr containsObject:aString]){[arr addObject:aString];}
    }
    
    [[self getDefaults] setObject:arr forKey:@"expression"];
}

@end
