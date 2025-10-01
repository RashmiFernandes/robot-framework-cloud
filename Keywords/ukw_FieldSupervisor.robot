*** Settings ***
Resource    ukw_Common.robot
Library    RPA.Netsuite

*** Keywords ***
Get_FieldSupervisor_LoginDetails_LoginToApp
    [Arguments]    ${LoginUser_Query}
    ukw_Generic_AppKeywords.ukw_Get_FS_LoginDetails    ${LoginUser_Query}

    ukw_Common.Open Browser to test    ${OGF_URL}   ${WebBrowser}   ${OGF_Alias}
    OGField-Login To FS    ${FS_USER}    ${FS_PWD}
    # Sleep  20s
 
    ${browserHeight}=   Execute JavaScript    return window.innerHeight
    ${pageHeight}=   Execute JavaScript    return document.body.scrollHeight  
    Set Global variable  ${browserHeight}
    Set Global variable  ${pageHeight}

    OGField-Handle System Messages for Login     ${user}    FS

    OGField-Open Navigation Panel
    OGField-Click menu from NavigationPanel    ${loc_OGField_Home_FieldSupervisor}
    OGField-Handle System Messages for Login     ${user}    FS
    Sleep  5s

    Generic-Joblist_Crewlist_Query not found

Get_FieldSupervisor_LoginDetails_LoginToApp_UsingValue_FromGlobalData
    ukw_Generic_AppKeywords.ukw_Get_FS_LoginDetails_From_TestData
    
    ukw_Common.Open Browser to test    ${OGF_URL}   ${WebBrowser}   ${OGF_Alias}
    
    OGField-Login To FS    ${FS_USER}    ${FS_PWD}
    Sleep  20s
    OGField-Open Navigation Panel
    OGField-Click menu from NavigationPanel    ${loc_OGField_Home_FieldSupervisor}
    OGField-Handle System Messages for Login     ${user}    FS

OGField-Login To FS
    [Arguments]    ${user}    ${password}
    TRY
        Wait Until Element Is Visible    ${loc_OGField_Username}    10s
        Clear Element Text    ${loc_OGField_Username}
        Input Text    ${loc_OGField_Username}    ${user}
        Clear Element Text    ${loc_OGField_Password}
        Input Text    ${loc_OGField_Password}    ${password}
        Sleep    3s
        GetElementToView    ${loc_OGField_Agree}    OGField_Agree
        # Sleep    1s
        Click Button    ${loc_OGField_Login}
        Sleep    10s

        ${elem_exist}    Run Keyword And Return Status   Page Should Contain Element   ${loc_OGField_SelectShift}
        IF    '${elem_exist}' == 'True'
            Run Keyword And Continue On Failure    ukw_OGField.OGField-Select Shift Date
            Sleep    50s 
        END  
          
        
        ukw_Common.CaptureScreen    ${TEST_NAME}_FS-Login To OGField.png
        Wait Until Element Is Visible    ${loc_OGField_ConnectivityStatus_Online}    200s    
        Page should Contain Element    ${loc_OGField_ConnectivityStatus_Online}    OGField is not online  
        OGField-Handle System Messages for Login        ${user}   FS  
        OGField-Open Navigation Panel
        OGField-Click menu from NavigationPanel    ${loc_OGField_Home_FieldSupervisor}
        OGField-Handle System Messages for Login        ${user}   FS 
        Wait Until Element Is Visible    ${loc_FS_JobList_SelectQuery1}    120s        
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_FS-Login To OGField.png   FS-Login to Field Supervisor    passed
        
    EXCEPT 
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_FS-Login To OGField.png   FS-Login to Field Supervisor     failed 
        Close Browser   
        FAIL     FS_Homepage not loaded
    END

