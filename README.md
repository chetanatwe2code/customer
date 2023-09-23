# nursery V2

# Customer Functionality Change V1 TO V2

| model | updates / change |
|-------|------------------|



vendor  1.vendor can choose his service area pin

| NO  | Name | Number |
|-----|------|--------|
 | 05  | Roy  | 450    |

product   1.add two new feilds (a). care & instruction (b).benifits
2. select category, while adding product
3. verient add of product
4. add verient image with position

user           1. before order, check vendor service available or not in user area
2. add custom user details like user name pin, city etc.
3. select payment method, do payment

transation  1. transaction payment api,
2. transaction list api

banner        1. add blog
2. read blog

blog             1.

review / rating  1. review_rating
2.review_list
3.review_approved

----------------------------------------------------

----------------------------------------------------
Rename Package
----------------------------------------------------
flutter pub run change_app_package_name:main com.indiaki.nursery


----------------------------------------------------
Build App
----------------------------------------------------

keytool -genkey -v -keystore ~/jks/user-v2-app.jks -keyalg RSA -keysize 2048 -validity 10000 -alias user_v2
./gradlew signingReport
----------------------------------------------------


----------------------------------------------------
SHA KEYS
----------------------------------------------------

Variant: release
Config: debug
Store: /home/we2code/.android/debug.keystore
Alias: AndroidDebugKey
MD5: 31:C4:E9:26:39:DB:53:9C:75:93:A0:83:1A:8B:DC:E8
SHA1: 22:21:5B:43:F6:6E:52:8E:FB:DD:D6:51:36:64:A4:F7:36:DB:4F:C5
SHA-256: F1:F5:D8:8E:50:0E:B4:3E:E7:27:5A:3D:13:77:13:32:45:78:CC:9B:11:F1:FA:4D:FC:86:6A:E7:D7:18:7D:EB
----------------------------------------------------

# nursery customer app
# show total rating count
# add canceled order button in order detail
# add check box for update another address as a default address
# redirect order screen from notification

---------------

# in Order history when i go to order detail on second time then show error for orderLogic not fund *FIXED*
# fix ui issue on cart and checkout screen throw in tablet *FIXED*
# create responsive ui throw in tablet *FIXED*

checkout screen need to update address on order product detail *need to mayur*
when user submit review again any order then review should be update *need to mayur*

# Nursery Customer App
# upgrade to responsive on table and desktop screen