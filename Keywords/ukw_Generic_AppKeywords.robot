
*** Settings ***
Resource    ukw_Common.robot

*** Variables ***

*** Keywords ***
ukw_StatusGroup_GetListValues    
    ${StatusGroup}=     ukw_GetValue_FromDB    ${DB_StatusGroup} 
    ${StatusGroup}=      Replace Variables    ${DB_StatusGroup}   #Replace variable from data to env var
    Set Global Variable    ${StatusGroup}
    
    #Get DB value for status group  
    @{queryStatusGroup}=    GetDBValue Listofvalues    ${DBConnect}   ${StatusGroup}         
    ${numberOfStatus}=   Get Length    ${queryStatusGroup}

    # Read DB value if Code=0 append to _listNonOrderedStatus else append to _listOrderedStatus
    FOR    ${counter1}    IN RANGE    0    ${numberOfStatus}        
        Init Status Group    ${queryStatusGroup}[${counter1}]       
    END

    @{ListOfStatus}=    Get List Of Status
    @{ListOfStatusDescription}=    Get List Of Status Description
    @{ListOfActiveStatus}=    Get List Of Active Status
    ${numberOfStatus}=    Get Number Of Status
   
    Set Global Variable    @{ListOfStatus}   
    Set Global Variable    @{ListOfStatusDescription} 
    Set Global Variable    @{ListOfActiveStatus}   
    Set Global Variable    ${numberOfStatus}    


ukw_Get_DB_Crew_Job_Count           
    ${DB_JobsAssigned}=     ukw_GetValue_FromDB    ${DB_CrewJobCount}
    Set Global Variable    ${DB_JobsAssigned}

ukw_GetDispose(Y/N)
    ${DB_DisposeJob_Val}=     ukw_GetValue_FromDB    ${DB_DisposeJob}    
    Set Global Variable    ${DB_DisposeJob}    ${DB_DisposeJob_Val}

ukw_Get_FieldReport_For_Job 
    ${DB_FR_For_JOB}=     ukw_GetValue_FromDB    ${DB_FieldReport_For_Job}
    Set Global Variable    ${DB_FR_For_JOB} 

ukw_Get_OGF_LoginDetails_From_TestData
    Set Global Variable    ${OGF_USER}    ${OGField_User}   #Value from Json Testcase file        
    Set Global Variable    ${CREW}   ${OGField_Crew}    #Value from Json Testcase file        
    Set Global Variable    ${OGF_PWD}   ${OGField_PWD}    #Value from Json Testcase file

ukw_Get_OGF_LoginDetails
    [Arguments]    ${OGF_Query}
    # Get DB value for OGField login user and Crew     
    ${Temp}=    ukw_GetValue_FromDB    ${OGF_Query}
    Set Global Variable    ${OGF_USER}   ${Temp}[0] 
    Set Global Variable    ${CREW}   ${Temp}[1] 
    Set Global Variable    ${SHIFTDATE}   ${Temp}[2] 

ukw_Get_FS_LoginDetails_From_TestData
    Set Global Variable    ${FS_USER}    ${OG_FS_User}   #Value from Json Testcase file        
    Set Global Variable    ${FSCREW}   ${OG_FS_Crew}    #Value from Json Testcase file    


ukw_Get_FS_LoginDetails
    [Arguments]    ${FS_Query}
    # Get DB value for FS login user and Crew 
    ${Temp}=    ukw_GetValue_FromDB    ${FS_Query}
    Set Global Variable    ${FS_USER}   ${Temp}[0] 
    Set Global Variable    ${FSCREW}   ${Temp}[1] 
    ukw_Common.CaptureScreen    ${TEST_NAME}.png