FS-Get_FS_QueryNames
    [Arguments]    ${Joblist_Qry1}    ${Crewlist_Qry}    ${Assignmentlist_Qry1}    
    
    IF    "${Joblist_Qry1}" != "None"
        @{FS_Joblist_Qry1}=     Split String    ${Joblist_Qry}    ^
        set global variable    @{FS_Joblist_Qry1}    @{FS_Joblist_Qry1}
    END

    IF    "${Crewlist_Qry}" != "None"
        @{FS_Crewlist_Qry1}=     Split String    ${Crewlist_Qry}    ^
        set global variable    @{FS_Crewlist_Qry1}    @{FS_Crewlist_Qry1}
    END


    IF    "${Assignmentlist_Qry1}" != "None"
        @{FS_Assignmentlist_Qry1}=     Split String    ${Assignmentlist_Qry}    ^
        set global variable    @{FS_Assignmentlist_Qry1}    @{FS_Assignmentlist_Qry1}
    END

#------Joblist-----------
FS-Select Joblist Query
    [Arguments]    ${FS_JobQuery}    ${FS_JobQueryName}
    TRY
        Wait Until Element Is Visible    ${loc_FS_JobList_SelectQuery1}        60s 
        GetElementToView    ${loc_FS_JobList_SelectQuery1}    FS_JobList_SelectQuery1
        
        ${loc_FS_JobList_SelectQuery2}=    Replace Variables    ${loc_FS_JobList_SelectQuery2}
        GetElementToView    ${loc_FS_JobList_SelectQuery2}    FS_JobList_SelectQuery2

        ${loc_FS_JobList_QueryName}=    Replace Variables     ${loc_FS_JobList_QueryName}   
        GetElementToView    ${loc_FS_JobList_QueryName}    FS_JobList_QueryName
        Sleep    2s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select Joblist Query.png    FS-Select Joblist query    passed

    EXCEPT    
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Select Joblist Query.png    FS-Select Joblist query    failed
        FAIL   Verify if Joblist query ${FS_JobQuery}    ${FS_JobQueryName} exists
    END
    

FS-Select row in Joblist
    [Arguments]    ${data}
    TRY
        ${loc_FS_Joblist_JobCheckbox}=     Replace Variables    ${loc_FS_Joblist_JobCheckbox}
        GetElementToView    ${loc_FS_Joblist_JobCheckbox}    FS_Joblist_JobCheckbox
        CaptureScreen_AddStepsToReport   ${TEST_NAME}_Select row in Joblist.png    FS-Select row in joblist    passed
    EXCEPT
        CaptureScreen_AddStepsToReport   ${TEST_NAME}_Select row in Joblist.png    FS-Select row in joblist    failed
        FAIL    "Verify Topmenu JobCount Increased By One failed"
    END
    

FS-Refresh Joblist
    GetElementToView    ${loc_FS_JobList_Refresh}    FS_JobList_Refresh
    Sleep    2s
	
FS-Verify value in Joblist
    [Arguments]    ${data}
    TRY
        Element Should Contain    ${loc_FS_JoblistTableText}    ${data}
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Joblist.png   FS-Joblist contain ${data}      passed
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Joblist.png   FS-Joblist contain ${data}      failed
        # FAIL    FS-Job list contain ${data} failed
    END
	
FS-Click Joblist links
    [Arguments]    ${data}
    IF    "${data}" == "Next Status"
        GetElementToView    ${loc_FS_JobList_NextStatus}    FS_JobList_NextStatus
    ELSE
        GetElementToView    ${loc_FS_JobList_JobDetails}    FS_JobList_JobDetails
    END

    Sleep    2s

FS-Joblist_AssignJob
        GetElementToView    ${loc_FS_JobList_Assign}    FS_JobList_Assign
        Generic-Click element if shown    ${loc_OGField_Yes}
        Generic-Click element if shown    ${loc_OGField_AcceptAll}
        Wait Until Element Is Visible    ${loc_OGField_GritterMessage_AssignmentCompleted}    60s
        Sleep    10s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Joblist_Assign.png   FS-Joblist_AssignJob     passed

	
FS-Search_Select_Job from Joblist
    [Arguments]    ${data}    ${FS_JobQuery}  ${FS_JobQueryName}
    Sleep    1s
    FS-Select Joblist Query    ${FS_JobQuery}    ${FS_JobQueryName}
    FS-Enter Joblist Wildcard details    ${data}
    FS-Select row in Joblist    ${data}
    ukw_Common.CaptureScreen    ${TEST_NAME}_Select Job from Joblist.png

