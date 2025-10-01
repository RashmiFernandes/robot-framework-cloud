*** Settings ***
Resource    ukw_Common.robot

*** Keywords ***
Get_OGW_LoginDetails_LoginToApp       
        ukw_Common.Open Browser to test    ${OGW_URL}   ${WebBrowser}   ${OGW_Alias}         
        OGW-Login To OGW    ${OGW_USER}    ${OGW_PWD}

OGW-Login To OGW
    [Arguments]    ${user}    ${password}    
    TRY
        Wait Until Element Is Visible    ${loc_OGW_Username}    10s
        Input Text    ${loc_OGW_Username}    ${user}
        Clear Element Text    ${loc_OGW_Password}
        Input Text    ${loc_OGW_Password}    ${password}
        Click Button    ${loc_OGW_Submit}
        Sleep    50s
   
        Generic-Joblist_Crewlist_Query not found

        Wait Until Element Is Visible    ${loc_OGW_JobList_SelectQuery1}    200s
		CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW-Login.png    OGW-Login to OGWorkforce    passed
    EXCEPT 
		CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW-Login.png    OGW-Login to OGWorkforce    failed
        Close Browser   
        FAIL    Login to OGWorkforce failed
    END

Get_OGW_LoginDetails_LoginToApp_UsingValue_FromGlobalData   
    ukw_Common.Open Browser to test    ${OGW_URL}   ${WebBrowser}   ${OGW_Alias}  
    Set Global Variable    ${OGW_USER}    ${OGWUSER_TESTDATA}
    OGW-Login To OGW    ${OGW_USER}    ${OGW_PWD}
     
 

OGW-Logout from OGW
    TRY
        seleniumlibrary.Switch Browser    ${OGW_Alias}   
        GetElementToView    ${loc_OGW_Logout}    OGW_Logout

		CaptureScreen_AddStepsToReport    ${TEST_NAME}_Logout.png    OGW-Logout from OGWorkforce    passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Logout.png     OGW-Logout from OGWorkforce    failed
        FAIL   Logout from OGWorkforce failed
    END
    
#    =============Joblist========================================================================================================================================

OGW-Select Joblist Query
    [Arguments]    ${JobList_SelectQuery2}    ${JobListQueryName}
    TRY
        Set Global Variable    ${JobList_SelectQuery2}
        Set Global Variable    ${JobListQueryName}
        Scroll complete page up using Javascript
        Wait Until Element Is Visible    ${loc_OGW_JobList_SelectQuery1}        120s
        GetElementToView    ${loc_OGW_JobList_SelectQuery1}       Joblist-Query dropdown not found
        
        ${loc_OGW_JobList_SelectQuery2}=    Replace Variables    ${loc_OGW_JobList_SelectQuery2}
        GetElementToView    ${loc_OGW_JobList_SelectQuery2}    Query not found

        ${loc_OGW_JobList_QueryName}=    Replace Variables     ${loc_OGW_JobList_QueryName} 
        GetElementToView    ${loc_OGW_JobList_QueryName}        Query name not found    
        Sleep    5s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW_Select Joblist Query.png    OGW-Select Joblist Query   passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW_Select Joblist Query.png    OGW-Select Joblist Query   failed 
        FAIL   OGW-Select joblist query failed
    END


OGW-Enter Joblist Wildcard details
    [Arguments]    ${data}
    TRY
        Set Selenium Timeout    60 seconds
        Input Text    ${loc_OGW_JobListWildcard_Text}    ${data}
        GetElementToView    ${loc_OGW_JobListWildcard_OK}    OGW_JobListWildcard_OK
        Sleep    2s
        Wait Until Element Is Visible    ${loc_OGW_Joblist_TableRow1}    120s
        Page Should Contain Element    ${loc_OGW_Joblist_TableRow1}    Job ${data} not found in Joblist
        ukw_Common.CaptureScreen    ${TEST_NAME}_Enter Joblist Wildcard details.png
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Enter Joblist Wildcard details.png    OGW-Enter Joblist Wildcard details   failed 
        FAIL   OGW-Enter Joblist Wildcard details failed
    END
OGW-Select row in Joblist
    [Arguments]    ${data}
    TRY
        ${loc_OGW_Joblist_JobCheckbox}=    Replace Variables    ${loc_OGW_Joblist_JobCheckbox}
        GetElementToView    ${loc_OGW_Joblist_JobCheckbox}    OGW_Joblist_JobCheckbox
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select row in Joblist.png    OGW-Select row in Joblist   passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select row in Joblist.png    OGW-Select row in Joblist   failed 
        FAIL   OGW-Select row in Joblist failed
    END

OGW-Select Query from Joblist
    [Arguments]    ${data}    ${OGW_JobQuery}  ${OGW_JobQueryName}  
    Sleep    1s
    OGW-Select Joblist Query    ${OGW_JobQuery}    ${OGW_JobQueryName}
    Sleep   5s
    OGW-Select row in Joblist    ${data}

 OGW-Select Query from Joblist_ClickValue
    [Arguments]    ${data}    ${OGW_JobQuery}  ${OGW_JobQueryName}  
    Sleep    1s
    OGW-Select Joblist Query    ${OGW_JobQuery}    ${OGW_JobQueryName}
    Sleep   5s
    ${loc_OGW_Joblist_ContainsText}=    Replace Variables    ${loc_OGW_Joblist_ContainsText}

    GetElementToView    ${loc_OGW_Joblist_ContainsText}    ${data} not found in Joblist
    ukw_Common.CaptureScreen    ${TEST_NAME}_Select ${data} in Joblist.png

