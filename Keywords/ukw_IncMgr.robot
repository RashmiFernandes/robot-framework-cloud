*** Settings ***
Resource    ukw_Common.robot


*** Keywords ***
IncMgr-Login To IncMgr
    [Arguments]    ${user}    ${password}
    TRY
        Wait Until Element Is Visible    ${loc_IncMgr_Username}    10s
        Clear Element Text    ${loc_IncMgr_Username}
        Input Text    ${loc_IncMgr_Username}    ${user}
        Clear Element Text    ${loc_IncMgr_Password}
        Input Text    ${loc_IncMgr_Password}    ${password}
        Click Button    ${loc_IncMgr_Login}
    
        GetElementToView    ${loc_IncMgr_Calls}    IncMgr_Calls
        Wait Until Element Is Visible    ${loc_IncMgr_CreateNonConnectedCall}    120s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Incmgr-Login.png     Login To IncidentMgr    passed    

    EXCEPT   
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Incmgr-Login.png     Login To IncidentMgr    failed    
        Close Browser   
        FAIL     IncidentMgr home page not loaded       
    END

Incmgr-Click Topmenu links
    [Arguments]    ${data}
    TRY
       IF    "${data}" == "Calls"
            GetElementToView    ${loc_IncMgr_Calls}    IncMgr_Calls
        ELSE IF    "${data}" == "Incidents"
            GetElementToView    ${loc_IncMgr_Incidents}    IncMgr_Incidents
        END
        Sleep    5s
        
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_IncMgr_Topmenu.png     Click menu ${data}    passed
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_IncMgr_Topmenu.png     Click menu ${data}    failed
        FAIL    "Incmgr-Click Topmenu ${data} failed"
    END
    

Incmgr-Search Customer
    [Arguments]    ${data}
    Set Selenium Timeout    60 seconds
    Input Text    ${loc_IncMgr_CustomerName}    ${data}
    GetElementToView    ${loc_IncMgr_Search}    IncMgr_Search
    Sleep    10s
    ukw_Common.CaptureScreen    ${TEST_NAME}_Incmgr-Search Customer.png

IncMgr-Logout from IncMgr
    TRY
        GetElementToView    ${loc_IncMgr_LogOff}    IncMgr_LogOff
        Sleep    2s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_IncMgr-Logout.png    Logout from IncMgr    passed

    EXCEPT 
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_IncMgr-Logout.png    Logout from IncMgr    failed
        Close Browser
        FAIL    "Logout from IncMgrfailed" 
    END

Incmgr-Click and verify element exists
    [Arguments]    ${locator1}    ${locator2}    ${screen}
    TRY
        Run Keyword And Continue On Failure     GetElementToView    ${locator1}    ${locator1}    
        Wait Until Element Is Visible    ${locator2}    120s
        ukw_Common.CaptureScreen    ${TEST_NAME}_${screen}.png
        Page Should Contain Element    ${locator2}    Page not loaded-${locator2} not shown

        CaptureScreen_AddStepsToReport    ${TEST_NAME}_IncMgr_Verify Tab ${screen} exists.png       Verify ${screen} is loaded    passed  
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_IncMgr_Verify ${screen} exists.png       Verify ${screen} is loaded    failed  
        FAIL    "IncMgr_Verify ${screen} exists failed"
    END
    

Incmgr-Verify Incident Status
    [Arguments]    ${data}    ${address}
    # GetElementToView    ${loc_IncMgr_Refresh}
    Sleep    5s
    ${rows} =    Get Element Count    //table[@id='incident-list-grid']/tbody[1]/tr

    IF   ${rows} != 2       
        GetElementToView    ${loc_IncMgr_TableSelectAll}    IncMgr_TableSelectAll
        Sleep    2s
        GetElementToView    ${loc_IncMgr_TableSelectAll}    IncMgr_TableSelectAll
        Sleep    2s
        ${loc_IncMgr_Incident_Address}=    Replace Variables    ${loc_IncMgr_Incident_Address}
        GetElementToView    ${loc_IncMgr_Incident_Address}    IncMgr_Incident_Address
        Sleep    5s
        Scroll Element Into View    ${loc_IncMgr_Status_BottomTable}
        ukw_Common.CaptureScreen    ${TEST_NAME}_Incmgr-Verify Incident Status.png

        Element Should Contain    ${loc_IncMgr_Status_BottomTable}    ${data}    ${data} not found in the table
    
    ELSE
        Sleep    2s
        
        ${loc_IncMgr_Incident_Address}=    Replace Variables     ${loc_IncMgr_Incident_Address}
        
        # GetElementToView    ${loc_IncMgr_Incident_Address}
        # Sleep    5s
        # Refresh list
        Select From List By Index    ${loc_IncMgr_Incident_SelectFilter}    0
        Sleep    10s
        Select From List By Value    ${loc_IncMgr_Incident_SelectFilter}    ${IncidentQuery}
        Sleep    10s

        Scroll Element Into View    ${loc_IncMgr_Status_BottomTable}
        ukw_Common.CaptureScreen    ${TEST_NAME}_Incmgr-Verify Incident Status.png
        Element Should Contain    ${loc_IncMgr_Status_BottomTable}    ${data}    ${data} not found in the table
        
    END