FS-Enter Joblist Wildcard details
    [Arguments]    ${data}
    TRY
        Wait Until Element Is Visible    ${loc_FS_JobListWildcard_Text}    60s
        Input Text    ${loc_FS_JobListWildcard_Text}    ${data}
        GetElementToView    ${loc_FS_JobListWildcard_OK}    OGW_JobListWildcard_OK
        Sleep    5s
        ${loc_FS_JoblistTableText}=    Replace Variables    ${loc_FS_JoblistTableText}
        Page Should Contain Element    ${loc_FS_JoblistTableText}    Job ${data} not found in Joblist
        
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Enter Joblist Wildcard details.png   FS-Enter Joblist Wildcard details    passed

    EXCEPT 
	    CaptureScreen_AddStepsToReport    ${TEST_NAME}_Enter Joblist Wildcard details.png   FS-Enter Joblist Wildcard details    failed
        Close Browser   
        FAIL     FS-Enter Joblist Wildcard details failed
    END

FS-Select Query from Joblist
    [Arguments]    ${data}    ${FS_JobQuery}  ${FS_JobQueryName}
    Sleep    1s
    FS-Select Joblist Query    ${FS_JobQuery}    ${FS_JobQueryName}
    Sleep   5s
    FS-Select row in Joblist    ${data}

FS-Select Query from Joblist_ClickValue
    [Arguments]    ${data}    ${FS_JobQuery}  ${FS_JobQueryName}  
    Sleep    1s
    FS-Select Joblist Query    ${FS_JobQuery}    ${FS_JobQueryName}
    Sleep   5s
    ${loc_FS_JoblistTableText}=    Replace Variables    ${loc_FS_JoblistTableText}

    GetElementToView    ${loc_FS_JoblistTableText}    ${data} not found in Joblist
    ukw_Common.CaptureScreen    ${TEST_NAME}_Select ${data} in Joblist.png
	
FS_CreateJob_FromJoblist_JobDetails
    # Create job through Job/FR-Job Details
    TRY
        GetElementToView    ${loc_FS_JobList_JobDetails}    FS_JobList_JobDetails
        Sleep    5s
        ${CreateJob_JobDetails1} =    Replace Variables    ${CreateJob_JobDetails1} 
        ${thisdict}=    Create Dict From Input    ${CreateJob_JobDetails1}    ,  :  #outer delimeter and inner delimeter     
        
        Run Keyword And Continue On Failure     FS-CreateJob_EnterJobDetails    ${thisdict}[TaskType]     ${thisdict}[Jobtype]     ${thisdict}[Address]    ${thisdict}[City]
        @{FS_Joblist_Qry1}    Split String    ${FS_JobList_Query_ALL_JOBS_TODAY}    ^
        FS-Select Query from Joblist_ClickValue    ${address}    ${FS_Joblist_Qry1}[0]    ${FS_Joblist_Qry1}[1]
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_FS_CreateJob_FromJoblist_JobDetails.png   FS_CreateJob_FromJoblist_JobDetails    passed

    EXCEPT 
	    CaptureScreen_AddStepsToReport    ${TEST_NAME}_FS_CreateJob_FromJoblist_JobDetails.png   FS_CreateJob_FromJoblist_JobDetails    failed
        Close Browser   
        FAIL     FS_CreateJob_FromJoblist_JobDetails failed
    END


	
FS_CreateJob_Map_CreateSupervisorjob        
    ${CreateJob_JobDetails1} =    Replace Variables    ${CreateJob_JobDetails1} 
    ${thisdict}=    Create Dict From Input    ${CreateJob_JobDetails1}    ,  :  #outer delimeter and inner delimeter   

    Double Click Element    ${loc_FS_Map_Canvas}
    Sleep     5s
    GetElementToView    ${loc_FS_Map_CreateSupervisorJob}    Create Supervisor job
    Sleep    5s  
    
    Run Keyword And Continue On Failure     FS-CreateJob_EnterJobDetails    ${thisdict}[TaskType]     ${thisdict}[Jobtype]     ${thisdict}[Address]    ${thisdict}[City]
    @{FS_Joblist_Qry1}    Split String    ${FS_JobList_Query_ALL_JOBS_TODAY}    ^
    FS-Select Query from Joblist_ClickValue    ${address}    ${FS_Joblist_Qry1}[0]    ${FS_Joblist_Qry1}[1]
	
