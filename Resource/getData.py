# import openpyxl
# import  pandas as pd
# import  sqlalchemy as sa
# from    sqlalchemy  import  create_engine, text
from robot.libraries.BuiltIn import BuiltIn   # to set global variable and pass it to Robotfmwk
import shutil  #to copy files   
import chromedriver_autoinstaller
import pandas as pd

def chromeinsall():
    chromedriver_autoinstaller.install
    
def get_results_path():
    return BuiltIn().get_variable_value("${RESULTS_PATH}")  #or you can retrun the global variable as belowreturn BuiltIn().set_suite_variable("${RobotVAR}", thisdict)


# def getData(sheetname,testdataname):
#     workbook = openpyxl.load_workbook("C:\\RobotSource\\Robot\\Testdata\\Pragma.xlsx")
#     worksheet = workbook[sheetname]
#     print(worksheet)
#     rowEndIndex = worksheet.max_row
#     print(rowEndIndex)
#     colEndIndex = worksheet.max_column
#     print(colEndIndex)
#     rowStartIndex = 1
#     colStartIndex = 1
#     testData = []
#     dataRow = []

#     curr_row = rowStartIndex
#     while curr_row <= rowEndIndex:
#         cur_col = colStartIndex
#         current_row = worksheet.cell(curr_row, cur_col)
#         current_row_value = current_row.value
#         print(current_row_value)
#         if current_row_value == testdataname:
#             while cur_col <= colEndIndex:
#                 cell = worksheet.cell(curr_row, cur_col)
#                 dataRow.append(cell.value)
#                 cur_col += 1
#         curr_row += 1
#     return dataRow


# # Get first column value of the sheet
# def getColumnData(excelsheet,sheetname):
#     # workbook = openpyxl.load_workbook("C:\\RobotSource\\Robot\\Pragma\\Validations.xlsx")
#     workbook = openpyxl.load_workbook(excelsheet)

#     worksheet = workbook[sheetname]
#     print(worksheet)
#     rowEndIndex = worksheet.max_row
#     # print(rowEndIndex)
#     colEndIndex = worksheet.max_column
#     # print(colEndIndex)
#     rowStartIndex = 1
#     colStartIndex = 1
#     testData = []
#     dataRow = []

#     curr_row = rowStartIndex
#     while curr_row <= rowEndIndex:
#         cur_col = colStartIndex
#         current_row = worksheet.cell(curr_row, cur_col)
#         current_row_value = current_row.value
#         print(current_row_value)
#         # if current_row_value == testdataname:
#         #     while cur_col <= colEndIndex:
#         #         cell = worksheet.cell(curr_row, cur_col)
#         #         dataRow.append(cell.value)
#         #         cur_col += 1
#         curr_row += 1
#     return dataRow

# #=== Get corresponding row value and map it to the xl header eg: getXL_RowValues("C:/RobotSource/Robot/Testdata/Pragma.xlsx","integration7-QC","Status_DP_to_CL_PF_WEBD")
# # This script will read all values as strings, check each row for the specified value, create a dictionary of the header and row values if a match is found, and then stop execution.
# def getXL_RowValues(filename,sheetname,rowvalue):
#     file_path = filename
#     sheet_name = sheetname  # Replace with your specific sheet name
#     df = pd.read_excel(file_path, sheet_name=sheet_name, dtype=str)    #read as string

#     # Get the headers
#     headers = df.columns.tolist()

#     # Specify the column name to match
#     match_column_name = rowvalue  # Replace with the column name to match   

#     # Iterate through each row and capture the values
#     for index, row in df.iterrows():
#         row_values = row.tolist()
#         if match_column_name in row_values:
#             # Create a dictionary of the header and row values
#             row_dict = dict(zip(headers, row_values))
#             # print(f"Value '{match_column_name}' found in row {index + 1}. Stopping execution.")
#             # print("Dictionary of the header and row values:")
#             # print(row_dict)
#             return row_dict
#             break        

# def Replace_value_XL(filename):
#     # Load the workbook and select the active worksheet
#     workbook = openpyxl.load_workbook('your_excel_file.xlsx')
#     sheet = workbook['SheetName']  # Replace 'SheetName' with the actual name of your sheet

#     # Iterate through each row and cell to find and replace the value
#     for row in sheet.iter_rows():
#         for cell in row:
#             if isinstance(cell.value, str) and '${' in cell.value:
#                 cell.value = cell.value.replace('${', 'testenvdo').replace('}', '')

