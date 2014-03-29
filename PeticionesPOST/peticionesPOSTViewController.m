//
//  peticionesPOSTViewController.m
//  PeticionesPOST
//
//  Created by Ruben on 28/03/14.
//  Copyright (c) 2014 AppAndWeb. All rights reserved.
//

#import "peticionesPOSTViewController.h"

@interface peticionesPOSTViewController ()

@end

@implementation peticionesPOSTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) peticionPOST: (NSData *) token{
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            @"valor", @"clave",
                            @"valor", @"clave",
                            @"valor", @"clave",nil];
    
    NSURL *url = [NSURL URLWithString:@"url-peticion"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self connectionPOST:urlRequest withParams:params];
}

- (BOOL)connectionPOST:(NSURLRequest *)aRequest
            withParams:(NSDictionary *)aDictionary {
    
    if ([aDictionary count] > 0) {
        requestPOST = [[NSMutableURLRequest alloc] initWithURL:[aRequest URL]];
        [requestPOST setHTTPMethod:@"POST"];
        
        NSMutableString *postString = [[NSMutableString alloc] init];
        NSArray *allKeys = [aDictionary allKeys];
        for (int i = 0; i < [allKeys count]; i++) {
            NSString *key = [allKeys objectAtIndex:i];
            NSString *value = [aDictionary objectForKey:key];
            [postString appendFormat:( (i == 0) ? @"%@=%@" : @"&%@=%@" ), key, value];
        }
        
        [requestPOST setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        
        data = [[NSMutableData alloc] init];
        if (connectionInProgress) {
            [connectionInProgress cancel];
        }
        
        connectionInProgress = [[NSURLConnection alloc] initWithRequest:requestPOST delegate:self startImmediately:YES];
        
        postString = nil;
        request = nil;
        
        return YES;
    } else {
        return NO;
    }
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)datos
{
    [data appendData: datos];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Comprobación de que se reciben los datos
    NSString *xmlCheck = [[NSString alloc] initWithData: data encoding:NSISOLatin1StringEncoding];
    if (xmlCheck != NULL && ![xmlCheck  isEqual: @""]) {
        NSLog(@"%@", xmlCheck);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
