class Constant {
  //MODIFICATION PART

  static String MainBaseUrl =
      "https://webadmin.koumishop.com/"; //Admin panel url

  static String FLEXPAY_URL = "https://koumishop.com/pay/erreur.php";

  static String WebSiteUrl = "https://koumishop.com/"; //Admin panel url

  //set your jwt secret key here...key must same in PHP and Android
  static String JWT_KEY = "1234567890";

  static int GRID_COLUMN = 3; //Category View Number Of Grid Per Line
  // static int DATA = "data";

  static int LOAD_ITEM_LIMIT =
      10; //Load items limit in listing ,Maximum load item once

  //MODIFICATION PART END

  static String BaseUrl = MainBaseUrl + "api-firebase/";

  //Do not change anything in this link**************************************************
  static String PLAY_STORE_LINK =
      "https://play.google.com/store/apps/details?id=";
  static String PLAY_STORE_RATE_US_LINK = "market://details?id=";

  //*************************************************************************************
  //PayTm configs
  static String WEBSITE_LIVE_VAL = "WEB";
  static String INDUSTRY_TYPE_ID_LIVE_VAL = "Retail";
  static String MOBILE_APP_CHANNEL_ID_LIVE_VAL = "WAP";
  //    static String PAYTM_ORDER_PROCESS_LIVE_URL = "https://securegw.paytm.in/order/process";
  static String WEBSITE_DEMO_VAL = "WEBSTAGING";
  static String INDUSTRY_TYPE_ID_DEMO_VAL = "Retail";
  static String MOBILE_APP_CHANNEL_ID_DEMO_VAL = "WAP";
  static String PAYTM_ORDER_PROCESS_DEMO_VAL =
      "https://securegw-stage.paytm.in/order/process";
  static String GENERATE_PAYTM_CHECKSUM =
      MainBaseUrl + "paytm/generate-checksum.php";
  static String VALID_TRANSACTION = MainBaseUrl + "/paytm/valid-transction.php";
  static String CALLBACK_URL = "CALLBACK_URL";
  static String CHECKSUMHASH = "CHECKSUMHASH";
  static String ORDER_ID_ = "ORDER_ID";
  static String CHANNEL_ID = "CHANNEL_ID";
  static String INDUSTRY_TYPE_ID = "INDUSTRY_TYPE_ID";
  static String WEBSITE = "WEBSITE";
  static String TXN_AMOUNT = "TXN_AMOUNT";
  static String MID = "MID";

  //**********APIS**********
  static String FAQ_URL = BaseUrl + "get-faqs.php";
  static String CATEGORY_URL = BaseUrl + "get-categories.php";
  static String SELLER_URL = BaseUrl + "get-seller-data.php";
  static String GET_RAZORPAY_ORDER_URL = BaseUrl + "create-razorpay-order.php";
  static String GET_SUB_CATEGORY_URL = BaseUrl + "get-subcategories.php";
  static String GET_SECTION_URL = BaseUrl + "sections.php";
  static String GET_ADDRESS_URL = BaseUrl + "user-addresses.php";
  static String REGISTER_URL = BaseUrl + "user-registration.php";
  static String PAPAL_URL = MainBaseUrl + "paypal/create-payment.php";
  static String LOGIN_URL = BaseUrl + "login.php";
  static String GET_ALL_DATA_URL = BaseUrl + "get-all-data.php";
  static String GET_PRODUCTS_URL = BaseUrl + "get-products.php";
  static String GET_SELLER_DATA_URL = BaseUrl + "get-seller-data.php";
  static String SETTING_URL = BaseUrl + "settings.php";
  static String GET_FAVORITES_URL = "${BaseUrl}favorites.php";
  static String MIDTRANS_PAYMENT_URL =
      MainBaseUrl + "midtrans/create-payment.php";
  static String GET_LOCATIONS_URL = BaseUrl + "get-locations.php";
  static String ORDER_PROCESS_URL = BaseUrl + "order-process.php";
  static String USER_DATA_URL = BaseUrl + "get-user-data.php";
  static String CART_URL = BaseUrl + "cart.php";
  static String STRIPE_BASE_URL = MainBaseUrl + "stripe/create-payment.php";
  static String TRANSACTION_URL = BaseUrl + "get-user-transactions.php";
  static String PROMO_CODE_CHECK_URL = BaseUrl + "validate-promo-code.php";
  static String VERIFY_PAYMENT_REQUEST = BaseUrl + "payment-request.php";
  static String REGISTER_DEVICE_URL = BaseUrl + "store-fcm-id.php";
  static String GET_SERVICES_DATA_URL = BaseUrl + "get-service-data.php";