OGW-Refresh Joblist
    Scroll complete page up using Javascript
    GetElementToView    ${loc_OGW_JobList_Refresh}    OGW_JobList_Refresh
    Sleep    5s
    ukw_Common.CaptureScreen    ${TEST_NAME}_Refresh Joblist.png

OGW-Verify value in Joblist
    [Arguments]    ${data}
    TRY    
        ukw_Common.CaptureScreen    ${TEST_NAME}_Verify value in Joblist.png
        Element Should Contain    ${loc_OGW_JoblistTableText}    ${data}
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Verify value in Joblist.png    OGW-Verify value in Joblist-${data}   passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Verify value in Joblist.png    OGW-Verify value in Joblist-${data}   failed 
        FAIL   OGW-Verify value in Joblist-${data} failed
    END

OGW-Select Job from Joblist
    [Arguments]    ${data}    ${OGW_JobQuery}  ${OGW_JobQueryName}  
    Sleep    1s
    TRY
        OGW-Select Joblist Query    ${OGW_JobQuery}    ${OGW_JobQueryName}
        OGW-Enter Joblist Wildcard details    ${data}
        Sleep    10s
        OGW-Select row in Joblist    ${data}
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select Job from Joblist.png    OGW-Select Job from Joblist   passed            

    EXCEPT 
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select Job from Joblist.png     OGW-Select Job from Joblist   failed            
        FAIL     OGW-Verify Joblist query or Jobnumber is available
    END
    

#    =============Crewlist========================================================================================================================================

OGW-Select Crewlist Query
    [Arguments]    ${CrewList_SelectQuery2}    ${CrewListQueryName}
    TRY
        Wait Until Element Is Visible    ${loc_OGW_CrewList_SelectQuery1}    120s
        GetElementToView    ${loc_OGW_CrewList_SelectQuery1}    Crewlist Query-Query dropdown not found   

        IF  '${Crewlist_Qry1}[0]' == 'General'
            GetElementToView    ${loc_OGW_CrewList_SelectQuery_General}    Crewlist Query-General not found
        ELSE
            Set Global Variable    ${CrewList_SelectQuery2}    ${Crewlist_Qry1}[0]
            ${loc_OGW_CrewList_SelectQuery2}=    Replace Variables    ${loc_OGW_CrewList_SelectQuery2}
            GetElementToView    ${loc_OGW_CrewList_SelectQuery2}    OGW_CrewList_SelectQuery2
        END
        
        Set Global Variable    ${CrewListQueryName}    ${Crewlist_Qry1}[1]
        ${loc_OGW_CrewList_QueryName}=    Replace Variables    ${loc_OGW_CrewList_QueryName}
        Sleep    2s
        GetElementToView    ${loc_OGW_CrewList_QueryName}    Crewlist QueryName not found
        Sleep    5s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW_Select Crewlist Query.png    OGW-Select Crewlist Query   passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW_Select Crewlist Query.png    OGW-Select Crewlist Query   failed 
        FAIL   OGW-Select crewlist query failed
    END

OGW-Enter Crewlist Wildcard details
    [Arguments]    ${data}
    TRY
        Wait Until Element Is Visible    ${loc_OGW_CrewListWildcard_Text}    50s
        Input Text    ${loc_OGW_CrewListWildcard_Text}    ${data}
        GetElementToView    ${loc_OGW_CrewListWildcard_OK}    OGW_CrewListWildcard_OK
        Sleep    15s
        ukw_Common.CaptureScreen    ${TEST_NAME}_Enter Crewlist Wildcard details.png
        Wait Until Element Is Visible    ${loc_OGW_CrewList_TableRow1}    120s
        Page Should Contain Element    ${loc_OGW_CrewList_TableRow1}    Crew ${data} not found in Crewlist
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Enter Crewlist Wildcard details.png    OGW-Enter Crewlist Wildcard details   failed 
        FAIL   OGW-Enter Crewlist Wildcard details failed
    END

OGW-Select row in Crewlist
    [Arguments]    ${data}
    TRY
        ${loc_OGW_CrewList_TableValue}=    Replace Variables    ${loc_OGW_CrewList_TableValue}
        Page Should Contain Element    ${loc_OGW_CrewList_TableText}
        GetElementToView    ${loc_OGW_CrewList_TableText}    OGW_CrewList_TableText-${data}
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select row in Crewlist.png    OGW-Select row in Crewlist   passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select row in Crewlist.png    OGW-Select row in Crewlist   failed 
        FAIL   OGW-Select row in Crewlist failed
    END

OGW-Assign job from Crewlist
    GetElementToView    ${loc_OGW_CrewList_Assign}    OGW_CrewList_Assign
    Sleep    5s
    Run Keyword And Continue On Failure    OGW-Click AcceptAll message if shown
    CaptureScreen_AddStepsToReport   ${TEST_NAME}_Assign job from Crewlist.png    OGW-Assign job from Crewlist   passed 

OGW-Refresh Crewlist
    GetElementToView    ${loc_OGW_CrewList_Refresh}    OGW_CrewList_Refresh
    Sleep    5s
    ukw_Common.CaptureScreen    ${TEST_NAME}_Refresh Crewlist.png

OGW-Verify value in Crewlist
    [Arguments]    ${data}  
    TRY    
        Element Should Contain    ${loc_OGW_CrewList_TableText}    ${data}
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Verify value in Crewlist.png    OGW-Verify value in Crewlist-${data}   passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Verify value in Crewlist.png    OGW-Verify value in Crewlist-${data}   failed 
        FAIL   OGW-Verify value in Crewlist-${data} failed
    END  

