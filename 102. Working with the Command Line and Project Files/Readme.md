Commands to create, rename, and copy files using PowerShell
```powershell
New-Item sample.csv -ItemType File                    
          
    Directory: D:\2026\an-eng-oss\02. Working with the Command Line and Project Files\data

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---          10/25/2026  9:26 PM              0 sample.csv

New-Item sample.csv -ItemType Fi^C 
cd raw 
ls

    Directory: D:\2026\an-eng-oss\02. Working with the Command Line and Project Files\data\raw

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           8/10/2026  7:00 AM              0 sales_data.csv
-a---          10/25/2026  9:26 PM              0 sample.csv

Rename-Item .\sample.csv .\sales_data_ii.csv
Copy-Item .\sales_data_ii.csv ..\processed\sales_data_copy_ii.csv
cd ..
cd .\processed\                                       
Rename-Item .\sales_data_copy_ii.csv .\processed_sales_ii.csv
```