  //**************parameters***************

  static String GET_CATEGORY_SERVICE = "get_category_by_service";
  static String SERVICE_ID = "service_id";
  static String ALL_SERVICE = "all_service";
  static String VERIFY_PAYSTACK = "verify_paystack_transaction";
  static String DISCOUNTED_AMOUNT = "discounted_amount";
  static String AccessKey = "accesskey";
  static String VALIDATE_PROMO_CODE = "validate_promo_code";
  static String AccessKeyVal = "90336";
  static String PROFILE = "profile";
  static String UPLOAD_PROFILE = "upload_profile";
  static String GetVal = "1";
  static String MOBILE_PAYMENT = "Mobile money";
  static String GET_PIN_CODES = "get_pincodes";
  static String GET_CITIES = "get_cities";
  static String GET_AREAS = "get_areas";
  static String GROSS_AMOUNT = "gross_amount";
  static String AUTHORIZATION = "Authorization";
  static String PARAMS = "params";
  static String GET_SELECTED_PINCODE = "get_selected_pincode";
  static String GET_SELECTED_PINCODE_NAME = "get_selected_pincode_name";
  static String GET_SELECTED_PINCODE_ID = "get_selected_pincode_id";
  static String IS_USER_LOGIN = "is_user_login";
  static String GET_PRIVACY = "get_privacy";
  static String GET_TERMS = "get_terms";
  static String GET_ADDRESSES = "get_addresses";
  static String DELETE_ADDRESS = "delete_address";
  static String ADD_ADDRESS = "add_address";
  static String UPDATE_ADDRESS = "update_address";
  static String GET_CONTACT = "get_contact";
  static String GET_ABOUT_US = "get_about_us";
  static String NEW_BALANCE = "new_balance";
  static String ADD_TO_FAVORITES = "add_to_favorites";
  static String REMOVE_FROM_FAVORITES = "remove_from_favorites";
  static String CANCELLED = "cancelled";
  static String RECEIVED = "received";
  static String SHIPPED = "shipped";
  static String PROCESSED = "processed";
  static String DELIVERED = "delivered";
  static String GET_NOTIFICATIONS = "get-notifications";
  static String RETURNED = "returned";
  static String GET_USER_DATA = "get_user_data";
  static String BALANCE = "balance";
  static String AWAITING_PAYMENT = "awaiting_payment";
  static String KEY_WALLET_USED = "wallet_used";
  static String KEY_WALLET_BALANCE = "wallet_balance";
  static String WALLET = "Portefeuille";
  static String PAYMENT = "payment";
  static String REDIRECT_URL = "redirect_url";
  static String URL = "url";
  static String ADD_MULTIPLE_ITEMS = "add_multiple_items";
  static String SAVE_FOR_LATER_ITEMS = "save_for_later_items";
  static String GET_REORDER_DATA = "get_reorder_data";
  static String FIRST_NAME = "first_name";
  static String LAST_NAME = "last_name";
  static String PAYER_EMAIL = "payer_email";
  static String COUNTRY_CODE = "country_code";
  static String COUNTRY = "country";
  static String IS_DEFAULT = "is_default";
  static String ITEM_NAME = "item_name";
  static String ITEM_NUMBER = "item_number";
  static String UPDATE_ORDER_STATUS = "update_order_status";
  static String ORDER_ITEM_ID = "order_item_id";
  static String PAYMENT_METHODS = "payment_methods";
  static String PAY_M_KEY = "payumoney_merchant_key";
  static String PAYU_M_ID = "payumoney_merchant_id";
  static String PAYU_SALT = "payumoney_salt";
  static String RAZOR_PAY_KEY = "razorpay_key";
  static String paystack_public_key = "paystack_public_key";
  static String UNREAD_NOTIFICATION_COUNT = "unread_notification_count";
  static String UNREAD_WALLET_COUNT = "unread_wallet_count";
  static String UNREAD_TRANSACTION_COUNT = "unread_transaction_count";
  static String flutterwave_public_key = "flutterwave_public_key";
  static String flutterwave_secret_key = "flutterwave_secret_key";
  static String flutterwave_encryption_key = "flutterwave_encryption_key";
  static String flutterwave_currency_code = "flutterwave_currency_code";
  static String CITY_ID = "city_id";
  static String PINCODE_ID = "pincode_id";
  static String PINCODE = "pincode";
  static String CITY = "city";
  static String AREA_ID = "area_id";
  static String REFERRAL_CODE = "referral_code";
  static String FRIEND_CODE = "friends_code";
  static String SOLD_OUT_TEXT = "Sold Out";
  static String AVAILABLE = "Available";

