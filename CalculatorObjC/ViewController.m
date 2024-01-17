//
//  ViewController.m
//  CalculatorObjC
//
//  Created by Admin on 2024/01/16.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblAnswer;
@property (weak, nonatomic) IBOutlet UITextView *txtExpression;
@property (weak, nonatomic) IBOutlet UILabel *lblExpression;
@property (strong, nonatomic) NSMutableString *expression;

@end

@implementation ViewController

NSInteger lastSymbolIndex=0;
NSMutableString *current=@"";
NSMutableArray *arrExpression;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _expression = [[NSMutableString alloc] init];
    current = [[NSMutableString alloc] init];
    arrExpression = [[NSMutableArray alloc] init];
}

- (IBAction)tapNumber:(UIButton *)sender {
    if([_txtExpression.text isEqualToString:@"Expression"]){[_txtExpression setText:@""];}
    NSMutableString *obj =@"";
    if(_txtExpression.text.length>0){obj = [_txtExpression.text substringFromIndex:_txtExpression.text.length-1];}
    if([obj isEqualToString:@""]||[obj isEqualToString:@"0"]) {
//        [current setString: sender.titleLabel.text];
        if(_txtExpression.text.length>0){_txtExpression.text = [_txtExpression.text substringToIndex:_txtExpression.text.length-1];}
        [self appendExpression:sender.titleLabel.text];
//        [_expression setString:[[_expression substringToIndex:lastSymbolIndex-1] stringByAppendingString:current]];
    }
//    else if(_expression.length>1&&[[_expression substringFromIndex:_expression.length-1] isEqualToString:@"0"]&&![NSString stringWithCharacters:[_expression characterAtIndex:_expression.length-2] length:1].floatValue){
//        [_txtExpression setText:[_expression substringToIndex:_expression.length-2]];}
    else {[self appendExpression:sender.titleLabel.text];}
    
//    [_txtExpression setText:[[_txtExpression.text substringToIndex:lastSymbolIndex] stringByAppendingString:current]];
    
//    if(_expression.length>1){NSLog(@"%@:%@",  @"Expression#charAt-2", [_expression characterAtIndex:_expression.length-2]);}
    NSLog(@"%@%@", @"current tapNumber:", current);
}

- (IBAction)tapSymbol:(UIButton *)sender {
    NSString *currSym = @"";
//    if(_txtExpression.text.length>1&&lastSymbolIndex==_txtExpression.text.length-1){return;}
    NSMutableString *obj =[_txtExpression.text substringFromIndex:_txtExpression.text.length-1];
    if(_txtExpression.text.length<1||(!obj.floatValue&&![obj isEqualToString:@"0"])){if(sender.tag<3){_txtExpression.text = [_txtExpression.text stringByAppendingString:@"0"];}else{_txtExpression.text = [_txtExpression.text stringByAppendingString:@"1"];}}
    obj =[_txtExpression.text substringFromIndex:_txtExpression.text.length-1];
    if (obj.floatValue||[obj isEqualToString:@"0"]) {
        switch (sender.tag) {
            case 1: currSym = @"+"; break;
            case 2: currSym = @"-"; break;
            case 3: currSym = @"÷"; break;
            case 4: currSym = @"×"; break;
            case -1: [self appendExpression: sender.titleLabel.text]; break;
            default: break;
        }
        NSLog(@"%@%@", @"obj tapSymbol:", obj);
        [self appendExpression: currSym];
        [arrExpression addObject:current];
        [arrExpression addObject:currSym];
        lastSymbolIndex=_txtExpression.text.length-1;
        [current setString:@""];
    }
    
//    [_txtExpression setText:_expression];
}

- (IBAction)tapClear:(UIButton *)sender {[self clearAll];}

- (IBAction)tapBackspace:(UIButton *)sender {
    
//    if(current.length<=0){[arrExpression removeLastObject];[arrExpression removeLastObject];NSString *aStr =(NSString *)[arrExpression lastObject];[current setString:aStr];}
//    if(current.length>0){[current setString:[current substringToIndex:current.length-1]];}
    [_txtExpression setText:[_txtExpression.text substringToIndex:_txtExpression.text.length-1]];
    NSLog(@"%@%@\n%@%@", @"current fromBackS:", current, @"aStr:", [arrExpression lastObject]);
}

- (void)clearAll {
    [_txtExpression setText:@"Expression"];
    [current setString:@""];
}

- (void) appendExpression:(NSString *)val {
//    NSString *toEnter;
//    NSInteger indx=lastSymbolIndex;
//    if([val isEqualToString:@""]){toEnter=current;}
//    else {toEnter=val;}
//    if(indx<1){indx=_txtExpression.text.length-1;if(indx<0){indx=0; if(!val.floatValue){indx+=1;}}}
//    [_txtExpression setText:[[_txtExpression.text substringToIndex:indx] stringByAppendingString:toEnter]];
    [_txtExpression setText:[_txtExpression.text stringByAppendingString:val]];
    NSRange bottom = NSMakeRange(_txtExpression.text.length -1, 1);
    [_txtExpression scrollRangeToVisible:bottom];
}

@end