Incmgr-Search and Update call
    Set Global Variable    ${address}    ${ServiceAddress}


Incmgr-Search Incident and get Incident and Location ID
    [Arguments]    ${IncidentQuery}
    TRY
        # Set Global Variable    ${address}    ${ServiceAddress}
        Select From List By Value    ${loc_IncMgr_Incident_SelectFilter}    ${IncidentQuery}
        Sleep    10s

        Generic-Verify page contains element and update report    ${loc_IncMgr_IncidentList_TableRow1}    OGAppconfig-Incident list not found
        ${rows} =    Get Element Count    //table[@id='incident-list-grid']/tbody[1]/tr

        IF   ${rows} != 2
            # Select - Unselect all rows
            # GetElementToView    ${loc_IncMgr_TableSelectAll}
            # Sleep    2s

            # GetElementToView    ${loc_IncMgr_TableSelectAll}
            # Sleep    2s
            ${loc_IncMgr_Incident_Address}=    Replace Variables    ${loc_IncMgr_Incident_Address}
            GetElementToView    ${loc_IncMgr_Incident_Address}    IncMgr_Incident_Address
            Sleep    5s
        
        ELSE
            Sleep    2s
            #Click Incident column to sort in descending orsder
            GetElementToView    ${loc_IncMgr_IncidentList_ColumnHeader}    IncMgr_IncidentList_ColumnHeader
            Sleep    5s
            ${loc_IncMgr_Incident_Address}=    Replace Variables    ${loc_IncMgr_Incident_Address}
            ukw_Common.CaptureScreen    ${TEST_NAME}_Search Incident1.png

            Generic-Verify page contains element and update report    ${loc_IncMgr_Incident_Address}    OGAppconfig-Incident list-Address not found
            
            ${loc_IncMgr_Incident_Address}=    Replace Variables    ${loc_IncMgr_Incident_Address}
            
            Select From List By Index    ${loc_IncMgr_Incident_SelectFilter}    0
            Sleep    10s
            Select From List By Value    ${loc_IncMgr_Incident_SelectFilter}    ${IncidentQuery}
            Sleep    10s
        
        END
        ukw_Common.CaptureScreen    ${TEST_NAME}_Search Incident2.png

        # Get Incident number
        ${loc_IncMgr_Incident_Address}=    Replace Variables    ${loc_IncMgr_Incident_Address}

        ${IncidtentID}=    SeleniumLibrary.Get Text    ${loc_IncMgr_IncidentID}
        Set Global Variable    ${IncidtentID}    ${IncidtentID}
        
        # Get LocationID
        ${LocationID}=    SeleniumLibrary.Get Text    ${loc_IncMgr_LocationID_BottomTable}
        GetElementToView    ${loc_IncMgr_LocationID_BottomTable}    IncMgr_LocationID_BottomTable
        Set Global Variable    ${LocationID}    ${LocationID}
        ukw_Common.CaptureScreen    ${TEST_NAME}_Incmgr-Search Incident and get Incident and Location ID.png

        CaptureScreen_AddStepsToReport    ${TEST_NAME}_IncMgr_SearchIncident.png      Search Incident and get Incident and Location ID    passed   
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_IncMgr_SearchIncident.png      Search Incident and get Incident and Location ID    failed   
        FAIL    "Search Incident and get Incident and Location ID failed"
    END

    