OGW-Select Crew from Crewlist
    [Arguments]    ${data}    ${OGW_CrewQuery}    ${OGW_CrewQueryName}
    
    TRY
        OGW-Select Crewlist Query    ${OGW_CrewQuery}    ${OGW_CrewQueryName}
        OGW-Enter Crewlist Wildcard details    ${data}
        Sleep    2s
        Page Should Contain Element    ${loc_OGW_CrewList_TableRow1} 
        OGW-Select row in Crewlist    ${data}
		CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select Crew from Crewlist.png    OGW-Select Crew from Crewlist-${data}    passed
    EXCEPT 
		CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select Crew from Crewlist.png    OGW-Select Crew from Crewlist-${data}    failed
        FAIL     OGW-Select Crew from Crewlist-${data} failed
    END
#    =============Assignmentlist========================================================================================================================================

OGW-Select AssignmentlistQuery
    [Arguments]    ${AssignmentList_SelectQuery2}    ${AssignmentListQueryName}
    TRY
        Sleep    2s
        Wait Until Element Is Visible    ${loc_OGW_AssignmentList_SelectQuery1}    120s

        # Click Main Query dropdown
        GetElementToView    ${loc_OGW_AssignmentList_SelectQuery1}    AssignmentList_Query dropdown not found

        # Click Query name
        Set Global Variable    ${AssignmentListQuery1}    ${Assignmentlist_Qry1}[0]
        ${loc_OGW_AssignmentList_SelectQuery2}=    Replace Variables     ${loc_OGW_AssignmentList_SelectQuery2} 
        GetElementToView    ${loc_OGW_AssignmentList_SelectQuery2}    Query not found
        Sleep    2s

        # Click Subquery name
        Set Global Variable    ${AssignmentListQueryName}    ${Assignmentlist_Qry1}[1]
        ${loc_OGW_AssignmentList_QueryName}=    Replace Variables     ${loc_OGW_AssignmentList_QueryName} 
        GetElementToView    ${loc_OGW_AssignmentList_QueryName}    QueryName not found
        Sleep    5s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW_Select Assignmentlist Query.png    OGW-Select Assignmentlist Query   passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW_Select Assignmentlist Query.png    OGW-Select Assignmentlist Query   failed 
        FAIL   OGW-Select Assignmentlist query failed
    END

OGW-Select crew from Assignmentlist
    TRY
        Wait Until Element Is Visible    ${loc_OGW_AssignmentList_SelectQuery1}    120s
        GetElementToView    ${loc_OGW_AssignmentList_SelectQuery1}    OGW_AssignmentList_SelectQuery1
        GetElementToView    ${loc_OGW_AssignmentList_SelectQuery2}     OGW_AssignmentList_SelectQuery2   

        ${loc_OGW_AssignmentList_QueryName_BYCREWTODAY}=    Replace Variables    ${loc_OGW_AssignmentList_QueryName_BYCREWTODAY}
        GetElementToView    ${loc_OGW_AssignmentList_QueryName_BYCREWTODAY}    OGW_AssignmentList_QueryName_BYCREWTODAY
        Sleep    10s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW_Select crew from Assignmentlist.png    OGW-Select crew from Assignmentlist   passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW_Select crew from Assignmentlist.png    OGW-Select crew from Assignmentlist   failed 
        FAIL   OGW-Select crew from Assignmentlist failed
    END

OGW-Select row in Assignmentlist
    [Arguments]    ${data}
   TRY
        ${loc_OGW_AssignmentList_TableText}=    Replace Variables    ${loc_OGW_AssignmentList_TableText}
        GetElementToView    ${loc_OGW_AssignmentList_TableText}    OGW_AssignmentList_TableText-${data}
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select row in Assignmentlist.png    OGW-Select row in Assignmentlist   passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select row in Assignmentlist.png    OGW-Select row in Assignmentlist   failed 
        FAIL   OGW-Select row in Assignmentlist failed
    END


OGW-Refresh AssignmentList
    GetElementToView    ${loc_OGW_AssignmentList_Refresh}    OGW_AssignmentList_Refresh
    Sleep    5s
    ukw_Common.CaptureScreen    ${TEST_NAME}_Refresh AssignmentList.png

OGW-Verify value in AssignmentList
    [Arguments]    ${data}    
    TRY    
        Element Should Contain    ${loc_OGW_AssignmentList_TableText}    ${data}
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Verify value in AssignmentList.png    OGW-Verify value in AssignmentList-${data}   passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Verify value in AssignmentList.png    OGW-Verify value in AssignmentList-${data}   failed 
        FAIL   OGW-Verify value in AssignmentList-${data} failed
    END  
    
OGW-Enter AssignmentList Wildcard details
    [Arguments]    ${data}
    TRY   
        Input Text    ${loc_OGW_AssignmentListWildcard_Text}    ${data}
        GetElementToView    ${loc_OGW_AssignmentListWildcard_OK}    OGW_AssignmentListWildcard_OK
        Sleep    2s
        ukw_Common.CaptureScreen    ${TEST_NAME}_Enter AssignmentList Wildcard details.png

        Wait Until Element Is Visible    ${loc_OGW_AssignmentList_TableRow1}    120s
        Page Should Contain Element    ${loc_OGW_AssignmentList_TableRow1}    ${data} not found in Assignmentlist       
    EXCEPT    
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Enter AssignmentList Wildcard details.png  OGW-Enter AssignmentList Wildcard details   failed 
        FAIL   OGW-Enter AssignmentList Wildcard details failed
    END 
