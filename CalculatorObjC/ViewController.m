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
    if([_lblExpression.text isEqualToString:@"Expression"]){[_lblExpression setText:@""];}
    if([current isEqualToString:@"0"]) {
        [current setString: sender.titleLabel.text];
//        [_expression setString:[[_expression substringToIndex:lastSymbolIndex-1] stringByAppendingString:current]];
    }
//    else if(_expression.length>1&&[[_expression substringFromIndex:_expression.length-1] isEqualToString:@"0"]&&![NSString stringWithCharacters:[_expression characterAtIndex:_expression.length-2] length:1].floatValue){
//        [_lblExpression setText:[_expression substringToIndex:_expression.length-2]];}
    else {[current appendString: sender.titleLabel.text];}
    [self appendExpression:@""];
//    [_lblExpression setText:[[_lblExpression.text substringToIndex:lastSymbolIndex] stringByAppendingString:current]];
    
//    if(_expression.length>1){NSLog(@"%@:%@",  @"Expression#charAt-2", [_expression characterAtIndex:_expression.length-2]);}
}

- (IBAction)tapSymbol:(UIButton *)sender {
    if(_lblExpression.text.length>1&&lastSymbolIndex==_lblExpression.text.length-1){return;}
    if(current.length<1){if(sender.tag<3){[current setString:@"0"];}else{[current setString:@"1"];}}
    
//    NSObject obj =[_lblExpression.text substringFromIndex:_lblExpression.text.length-1]
    if (current.floatValue||[current isEqualToString:@"0"]) {
        switch (sender.tag) {
            case 1: [self appendExpression: @"+"]; break;
            case 2: [self appendExpression: @"-"]; break;
            case 3: [self appendExpression: @"÷"]; break;
            case 4: [self appendExpression: @"×"]; break;
            case -1: [self appendExpression: sender.titleLabel.text]; break;
            default: break;
        }
        lastSymbolIndex=_lblExpression.text.length-1;
        [current setString:@""];
    }
    
//    [_lblExpression setText:_expression];
}

- (IBAction)tapClear:(UIButton *)sender {[self clearAll];}

- (IBAction)tapBackspace:(UIButton *)sender {
    if(current.length>0){[current setString:[current substringToIndex:current.length-1]];}
    if(current.length<=0){[self clearAll]; return;}
    [_lblExpression setText:_expression];
}

- (void)clearAll {
    [_lblExpression setText:@"Expression"];
    [current setString:@""];
}

- (void) appendExpression:(NSString *)val {
    NSString *toEnter;
    NSInteger indx=lastSymbolIndex;
    if([val isEqualToString:@""]){toEnter=current;}
    else {toEnter=val;}
    if(indx<1){indx=_lblExpression.text.length-1;}
    [_lblExpression setText:[[_lblExpression.text substringToIndex:indx] stringByAppendingString:toEnter]];
}

@end
