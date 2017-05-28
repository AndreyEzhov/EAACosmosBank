//
//  EAABankTableViewController.m
//  EAACosmosBank
//
//  Created by Андрей Ежов on 27.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import "EAABankTableViewController.h"
#import "EAAHub.h"
#import "EAABankUnitCell.h"
#import "EAALocationManager.h"

@interface EAABankTableViewController () <EAALocationManagerDelegate>

@property (weak, nonatomic) EAABankDataSource* dataSource;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;

@property (strong, nonatomic) EAALocationManager* locationManager;

@end



static NSString* EAABankCellResuseidentifier = @"EAABankCellResuseidentifier";



@implementation EAABankTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[EAALocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"EAABankUnitCell" bundle:nil]
         forCellReuseIdentifier:EAABankCellResuseidentifier];
        
    self.dataSource = [EAAHub sharedManager].banksDataSource;
    
    [self updateTableView];
}


-(void) updateTableView {
    
    [self.refreshButton setEnabled:NO];
    
    [self.dataSource updateOnCompletion:^(NSString * _Nullable error) {
        if (error) {
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Ошибка!"
                                                                                     message:error
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 [alertController dismissViewControllerAnimated:YES completion:nil];
                                                             }];
            
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        [self.tableView reloadData];
        [self.refreshButton setEnabled:YES];
        
    }];
}


- (void)locationDidChanged {

    NSArray<NSIndexPath *>* visibleRows = [self.tableView indexPathsForVisibleRows];
    
    for (NSIndexPath* ip in visibleRows) {
        EAABankUnitCell *cell = [self.tableView cellForRowAtIndexPath:ip];
        EAABankRecord* bank = [self.dataSource bankAtIndex:ip.row];
        cell.distanceLabel.text = [self.locationManager distanceCounter:bank.location];
    }
    
}


#pragma mark - actions

- (IBAction)refreshAction:(UIBarButtonItem *)sender {
    [self updateTableView];
}


@end


@implementation EAABankTableViewController(UITableViewDataSourceExtention)


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource banksCount];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EAABankUnitCell *cell = [tableView dequeueReusableCellWithIdentifier:EAABankCellResuseidentifier forIndexPath:indexPath];
    
    EAABankRecord* bank = [self.dataSource bankAtIndex:indexPath.row];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"Название: %@", bank.title];
    cell.scheduleLabel.text = [NSString stringWithFormat:@"Режим работы: %@", bank.schedule];
    cell.address.text = [NSString stringWithFormat:@"Адрес: %@", bank.address];
    cell.distanceLabel.text = [self.locationManager distanceCounter:bank.location];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


@end



@implementation EAABankTableViewController(UITableViewDelegateExtention)

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end