OGW-Click Joblist links
    [Arguments]    ${data}
    IF    "${data}" == "Next Status"
        GetElementToView    ${loc_OGW_JobList_NestStatus}    OGW_JobList_NestStatus
    ELSE IF    "${data}" == "Previous Status"
        GetElementToView    ${loc_OGW_JobList_PreviousStatus}    OGW_JobList_PreviousStatus
    ELSE IF    "${data}" == "Job Details"
        GetElementToView    ${loc_OGW_JobList_JobDetails}    OGW_JobList_JobDetails
    ELSE IF    "${data}" == "Attachments"
        GetElementToView    ${loc_OGW_JobList_Attachments}    OGW_JobList_Attachments
    ELSE IF    "${data}" == "Assign Job"
        GetElementToView    ${loc_OGW_JobList_Assignjob}    OGW_JobList_Assignjob
    END
    Sleep    2s
    ukw_Common.CaptureScreen    ${TEST_NAME}_Click Joblist links ${data}.png

OGW-Click Crewlist links
    [Arguments]    ${data}

    IF    "${data}" == "Next Status"
        GetElementToView    ${loc_OGW_CrewList_NestStatus}    OGW_CrewList_NestStatus
    ELSE IF    "${data}" == "Previous Status"
        GetElementToView    ${loc_OGW_Crewist_PreviousStatus}    OGW_Crewist_PreviousStatus
    ELSE IF    "${data}" == "Crew Details"
        GetElementToView    ${loc_OGW_CrewList_CrewDetails}    OGW_CrewList_CrewDetails
        Sleep    20s
    ELSE IF    "${data}" == "Duty On"
        GetElementToView    ${loc_OGW_CrewList_DutyOn}    OGW_CrewList_DutyOn
    ELSE IF    "${data}" == "Duty Off"
        GetElementToView    ${loc_OGW_CrewList_DutyOff}    OGW_CrewList_DutyOff
    ELSE IF    "${data}" == "Lunch On"
        GetElementToView    ${loc_OGW_CrewList_LunchOn}    OGW_CrewList_LunchOn
    ELSE IF    "${data}" == "Lunch Off"
        GetElementToView    ${loc_OGW_CrewList_LunchOff}    OGW_CrewList_LunchOff
    ELSE IF    "${data}" == "Assign Job"
        GetElementToView    ${loc_OGW_CrewList_Assign}    OGW_CrewList_Assign
    ELSE IF    "${data}" == "Unassign"
        GetElementToView    ${loc_OGW_Crewlist_Unassign}    OGW_Crewlist_Unassign

    END
    Sleep    2s
    OGW-Click Acknowledge message if shown
    CaptureScreen_AddStepsToReport    ${TEST_NAME}_Click Crewlistlinks ${data}.png    Crewlist-${data} click passed    passed


OGW-Unassign all jobs from Crewlist
    [Arguments]    ${CREW}    ${Query1}    ${Query2}
    
    #Get no.of jobs assigned to crew if its > 0 then unassign    
    IF    ${DB_JobsAssigned} > 0
        GetElementToView    ${loc_OGW_Crewlist_Unassign}    OGW_Crewlist_Unassign
        Sleep    10s
        GetElementToView    ${loc_OGW_Unassign}    OGW_Unassign
        Sleep    10s
        IF    ${DB_JobsAssigned} <= 3   
        Sleep    10s
        ELSE IF   ${DB_JobsAssigned} > 3
            Sleep    30s
        END
        
        ${elem_exist}    Run Keyword And Return Status
        ...    Page Should Contain Element
        ...    ${loc_OGW_AcceptAll}
        IF    '${elem_exist}' == 'True'
            GetElementToView    ${loc_OGW_AcceptAll}    OGW_AcceptAll
        END
        Sleep    5s
        Set Global Variable    ${SetReason}     ${SetReason_Remarks}
        OGW-Set Reason    ${SetReason}
        Sleep    20s
        OGW-Refresh Crewlist

        ukw_Common.CaptureScreen    ${TEST_NAME}_Unassign all jobs from Crewlist.png
    END
    
    CaptureScreen_AddStepsToReport    ${TEST_NAME}_Unassign all jobs from Crewlist.png     OGW-Unassign all jobs from Crewlist    passed            



OGW-Click Acknowledge message if shown
    ${elem_exist}    Run Keyword And Return Status
    ...    Page Should Contain Element
    ...    ${loc_OGW_Acknowledge}
    IF    '${elem_exist}' == 'True'
        GetElementToView    ${loc_OGW_Acknowledge}    OGW_Acknowledge
        Sleep    2s
    END

OGW-Click AcceptAll message if shown
    ${elem_exist}    Run Keyword And Return Status
    ...    Page Should Contain Element
    ...    ${loc_OGW_AcceptAll}
    IF    '${elem_exist}' == 'True'
        GetElementToView    ${loc_OGW_AcceptAll}    OGW_AcceptAll
        Sleep    2s
    END

OGW-Click Assignmentlist links
    [Arguments]    ${data}

    IF    "${data}" == "Next Status"
        GetElementToView    ${loc_OGW_AssignmentList_NextStatus}    OGW_AssignmentList_NextStatus
    ELSE IF    "${data}" == "Previous Status"
        GetElementToView    ${loc_OGW_AssignmentList_PreviousStatus}    OGW_AssignmentList_PreviousStatus
    ELSE IF    "${data}" == "Unassign"
        GetElementToView    ${loc_OGW_AssignmentList_Unassign}    OGW_AssignmentList_Unassign
    ELSE IF    "${data}" == "Open"
        GetElementToView    ${loc_OGW_AssignmentList_Open}    OGW_AssignmentList_Open
    ELSE IF    "${data}" == "Hold"
        GetElementToView    ${loc_OGW_AssignmentList_Hold}    OGW_AssignmentList_Hold
    END
    Sleep    2s
    ukw_Common.CaptureScreen    ${TEST_NAME}_Click Assignmentlist links ${data}.png

