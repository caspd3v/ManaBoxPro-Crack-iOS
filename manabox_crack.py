from mitmproxy import http
import json
from datetime import datetime, timedelta

class ManaBoxCrack:
    def request(self, flow: http.HTTPFlow) -> None:
        if "api.revenuecat.com" in flow.request.host:
            print(f"[ManaBoxCrack] intercepted request - {flow.request.method} {flow.request.path}")
            print(f"[ManaBoxCrack] request headers - {dict(flow.request.headers)}")
            if flow.request.content:
                print(f"[ManaBoxCrack] request body - {flow.request.content.decode('utf-8', errors='ignore')}")

        if any(domain in flow.request.host for domain in ["googleads.g.doubleclick.net", "googleadservices.com", "doubleclick.net"]):
            flow.response = http.Response.make(404, b'', {"Content-Type": "text/plain"})
            print(f"[ManaBoxCrack] blocked admob request {flow.request.path}")

    def response(self, flow: http.HTTPFlow) -> None:
        if "api.revenuecat.com" not in flow.request.host:
            return

        print(f"[ManaBoxCrack] process response for {flow.request.path}")
        print(f"[ManaBoxCrack] og response status - {flow.response.status_code}")
        print(f"[ManaBoxCrack] og response headers - {dict(flow.response.headers)}")
        if flow.response.content:
            print(f"[ManaBoxCrack] og response body - {flow.response.content.decode('utf-8', errors='ignore')}")

        if any(path in flow.request.path for path in ["/v1/subscribers", "/v1/receipts", "/v1/offerings"]):
            flow.response.headers["x-revenuecat-etag"] = flow.request.headers.get("x-revenuecat-etag", "mock_etag")
            flow.response.headers["x-platform"] = flow.request.headers.get("x-platform", "ios")
            flow.response.headers["x-client-version"] = flow.request.headers.get("x-client-version", "3.20.1")
            flow.response.headers["x-client-build-version"] = flow.request.headers.get("x-client-build-version", "2411")
            flow.response.headers["content-type"] = "application/json"
            if "x-signature" in dict(flow.request.headers):
                flow.response.headers["x-signature"] = flow.request.headers.get("x-signature")

            request_date_ms = int(datetime.utcnow().timestamp() * 1000)
            request_date = datetime.utcnow().isoformat() + "Z"
            last_seen = request_date
            first_seen = (datetime.utcnow() - timedelta(days=1)).isoformat() + "Z"
            original_purchase_date = datetime.utcnow().isoformat() + "Z"

            entitlements = {
                "pro": {
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "grace_period_expires_date": None,
                    "product_identifier": "manabox_pro_lifetime",
                    "is_active": True,
                    "purchase_date": datetime.utcnow().isoformat() + "Z"
                },
                "no_ads": {
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "grace_period_expires_date": None,
                    "product_identifier": "manabox_no_ads",
                    "is_active": True,
                    "purchase_date": datetime.utcnow().isoformat() + "Z"
                },
                "unlimited_deck_simulator": {
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "grace_period_expires_date": None,
                    "product_identifier": "manabox_unlimited_deck_simulator",
                    "is_active": True,
                    "purchase_date": datetime.utcnow().isoformat() + "Z"
                },
                "unlimited_binders_lists": {
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "grace_period_expires_date": None,
                    "product_identifier": "manabox_unlimited_binders_lists",
                    "is_active": True,
                    "purchase_date": datetime.utcnow().isoformat() + "Z"
                },
                "unlimited_collection_decks": {
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "grace_period_expires_date": None,
                    "product_identifier": "manabox_unlimited_collection_decks",
                    "is_active": True,
                    "purchase_date": datetime.utcnow().isoformat() + "Z"
                },
                "unlimited_deck_folders": {
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "grace_period_expires_date": None,
                    "product_identifier": "manabox_unlimited_deck_folders",
                    "is_active": True,
                    "purchase_date": datetime.utcnow().isoformat() + "Z"
                },
                "dark_theme": {
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "grace_period_expires_date": None,
                    "product_identifier": "manabox_dark_theme",
                    "is_active": True,
                    "purchase_date": datetime.utcnow().isoformat() + "Z"
                },
                "darker_theme": {
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "grace_period_expires_date": None,
                    "product_identifier": "manabox_darker_theme",
                    "is_active": True,
                    "purchase_date": datetime.utcnow().isoformat() + "Z"
                },
                "tiger_theme": {
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "grace_period_expires_date": None,
                    "product_identifier": "manabox_tiger_theme",
                    "is_active": True,
                    "purchase_date": datetime.utcnow().isoformat() + "Z"
                },
                "orange_theme": {
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "grace_period_expires_date": None,
                    "product_identifier": "manabox_orange_theme",
                    "is_active": True,
                    "purchase_date": datetime.utcnow().isoformat() + "Z"
                },
                "monthly": {
                    "expires_date": (datetime.utcnow() + timedelta(days=30)).isoformat() + "Z",
                    "grace_period_expires_date": None,
                    "product_identifier": "manabox_monthly",
                    "is_active": True,
                    "purchase_date": datetime.utcnow().isoformat() + "Z"
                },
                "lifetime": {
                    "expires_date": (datetime.utcnow() + timedelta(days=3650)).isoformat() + "Z",
                    "grace_period_expires_date": None,
                    "product_identifier": "manabox_lifetime",
                    "is_active": True,
                    "purchase_date": datetime.utcnow().isoformat() + "Z"
                }
            }

            subscriptions = {
                "manabox_pro_lifetime": {
                    "auto_resume_date": None,
                    "billing_issues_detected_at": None,
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "is_sandbox": False,
                    "original_purchase_date": original_purchase_date,
                    "ownership_type": "PURCHASED",
                    "period_type": "normal",
                    "purchase_date": datetime.utcnow().isoformat() + "Z",
                    "store": "app_store",
                    "unsubscribe_detected_at": None
                },
                "manabox_no_ads": {
                    "auto_resume_date": None,
                    "billing_issues_detected_at": None,
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "is_sandbox": False,
                    "original_purchase_date": original_purchase_date,
                    "ownership_type": "PURCHASED",
                    "period_type": "normal",
                    "purchase_date": datetime.utcnow().isoformat() + "Z",
                    "store": "app_store",
                    "unsubscribe_detected_at": None
                },
                "manabox_unlimited_deck_simulator": {
                    "auto_resume_date": None,
                    "billing_issues_detected_at": None,
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "is_sandbox": False,
                    "original_purchase_date": original_purchase_date,
                    "ownership_type": "PURCHASED",
                    "period_type": "normal",
                    "purchase_date": datetime.utcnow().isoformat() + "Z",
                    "store": "app_store",
                    "unsubscribe_detected_at": None
                },
                "manabox_unlimited_binders_lists": {
                    "auto_resume_date": None,
                    "billing_issues_detected_at": None,
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "is_sandbox": False,
                    "original_purchase_date": original_purchase_date,
                    "ownership_type": "PURCHASED",
                    "period_type": "normal",
                    "purchase_date": datetime.utcnow().isoformat() + "Z",
                    "store": "app_store",
                    "unsubscribe_detected_at": None
                },
                "manabox_unlimited_collection_decks": {
                    "auto_resume_date": None,
                    "billing_issues_detected_at": None,
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "is_sandbox": False,
                    "original_purchase_date": original_purchase_date,
                    "ownership_type": "PURCHASED",
                    "period_type": "normal",
                    "purchase_date": datetime.utcnow().isoformat() + "Z",
                    "store": "app_store",
                    "unsubscribe_detected_at": None
                },
                "manabox_unlimited_deck_folders": {
                    "auto_resume_date": None,
                    "billing_issues_detected_at": None,
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "is_sandbox": False,
                    "original_purchase_date": original_purchase_date,
                    "ownership_type": "PURCHASED",
                    "period_type": "normal",
                    "purchase_date": datetime.utcnow().isoformat() + "Z",
                    "store": "app_store",
                    "unsubscribe_detected_at": None
                },
                "manabox_dark_theme": {
                    "auto_resume_date": None,
                    "billing_issues_detected_at": None,
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "is_sandbox": False,
                    "original_purchase_date": original_purchase_date,
                    "ownership_type": "PURCHASED",
                    "period_type": "normal",
                    "purchase_date": datetime.utcnow().isoformat() + "Z",
                    "store": "app_store",
                    "unsubscribe_detected_at": None
                },
                "manabox_darker_theme": {
                    "auto_resume_date": None,
                    "billing_issues_detected_at": None,
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "is_sandbox": False,
                    "original_purchase_date": original_purchase_date,
                    "ownership_type": "PURCHASED",
                    "period_type": "normal",
                    "purchase_date": datetime.utcnow().isoformat() + "Z",
                    "store": "app_store",
                    "unsubscribe_detected_at": None
                },
                "manabox_tiger_theme": {
                    "auto_resume_date": None,
                    "billing_issues_detected_at": None,
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "is_sandbox": False,
                    "original_purchase_date": original_purchase_date,
                    "ownership_type": "PURCHASED",
                    "period_type": "normal",
                    "purchase_date": datetime.utcnow().isoformat() + "Z",
                    "store": "app_store",
                    "unsubscribe_detected_at": None
                },
                "manabox_orange_theme": {
                    "auto_resume_date": None,
                    "billing_issues_detected_at": None,
                    "expires_date": (datetime.utcnow() + timedelta(days=365)).isoformat() + "Z",
                    "is_sandbox": False,
                    "original_purchase_date": original_purchase_date,
                    "ownership_type": "PURCHASED",
                    "period_type": "normal",
                    "purchase_date": datetime.utcnow().isoformat() + "Z",
                    "store": "app_store",
                    "unsubscribe_detected_at": None
                },
                "manabox_monthly": {
                    "auto_resume_date": None,
                    "billing_issues_detected_at": None,
                    "expires_date": (datetime.utcnow() + timedelta(days=30)).isoformat() + "Z",
                    "is_sandbox": False,
                    "original_purchase_date": original_purchase_date,
                    "ownership_type": "PURCHASED",
                    "period_type": "normal",
                    "purchase_date": datetime.utcnow().isoformat() + "Z",
                    "store": "app_store",
                    "unsubscribe_detected_at": None
                },
                "manabox_lifetime": {
                    "auto_resume_date": None,
                    "billing_issues_detected_at": None,
                    "expires_date": (datetime.utcnow() + timedelta(days=3650)).isoformat() + "Z",
                    "is_sandbox": False,
                    "original_purchase_date": original_purchase_date,
                    "ownership_type": "PURCHASED",
                    "period_type": "normal",
                    "purchase_date": datetime.utcnow().isoformat() + "Z",
                    "store": "app_store",
                    "unsubscribe_detected_at": None
                }
            }

            if "/v1/subscribers" in flow.request.path or "/v1/receipts" in flow.request.path:
                try:
                    original_response = json.loads(flow.response.content.decode('utf-8', errors='ignore')) if flow.response.content else {}
                except json.JSONDecodeError:
                    original_response = {}
                    print(f"[ManaBoxCrack] failed to parse og response json")

                forged_response = {
                    "request_date": request_date,
                    "request_date_ms": request_date_ms,
                    "subscriber": {
                        "entitlements": entitlements,
                        "subscriptions": subscriptions,
                        "first_seen": first_seen,
                        "last_seen": last_seen,
                        "original_app_user_id": original_response.get("subscriber", {}).get("original_app_user_id", "4UWXh3VOL5SdL7Bu66YMHtJcYoj2"),
                        "original_application_version": "3.20.1",
                        "original_purchase_date": original_purchase_date,
                        "non_subscriptions": {},
                        "other_purchases": {},
                        "management_url": None
                    }
                }
                flow.response.text = json.dumps(forged_response)
                flow.response.status_code = 200
                print(f"[ManaBoxCrack] forged response with premium entitlements")
                print(f"[ManaBoxCrack] forged json {json.dumps(forged_response, indent=2)}")

            elif "/v1/offerings" in flow.request.path:
                forged_response = {
                    "request_date": request_date,
                    "request_date_ms": request_date_ms,
                    "offerings": {
                        "current": {
                            "identifier": "default",
                            "description": "Premium Features",
                            "available_packages": [
                                {
                                    "identifier": "pro_lifetime",
                                    "product_identifier": "manabox_pro_lifetime",
                                    "product": {
                                        "identifier": "manabox_pro_lifetime",
                                        "price_string": "$0.00",
                                        "localized_price": 0,
                                        "localized_title": "Lifetime Premium",
                                        "localized_description": "Unlock all features forever"
                                    }
                                },
                                {
                                    "identifier": "no_ads",
                                    "product_identifier": "manabox_no_ads",
                                    "product": {
                                        "identifier": "manabox_no_ads",
                                        "price_string": "$0.00",
                                        "localized_price": 0,
                                        "localized_title": "Ad-Free",
                                        "localized_description": "Remove all ads"
                                    }
                                },
                                {
                                    "identifier": "unlimited_deck_simulator",
                                    "product_identifier": "manabox_unlimited_deck_simulator",
                                    "product": {
                                        "identifier": "manabox_unlimited_deck_simulator",
                                        "price_string": "$0.00",
                                        "localized_price": 0,
                                        "localized_title": "Unlimited Deck Simulator",
                                        "localized_description": "Unlimited time in deck simulator"
                                    }
                                },
                                {
                                    "identifier": "unlimited_deck_folders",
                                    "product_identifier": "manabox_unlimited_deck_folders",
                                    "product": {
                                        "identifier": "manabox_unlimited_deck_folders",
                                        "price_string": "$0.00",
                                        "localized_price": 0,
                                        "localized_title": "Unlimited Deck Folders",
                                        "localized_description": "Create unlimited deck folders"
                                    }
                                }
                            ]
                        }
                    }
                }
                flow.response.text = json.dumps(forged_response)
                flow.response.status_code = 200
                print(f"[ManaBoxCrack] forged response for premium offerings")
                print(f"[ManaBoxCrack] forged json - {json.dumps(forged_response, indent=2)}")

    def error(self, flow: http.HTTPFlow) -> None:
        print(f"[ManaBoxCrack] error oh noooo {flow.request.path}: {flow.error}")

addons = [ManaBoxCrack()]