Incmgr-Create JOB      
    # Get/Create Cad jobnumber
    GetElementToView    ${loc_IncMgr_Refresh}    IncMgr_Refresh
    Sleep    60s

    ${loc_IncMgr_CADID_BottomTable}=    Replace Variables    ${loc_IncMgr_CADID_BottomTable}
    ${JOBNUMBER}=    SeleniumLibrary.Get Text    ${loc_IncMgr_CADID_BottomTable}  
    

    # IF    "${JOBNUMBER}" == "${EMPTY}"
        GetElementToView    ${loc_IncMgr_ReleaseToCAD}    IncMgr_ReleaseToCAD
        Sleep    3s
        GetElementToView    ${loc_IncMgr_Yes}    IncMgr_Yes
        Sleep    15s
        GetElementToView    ${loc_IncMgr_Close}    IncMgr_Close
        Sleep    5s
        ${rows} =    Get Element Count    //table[@id='incident-list-grid']/tbody[1]/tr

        IF   ${rows} != 2

            # GetElementToView    ${loc_IncMgr_TableSelectAll}
            # Sleep    5s
            # GetElementToView    ${loc_IncMgr_TableSelectAll}
            # Sleep    5s
            # GetElementToView    ${loc_IncMgr_TableSelectAll}
            # Sleep    5s
            ${loc_IncMgr_Incident_Address}=    Replace Variables     ${loc_IncMgr_Incident_Address}
            GetElementToView    ${loc_IncMgr_Incident_Address}    IncMgr_Incident_Address
            Sleep    3s
        
        ELSE
            # GetElementToView    ${loc_IncMgr_TableSelectAll}
            # Sleep    5s
            # GetElementToView    ${loc_IncMgr_TableSelectAll}
            # Sleep    5s
            # GetElementToView    ${loc_IncMgr_TableSelectAll}
            # Sleep    5s

            ${loc_IncMgr_Incident_Address}=    Replace Variables     ${loc_IncMgr_Incident_Address}
            # Refresh table
            # GetElementToView    ${loc_IncMgr_Incident_Address}
            # Sleep    5s
            # GetElementToView    ${loc_IncMgr_Incident_Address}
            # Sleep    5s
        END
        
        Incmgr-Search Incident and get Incident and Location ID    ${IncidentQuery}
        GetElementToView    ${loc_IncMgr_LocationID_BottomTable}    IncMgr_LocationID_BottomTable
        ${JOBNUMBER}=    SeleniumLibrary.Get Text    ${loc_IncMgr_CADID_BottomTable}
    # END

    ukw_Common.CaptureScreen    ${TEST_NAME}_Incmgr-Create JOB1.png

    Element Should Contain    ${loc_IncMgr_CADID_BottomTable}    EPB
    # Element Should Contain    ${loc_IncMgr_CADID_IncidentTable}    EPB


    Set Global Variable    ${JOBNUMBER}    ${JOBNUMBER}
    ukw_Common.CaptureScreen    ${TEST_NAME}_Incmgr-Create JOB2.png



Incmgr-Create Call
    [Arguments]    ${CustomerName}  ${Phone}  ${ServiceAddress}  ${City}  ${Structure}  ${District}  ${Remarks}  ${Destination}  ${CallType}  ${ProblemCode}
   TRY
        GetElementToView    ${loc_IncMgr_CreateNonConnectedCall}    IncMgr_CreateNonConnectedCall
        Sleep    3s
        Wait Until Element Is Visible    ${loc_IncMgr_CustomerName}    20s
        Input Text    ${loc_IncMgr_CustomerName}    ${CustomerName}
        Input Text    ${loc_IncMgr_Phone}    ${Phone}
        Input Text    ${loc_IncMgr_ServiceAddress}    ${ServiceAddress}
        Select From List By Index    ${loc_IncMgr_City}    1

        Input Text    ${loc_IncMgr_Structure}    ${Structure}    
        Select From List By Index    ${loc_IncMgr_District}    1
        Input Text    ${loc_IncMgr_Remarks}     ${Remarks}

        Select From List By Index    ${loc_IncMgr_CallType}    1
        Select From List By Index    ${loc_IncMgr_ProblemCode1}    1
        GetElementToView    ${loc_IncMgr_ContactInfoSame}      IncMgr_ContactInfoSame  
        Input Text    ${loc_IncMgr_Directions}     ${Destination}
        ukw_Common.CaptureScreen    ${TEST_NAME}_Incmgr-Create Call1.png

        GetElementToView    ${loc_IncMgr_Save}    IncMgr_Save
        Sleep    20s
        ukw_Common.CaptureScreen    ${TEST_NAME}_Incmgr-Create Call2.png
        ukw_Generic_AppKeywords.Generic-Click element if shown    ${loc_IncMgr_Yes}      
        ukw_Common.CaptureScreen    ${TEST_NAME}_Incmgr-Create Call3.png

        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Incmgr-Create Calls.png    Incmgr-Create Call    passed
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Incmgr-Create Calls.png    Incmgr-Create Call    failed
        FAIL    "Incmgr-Create Call failed"
    END
   
   
    


    
ukw_IncidentMgr_Get_CreateCallValues
    ${randomstring} =  Generate Random String  2  [NUMBERS]
    Set Global Variable    ${IncidentServiceAddress}    ${IncidentServiceAddress}${randomstring}