OGW-Unassign all jobs from Assignmentlist
    [Arguments]    ${crewid}
    ukw_OGWorkforce.OGW-Select crew from Assignmentlist
    Sleep    5
       

    ${elem_exist}    Run Keyword And Return Status
    ...    Page Should Contain Element
    ...    ${loc_OGW_AssignmentListWildcard_Crew}
    IF    '${elem_exist}' == 'True'
             Wait Until Element Is Visible    ${loc_OGW_AssignmentListWildcard_Crew}
            Input Text    ${loc_OGW_AssignmentListWildcard_Crew}    ${crewid}
            GetElementToView    ${loc_OGW_AssignmentListWildcard_OK}    OGW_AssignmentListWildcard_OK
            Sleep    5s
            Page Should Contain Element    ${loc_OGW_CrewList_TableRow1}    Crew ${crewid} not found in Crewlist
    END

    ${elem_exist}    Run Keyword And Return Status
    ...    Page Should Contain Element
    ...    ${loc_OGW_AssignmentList_NoRecordsToView}
    IF    '${elem_exist}' == 'False'
        GetElementToView    ${loc_OGW_AssignmentList_SelectAllCrews}    OGW_AssignmentList_SelectAllCrews
        Sleep    5s
        OGW-Click Assignmentlist links    Unassign
        GetElementToView    ${loc_OGW_Unassign}    OGW_Unassign
        Sleep    2s
        ${elem_exist}    Run Keyword And Return Status
        ...    Page Should Contain Element
        ...    ${loc_OGW_AcceptAll}
        IF    '${elem_exist}' == 'True'    
            GetElementToView    ${loc_OGW_AcceptAll}    OGW_AcceptAll
        END
        Sleep    5s
        OGW-Set Reason    ${SetReason}
        OGW-Refresh AssignmentList
        Sleep    10s
    END
    CaptureScreen_AddStepsToReport    ${TEST_NAME}_Unassign all jobs from Assignmentlist.png     OGW-Unassign all jobs from Assignmentist    passed            
    



OGW-Verify values in Joblist Crewlist Assignmentlist
    [Arguments]    ${job}    ${joblist}    ${crewlist}    ${assignmentlist}
    OGW-Refresh Joblist
    IF    "${joblist}" != "None"
        # OGW-Select row in Joblist    ${job}
        OGW-Verify value in Joblist    ${joblist}
    END
    OGW-Refresh Crewlist
    IF    "${crewlist}" != "None"
        OGW-Verify value in Crewlist    ${crewlist}
    END
    OGW-Refresh AssignmentList
    IF    "${assignmentlist}" != "None"
        OGW-Verify value in AssignmentList    ${assignmentlist}
    END


OGW-Verify StatusCode or StatusDescription in Joblist Crewlist Assignmentlist
    TRY    
        OGW-Refresh Joblist
        ukw_Common.CaptureScreen    ${TEST_NAME}_Verify value in All list.png
        ${loc_OGW_Joblist_Status}=    Replace Variables    ${loc_OGW_Joblist_Status}
        Wait Until Page Contains Element     ${loc_OGW_Joblist_Status}    150s
        Page Should Contain Element    ${loc_OGW_Joblist_Status}    Status not found in Joblist
        OGW-Refresh Crewlist
        IF    '${ActiveStatus}' == 'T'
            ${loc_OGW_Crewlist_Status}=    Replace Variables    ${loc_OGW_Crewlist_Status} 
            Wait Until Page Contains Element     ${loc_OGW_Crewlist_Status}    150s
            Page Should Contain Element    ${loc_OGW_Crewlist_Status}    Status not found in Crewlist
        END

        OGW-Refresh AssignmentList
        ${loc_OGW_AssignmentList_Status_BYJOB}=    Replace Variables    ${loc_OGW_AssignmentList_Status_BYJOB}
        Sleep     5s
        Wait Until Page Contains Element    ${loc_OGW_AssignmentList_Status_BYJOB}    150s
        Page Should Contain Element    ${loc_OGW_AssignmentList_Status_BYJOB}    Status not found in Assignmentlist
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Verify value in All list.png    OGW-Verify StatusCode or StatusDescription in Joblist Crewlist Assignmentlist-${Status}    passed
    EXCEPT 
		CaptureScreen_AddStepsToReport    ${TEST_NAME}_Verify value in All list.png    OGW-Verify StatusCode or StatusDescription in Joblist Crewlist Assignmentlist-${Status}    failed
        FAIL     OGW-Verify StatusCode or StatusDescription in Joblist Crewlist Assignmentlist failed
    END
OGW-Select value from Assignmentlist Query
    [Arguments]    ${query1}    ${query2}    ${job}
    
    TRY
        OGW-Select AssignmentlistQuery    ${query1}    ${query2}
        OGW-Enter AssignmentList Wildcard details    ${job}
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select value from Assignmentlist Query.png    OGW-Select value from Assignmentlist Query    passed

    EXCEPT 
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select value from Assignmentlist Query.png    OGW-Select value from Assignmentlist Query    failed
        FAIL     OGW-Select value from Assignmentlist Query failed
    END