  static String QTY = "qty";
  static String GET_USER_CART = "get_user_cart";
  static String DELETE_ORDER = "delete_order";
  static String GET_USER_TRANSACTION = "get_user_transactions";
  static String TYPE_TRANSACTION = "transactions";
  static String TYPE_WALLET_TRANSACTION = "wallet_transactions";
  static String SUCCESS = "success";
  static String FAILED = "failed";
  static String PENDING = "pending";
  static String CREDIT = "credit";
  static String SAVE_FOR_LATER = "save_for_later";
  static String REMOVE_FROM_CART = "remove_from_cart";
  static String SORT = "sort";
  static String TYPE = "type";
  static String IMAGE = "image";
  static String NAME = "name";
  static String TYPE_ID = "type_id";
  static String ID = "id";
  static String VARIANT_POSITION = "variantPosition";
  static String LIST_POSITION = "list_position";
  static String SUBTITLE = "subtitle";
  static String PRODUCTS = "products";
  static String SUBCATEROGYCOMPLEMENTARYIDS = "subcat_complementary_ids";
  static String STATUS = "status";
  static String DATE_ADDED = "date_added";
  static String TITLE = "title";
  static String SECTION_STYLE = "style";
  static String SHORT_DESC = "short_description";
  static String REGISTER = "register";
  static String EMAIL = "email";
  static String MOBILE = "mobile";
  static String LOGIN = "login";
  static String ALTERNATE_MOBILE = "alternate_mobile";
  static String PASSWORD = "password";
  static String FCM_ID = "fcm_id";
  static String GET_ALL_PRODUCTS_NAME = "get_all_products_name";
  static String GET_ALL_PRODUCTS = "get_all_products";
  static String CHECK_DELIEVABILITY = "check_deliverability";
  static String STATE = "state";
  static String ERROR = "error";
  static String STORE_NAME = "store_name";
  static String LOGO = "logo";
  static String GET_TIMEZONE = "get_timezone";
  static String ORDER_NOTE = "order_note";
  static String VERIFY_USER = "verify-user";
  static String USER_ID = "user_id";
  static String OTP = "otp";
  static String ADD_WALLET_BALANCE = "add_wallet_balance";
  static String TAX_AMOUNT = "tax_amount";
  static String TAX_PERCENT = "tax_percentage";
  static String IS_AVAILABLE = "is_available";
  static String RETURN_DAYS = "return_days";
  static String SELLER_ID = "seller_id";
  static String GET_SELLER_DATA = "get_seller_data";
  static String EDIT_PROFILE = "edit-profile";
  static String CHANGE_PASSWORD = "change-password";
  static String FORGOT_PASSWORD_MOBILE = "forgot-password-mobile";
  static String CATEGORY_ID = "category_id";
  static String CATEGORIES = "categories";
  static String SLIDER_IMAGES = "slider_images";
  static String SELLER = "seller";
  static String SECTIONS = "sections";
  static String OFFER_IMAGES = "offer_images";
  static String RETURN_STATUS = "return_status";
  static String CANCELLABLE_STATUS = "cancelable_status";
  static String TILL_STATUS = "till_status";
  static String SUB_CATEGORY_ID = "subcategory_id";
  static String GET_ALL_SECTIONS = "get-all-sections";
  static String SECTION_ID = "section_id";
  static String GET_FAVORITES = "get_favorites";
  static String GET_PRODUCTS_OFFLINE = "get_products_offline";
  static String GET_VARIANTS_OFFLINE = "get_variants_offline";
  static String SEARCH = "search";
  static String ADD_TRANSACTION = "add_transaction";
  static String GET_PAYMENT_METHOD = "get_payment_methods";
  static String GET_ORDERS = "get_orders";
  static String CONTACT = "contact";
  static String DATA = "data";
  static String ITEMS = "items";
  static String PRODUCT_ID = "product_id";
  static String GET_SIMILAR_PRODUCT = "get_similar_products";
  static String GET_COMPLEMENTARY_PRODUCT = "get_complementary_products";
  static String PRODUCT_IDs = "product_ids";
  static String VARIANT_IDs = "variant_ids";
  static String MEASUREMENT = "measurement";
  static String PRICE = "price";
  static String DISCOUNT = "discount";
  static String DISCOUNTED_PRICE = "discounted_price";
  static String SETTINGS = "settings";
  static String GET_TIME_SLOT_CONFIG = "get_time_slot_config";
  static String TIME_SLOT_CONFIG = "time_slot_config";
  static String IS_TIME_SLOTS_ENABLE = "is_time_slots_enabled";
  static String DELIVERY_STARTS_FROM = "delivery_starts_from";
  static String ALLOWED_DAYS = "allowed_days";
  static String paypal_method = "paypal_payment_method";
  static String payu_method = "payumoney_payment_method";
  static String razor_pay_method = "razorpay_payment_method";
  static String cod_payment_method = "cod_payment_method";
  static String product = "product";
  static String global = "global";
  static String cod_mode = "cod_mode";
  static String paymobile_method = "paymobile_payment_method";
  static String payvisa_method = "paycard_payment_method";
  static String paystack_method = "paystack_payment_method";
  static String flutterwave_payment_method = "flutterwave_payment_method";
  static String midtrans_payment_method = "midtrans_payment_method";
  static String stripe_payment_method = "stripe_payment_method";
  static String paytm_payment_method = "paytm_payment_method";
  static String ssl_commerce_payment_method = "ssl_commerce_payment_method";
  static String ssl_commerece_mode = "ssl_commerece_mode";
  static String ssl_commerece_store_id = "ssl_commerece_store_id";
  static String ssl_commerece_secret_key = "ssl_commerece_secret_key";
  static String paytm_merchant_id = "paytm_merchant_id";
  static String paytm_merchant_key = "paytm_merchant_key";
  static String paytm_mode = "paytm_mode";
  static String payumoney_mode = "payumoney_mode";
  static String MINIMUM_AMOUNT = "min_amount";
  static String DELIVERY_CHARGE = "delivery_charge";
  static String CURRENCY = "currency";
  static String SUBTOTAL_IN_USD = "subtotalInUSD";
  static String GET_FAQS = "get_faqs";
  static String LIMIT = "limit";
  static String OFFSET = "offset";
  static String LATITUDE = "latitude";
  static String LONGITUDE = "longitude";
  static String AMOUNT = "amount";
  static String REFERENCE = "reference";
  static String PROMO_DISCOUNT = "promo_discount";
  static String DISCOUNT_AMT = "discount_rupees";
  static String TOTAL = "total";
  static String DAILY_RATE = "daily_rate";

