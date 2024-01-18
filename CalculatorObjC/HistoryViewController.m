//
//  HistoryViewController.m
//  CalculatorObjC
//
//  Created by Admin on 2024/01/18.
//

#import <Foundation/Foundation.h>
#import "HistoryViewController.h"
#import "ViewController.h"
#import "DefaultHistory.h"

@interface HistoryViewController ()
    
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [[[DefaultHistory alloc] init] removeDuplicates];
}
    
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cella"];
    cell.textLabel.text = [self expressionAtIndex:indexPath];
    
    return cell;
}

- (NSInteger*)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {return [[[DefaultHistory alloc] init] getExpressions].count;}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for(UIViewController *vc in self.navigationController.viewControllers) {
        if([vc isMemberOfClass:[ViewController class]]) {
            [((ViewController*) vc) writeExpression:[self expressionAtIndex:indexPath]];
            [self.navigationController popViewControllerAnimated:true];
        }
    }
}

- (NSString*) expressionAtIndex: (NSIndexPath*) indexPath {
    return [[[[NSString alloc] initWithFormat:@"%@",[[[[DefaultHistory alloc] init] getExpressions] objectAtIndex:indexPath.row]] stringByReplacingOccurrencesOfString:@"/" withString:@"÷"] stringByReplacingOccurrencesOfString:@"*" withString:@"×"];
}

@end