CreateJob_FromMap
    [Arguments]    ${application}
    IF  '${application}' == 'OGF'
        GetElementToView    ${loc_OGField_Map}    OGField_Joblist
        Sleep    15s 
        Set Focus To Element    ${loc_OGField_Map_Canvas}
        Double Click Element    ${loc_OGField_Map_Canvas}
        Sleep     5s
        GetElementToView    ${loc_OGField_Map_CreateJob}    Create job
        Sleep    5s    
        ${CreateJob_JobDetails1} =    Replace Variables    ${CreateJob_JobDetails1} 
        ${thisdict}=    Create Dict From Input    ${CreateJob_JobDetails1}    ,  :  #outer delimeter and inner delimeter 

        Run Keyword And Continue On Failure     OGField-CreateJob_EnterJobDetails    ${thisdict}[TaskType]     ${thisdict}[Jobtype]     ${thisdict}[Address]    ${thisdict}[City]
    ELSE IF  '${application}' == 'OGW'
        Sleep     5s
        # Set Focus To Element    ${loc_OGW_Map_Canvas}
        # GetElementToView    ${loc_OGW_Map_Canvas}    Map_Canvas job        
        # Scroll complete page down using Javascript
        Double Click Element    ${loc_OGW_Map_Canvas}
        ukw_Common.CaptureScreen    ${TEST_NAME}.png
        Sleep     5s
        GetElementToView    ${loc_OGW_Map_CreateJob}    Create job
        Sleep    5s    
        Switch Window    NEW
        ${CreateJob_JobDetails1} =    Replace Variables    ${CreateJob_JobDetails1} 
        ${thisdict}=    Create Dict From Input    ${CreateJob_JobDetails1}    ,  :  #outer delimeter and inner delimeter  
        OGW-CreateJob_EnterJobDetails    ${thisdict}[TaskType]     ${thisdict}[Jobtype]     ${thisdict}[Address]    ${thisdict}[City]
        Switch Window    MAIN
        ${address}=    Convert To Upper Case    ${thisdict}[Address]
        @{Joblist_Qry1}     Split String    ${OGW_JobList_Query_RC_JOBS}    ^    
        OGW-Select Query from Joblist_ClickValue   ${address}     ${Joblist_Qry1}[0]    ${Joblist_Qry1}[1]
        ukw_Common.CaptureScreen    ${TEST_NAME}.png

    END



CrewDetails_CrewMakeup_CloseWindow
    [Arguments]    ${App}
    IF    "${App}" == "OGW"
        GetElementToView    ${loc_OGW_CrewDetails_Close}    OGW_CrewDetails_Close
    END

    IF    "${App}" == "FS"
        GetElementToView    ${loc_FS_CrewDetails_Close}    FS_CrewDetails_Close
    END

    IF    "${App}" == "OGF"
        GetElementToView   ${loc_OGField_CrewMakeUP_Close}    OGField_CrewMakeUP_Close
    END

    Sleep  5s


Calendar-SelectStartDate   
    [Arguments]    ${mm}    ${dd}    ${yyyy}    ${hh}    ${ss}
    ukw_Common.CaptureScreen    ${TEST_NAME}.png
    Execute Javascript    document.querySelector("#page-main > div.ui-datebox-container.ui-overlay-shadow.ui-corner-all.pop.ui-body-b.in > span > div.ui-datebox-align.ui-datebox-dboxin.ui-grid-d > div.ui-block-a > input").value=${mm}
    Execute Javascript    document.querySelector("#page-main > div.ui-datebox-container.ui-overlay-shadow.ui-corner-all.pop.ui-body-b.in > span > div.ui-datebox-align.ui-datebox-dboxin.ui-grid-d > div.ui-block-b > input").value=${dd}
    Execute Javascript    document.querySelector("#page-main > div.ui-datebox-container.ui-overlay-shadow.ui-corner-all.pop.ui-body-b.in > span > div.ui-datebox-align.ui-datebox-dboxin.ui-grid-d > div.ui-block-c > input").value=${yyyy}
    Execute Javascript    document.querySelector("#page-main > div.ui-datebox-container.ui-overlay-shadow.ui-corner-all.pop.ui-body-b.in > span > div.ui-datebox-align.ui-datebox-dboxin.ui-grid-d > div.ui-block-d > input").value=${hh}
    Execute Javascript    document.querySelector("#page-main > div.ui-datebox-container.ui-overlay-shadow.ui-corner-all.pop.ui-body-b.in > span > div.ui-datebox-align.ui-datebox-dboxin.ui-grid-d > div.ui-block-e > input").value=${ss}
    ukw_Common.CaptureScreen    ${TEST_NAME}.png
    Click Element     ${loc_OGField_Agenda_DateControl_Ok}   
    Sleep    2s


Calendar-SelectEndDate   
    [Arguments]    ${mm}    ${dd}    ${yyyy}    ${hh}    ${ss}
    ukw_Common.CaptureScreen    ${TEST_NAME}.png
    Execute Javascript    document.querySelector("#page-main > div.ui-datebox-container.ui-overlay-shadow.ui-corner-all.pop.ui-body-b.in > span > div.ui-datebox-align.ui-datebox-dboxin.ui-grid-d > div.ui-block-a > input").value=${mm}
    Execute Javascript    document.querySelector("#page-main > div.ui-datebox-container.ui-overlay-shadow.ui-corner-all.pop.ui-body-b.in > span > div.ui-datebox-align.ui-datebox-dboxin.ui-grid-d > div.ui-block-b > input").value=${dd}
    Execute Javascript    document.querySelector("#page-main > div.ui-datebox-container.ui-overlay-shadow.ui-corner-all.pop.ui-body-b.in > span > div.ui-datebox-align.ui-datebox-dboxin.ui-grid-d > div.ui-block-c > input").value=${yyyy}
    Execute Javascript    document.querySelector("#page-main > div.ui-datebox-container.ui-overlay-shadow.ui-corner-all.pop.ui-body-b.in > span > div.ui-datebox-align.ui-datebox-dboxin.ui-grid-d > div.ui-block-d > input").value=${hh}
    Execute Javascript    document.querySelector("#page-main > div.ui-datebox-container.ui-overlay-shadow.ui-corner-all.pop.ui-body-b.in > span > div.ui-datebox-align.ui-datebox-dboxin.ui-grid-d > div.ui-block-e > input").value=${ss}
    ukw_Common.CaptureScreen    ${TEST_NAME}.png
    Click Element     ${loc_OGField_Agenda_DateControl_Ok}   
    Sleep    2s
    