OGW-Set Reason
    [Arguments]    ${data}
    ${elem_exist}    Run Keyword And Return Status
        ...    Page Should Contain Element
        ...    ${loc_OGW_SetReason_Popup}
        IF    '${elem_exist}' == 'True'
            Input Text    ${loc_OGW_SetReason_Reason}    ${data}
            GetElementToView    ${loc_OGW_SetReason_Save}    OGW_SetReason_Save
            CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW-Set Reason.png    OGW-Set Reason   passed

        END
        Sleep    5s

    
OGW-Unassign jobs from crew-Assign job-Select jobnumber from Assignmentlist
    OGW-Unassign all jobs from Crewlist    ${CREW}    ${Crewlist_Qry1}[0]  ${Crewlist_Qry1}[1]
    OGW-Select Job from Joblist    ${JOBNUMBER}    ${Joblist_Qry1}[0]  ${Joblist_Qry1}[1]
    OGW-Assign job from Crewlist    
    OGW-Select value from Assignmentlist Query    ${Assignmentlist_Qry1}[0]  ${Assignmentlist_Qry1}[1]  ${JOBNUMBER}  

OGW_Select job from Joblist_Assign job_Select jobnumber from Assignmentlist
    OGW-Select Job from Joblist    ${JOBNUMBER}    ${Joblist_Qry1}[0]  ${Joblist_Qry1}[1]
    # OGW-Select Crewlist Query    ${Crewlist_Qry1}[0]  ${Crewlist_Qry1}[1]
    # OGW-Enter Crewlist Wildcard details    ${CREW}
    # Sleep    5s
    # OGW-Select row in Crewlist   ${CREW} 
    # Sleep    5s     
    OGW-Assign job from Crewlist    
    OGW-Select value from Assignmentlist Query    ${Assignmentlist_Qry1}[0]  ${Assignmentlist_Qry1}[1]  ${JOBNUMBER} 
    CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select job from Joblist_Assign job_Select jobnumber from Assignmentlist.png     OGW-Select job from Joblist_Assign job_Select jobnumber from Assignmentlist    passed            
 

OGW_Doubleclick_Map_VerifyMenuItems
    Set focus to element    ${loc_OGW_Map_Layer}
    Double Click Element    ${loc_OGW_Map_Canvas}
    Sleep     5s
    Generic-Verify page contains element and update report    ${loc_OGW_Map_Address}    Verify Address is found
    Generic-Verify page contains element and update report     ${loc_OGW_Map_CreateJob}    Verify Create job is found
    Generic-Verify page contains element and update report    ${loc_OGW_Map_MoveJob}   Verify Move job is found
    Generic-Verify page contains element and update report   ${loc_OGW_Map_GetRoute}    Verify Get Route is found
    # Page Should Contain Element   ${loc_OGW_Map_Actions}    Actions not found
    Generic-Verify page contains element and update report   ${loc_OGW_Map_CreateCall}   Verify Create Call is found


OGW-CreateJob_EnterJobDetails
    [Arguments]    ${tasktype}    ${jobtype}    ${address}    ${citycode}
    Generic-Click element if shown    ${loc_OGW_JobDetails_DetailsTAB}
    Generic-Click element if shown    ${loc_OGW_JobDetails_JobDetailsTAB}
    Select From List By value     ${loc_OGW_TaskType}    ${tasktype}
    Select From List By Value     ${loc_OGW_Jobtype_WorkCode}    ${jobtype} 
    ${address}=    Generate Random String    5    [LETTERS]
    Input Text    ${loc_OGW_JobDetails_Address}    ${address}
    set global variable    ${address}    ${address}
    # ${citycode}=    convert to string      ${citycode}
    Select From List By index    ${loc_OGW_CityCode}    ${citycode}
    ukw_Common.CaptureScreen    ${TEST_NAME}_OGW-Createjob.png
    #  GetElementToView   ${loc_OGField_JobDetails_ReportingTAB}    Work Review tab  
    # Sleep    2s  
    # ${tempval}=    generate random string    3    [LETTERS]

    # Enter value if element is available    ${loc_OGField_Reporting_UDF14}    ${tempval}    

    GetElementToView   ${loc_OGW_JobDetails_Save}    Job Details Save
    Sleep    5s

    
    
OGW-Get OGW query names
    [Arguments]    ${Joblist_Qry}    ${Crewlist_Qry}    ${Assignmentlist_Qry}
    IF    "${Joblist_Qry}" != "None"
       @{Joblist_Qry1}=     Split String    ${Joblist_Qry}    ^
        set global variable    @{Joblist_Qry1}    @{Joblist_Qry1}
    END

    IF    "${Crewlist_Qry}" != "None"
        @{Crewlist_Qry1}=     Split String    ${Crewlist_Qry}    ^
        set global variable    @{Crewlist_Qry1}    @{Crewlist_Qry1}
    END


    IF    "${Assignmentlist_Qry}" != "None"
        @{Assignmentlist_Qry1}=     Split String    ${Assignmentlist_Qry}    ^
        set global variable    @{Assignmentlist_Qry1}    @{Assignmentlist_Qry1}
    END
  

