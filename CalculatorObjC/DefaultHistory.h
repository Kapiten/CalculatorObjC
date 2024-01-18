//
//  DefaultHistory.h
//  CalculatorObjC
//
//  Created by Admin on 2024/01/18.
//

#ifndef DefaultHistory_h
#define DefaultHistory_h

#endif /* DefaultHistory_h */

@interface DefaultHistory : NSObject
- (NSUserDefaults*) getDefaults;
- (NSArray*) getExpressions;
- (void) addItem:(NSString *)expression;
- (void) removeItem:(NSString *)expression;
- (void) removeItemAtIndex:(NSInteger *) index;
- (void) removeDuplicates;
@end
