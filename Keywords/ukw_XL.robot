*** Settings ***
Resource    ukw_Common.robot

*** Variables ***

*** Keywords ***

Fetch GlobalData recordset
    [Arguments]    ${EXCEL_FILE}    ${TEST_ENV}    ${GlobalData}    ${ColumnName}

     # Get column count of sheet eg:PREDEV
    Set Test Variable    ${counter}    0
    ${columncount}=    Get Columncount    ${EXCEL_FILE}    ${GlobalData}

    # Get sheet header names
    @{SheetHeader}=    Get Sheet Header    ${EXCEL_FILE}    ${GlobalData}
    ${length}=    Get Length    ${SheetHeader}   

    # Get testcase row values
    @{RowValues}=    Get Row Values    ${EXCEL_FILE}    ${GlobalData}    ${TEST_ENV}    ${ColumnName}
    
    # Map header value to testcase row value
    FOR    ${value}    IN    @{RowValues}        
         ${counter}=     Evaluate  ${counter}+1        
        Set Global Variable    ${${SheetHeader}[${counter}]}    ${value}
        Set Global Variable    ${${SheetHeader}[${counter}]}    ${${SheetHeader}[${counter}]}
    END

# =====================================================================================================================================================

Fetch Testcase recordset
    [Arguments]    ${EXCEL_FILE}    ${TEST_ENV}     ${TEST_NAME}    ${ColumnName}

    # Get column count of sheet eg:PREDEV
    Set Test Variable    ${counter}    0
    ${columncount}=    Get Columncount    ${EXCEL_FILE}    ${TEST_ENV}

    # Get sheet header names
    @{SheetHeader}=    Get Sheet Header    ${EXCEL_FILE}    ${TEST_ENV}
    ${length}=    Get Length    ${SheetHeader}    

    # Get testcase row values
    @{RowValues}=    Get Row Values    ${EXCEL_FILE}    ${TEST_ENV}    ${TEST_NAME}    ${ColumnName}
    
    # Map header value to testcase row value
    FOR    ${value}    IN    @{RowValues}        
        ${counter}=     Evaluate  ${counter}+1            
        Set Global Variable    ${${SheetHeader}[${counter}]}    ${value}
        Set Global Variable    ${${SheetHeader}[${counter}]}    ${${SheetHeader}[${counter}]}
    END



#    =====================================================================================================================================================
Read Data From Excel
    [Arguments]    ${Sheetname}    ${Dataname}
    @{data_rows} =    Get Data    ${Sheetname}    ${Dataname}
    RETURN    @{data_rows}