OGW_GetDBCount_UnassignJobs    
    [Arguments]    ${Logout_Y_N}
    #Get crew job count , unassign if record is  not 0
    ukw_Generic_AppKeywords.ukw_Get_DB_Crew_Job_Count
    OGW-Get OGW query names  ${OGW_JobList_Query_SEARCHJOB}    ${OGW_CrewList_Query_SEARCHCREW}   ${OGW_AssignmentList_Query_BYJOB}   
    OGW-Select Crewlist Query    ${Crewlist_Qry1}[0]  ${Crewlist_Qry1}[1]
    OGW-Enter Crewlist Wildcard details    ${CREW}
    Sleep    5s
    OGW-Select row in Crewlist   ${CREW} 
    Sleep    5s  
    
    IF    ${DB_JobsAssigned} > 0
        seleniumlibrary.Switch Browser    ${OGW_Alias} 
        OGW-Unassign all jobs from Crewlist    ${CREW}    ${Crewlist_Qry1}[0]  ${Crewlist_Qry1}[1]
        IF    "${Logout_Y_N}" == "Logout"
            OGW-Logout from OGW
            Close Browser    
        END
         
    END

# =======================GDM===========================
OGW_Navigate_to_GDM    	
    TRY        
        GetElementToView   ${loc_OGW_NavigationPanel}   OGW_NavigationPanel
        GetElementToView   ${loc_OGW_Navigate_WorkSpacemanager}   OGW_Navigate_WorkSpacemanager
        GetElementToView   ${loc_OGW_Navigate_SystemPanel}   OGW_Navigate_SystemPanel
        Select From List By Value   ${loc_OGW_Navigate_WorkSpaceManger_SystemPanel_Select}   ${OGW_GDM_Panel}    #global data
        GetElementToView   ${loc_OGW_Navigate_WorkSpaceManger_Close}   OGW_Navigate_WorkSpaceManger_Close
        Sleep    60s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW_Navigate_to_GDM.png    OGW_Navigate_to_GDM      passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW_Navigate_to_GDM.png    OGW_Navigate_to_GDM      failed
        FAIL    OGW_Navigate_to_GDM failed
    END

OGW_Select_GDM_Query_Open and verify icons
    [Arguments]    ${GDM_MainQuery}    ${GDM_SubQuery}

    TRY
    ${loc_GDM_QueryFilter_MainQuery} =    Replace Variables    ${loc_GDM_QueryFilter_MainQuery}  

    # Set GDM locators
    ukw_Set locator values for GDM
   
    # Select Main Query
    GetElementToView   ${loc_GDM_QueryFilter_Button}   GDM_QueryFilter_Button not found
    Sleep   1s  
    GetElementToView   ${loc_GDM_QueryFilter_MainQuery}   GDM_QueryFilter_MainQuery not found    
    Sleep   1s   
    GetelementToView   ${loc_GDM_QueryFilter_SubQuery}   GDM_QueryFilter_SubQuery not found
    Sleep    10s
   
    Generic-Verify page contains element and update report    ${loc_GDM_Icon_FilterFunnel}    Verify FilterFunnel is found
    Generic-Verify page contains element and update report    ${loc_GDM_Icon_QueryBuilder}   Verify QueryBuilder is found
    Generic-Verify page contains element and update report    ${loc_GDM_Icon_Calendar}   Verify Calendar is found
    Generic-Verify page contains element and update report    ${loc_GDM_Icon_LineInfo}     Verify LineInfo is found
    Generic-Verify page contains element and update report    ${loc_GDM_Icon_JobDetails}      Verify JobDetails is found       
    Generic-Verify page contains element and update report    ${loc_GDM_Icon_ZoomIn}  Verify ZoomIn is found
    Generic-Verify page contains element and update report    ${loc_GDM_Icon_ZoomOut}  Verify ZoomOut is found
    Generic-Verify page contains element and update report    ${loc_GDM_Icon_ZoomToFit}  Verify ZoomToFit is found
    Generic-Verify page contains element and update report    ${loc_GDM_Icon_ShowonMap}     Verify ShowonMap is found      
    Generic-Verify page contains element and update report    ${loc_GDM_Icon_MultiRoute}  Verify MultiRoute is found
    Generic-Verify page contains element and update report    ${loc_GDM_Icon_RefreshData}  Verify RefreshData is found
    
    # Open and close GDM Filter
    GetElementToView    ${loc_GDM_Icon_FilterFunnel}   GDM_Icon_FilterFunnel
    Sleep    2s
    ukw_Common.CaptureScreen    ${TEST_NAME}_GDM_Filter.png
    GetElementToView    ${loc_GDM_Icon_FilterFunnel}   GDM_Icon_FilterFunnel
    Sleep    2s

    # Open and close Query builder
    GetElementToView    ${loc_GDM_Icon_QueryBuilder}    GDM_Icon_QueryBuilder 
    Sleep    2s
    ukw_Common.CaptureScreen    ${TEST_NAME}_GDM_QueryBuilder.png
    GetElementToView    ${loc_GDM_Icon_QueryBuilder}   GDM_Icon_QueryBuilder
    Sleep    2s


    # Calendar
    GetElementToView    ${loc_GDM_Icon_Calendar}    GDM_Icon_Calendar
    Sleep    2s
    ukw_Common.CaptureScreen    ${TEST_NAME}_GDM_Calendar.png
    Generic-Verify page contains element and update report    ${loc_GDM_Icon_Calendar_Cancel}     Verify Calendar_Cancel is found      
    Generic-Verify page contains element and update report    ${loc_GDM_Icon_Calendar_Close}     Verify Calendar_Close is found     
    GetElementToView    ${loc_GDM_Icon_Calendar_Cancel}    GDM_Icon_Calendar_Cancel 
    Sleep    2s

    #Settings window
    GetElementToView    ${loc_GDM_Settings}    GDM_Icon_Settings
    Sleep    2s
    Generic-Verify page contains element and update report    ${loc_GDM_Settings_Dialog}     Verify Settings_Dialog is found     
    Generic-Verify page contains element and update report    ${loc_GDM_Settings_HeightTimeBar}     Verify Settings_Height_Time_Bar is found     
    GetElementToView    ${loc_GDM_Settings_Close}    GDM_Settings_Close


    # Select row in GDM
    GetElementToView    ${loc_GDM_SelectCrew_Row1}    GDM_SelectCrew_Row1
    # Click Element    ${loc_GDM_SelectCrew_Row2}
    ukw_Common.CaptureScreen    ${TEST_NAME}_GDM_SelectCrew.png
    # Open and close Multiroute 
    # GetElementToView    ${loc_GDM_Icon_MultiRoute}   GDM_Icon_MultiRoute
    # Sleep    2s
    # ukw_Common.CaptureScreen    ${TEST_NAME}_GDM_MultiRoute.png
    # GetElementToView    ${loc_GDM_MultiRoute_Cancel}   GDM_MultiRoute_Cancel
    # Sleep    2s 
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW_Select_GDM_Query_Open and verify icons.png    OGW_Select_GDM_Query_Open and verify icons     passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW_Select_GDM_Query_Open and verify icons.png    OGW_Select_GDM_Query_Open and verify icons    failed
        FAIL    OGW_Select_GDM_Query_Open and verify icons failed
    END

