<!---
Copyright 2023 Province of Alberta

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

### Upload Data Help

Get data into the app by filling out the template and uploading the file. 
The uploaded data will be run through a series of checks before it will be accepted by the app.

##### Process

1. Download and fill in template. 
   - Click the **Download Template** button.
   - Open the excel file (template-bison-model.xlsx) that was downloaded to your computer.
   - Enter the data into the file.
   - Review data to ensure it follows the required data format.
2. Upload data.
   - Click the **Browse...** button and select a file.
   - If the file is successfully uploaded it will appear in the Uploaded data box.
   - If the file is not successfully uploaded a pop-up box will appear with an error message:
     - Close the pop-up box.
     - Correct the error.
     - Upload the corrected data.
     - Repeat until the file is successfully uploaded.
     
If desired, download an example dataset by clicking the **Download Example Data** button, then proceed with step 2 above to explore the app's functionality.
   
##### Required Data Format

The Required data format box at the top right of the page contains the checks and rules the data is run through when uploaded. 
The data will not be uploaded to the app until the required data format is followed.
The app is only able to detect one error at a time so this process may take several iterations as you work through various issues in the data format. 

Description of the rows:

- name: Name of the column.
- description: Description of the column.
- example: Example value for the column.
- constraint: The type and allowed range of values for the column.
- missing allowed: Whether missing values are allowed in the column. Missing values are blank cells in the excel file.
- primary key: Columns that make up the primary key for the table, this is the set of columns that make the row unique.
- joins to: Names the table the column joins to, the value must appear in the table listed for it to be allowed. For example, a location_id must be in the *location* table to be allowed in the *event* table. 

Helpful tips:

- Download the template and copy your data into the template file instead of changing your data file to follow the template format.
- Words must be identical this includes sheet names, column names and cell values (ie. they are case sensitive and space sensitive).

