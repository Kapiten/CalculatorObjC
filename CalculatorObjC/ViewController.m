//
//  ViewController.m
//  CalculatorObjC
//
//  Created by Admin on 2024/01/16.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblAnswer;
@property (weak, nonatomic) IBOutlet UILabel *lblExpression;
@property (strong, nonatomic) NSMutableString *expression;
//@property (strong, nonatomic) NSMutableString *current;

@end

@implementation ViewController

NSInteger lastSymbolIndex=0;
NSMutableString *current=@"";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _expression = [[NSMutableString alloc] init];
    current = [[NSMutableString alloc] init];
}

- (IBAction)tapNumber:(UIButton *)sender {
    if([current isEqualToString:@"0"]) {
        [current setString: sender.titleLabel.text];
        [_expression setString:[[_expression substringToIndex:lastSymbolIndex-1] stringByAppendingString:current]];
    }
//    else if(_expression.length>1&&[[_expression substringFromIndex:_expression.length-1] isEqualToString:@"0"]&&![NSString stringWithCharacters:[_expression characterAtIndex:_expression.length-2] length:1].floatValue){
//        [_lblExpression setText:[_expression substringToIndex:_expression.length-2]];}
    else {[_expression appendString: sender.titleLabel.text];}
    [_lblExpression setText:_expression];
    
//    if(_expression.length>1){NSLog(@"%@:%@",  @"Expression#charAt-2", [_expression characterAtIndex:_expression.length-2]);}
}

- (IBAction)tapSymbol:(UIButton *)sender {
    if(![_expression substringToIndex:_expression.length-1].intValue&&lastSymbolIndex==_expression.length-1){return;}
    if(_expression.length<1){if(sender.tag<3){[_expression setString:@"0"];}else{[_expression setString:@"1"];}}
    
//    NSObject obj =[_lblExpression.text substringFromIndex:_lblExpression.text.length-1]
    if ([_expression substringFromIndex:_expression.length-1].floatValue||[_expression isEqualToString:@"0"]) {
        switch (sender.tag) {
            case 1: [_expression appendString: @"+"]; break;
            case 2: [_expression appendString: @"-"]; break;
            case 3: [_expression appendString: @"÷"]; break;
            case 4: [_expression appendString: @"×"]; break;
            case -1: [_expression appendString: sender.titleLabel.text]; break;
            default: break;
        }
    }
    
    [_lblExpression setText:_expression];
    lastSymbolIndex=_expression.length-1;
    [current setString:@""];
}

- (IBAction)tapClear:(UIButton *)sender {[self clearAll];}

- (IBAction)tapBackspace:(UIButton *)sender {
    if(_expression.length>0){[_expression setString:[_expression substringToIndex:_expression.length-1]];}
    if(_expression.length<=0){[self clearAll]; return;}
    [_lblExpression setText:_expression];
}

- (void)clearAll {
    [_lblExpression setText:@"Expression"];
    [_expression setString:@""];
}

@end