  static String PRODUCT_VARIANT_ID = "product_variant_id";
  static String QUANTITY = "quantity";
  static String USER_NAME = "user_name";
  static String DELIVERY_TIME = "delivery_time";
  static String ADDRESS_ID = "address_id";
  static String PAYMENT_METHOD = "payment_method";
  static String ACTIVE_STATUS = "active_status";
  static String ADDRESS = "address";
  static String ADDRESS_LINE1 = "address_line1";
  static String POSTAL_CODE = "postal_code";
  static String LANDMARK = "landmark";
  static String TRANS_ID = "txn_id";
  static String MESSAGE = "message";
  static String FINAL_TOTAL = "final_total";
  static String FROM = "from";
  static String THESE_SEARCH = "these_seach";
  static String ORDER_ID = "order_id";
  static String publishableKey = "publishableKey";
  static String clientSecret = "clientSecret";
  static String PLACE_ORDER = "place_order";
  static String NEW = "new";
  static String OLD = "old";
  static String HIGH = "high";
  static String LOW = "low";
  static String SUB_TOTAL = "sub_total";
  static String UNIT = "unit";
  static String SLUG = "slug";
  static String PROMO_CODE = "promo_code";
  static List filterValues = [
    " Les plus récents ",
    " Les plus anciens ",
    " Prix les plus hauts ",
    " Prix les plus bas "
  ];
  static String CUST_ID = "CUST_ID";
  static String ORDERID = "ORDERID";
  static String STATUS_ = "STATUS";
  static String TXN_SUCCESS = "TXN_SUCCESS";
  static String minimum_version_required = "minimum_version_required";
  static String is_version_system_on = "is_version_system_on";
  static String min_order_amount = "min_order_amount";
  static String max_cart_items_count = "max_cart_items_count";
  static String area_wise_delivery_charge = "area_wise_delivery_charge";
  static String is_refer_earn_on = "is_refer_earn_on";
  static String refer_earn_bonus = "refer_earn_bonus";
  static String refer_earn_method = "refer_earn_method";
  static String max_refer_earn_amount = "max_refer_earn_amount";
  static String max_product_return_days = "max_product_return_days";
  static String user_wallet_refill_limit = "user_wallet_refill_limit";
  static String min_refer_earn_order_amount = "min_refer_earn_order_amount";
  static String ALPHA_NUMERIC_STRING =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghjiklmnopqrstuvwxyz";
  static String NUMERIC_STRING = "123456789";
  static String TOOLBAR_TITLE = "";
  static String ID_SERVICES = "";
  static String IS_USD = "isUSD";

