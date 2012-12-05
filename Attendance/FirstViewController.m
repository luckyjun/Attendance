//
//  FirstViewController.m
//  Attendance
//
//  Created by jun on 12/5/12.
//  Copyright (c) 2012 Jun. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController (){
    NSMutableArray *list;
    NSMutableArray *check;
}

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    list = [[NSMutableArray alloc] init];
    check = [[NSMutableArray alloc] init];
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://dimeet.iptime.org:8080/board/study_list.php?study=2"]];
    NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *key in jsonObjects) {
        [check addObject:[NSNumber numberWithBool:NO]];
        [list addObject:[key objectForKey:@"value"]];
    }
    
    
    
    [_table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table View
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [[list objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    if ([[check objectAtIndex:indexPath.row] boolValue]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }else{
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[check objectAtIndex:indexPath.row] boolValue]) {
        [check replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
    }else{
        [check replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
    }
    
    [_table reloadData];
}





@end
