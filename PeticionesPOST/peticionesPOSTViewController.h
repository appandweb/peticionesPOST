//
//  peticionesPOSTViewController.h
//  PeticionesPOST
//
//  Created by Ruben on 28/03/14.
//  Copyright (c) 2014 AppAndWeb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface peticionesPOSTViewController : UIViewController<NSURLConnectionDelegate, NSURLConnectionDataDelegate>{
    
    NSURLRequest *request;
    NSMutableURLRequest *requestPOST;
    NSURLConnection *connectionInProgress;
    NSMutableData *data;
}

@end