OGW-Topmenu_UI_Verification
    seleniumlibrary. Switch Browser    ${OGW_Alias}   
    Run Keyword And Continue On Failure    Element Should Be Visible    ${loc_OGW_Topmenu_ListRefresh}
    
    Run Keyword And Continue On Failure    Page Should Contain Element    ${loc_OGW_Topmenu_Username}    OGW_Topmenu_Username not found

    Run Keyword And Continue On Failure    OGW_Click element_VerifyElement exists_Reload page   ${loc_OGW_Topmenu_Chat}    ${loc_OGField_Chat_Status}   IM chat window
    Run Keyword And Continue On Failure    OGW_Click element_VerifyElement exists_Reload page   ${loc_OGW_Topmenu_Mail}   ${loc_OGField_Mail_AddFolder}   Mail add folder 
    Run Keyword And Continue On Failure    OGW_Click element_VerifyElement exists_Reload page   ${loc_OGW_Topmenu_QueryBuilder}    ${loc_OGW_QueryBuilder_Agency}    Query Builder window
    Run Keyword And Continue On Failure    OGW_Click element_VerifyElement exists_Reload page   ${loc_OGW_Topmenu_JobSearch}    ${loc_OGW_JobSearch_Agency}   Job search window
    Run Keyword And Continue On Failure    OGW_Click element_VerifyElement exists_Reload page   ${loc_OGW_NavigationPanel}    ${loc_OGW_Navigate_WorkSpacemanager}   WorkspaceMgr window



OGW_Click element_VerifyElement exists_Reload page
    [Arguments]    ${element}    ${elementToVerify}    ${messg}
    # Reloading Page     OGW    
   TRY
      

        IF    '${messg}' == 'IM chat window'
            Run Keyword And Continue On Failure    Click Element    ${element}
            Sleep   5s        
            Run Keyword And Continue On Failure     Wait Until Element Is Visible    ${elementToVerify}    20s
            Page Should Contain Element    ${elementToVerify}    ${messg} not found  
            CaptureScreen_AddStepsToReport    ${TEST_NAME}_${messg}.png    Verify ${messg} is shown    passed 
            Run Keyword And Continue On Failure    Click Element    ${loc_OGField_Chat_Close}
            Sleep    2s
        ELSE IF    '${messg}' == 'Job search window'
            Run Keyword And Continue On Failure    Click Element    ${element}
            Sleep   5s   
            Switch New window     
            Run Keyword And Continue On Failure     Wait Until Element Is Visible    ${elementToVerify}    20s
            CaptureScreen_AddStepsToReport    ${TEST_NAME}_${messg}.png    Verify ${messg} is shown    passed 
            Page Should Contain Element    ${elementToVerify}    ${messg} not found  
            Sleep    2s
            Close Window
            Switch Main Window
        ELSE IF    '${messg}' == 'WorkspaceMgr window'
            Run Keyword And Continue On Failure    Click Element    ${element}
            Sleep    5s
            Run Keyword And Continue On Failure    Click Element    ${elementToVerify}  
            Sleep    5s 
            Run Keyword And Continue On Failure    Click Element    ${loc_OGW_Navigate_SystemPanel}
            Sleep    2s   
            Run Keyword And Continue On Failure    Click Element    ${loc_OGW_Navigate_WorkSpaceManger_SystemPanel_Dropdown}    
            Run Keyword And Continue On Failure    Select From List By Value    ${loc_OGW_Navigate_WorkSpaceManger_SystemPanel_Select}   ${OGW_WorkspaceMgr_AllLists_Map}
            Sleep    10s
            CaptureScreen_AddStepsToReport    ${TEST_NAME}_${messg}.png    Verify ${messg} is shown    passed 
            Run Keyword And Continue On Failure    Click Element    ${loc_OGW_Navigate_WorkSpaceManger_Close}

        ELSE
            Run Keyword And Continue On Failure    Click Element    ${element}
            Sleep   5s        
            Run Keyword And Continue On Failure     Wait Until Element Is Visible    ${elementToVerify}    20s
            Page Should Contain Element    ${elementToVerify}    ${messg} not found         
        END

            CaptureScreen_AddStepsToReport    ${TEST_NAME}_${messg}.png    Verify ${messg} is shown    passed 

    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_${messg}.png    Verify ${messg} is shown    failed
    END


