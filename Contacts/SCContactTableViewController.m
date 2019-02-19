//
//  SCContactTableViewController.m
//  Contacts
//
//  Created by Stephen Cao on 17/2/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

#import "SCContactTableViewController.h"
#define targetFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"contacts.data"]

@interface SCContactTableViewController ()<UIActionSheetDelegate, SCAddNewContactViewControllerDelegate, SCUpdateContactViewControllerDelegate>
-(void) goBack2LoginPage;
-(void) setNavigationItemButtons;
-(void) addNewFriend;
@property(nonatomic,strong)NSMutableArray *contactList;
@property(nonatomic,strong)SCNewContactPerson *selectedContact;
@property(nonatomic,strong)NSIndexPath *selectedIndexPath;
@property(nonatomic,copy)NSString *filePath;
@end

@implementation SCContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItemButtons];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0,0)];
    [self restoreContactRecord];
}
#pragma mark - NSKeyArchiver method
-(void)saveContactRecord{
    NSString *filePath = targetFilePath;
    self.filePath = filePath;
    [NSKeyedArchiver archiveRootObject:self.contactList toFile:filePath];
}
-(void) restoreContactRecord{
    self.contactList = [NSKeyedUnarchiver unarchiveObjectWithFile:targetFilePath];
}
#pragma mark - initialize contact list
- (NSMutableArray *)contactList{
    if(_contactList == nil){
        _contactList = [[NSMutableArray alloc]init];
    }
    return _contactList;
}
#pragma mark - SCAddNewContactViewControllerDelegate method

- (void)addNewContactWithController:(SCAddNewContactViewController *)controller andWithNewContactPerson:(SCNewContactPerson *)person{
    [self.contactList addObject:person];
    [self.tableView reloadData];
    [self saveContactRecord];
}
#pragma mark - SCUpdateContactViewControllerDelegate method
- (void)updateConcactWithController:(SCUpdateContactViewController *)controller andWithContact:(SCNewContactPerson *)person{
    self.contactList[self.selectedIndexPath.row] = person;
    NSArray *selectedList = @[self.selectedIndexPath];
    [self.tableView reloadRowsAtIndexPaths:selectedList withRowAnimation:UITableViewRowAnimationAutomatic];
    [self saveContactRecord];
}
#pragma mark - navigation bar button items and their methods
-(void) setNavigationItemButtons{
    UIBarButtonItem *logout = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(goBack2LoginPage)];
    self.navigationItem.leftBarButtonItem = logout;
    
    UIBarButtonItem *addFriend = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewFriend)];
    self.navigationItem.rightBarButtonItem = addFriend;
}
-(void) addNewFriend{
    [self performSegueWithIdentifier:@"addNewContact" sender:nil];
}
-(void) goBack2LoginPage{
   UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"Do you really want to logout?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Confirm" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
}
#pragma mark - segue method
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"addNewContact"]){
        SCAddNewContactViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
    else if([segue.identifier isEqualToString:@"editContact"]){
        SCUpdateContactViewController *controller = segue.destinationViewController;
        controller.person = self.selectedContact;
        controller.delegate = self;
    }
}
#pragma mark - Action sheet delegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contactList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCNewContactPerson *person = self.contactList[indexPath.row];
    static NSString* identifier = @"person_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = person.tel;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SCNewContactPerson *person = self.contactList[indexPath.row];
    self.selectedIndexPath = indexPath;
    self.selectedContact = person;
    [self performSegueWithIdentifier:@"editContact" sender:nil];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.contactList removeObjectAtIndex:indexPath.row];
    [self saveContactRecord];
    NSArray *indexPaths = @[indexPath];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