#     # Save the changes to the workbook
#     # workbook.save('your_excel_file.xlsx')

#     # print("Replacement complete!")

# def getRowValues(filename,sheetname,testname,columname):    
#     engine = create_engine('sqlite://', echo=False)  #create a random access  memory and get rid at the end
#     df = pd.read_excel('C:\\RobotSource\\Robot\\Testdata\\Pragma.xlsx',sheet_name=sheetname)
#     df.to_sql('mytestdata',engine,if_exists='replace',index=None) #create your connection, mytest is a temporary db to the connection, if it exists replace it, append is to update, turn of index
#     connection = engine.connect()    
#     # query = f"Select * from mytestdata where TESTCASENAME = '{testname}'"
#     query = f"Select * from mytestdata where {columname} = '{testname}'"

#     results = engine.execute(sa.text(query)).fetchone()
#     print(results)
#     return results

# def getSheetHeader(filename,sheetname):
#     # load excel with its path
#     wrkbk = openpyxl.load_workbook(filename)
#     sh = wrkbk[sheetname]
#     Testdata_HeaderRow=['0']  #initialize default python list

#     for i in range(1, 2):   #only header row
#         for j in range(1, sh.max_column+1):
#             cell_obj = sh.cell(row=i, column=j)
#             Testdata_HeaderRow.append(cell_obj.value)
            
#     # print(Testdata_HeaderRow)
#     return Testdata_HeaderRow
#     wrkbk.close()

# def getColumncount(filename,sheetname):
#     # load excel with its path
#     wrkbk = openpyxl.load_workbook(filename)
#     sh = wrkbk[sheetname]
#     return sh.max_column
#     wrkbk.close()
#     chromedriver_autoinstaller.install

# ====================GENERIC=============================================

def split_string_to_list(input_string, delimiter):
    # Split the input string by the specified delimiter
    temp_list = input_string.split(delimiter)
    return temp_list

    # # Example usage
    # input_string = "IncidentQuery^TODAY/TRAIN05"
    # delimiter = "^"
    # result = split_string_to_list(input_string, delimiter)
    # print(result)  # Output: ['apple', 'banana', 'cherry']

# Convert the item to a string and split by the delimiter
def split_values_in_list(input_list, delimiter):
    temp_list = []    
    for item in input_list:        
        temp_list[item]=str(item).split(delimiter)    
    return temp_list

def create_dict_values(input,delimiter1,delimiter2):     # delimeter1 - ^ and delimeter2 - :  eg:Name:AUT^District:CHATTANOOGA
    temp_list = split_string_to_list(input,delimiter1)
    thisdict={}  #create empty dictionary
    for i in range(0,len(temp_list)):    
        temp_list1 = split_string_to_list(temp_list[i],delimiter2)
        val=temp_list1[0]
        thisdict[val]=temp_list1[1]  #eg: Name:AUT-assign Name=AUT and return the dictionary
    return  thisdict
    # return BuiltIn().set_suite_variable(thisdict, thisdict)
    # return BuiltIn().set_suite_variable("${RobotVAR}", thisdict)---This is to assign value to robotfrmwk variable. Set global variable 

def copyfile(source_file,destination_file):  
    shutil.copy(source_file, destination_file) 


def create_dict_from_input(input_string, outer_delim, inner_delim):
    result_dict = {}
    pairs = input_string.split(outer_delim)
    for pair in pairs:
        key, value = pair.split(inner_delim)
        result_dict[key] = value
    return result_dict

def read_file(file):    
    with open(file,'r') as f:
        data = f.read()
    return (data)

def check_duplicates_in_excel(file_path, sheet_name):
    try:
        # Load the Excel sheet into a DataFrame
        df = pd.read_excel(file_path, sheet_name=sheet_name)

        # Check for duplicate rows
        duplicates = df[df.duplicated()]

        if not duplicates.empty:
            print("Duplicate rows found:")
            print(duplicates)
        else:
            print("No duplicate rows found.")

    except Exception as e:
        print(f"An error occurred: {e}")

# Example usage
# if __name__ == "__main__":
#     file_path = r"C:\RobotResults\Field_Validations_FLV.xlsm"
#     sheet_name = "Fields_Details"
#     check_duplicates_in_excel(file_path, sheet_name)