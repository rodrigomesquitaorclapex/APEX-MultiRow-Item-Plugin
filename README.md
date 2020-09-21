# APEX-MultiRow-Item-Plugin
This plugin create a multi row APEX item.

## Installation ##
Import *item_type_plugin_mesquitarod_multirow_item.sql* file into your application.

## Usage ##
1. Create an item
2. Change the item type to *APEX MultiRow Item Plugin[Plug-In]*.

## Settings ##
1. Limit: limit the number of items. 
2. Limit Reached Message:  Custom message to show when the limit is reached
3. Add Item Icon: Add item buttom icon
4. Remove Item Icon: Remove item buttom icon

## Dynamic Action ##
1. The change event dynamic action can be used when add/remove a new item.

## Demo ##

http://bit.ly/2Io4U7E

## Preview ##

![Preview](Preview.gif)

## Hint ##

Use APEX_STRING (SPLIT/SHUFFLE) to separate or regroup the colon separated values

Documentation: https://docs.oracle.com/en/database/oracle/application-express/19.1/aeapi/APEX_STRING.html#GUID-CAFD987C-7382-4F0F-8CB9-1D3BD05F054A

select column_value
 From TABLE(apex_string.split('1:2:3',':'));

