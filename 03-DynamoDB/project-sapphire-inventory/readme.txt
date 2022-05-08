Now, let's add an item to this table called inventory. Use the following specifications and update the main.tf file:

Resource Name: upload
Table = Use reference expression to the table called inventory
Hash Key = Use reference expression to use the primary key used by the table inventory

Use the below data for item:
{
"AssetID": {"N": "1"},
"AssetName": {"S": "printer"},
"age": {"N": "5"},
"Hardware": {"B": "true" }
}