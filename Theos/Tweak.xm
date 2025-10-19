#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <substrate.h>

static NSString *getCurrentUTCIsoString() {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [formatter stringFromDate:[NSDate date]];
}

static long long getCurrentTimestampMs() {
    return (long long)([[NSDate date] timeIntervalSince1970] * 1000);
}

static NSString *getDateStringWithDays(int days) {
    NSDate *futureDate = [[NSDate date] dateByAddingTimeInterval:(days * 24 * 60 * 60)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [formatter stringFromDate:futureDate];
}

static NSDictionary *createPremiumEntitlements() {
    NSString *now = getCurrentUTCIsoString();
    NSString *yearLater = getDateStringWithDays(365);
    NSString *monthLater = getDateStringWithDays(30);
    NSString *lifetimeLater = getDateStringWithDays(3650);
    return @{
        @"pro": @{@"expires_date": yearLater, @"grace_period_expires_date": [NSNull null], @"product_identifier": @"manabox_pro_lifetime", @"is_active": @YES, @"purchase_date": now},
        @"no_ads": @{@"expires_date": yearLater, @"grace_period_expires_date": [NSNull null], @"product_identifier": @"manabox_no_ads", @"is_active": @YES, @"purchase_date": now},
        @"unlimited_deck_simulator": @{@"expires_date": yearLater, @"grace_period_expires_date": [NSNull null], @"product_identifier": @"manabox_unlimited_deck_simulator", @"is_active": @YES, @"purchase_date": now},
        @"unlimited_binders_lists": @{@"expires_date": yearLater, @"grace_period_expires_date": [NSNull null], @"product_identifier": @"manabox_unlimited_binders_lists", @"is_active": @YES, @"purchase_date": now},
        @"unlimited_collection_decks": @{@"expires_date": yearLater, @"grace_period_expires_date": [NSNull null], @"product_identifier": @"manabox_unlimited_collection_decks", @"is_active": @YES, @"purchase_date": now},
        @"unlimited_deck_folders": @{@"expires_date": yearLater, @"grace_period_expires_date": [NSNull null], @"product_identifier": @"manabox_unlimited_deck_folders", @"is_active": @YES, @"purchase_date": now},
        @"dark_theme": @{@"expires_date": yearLater, @"grace_period_expires_date": [NSNull null], @"product_identifier": @"manabox_dark_theme", @"is_active": @YES, @"purchase_date": now},
        @"darker_theme": @{@"expires_date": yearLater, @"grace_period_expires_date": [NSNull null], @"product_identifier": @"manabox_darker_theme", @"is_active": @YES, @"purchase_date": now},
        @"tiger_theme": @{@"expires_date": yearLater, @"grace_period_expires_date": [NSNull null], @"product_identifier": @"manabox_tiger_theme", @"is_active": @YES, @"purchase_date": now},
        @"orange_theme": @{@"expires_date": yearLater, @"grace_period_expires_date": [NSNull null], @"product_identifier": @"manabox_orange_theme", @"is_active": @YES, @"purchase_date": now},
        @"monthly": @{@"expires_date": monthLater, @"grace_period_expires_date": [NSNull null], @"product_identifier": @"manabox_monthly", @"is_active": @YES, @"purchase_date": now},
        @"lifetime": @{@"expires_date": lifetimeLater, @"grace_period_expires_date": [NSNull null], @"product_identifier": @"manabox_lifetime", @"is_active": @YES, @"purchase_date": now}
    };
}

static NSDictionary *createPremiumSubscriptions() {
    NSString *now = getCurrentUTCIsoString();
    NSString *originalPurchase = now;
    NSString *yearLater = getDateStringWithDays(365);
    NSString *monthLater = getDateStringWithDays(30);
    NSString *lifetimeLater = getDateStringWithDays(3650);
    return @{
        @"manabox_pro_lifetime": @{@"auto_resume_date": [NSNull null], @"billing_issues_detected_at": [NSNull null], @"expires_date": yearLater, @"is_sandbox": @NO, @"original_purchase_date": originalPurchase, @"ownership_type": @"PURCHASED", @"period_type": @"normal", @"purchase_date": now, @"store": @"app_store", @"unsubscribe_detected_at": [NSNull null]},
        @"manabox_no_ads": @{@"auto_resume_date": [NSNull null], @"billing_issues_detected_at": [NSNull null], @"expires_date": yearLater, @"is_sandbox": @NO, @"original_purchase_date": originalPurchase, @"ownership_type": @"PURCHASED", @"period_type": @"normal", @"purchase_date": now, @"store": @"app_store", @"unsubscribe_detected_at": [NSNull null]},
        @"manabox_unlimited_deck_simulator": @{@"auto_resume_date": [NSNull null], @"billing_issues_detected_at": [NSNull null], @"expires_date": yearLater, @"is_sandbox": @NO, @"original_purchase_date": originalPurchase, @"ownership_type": @"PURCHASED", @"period_type": @"normal", @"purchase_date": now, @"store": @"app_store", @"unsubscribe_detected_at": [NSNull null]},
        @"manabox_unlimited_binders_lists": @{@"auto_resume_date": [NSNull null], @"billing_issues_detected_at": [NSNull null], @"expires_date": yearLater, @"is_sandbox": @NO, @"original_purchase_date": originalPurchase, @"ownership_type": @"PURCHASED", @"period_type": @"normal", @"purchase_date": now, @"store": @"app_store", @"unsubscribe_detected_at": [NSNull null]},
        @"manabox_unlimited_collection_decks": @{@"auto_resume_date": [NSNull null], @"billing_issues_detected_at": [NSNull null], @"expires_date": yearLater, @"is_sandbox": @NO, @"original_purchase_date": originalPurchase, @"ownership_type": @"PURCHASED", @"period_type": @"normal", @"purchase_date": now, @"store": @"app_store", @"unsubscribe_detected_at": [NSNull null]},
        @"manabox_unlimited_deck_folders": @{@"auto_resume_date": [NSNull null], @"billing_issues_detected_at": [NSNull null], @"expires_date": yearLater, @"is_sandbox": @NO, @"original_purchase_date": originalPurchase, @"ownership_type": @"PURCHASED", @"period_type": @"normal", @"purchase_date": now, @"store": @"app_store", @"unsubscribe_detected_at": [NSNull null]},
        @"manabox_dark_theme": @{@"auto_resume_date": [NSNull null], @"billing_issues_detected_at": [NSNull null], @"expires_date": yearLater, @"is_sandbox": @NO, @"original_purchase_date": originalPurchase, @"ownership_type": @"PURCHASED", @"period_type": @"normal", @"purchase_date": now, @"store": @"app_store", @"unsubscribe_detected_at": [NSNull null]},
        @"manabox_darker_theme": @{@"auto_resume_date": [NSNull null], @"billing_issues_detected_at": [NSNull null], @"expires_date": yearLater, @"is_sandbox": @NO, @"original_purchase_date": originalPurchase, @"ownership_type": @"PURCHASED", @"period_type": @"normal", @"purchase_date": now, @"store": @"app_store", @"unsubscribe_detected_at": [NSNull null]},
        @"manabox_tiger_theme": @{@"auto_resume_date": [NSNull null], @"billing_issues_detected_at": [NSNull null], @"expires_date": yearLater, @"is_sandbox": @NO, @"original_purchase_date": originalPurchase, @"ownership_type": @"PURCHASED", @"period_type": @"normal", @"purchase_date": now, @"store": @"app_store", @"unsubscribe_detected_at": [NSNull null]},
        @"manabox_orange_theme": @{@"auto_resume_date": [NSNull null], @"billing_issues_detected_at": [NSNull null], @"expires_date": yearLater, @"is_sandbox": @NO, @"original_purchase_date": originalPurchase, @"ownership_type": @"PURCHASED", @"period_type": @"normal", @"purchase_date": now, @"store": @"app_store", @"unsubscribe_detected_at": [NSNull null]},
        @"manabox_monthly": @{@"auto_resume_date": [NSNull null], @"billing_issues_detected_at": [NSNull null], @"expires_date": monthLater, @"is_sandbox": @NO, @"original_purchase_date": originalPurchase, @"ownership_type": @"PURCHASED", @"period_type": @"normal", @"purchase_date": now, @"store": @"app_store", @"unsubscribe_detected_at": [NSNull null]},
        @"manabox_lifetime": @{@"auto_resume_date": [NSNull null], @"billing_issues_detected_at": [NSNull null], @"expires_date": lifetimeLater, @"is_sandbox": @NO, @"original_purchase_date": originalPurchase, @"ownership_type": @"PURCHASED", @"period_type": @"normal", @"purchase_date": now, @"store": @"app_store", @"unsubscribe_detected_at": [NSNull null]}
    };
}

static NSDictionary *createForgedSubscriberResponse(NSString *userId) {
    NSString *now = getCurrentUTCIsoString();
    NSString *firstSeen = getDateStringWithDays(-1);
    
    return @{
        @"request_date": now,
        @"request_date_ms": @(getCurrentTimestampMs()),
        @"subscriber": @{
            @"entitlements": createPremiumEntitlements(),
            @"subscriptions": createPremiumSubscriptions(),
            @"first_seen": firstSeen,
            @"last_seen": now,
            @"original_app_user_id": userId ?: @"4UWXh3VOL5SdL7Bu66YMHtJcYoj2",
            @"original_application_version": @"3.20.1",
            @"original_purchase_date": now,
            @"non_subscriptions": @{},
            @"other_purchases": @{},
            @"management_url": [NSNull null]
        }
    };
}

static NSDictionary *createForgedOfferingsResponse() {
    NSString *now = getCurrentUTCIsoString();
    return @{
        @"request_date": now,
        @"request_date_ms": @(getCurrentTimestampMs()),
        @"offerings": @{
            @"current": @{
                @"identifier": @"default",
                @"description": @"Premium Features",
                @"available_packages": @[
                    @{
                        @"identifier": @"pro_lifetime",
                        @"product_identifier": @"manabox_pro_lifetime",
                        @"product": @{
                            @"identifier": @"manabox_pro_lifetime",
                            @"price_string": @"$0.00",
                            @"localized_price": @0,
                            @"localized_title": @"Lifetime Premium",
                            @"localized_description": @"Unlock all features forever"
                        }
                    },
                    @{
                        @"identifier": @"no_ads",
                        @"product_identifier": @"manabox_no_ads",
                        @"product": @{
                            @"identifier": @"manabox_no_ads",
                            @"price_string": @"$0.00",
                            @"localized_price": @0,
                            @"localized_title": @"Ad-Free",
                            @"localized_description": @"Remove all ads"
                        }
                    },
                    @{
                        @"identifier": @"unlimited_deck_folders",
                        @"product_identifier": @"manabox_unlimited_deck_folders",
                        @"product": @{
                            @"identifier": @"manabox_unlimited_deck_folders",
                            @"price_string": @"$0.00",
                            @"localized_price": @0,
                            @"localized_title": @"Unlimited Deck Folders",
                            @"localized_description": @"Create unlimited deck folders"
                        }
                    }
                ]
            }
        }
    };
}

%hook UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL result = %orig;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cracked by devcasp" message:@"Premium Unlocked!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        UIWindow *window = UIApplication.sharedApplication.windows.firstObject;
        if (window && window.rootViewController) {
            [window.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    });
    
    return result;
}
%end