FS-CreateJob_EnterJobDetails
    [Arguments]    ${tasktype}    ${jobtype}    ${address}    ${citycode}    
    GetElementToView    ${loc_FS_JobDetails_JobDetailsTAB}   Job Details TAB 
    # Enter agency first
    GetElementToView    ${loc_OGField_JobDetails_AdditionalInfoTAB}   AdditionalInfo TAB 

    Set Global Variable    ${Agency}    ${Agency1}
    Select From List By value     ${loc_FS_JobDetails_Agency}    ${Agency}
    Select From List By Index    ${loc_FS_TaskType}    1
    Sleep    1s
    Select From List By Index     ${loc_FS_Jobtype_WorkCode}   2
    Sleep    1s
    ${address}=    Generate Random String    5    [LETTERS]
    Input Text    ${loc_FS_JobDetails_Address}    ${address}
    ${address}=    Convert To Upper Case    ${address}
    set global variable    ${address}    ${address}
    Select From List By index    ${loc_FS_CityCode}    ${citycode}
    ukw_Common.CaptureScreen    ${TEST_NAME}_FS-Createjob.png

    OGField-JobDetails_EnterUDF14
    getElementToView    ${loc_FS_JobDetails_Save}    FS_JobDetails_Save
    Sleep    5s
    ukw_Common.CaptureScreen    ${TEST_NAME}_FS-Createjob.png

#------Crewlist-----------

FS-Select Crewlist Query
    [Arguments]    ${CrewList_SelectQuery2}    ${CrewListQueryName}
    ukw_common.Scroll complete page up using Javascript
    Wait Until Element Is Visible    ${loc_FS_CrewList_SelectQuery1}
    Scroll Element Into View    ${loc_FS_CrewList_SelectQuery1}
    GetElementToView    ${loc_FS_CrewList_SelectQuery1}    FS_CrewList_SelectQuery dropdown
    ${loc_FS_CrewList_SelectQuery2}=    Replace Variables    ${loc_FS_CrewList_SelectQuery2}
    GetElementToView    ${loc_FS_CrewList_SelectQuery2}    FS_CrewList_SelectQuery2

    ${loc_FS_CrewList_QueryName}=    Replace Variables    ${loc_FS_CrewList_QueryName}
    GetElementToView    ${loc_FS_CrewList_QueryName}    FS_CrewList_QueryName
    Sleep    2s

FS-Refresh Crewlist
    ${position}=    Get Element Attribute    ${loc_FS_CrewList_Refresh}    clientTop
    ${new_position}=    Evaluate    ${position} - 100
    Execute Javascript    window.scrollTo(0, ${new_position})

    GetElementToView    ${loc_FS_CrewList_Refresh}    FS_CrewList_Refresh
    Sleep    2s

FS-Verify value in Crewlist
    [Arguments]    ${data}    
    TRY
        Element Should Contain    ${loc_FS_CrewList_TableText}    ${data}
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Crewlist.png   FS-Crewlist contain ${data}      passed
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Crewlist.png   FS-Crewlist contain ${data}      passed
        # FAIL    FS-Crew list contain ${data} failed
    END
	
FS-Enter Crewlist Wildcard details
    [Arguments]    ${data}
    Wait Until Element Is Visible     ${loc_FS_CrewListWildcard_Text}    60s
    Input Text    ${loc_FS_CrewListWildcard_Text}    ${data}
    GetElementToView    ${loc_FS_CrewListWildcard_OK}    FS_CrewListWildcard_OK
    Sleep    2s
    Page Should Contain Element    ${loc_OGW_CrewList_TableRow1}    Crew ${data} not found in Crewlist
    