Generic-Click element if shown
    [Arguments]    ${element}
    ${elem_exist}    Run Keyword And Return Status  Page Should Contain Element  ${element}
    IF    '${elem_exist}' == 'True'
        GetElementToView    ${element}    ${element}
        Sleep    2s
    END

Generic-Verify page contains element
    [Arguments]    ${element}
    ${elem_exist}    Run Keyword And Return Status  Page Should Contain Element  ${element}
    IF    '${elem_exist}' == 'True'
        RETURN    True
    END

Generic-Verify page contains element and update report
    [Arguments]    ${element}    ${report_messg}

    ${elem_exist}    Run Keyword And Return Status  Page Should Contain Element  ${element}
    IF    '${elem_exist}' == 'True'
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_${report_messg}_.png    ${report_messg}    passed
    ELSE
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_${report_messg}.png    ${report_messg}    failed
        FAIL    ${report_messg}   failed
    END

Generic-Create_job_and_assign_job_to_the_crew
    [Arguments]    ${jobtype}    ${crew}
    API_CreateSingleJob
    Log      Job number created - ${JOBNUMBER}
    API_Create_TempFile_ForAssignJobToCrew    ${crew}   ${JOBNUMBER}
    API_AssignJobToCrew 

Generic-Joblist_Crewlist_Query not found
     # NOJOBLISTDEFQUERY -Job list default query no longer exists - Please contact Admin message
    ${Sys_messg}=     ukw_GetValue_FromDB_CAD_Parameter     NOJOBLISTDEFQUERY    ${DB_SYSTEMMESSAGE} 
    Set Global Variable    ${Sys_messg}    ${Sys_messg}
    ${loc_OGField_System_Notification}=    Replace Variables    ${loc_OGField_System_Notification}
    ${elem_exist}    Run Keyword And Return Status  Page Should Contain Element  ${loc_OGField_System_Notification}        
    IF    '${elem_exist}' == 'True'
        Generic-Click element if shown    ${loc_OGField_Acknowledge}   
    END   


    # NOSYSDEFQUERY -Set system default query no longer exists - Please contact Admin
    ${Sys_messg}=     ukw_GetValue_FromDB_CAD_Parameter     NOSYSDEFQUERY    ${DB_SYSTEMMESSAGE} 
    Set Global Variable    ${Sys_messg}    ${Sys_messg}
    ${loc_OGField_System_Notification}=    Replace Variables    ${loc_OGField_System_Notification}
    ${elem_exist}    Run Keyword And Return Status  Page Should Contain Element  ${loc_OGField_System_Notification}        
    IF    '${elem_exist}' == 'True'
        Generic-Click element if shown    ${loc_OGField_Acknowledge}   
    END 

    ${elem_exist}    Run Keyword And Return Status  Page Should Contain Element  ${loc_OGField_General_Notification}        
    IF    '${elem_exist}' == 'True'
        Generic-Click element if shown    ${loc_OGField_Acknowledge}   
    END 
    
    
    Generic-Click element if shown    ${loc_OGField_Acknowledge}  
    Generic-Click element if shown    ${loc_OGField_Acknowledge}

InitializeTest_CustomReport_LoadTestcaseData    
    [Arguments]     ${test_name}    ${testdata_reference}      ${customreport_index}    ${customreport_testname}     
    
    InitializeTest    ${test_name}    ${testdata_reference}     
    
    Custom Report Settings Before Execution     ${customreport_index}    ${customreport_testname}
    
    Load_Access_Testcase_JSON_File

InitializeTest_CustomReport 
    [Arguments]     ${test_name}    ${testdata_reference}      ${customreport_index}    ${customreport_testname}     
    
    InitializeTest     ${test_name}    ${testdata_reference}    
    
    Custom Report Settings Before Execution     ${customreport_index}    ${customreport_testname}      
    
    Load_Access_Testcase_JSON_File