%hook NSURLSession
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    void (^newCompletionHandler)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *response, NSError *error) {
        @try {
            NSURL *url = request.URL;
            NSString *host = url.host;
            NSString *path = url.path;
            
            if ([host containsString:@"googleads.g.doubleclick.net"] || [host containsString:@"googleadservices.com"] || [host containsString:@"doubleclick.net"]) {
                NSHTTPURLResponse *adResponse = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:404 HTTPVersion:@"HTTP/1.1" headerFields:@{}];
                completionHandler(nil, adResponse, nil);
                return;
            }
            
            if ([host containsString:@"api.revenuecat.com"]) {
                NSMutableDictionary *headers = [NSMutableDictionary dictionary];
                headers[@"Content-Type"] = @"application/json";
                headers[@"X-RevenueCat-ETag"] = request.allHTTPHeaderFields[@"X-RevenueCat-ETag"] ?: @"mock_etag";
                
                if ([path containsString:@"/v1/subscribers"] || [path containsString:@"/v1/receipts"]) {
                    NSString *userId = [[url absoluteString] componentsSeparatedByString:@"/"].lastObject;
                    NSDictionary *forgedResponse = createForgedSubscriberResponse(userId);
                    NSError *error;
                    NSData *forgedData = [NSJSONSerialization dataWithJSONObject:forgedResponse options:0 error:&error];
                    if (!error) {
                        NSHTTPURLResponse *httpResponse = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:@"HTTP/1.1" headerFields:headers];
                        completionHandler(forgedData, httpResponse, nil);
                        return;
                    }
                }
                
                if ([path containsString:@"/v1/offerings"]) {
                    NSDictionary *forgedResponse = createForgedOfferingsResponse();
                    NSError *error;
                    NSData *forgedData = [NSJSONSerialization dataWithJSONObject:forgedResponse options:0 error:&error];
                    if (!error) {
                        NSHTTPURLResponse *httpResponse = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:@"HTTP/1.1" headerFields:headers];
                        completionHandler(forgedData, httpResponse, nil);
                        return;
                    }
                }
            }
            
            completionHandler(data, response, error);
        } @catch (NSException *exception) {
            completionHandler(data, response, error);
        }
    };
    
    return %orig(request, newCompletionHandler);
}
%end

%ctor {
}