FS-Select row in Crewlist
    [Arguments]    ${data}
    ${loc_FS_CrewList_TableText}=    Replace Variables    ${loc_FS_CrewList_TableText}
    GetElementToView    ${loc_FS_CrewList_TableText}    FS_CrewList_TableText-${data}
    Sleep    3s
    Generic-Click element if shown    ${loc_FS_CrewListWildcard_Cancel}

FS-SearchCrew_From_Crewlist
    [Arguments]    ${data}	${FS_CrewQuery}    ${FS_CrewQueryName}
    FS-Select Crewlist Query    ${FS_CrewQuery}    ${FS_CrewQueryName}
    FS-Enter Crewlist Wildcard details    ${data}
    FS-Select row in Crewlist    ${data}

FS-Click Crewlist links
    [Arguments]    ${data}
    IF    "${data}" == "Open"
        GetElementToView    ${loc_FS_JobList_NestStatus}    FS_Crewlist_Open
    END
    Sleep    2s

#------Assignmentlist-----------
FS-Refresh AssignmentList
    GetElementToView    ${loc_FS_AssignmentList_Refresh}    FS_AssignmentList_Refresh
    Sleep    2s

FS-Verify value in AssignmentList
    [Arguments]    ${data}    
    
    TRY
        Element Should Contain    ${loc_FS_AssignmentList_TableText}    ${data}
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Assignmentlist.png   FS-Assignment list contain ${data}      passed
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Assignmentlist.png   FS-Assignment list contain ${data}      failed
        # FAIL    FS-Assignment list contain ${data} failed
    END

FS-Select row in Assignmentlist
    [Arguments]    ${data}
    ${loc_FS_AssignmentList_TableValue}=    Replace Variables    ${loc_FS_AssignmentList_TableValue}
    GetElementToView    ${loc_FS_AssignmentList_TableText}    FS_AssignmentList_TableText-${data}

FS-SearchValue_From_Assignmentlist
    [Arguments]    ${data}	${FS_CrewQuery}    ${FS_CrewQueryName}
    # FS-Select Crewlist Query    ${FS_CrewQuery}    ${FS_CrewQueryName}
    # FS-Enter Crewlist Wildcard details    ${data}
    FS-Select row in Assignmentlist    ${data}

FS-Verify values in Joblist Crewlist Assignmentlist
    [Arguments]    ${job}    ${joblist}    ${crewlist}    ${assignmentlist}
    Scroll Element Into View    ${loc_FS_JobList_SelectQuery1}
    FS-Refresh Joblist
    IF    "${joblist}" != "None"      
        Execute Javascript    window.scrollTo(0,1500)
        FS-Verify value in Joblist    ${joblist}
        ukw_Common.Scroll complete page up using Javascript
    END
    FS-Refresh Crewlist
    IF    "${crewlist}" != "None"
        FS-Verify value in Crewlist    ${crewlist}
    END
    FS-Refresh AssignmentList
    IF    "${assignmentlist}" != "None"
        FS-Verify value in AssignmentList    ${assignmentlist}
    END
# ================================

FS-SearchJob_SearchCrew_AssignJob
    # Search Job in FS Joblist
    @{FS_Joblist_Qry1}    Split String    ${FS_JobList_Query_SEARCHJOB}    ^
    FS-Search_Select_Job from Joblist    ${JOBNUMBER}    ${FS_Joblist_Qry1}[0]    ${FS_Joblist_Qry1}[1]

    # Search Crew in FS Crewlist
    @{FS_Crewlist_Qry1}    Split String    ${FS_CrewList_Query_SEARCHCREW}    ^
    FS-SearchCrew_From_Crewlist    ${CREW}    ${FS_Crewlist_Qry1}[0]    ${FS_Crewlist_Qry1}[1]

    FS-Joblist_AssignJob    


# ====== Crew Details ==='
FS-SearchCrew_OpenCrewDetails
    [Arguments]    ${FS_USER}    ${FS_CrewQuery}    ${FS_CrewQueryName}
    FS-SearchCrew_From_Crewlist   ${FS_USER}    ${FS_Crewlist_Qry1}[0]    ${FS_Crewlist_Qry1}[1]
    GetElementToView    ${loc_FS_CrewList_Open}   Crew open details
    Sleep    10s