  //**************Constants Values***************

  static String ID_DEFAULT_ADDRESSES = "";
  static String selectedAddressId = "";
  static String DefaultAddress = "";
  static String DefaultCity = "";
  static String DefaultPinCode = "";
  static bool isCODAllow = true;
  static double SETTING_DELIVERY_CHARGE = 0.0;
  static double SETTING_TAX = 0.0;
  static double SETTING_MINIMUM_AMOUNT_FOR_FREE_DELIVERY = 0.0;
  static double WALLET_BALANCE = 0.0;
  static String U_ID = "";
  static Map<String, String> CartValues = Map();
  static int selectedDatePosition = 0;
  static double FLOAT_TOTAL_AMOUNT = 0.0;
  static int TOTAL_CART_ITEM = 0;
  static bool isOrderCancelled = true;
  static String FRIEND_CODE_VALUE = "";
  static String PAYPAL = "";
  static String PAYUMONEY = "";
  static String RAZORPAY = "";
  static String COD = "";
  static String COD_MODE = "";
  static String PAYSTACK = "";
  static String FLUTTERWAVE = "";
  static String MIDTRANS = "";
  static String STRIPE = "";
  static String MERCHANT_ID = "";
  static String MERCHANT_KEY = "";
  static String PAYTM_MERCHANT_ID = "";
  static String PAYTM = "";
  static String PAYTM_MERCHANT_KEY = "";
  static String PAYTM_MODE = "";
  static String PAYUMONEY_MODE = "";
  static String MERCHANT_SALT = "";
  static String RAZOR_PAY_KEY_VALUE = "";
  static String PAYSTACK_KEY = "";
  static String FLUTTERWAVE_PUBLIC_KEY_VAL = "";
  static String FLUTTERWAVE_SECRET_KEY_VAL = "";
  static String FLUTTERWAVE_ENCRYPTION_KEY_VAL = "";
  static String FLUTTERWAVE_CURRENCY_CODE_VAL = "";
  static String SSLECOMMERZ = "";
  static String SSLECOMMERZ_MODE = "";
  static String SSLECOMMERZ_STORE_ID = "";
  static String SSLECOMMERZ_SECRET_KEY = "";
  static String PAYMOBILE = "";
  static String PAYVISA = "";
  static double formatter = 0.00;

  // static String randomAlphaNumeric(int count) {
  //     StringBuilder builder = new StringBuilder();
  //     while (count-- != 0) {
  //         int character = (int) (Math.random() * ALPHA_NUMERIC_STRING.length());
  //         builder.append(ALPHA_NUMERIC_STRING.charAt(character));
  //     }
  //     return builder.toString();
  // }

  // static String randomNumeric(int count) {
  //     StringBuilder builder = new StringBuilder();
  //     while (count-- != 0) {
  //         int character = (int) (Math.random() * NUMERIC_STRING.length());
  //         builder.append(NUMERIC_STRING.charAt(character));
  //     }
  //     return builder.toString();
  // }
}
