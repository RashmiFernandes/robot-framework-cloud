*** Settings ***
Resource    ukw_Common.robot
# Library    stat


*** Variables ***
${newdate}      defaultvalue


*** Keywords ***
Get_OGField_LoginDetails_LoginToApp
    [Arguments]    ${data}    ${LoginUser_Query}
    ukw_Generic_AppKeywords.ukw_Get_OGF_LoginDetails   ${LoginUser_Query} 

    #Open browser and login to OGField
    ukw_Common.Open Browser to test    ${OGF_URL}   ${WebBrowser}    ${OGF_Alias}
    
    OGField-Login To OGField    ${OGF_USER}    ${OGF_PWD}

    IF    '${data}' == 'DutyOn'
        OGField-Perform DutyOn in OGField
    ELSE IF    '${data}' == 'DutyOff'
        OGField-Perform DutyOff in OGField
    ELSE IF    '${data}' == 'DonotDutyOn_Off'
        Log to console   "Do nothing"
    END

Get_OGField_LoginDetails_LoginToApp_UsingValue_FromGlobalData
    [Arguments]    ${data}
    ukw_Generic_AppKeywords.ukw_Get_OGF_LoginDetails_From_TestData
    
    #Open browser and login to OGField
    ukw_Common.Open Browser to test    ${OGF_URL}   ${WebBrowser}    ${OGF_Alias} 

    OGField-Login To OGField    ${OGF_USER}    ${OGF_PWD}

    IF    '${data}' == 'DutyOn'
        OGField-Perform DutyOn in OGField
    ELSE IF    '${data}' == 'DutyOff'
        OGField-Perform DutyOff in OGField
    ELSE IF    '${data}' == 'DonotDutyOn_Off'
        Log to console   "Do nothing"
    END

OGField-Login To OGField
    [Arguments]    ${user}    ${password}
    TRY
        SeleniumLibrary.Wait Until Element Is Visible    ${loc_OGField_Username}    10s
        Clear Element Text    ${loc_OGField_Username}
        Input Text    ${loc_OGField_Username}    ${user}
        Clear Element Text    ${loc_OGField_Password}
        Input Text    ${loc_OGField_Password}    ${password}
        Sleep    3s
        GetElementToView    ${loc_OGField_Agree}    OGField_Agree
        # Sleep    1s
        Click Button    ${loc_OGField_Login}
        Sleep    10s
        SeleniumLibrary.Wait Until Element Is Not Visible    ${loc_OGField_Login}    10s
        Sleep    5s 

        ${elem_exist}    Run Keyword And Return Status   Page Should Contain Element    ${loc_OGField_SelectShift}
        IF    '${elem_exist}' == 'True'
            Run Keyword And Continue On Failure    ukw_OGField.OGField-Select Shift Date
            Sleep    50s 
        END        

        # Verify OGField is Online, click Joblist and select required joblist query            
        OGField-Handle System Messages for Login     ${user}    OGF
        Wait Until Element Is Visible    ${loc_OGField_ConnectivityStatus_Online}    200s
        Generic-Verify page contains element and update report   ${loc_OGField_ConnectivityStatus_Online}    Verify OGField is online

        Wait Until Element Is Visible   ${loc_OGField_Joblist}    150s
        OGField-Handle System Messages for Login     ${user}    OGF
        GetElementToView    ${loc_OGField_Joblist}    OGField_Joblist
        OGField-Handle System Messages for Login     ${user}    OGF
        Sleep    10s 

        GetElementToView    ${loc_OGField_Home_JobsDropdown1}    OGField_Home_JobsDropdown1
        ${loc_OGField_Home_JobsDropdown2}=    Replace Variables    ${loc_OGField_Home_JobsDropdown2} 
        GetElementToView    ${loc_OGField_Home_JobsDropdown2}    OGField_Home_JobsDropdown2
        ${loc_OGField_Home_JobsDropdown3}=    Replace Variables    ${loc_OGField_Home_JobsDropdown3}
        GetElementToView    ${loc_OGField_Home_JobsDropdown3}    OGField_Home_JobsDropdown3      
            
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Login To OGField2.png   OGField-Login To OGField    passed

    EXCEPT 
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Login To OGField2.png    OGField-Login To OGField    failed
        Close Browser   
        FAIL     Login To OGField failed
    END

OGField-Logout from OGField
    TRY
        seleniumlibrary. Switch Browser    ${OGF_Alias}    
        OGField-Click OGField Topmenu links    NavigationPanel Open
        GetElementToView    ${loc_OGField_Home_Logout}    OGField_Home_Logout
        Generic-Click element if shown    ${loc_OGField_No}  
        Sleep    2s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Logout from OGField.png     OGField-Logout from OGField    passed

    EXCEPT 
        CaptureScreen_AddStepsToReport   ${TEST_NAME}_OGField-Logout from OGField.png    OGField-Logout from OGField    failed
        Close Browser   
        FAIL     Logout from OGField failed
    END
#    =====================================================================================================================================================

 OGField-Handle System Messages for Login
    [Arguments]    ${user}    ${app_name}
    Sleep   50s
    
    Set global variable    ${user}    ${user}
    #  # BOS message - Get the value of the system parameter from DB
    IF    '${app_name}' == 'OGF'        
        ${DB_SYSTEMPARAMETER_VALUE}=    Replace variables    ${DB_SYSTEMPARAMETER_VALUE}
        ${DB_BOSValue}=     ukw_GetValue_FromDB_CAD_Parameter     SHOWBOSFORM    ${DB_SYSTEMPARAMETER_VALUE}
    ELSE        
        ${DB_SYSTEMPARAMETER_VALUE_FSUSER}=     Replace variables   ${DB_SYSTEMPARAMETER_VALUE_FSUSER}
        ${DB_BOSValue}=     ukw_GetValue_FromDB_CAD_Parameter     SHOWBOSFORM    ${DB_SYSTEMPARAMETER_VALUE_FSUSER}
        
    END        
    
    IF   '${DB_BOSValue}' == 'Y'
        Generic-Click element if shown    ${loc_OGField_Login_BOS}
        Sleep    2s        
    END
    
    Generic-Click element if shown    ${loc_OGField_SafetyMessage_OK}
    Sleep    2s
    Generic-Click element if shown    ${loc_OGField_Timesheet_OK}
    Sleep    5s
    Generic-Click element if shown    ${loc_OGField_SafetyMessage_OK}
    Sleep    2s
    Generic-Click element if shown    ${loc_OGField_SafetyMessage_OK}
    Sleep    2s
    
    Generic-Joblist_Crewlist_Query not found

    Generic-Click element if shown    ${loc_OGField_VehicleMileage_Cancel}
    Generic-Click element if shown    ${loc_OGField_SafetyMessage_OK}
    Sleep    2s

OGField-Select Shift Date
    GetElementToView    ${loc_OGField_SelectShift}    OGField_SelectShift
    ${date}    Get Current Date
    ${newdate}    ConvertDate_MM_DD_YYYY    ${date}
    # ${newdate} =    Convert Date    ${date}    result_format=%d/%m/%Y
    ${loc_OGField_SelectShiftDate}=    Replace Variables    ${loc_OGField_SelectShiftDate}   # M/D/YYYY
    GetElementToView    ${loc_OGField_SelectShiftDate}    OGField_SelectShiftDate
    GetElementToView    ${loc_OGField_SelectShift_Continue}    OGField_SelectShift_Continue
    CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Select Shift Date.png    OGField-Select Shift Date    passed

OGField-Click OGField Topmenu links
    [Arguments]    ${data}

    # Click required OGField Topmenu link
    IF    "${data}" == "Joblist"
        Generic-Verify page contains element and update report    ${loc_OGField_Joblist}    Verify OGField_Topmenu_Joblist is found
        GetElementToView    ${loc_OGField_Joblist}    OGField_Joblist
        ${elem_exist}    Run Keyword And Return Status    Page Should Contain Element  ${loc_OGField_LoginJoblistDefaultQuery}
        IF    '${elem_exist}' == 'True'
            Generic-Click element if shown    ${loc_OGField_Acknowledge}   
        END   
    ELSE IF    "${data}" == "NavigationPanel Open"
        Generic-Verify page contains element and update report   ${loc_OGField_NavigationPanel_Open}    Verify OGField_Topmenu_NavigationPanel is found
        GetElementToView    ${loc_OGField_NavigationPanel_Open}    OGField_NavigationPanel_Open
    ELSE IF    "${data}" == "NavigationPanel Close"
        Generic-Verify page contains element and update report    ${loc_OGField_NavigationPanel_Close}      is found
        GetElementToView    ${loc_OGField_NavigationPanel_Close}    OGField_NavigationPanel_Close
    ELSE IF    "${data}" == "Mail"
        Generic-Verify page contains element and update report    ${loc_OGField_Mail}    Verify OGField_Topmenu_Mail is found
        GetElementToView    ${loc_OGField_Mail}    OGField_Mail
    ELSE IF    "${data}" == "Map"
        Generic-Verify page contains element and update report    ${loc_OGField_Map}        Verify OGField_Topmenu_Map is found
        GetElementToView    ${loc_OGField_MapAssetSearch}    OGField_MapAssetSearch
    ELSE IF    "${data}" == "Panic"
        Generic-Verify page contains element and update report    ${loc_OGField_Panic}        Verify OGField_Topmenu_Panic is found
        GetElementToView    ${loc_OGField_Panic_Yes}    OGField_Panic_Yes
    ELSE IF    "${data}" == "Panic"
        Generic-Verify page contains element and update report    ${loc_OGField_Chat}        Verify OGField_Topmenu_Chat is found
        GetElementToView    ${loc_OGField_Chat_Status}    OGField_Chat_Status
    END
    Sleep    5s
    CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Topmenu${data}.png    OGField-Click OGField Topmenu-${data}    passed


OGField-Perform DutyOn in OGField 
    # Open Navigation Panel and perfrom Duty on 
    TRY        
        OGField-Open Navigation Panel
        Generic-Click element if shown    ${loc_OGField_DutyIn} 
        
        Sleep    5s

        ${elem_exist}    Run Keyword And Return Status  Page Should Contain Element  ${loc_OGField_NavigationPanel_Close}
        IF    '${elem_exist}' == 'True'
            Run Keyword    OGField-Click OGField Topmenu links    NavigationPanel Close
        END
        ukw_Common.CaptureScreen    ${TEST_NAME}_OGField-Perform DutyOn in OGField.png
        OGField-Timesheet_AdditionalInfo
        Generic-Click element if shown    ${loc_OGField_SafetyMessage_OK}
        Generic-Click element if shown    ${loc_OGField_VehicleMileage_Cancel} 

    	CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Perform DutyOn.png    OGField-DutyOn in OGField   passed
    
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Perform DutyOnd.png    OGField-DutyOn in OGField   failed
        FAIL    Perform DutyOn in OGField failed
    END


   

OGField-Timesheet_AdditionalInfo    
    # Acknowledge OGField-Timesheet_AdditionalInfo 
    ${elem_exist}    Run Keyword And Return Status   Page Should Contain Element   ${loc_OGField_Timesheet_OK}
    IF    '${elem_exist}' == 'True'
        Generic-Verify page contains element and update report    ${loc_OGField_Timesheet_AdditionalInfo_Leader_Checkbox_Checked}    Verify Leader checkbox is checked
        Generic-Click element if shown    ${loc_OGField_Timesheet_AdditionalInfo_Helper1_Checkbox_Unchecked} 
        ukw_Common.CaptureScreen    ${TEST_NAME}_OGF_TSAdditionalInfo.png
        Generic-Click element if shown    ${loc_OGField_Timesheet_OK}
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGF_TSAdditionalInfo.png    OGField-Timesheet_AdditionalInfo   passed
    END
 
OGField-Perform DutyOff in OGField  
    # Perform DutyOff in OGField
    TRY
        OGField-Open Navigation Panel  
        Generic-Click element if shown    ${loc_OGField_DutyOff}
        Generic-Click element if shown    ${loc_OGField_No} 
        Generic-Click element if shown    ${loc_OGField_NavigationPanel_Close}

        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-DutyOff.png      OGField-DutyOff in OGField   passed                   
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-DutyOff.png      OGField-DutyOff in OGField   failed 
        FAIL    Perform DutyOff in OGField failed
    END


OGField-Select row in Joblist
    [Arguments]    ${data}
    # Select row in Joblist
 
    ${loc_OGField_SelectJobNumber_CheckBox}=    Replace Variables     ${loc_OGField_SelectJobNumber_CheckBox}   #Replace with ${data}
    Generic-Verify page contains element and update report    ${loc_OGField_SelectJobNumber_CheckBox}    Verify Job checkbox found in Joblist
    GetElementToView    ${loc_OGField_SelectJobNumber_CheckBox}    OGField_SelectJobNumber_CheckBox
    

OGField-Select Footer Next Status
    GetElementToView    ${loc_OGField_Footer_NextStatus}     OGField_Footer_NextStatus
    Sleep    10s
    ukw_Common.CaptureScreen    ${TEST_NAME}_OGField-Select Footer Next Status.png
    Generic-Click element if shown    ${loc_OGField_Yes2}  
    Sleep    5s

OGField-Select Footer Field Report
    GetElementToView    ${loc_OGField_Footer_FieldReport}    OGField_Footer_FieldReport
    Sleep    10s
    ukw_Common.CaptureScreen    ${TEST_NAME}_OGField-Select Footer Field Report.png

OGField-Verify Joblist value
    [Arguments]    ${data}

    ${loc_OGField_Joblist_TableValue}=    Replace Variables    ${loc_OGField_Joblist_TableValue}        
    Generic-Verify page contains element and update report    ${loc_OGField_Joblist_TableValue}    OGField-Verify Joblist value-${data}
    CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Verify Joblist value.png    OGField-Verify Joblist value-${data}    passed 
   

OGField-Enter Field Report
    [Arguments]    ${data1}    ${data2}
    TRY
        GetElementToView    ${loc_OGField_FieldReport_R02Template}    OGField_FieldReport_R02Template
        ${elem_exist}    Run Keyword And Return Status
        ...    Page Should Contain Element
        ...    ${loc_OGField_FieldReport_Pole_UDF12}
        IF    '${elem_exist}' == 'True'
            Input Text    ${loc_OGField_FieldReport_Pole_UDF12}    ${data1}
            # Select From List By Value    ${loc_OGField_FieldReport_RemoveFixture}    ${data2}
            # Select From List By Value    ${loc_OGField_FieldReport_InstallFixture}    ${data3}
            Select From List By Index    ${loc_OGField_FieldReport_RemoveFixture}     2
            Select From List By Index    ${loc_OGField_FieldReport_InstallFixture}     2
            Input Text    ${loc_OGField_FieldReport_Notes}    ${data2}
        END

        ${elem_exist}    Run Keyword And Return Status    
        ...    Page Should Contain Element
        ...    ${loc_OGField_FieldReport_Pole_UDF18}
        IF    '${elem_exist}' == 'True'
            Input Text    ${loc_OGField_FieldReport_Pole_UDF18}    ${data1}  [1]      
            Select From List By Index    ${loc_OGField_FieldReport_LocationType}     1
            Select From List By Index    ${loc_OGField_FieldReport_PolesReplaced}     1

            Select From List By Index    ${loc_OGField_FieldReport_PrimarySpansPutUp}     1
            Select From List By Index    ${loc_OGField_FieldReport_TfmrsReplaced}     1

            Select From List By Index    ${loc_OGField_FieldReport_LocationType}     1
            Select From List By Index    ${loc_OGField_FieldReport_PolesReplaced}     1

            Select From List By Index    ${loc_OGField_FieldReport_Outage}     1
            Sleep    1s
            Select From List By Index    ${loc_OGField_FieldReport_Cause}     1

            Select From List By Index    ${loc_OGField_FieldReport_Category}     1
            Select From List By Index    ${loc_OGField_FieldReport_SubCause}     1

            Select From List By Index    ${loc_OGField_FieldReport_EquipmentFacilityImpacted}     1
            Select From List By Index    ${loc_OGField_FieldReport_EquipmentFacilityRequired}     1

            Select From List By Index    ${loc_OGField_FieldReport_ConditionFound}     1
            Select From List By Index    ${loc_OGField_FieldReport_ActionPerformed}     1

            Input Text    ${loc_OGField_FieldReport_Remarks}    ${data2}
        END

        
        Scroll complete page up using Javascript
        GetElementToView    ${loc_OGField_FieldReport_Save}    OGField_FieldReport_Save
        Sleep    2
        Generic-Click element if shown    ${loc_OGField_Yes1}
        Sleep    20s
        Scroll complete page down using Javascript
        CaptureScreen_AddStepsToReport   ${TEST_NAME}_OGField-Enter Field Report.png    OGField-Enter Field Report    passed 
    EXCEPT 
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Enter Field Report.png     OGField-Enter Field Report    failed 
        FAIL     OGField-Enter Field Report failed
    END

OGField-Verify Crew Status on Topmenu
    [Arguments]    ${data}  
    TRY
        ${temp}=    Get Element Attribute   ${loc_OGField_CrewStatus}  value
        ${temp}    Convert To Upper Case    ${temp}
        ukw_Common.CaptureScreen    ${TEST_NAME}.png
        Should Be Equal    ${temp}    ${data}     Crew status should be ${data} 

        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Crew status.png    OGField-Verify Crew Status on Topmenu-${data}      passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Crew status.png    OGField-Verify Crew Status on Topmenu-${data}      failed 
        FAIL    OGField-Verify Crew Status on Topmenu-${data} failed
    END
    

OGField-Click menu from NavigationPanel
    [Arguments]    ${element} 
    OGField-Open Navigation Panel 
    GetElementToView    ${element}    ${element}
    Sleep    10s
    CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGF_NP.png    OGField-Click menu from navigation panel    passed


OGField-Click menu from Footer NavigationPanel
    [Arguments]    ${data} 
    GetElementToView   ${loc_OGField_Footer_FooterNavigationPanel}  Footer Navigation    
    ${loc_OGField_Footer_LeftSlidingPane} =    Replace Variables    ${loc_OGField_Footer_LeftSlidingPane}    
    GetElementToView    ${loc_OGField_Footer_LeftSlidingPane}    ${data} 
    Sleep    5s
    CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGF_${data}.png    OGField-Click menu from footer    passed


OGField_Create_New_Job    
    TRY
        OGField-Click menu from NavigationPanel    ${loc_OGField_NewJob}  
        ${CreateJob_JobDetails1} =    Replace Variables    ${CreateJob_JobDetails1} 
        ${thisdict}=    Create Dict From Input    ${CreateJob_JobDetails1}    ,  :  #outer delimeter and inner delimeter        
        OGField-CreateJob_EnterJobDetails    ${thisdict}[TaskType]     ${thisdict}[Jobtype]     ${thisdict}[Address]    ${thisdict}[City]

        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Createjob.png     OGField-Create New Job    passed            
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Createjob.png     OGField-Create New Job    failed 
        FAIL    OGField-Create_New_Job failed
    END


OGField_DuplicateJob
    OGField-Click menu from Footer NavigationPanel    DuplicateJob
    Wait Until Element Is Visible    ${loc_OGField_DuplicateJob}    5s
    # Click Element    ${loc_OGField_Yes}
    #  ${thisdict}=    Create Dict From Input    ${CreateJob_JobDetails1}    ,  :  #outer delimeter and inner delimeter     
    # OGField-CreateJob_EnterJobDetails    ${thisdict}[TaskType]     ${thisdict}[Jobtype]     ${thisdict}[Address]    ${thisdict}[City]
    # ukw_Common.CaptureScreen    ${TEST_NAME}_OGField-Duplicate Job.png
    ${elem_exist}=    Run Keyword And Return Status    Page Should Contain Element    ${loc_OGField_DuplicateJob}
    IF    '${elem_exist}' == 'True'
        Generic-Click element if shown    ${loc_OGField_Yes2}
    END
    OGField-SaveJobDetails_VerifyNewAssignment
    CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Duplicate.png     OGField-DuplicateJob   passed            


OGField_CreateJob_AssetSearch

    GetElementToView    ${loc_OGField_Map}    OGField_Map
    Wait Until Element Is Visible     ${loc_OGField_MapAllJobs}    100s
    Generic-Click element if shown    ${loc_OGField_Map_Layer}
    Generic-Click element if shown    ${loc_OGField_Map_Layer_GeoServer1}    
    Generic-Click element if shown    ${loc_OGField_Map_Layer_GeoServer1_Checkbox1}    
    Generic-Click element if shown    ${loc_OGField_Map_Layer_GeoServer1_Checkbox2}   
    Generic-Click element if shown    ${loc_OGField_Map_Layer}
 
    OGField-Click menu from NavigationPanel    ${loc_OGField_MapAssetSearch}
    Wait Until Element Is Visible    ${loc_OGField_MapAssetSearch_Query}         
    ${CreateJob_JobDetails1} =    Replace Variables    ${CreateJob_JobDetails1} 

    # OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel    ${loc_OGField_NewJob}    ${loc_OGField_JobDetails_JobDetailsTAB}     NewJob_JobDetailsTab
    &{FieldReport}=    Read_JSON_GenericDataFile_and_ReturnSingleValue   CreateJob_JobDetails1
    ${thisdict}=    Create Dict From Input    ${CreateJob_JobDetails1}    ,  :  #outer delimeter and inner delimeter        
    Run Keyword And Continue On Failure     OGField-CreateJob_EnterJobDetails    ${thisdict}[TaskType]     ${thisdict}[Jobtype]     ${thisdict}[Address]    ${thisdict}[City]


OGField_Enter_FieldReport
    OGField-Select Footer Field Report  
    ukw_Get_FieldReport_For_Job   
    IF  '${DB_FR_For_JOB}[0]' == 'R02_SPEC_REPORT'   #or EPB_CIS_SPEC_REP_NO, EPB_OMS_EMERG_RPT
        @{FR}     Split String     ${FieldReport}    ^
        OGField-Enter Field Report    ${FR}[0]    ${FR}[1] 
        ukw-Verify Value contains Input Element partially    ${loc_OGField_FieldReport_FieldReportNumber}    ${CREW}
        Sleep    5s
    ELSE  #Temporarily providing this code until we get a solution to find all possible templates
        @{FR}     Split String     ${FieldReport}    ^
        OGField-Enter Field Report    ${FR}[0]    ${FR}[1] 
        ukw-Verify Value contains Input Element partially    ${loc_OGField_FieldReport_FieldReportNumber}    ${CREW}
        Sleep    5s
    END
    CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGF-FR.png    OGField-Enter_FieldReport   passed 

OGField-Confirm New Assignment 
    Generic-Click element if shown    ${loc_OGField_VehicleMileage_Cancel} 
    TRY
       Wait Until Element Is Visible    ${loc_OGField_NewAssignment}    100s
        seleniumlibrary.Page Should Contain Element    ${loc_OGField_NewAssignment}    OGF-New Assignment message not found
        ukw_Common.CaptureScreen    ${TEST_NAME}_OGF-AssignmentReceived.png  
    
        #Get jobnumber from New Assignment notification
        ${new_assignment_text}=    Seleniumlibrary.Get Text  ${loc_OGField_NewAssignment}   
        @{new_job1}    Split String    ${new_assignment_text}   :
        @{new_job2}    Split String    ${new_job1}[1]   .        
        ${new_jobnumber} =    Strip String    ${new_job2}[0]
        Set global variable    ${new_jobnumber}    ${new_jobnumber}
        Wait Until Element Is Visible    ${loc_OGField_NewAssignment_OK}    120s
        Generic-Click element if shown    ${loc_OGField_ConfirmAll}  
        Generic-Click element if shown        ${loc_OGField_NewAssignment_OK}   
        Generic-Click element if shown    ${loc_OGField_Acknowledge}
        Sleep    10s 
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Newassignment.png    OGField-New assignment    passed

    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Newassignment.png    OGField-New assignment    failed
        FAIL  NewAssignment message not found
    END


OGField-DisposeJob
    ${elem_exist}    Run Keyword And Return Status    Page Should Contain Element    ${loc_OGField_DisposeCode_Select}
    IF    '${elem_exist}' == 'True'
        Select From List By Index      ${loc_OGField_DisposeCode_Select}    1
        GetElementToView    ${loc_OGField_DisposeCode_Add}    Add button
        Set Global Variable    ${SetReason}     ${SetReason_Remarks}
        Input Text    ${loc_OGField_DisposeCode_Remark}    ${SetReason} 
        GetElementToView     ${loc_OGField_DisposeCode_Dispose}    Dispose button
        Sleep    5s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Disposejob.png    OGField-Dispose Job    passed

    END

OGField-Click element_VerifyElement exists_Reload page
    [Arguments]    ${element}    ${elementToVerify}    ${messg}
    Reloading Page     OGF
    ${elem_exist}    Run Keyword And Return Status   Page Should Contain Element   ${loc_OGField_LoginJoblistDefaultQuery}
    IF    '${elem_exist}' == 'True'
        Generic-Click element if shown    ${loc_OGField_Acknowledge}   
    END  

    Generic-Click element if shown    ${loc_OGField_ConfirmAll}
    Generic-Click element if shown    ${loc_OGField_Panic_EmergencyClose}
    Wait until Element Is Visible    ${loc_OGField_Joblist}    200s 
    GetElementToView    ${loc_OGField_Joblist}    OGField_Joblist
    Sleep    5s 
   TRY
        Run Keyword And Continue On Failure    Click Element    ${element}
        Sleep   5s
        IF    '${messg}' == 'JobDetailsTAB'
            GetElementToView    ${loc_OGField_JobDetails_JobSummaryTab}   Job Summary TAB          
        END
        
        Run Keyword And Continue On Failure     Wait Until Element Is Visible    ${elementToVerify}    20s
        Page Should Contain Element    ${elementToVerify}    ${messg} not found  

        CaptureScreen_AddStepsToReport    ${TEST_NAME}_${messg}.png    Verify ${messg} is shown    passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_${messg}.png    Verify ${messg} is shown    failed
    END
      
    
OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel
    [Arguments]    ${element}    ${elementToVerify}    ${messg}
    Reloading Page    OGF
    
    OGField-Click menu from NavigationPanel    ${element}  
    IF     '${messg}' == 'NewJob_JobDetailsTab'
        GetElementToView    ${loc_OGField_JobDetails_JobSummaryTab}   Job Summary TAB        

    ELSE IF    '${messg}' == 'JobJar_Dropdown'
        ${elem_exist}    Run Keyword And Return Status    Page Should Contain Element  ${loc_OGField_LoginJoblistDefaultQuery}
            IF    '${elem_exist}' == 'True'
                Generic-Click element if shown    ${loc_OGField_Acknowledge}   
            END    
        
        # NOJOBJARDEFQUERY - Job Jar List - Job Jar default query no longer exists - Please contact Admin
        ${Sys_messg}=     ukw_GetValue_FromDB_CAD_Parameter     NOJOBJARDEFQUERY    ${DB_SYSTEMMESSAGE} 
        Set Global Variable    ${Sys_messg}    ${Sys_messg}
        ${loc_OGField_System_Notification}=    Replace Variables    ${loc_OGField_System_Notification}
        ${elem_exist}    Run Keyword And Return Status  Page Should Contain Element  ${loc_OGField_System_Notification}        
        IF    '${elem_exist}' == 'True'
            Generic-Click element if shown    ${loc_OGField_Acknowledge}   
        END   
       
        GetElementToView    ${loc_OGField_JobJar_Filter}    JobJar Filter 
        ${loc_OGField_JobJar_SelectQuery1}=    Replace Variables    ${loc_OGField_JobJar_SelectQuery1}
        ${loc_OGField_JobJar_SelectQuery2}=    Replace Variables    ${loc_OGField_JobJar_SelectQuery2}

        GetElementToView    ${loc_OGField_JobJar_SelectQuery1}    JobJar_SelectQuery1
        GetElementToView    ${loc_OGField_JobJar_SelectQuery2}    JobJar_SelectQuery2
        
        Wait Until Element Is Visible    ${loc_OGField_JobJar_Table}    10 seconds   
        Generic-Verify page contains element and update report    ${loc_OGField_JobJar_Table}    Verify Jobjar table is shown

    END

    Generic-Click element if shown    ${loc_OGField_Panic_EmergencyClose}
        
    Generic-Verify page contains element and update report    ${elementToVerify}     Verify ${messg} is shown 
   

OGField-Click element_VerifyElement exists_Reload page_Open_FooterNavigationPanel
    [Arguments]    ${data}    ${elementToVerify}    ${messg}
    Reloading Page    OGF
    ${loc_OGField_Footer_LeftSlidingPane}=    Replace Variables    ${loc_OGField_Footer_LeftSlidingPane}
    GetElementToView    ${loc_OGField_Footer_LeftSlidingPane}    OGField_Footer_LeftSlidingPane
    
    Sleep   1s 
    GetElementToView    ${data}    ${data}
    Sleep   5s
    Generic-Click element if shown    ${loc_OGField_Panic_EmergencyClose}
    Wait Until Element Is Visible    ${elementToVerify}    200s
    Generic-Verify page contains element and update report    ${elementToVerify}    Verify ${messg} is shown 

 OGField-Open Navigation Panel

    # Close navigation panel if already open
    Generic-Click element if shown    ${loc_OGField_NavigationPanel_Close}
    
    # Wait for Gritter message to disappear
    ${elem_exist}    Run Keyword And Return Status    Page Should Contain Element    ${loc_OGField_GritterMessage}
    IF    '${elem_exist}' == 'True'
        Sleep    60s            
    END 
    
    # Open Navigation Panel
    GetElementToView    ${loc_OGField_NavigationPanel_Open}    OGField_NavigationPanel_Open       
     
 
 OGField-Start_NOA
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel   ${loc_OGField_NOA}    ${loc_OGField_NOA_Close}    NOA_Close
    TRY
        GetElementToView    ${loc_OGField_NOA_ReasonClick}    OGField_NOA_ReasonClick
        Select From List By Index    ${loc_OGField_NOA_Reason}       1
        GetElementToView    ${loc_OGField_NOA_Start}    OGField_NOA_Start  
        GetelementToView    ${loc_OGField_NOA_Close}    OGField_NOA_Close
        Set Global Variable    ${DB_CrewStatusDesc}       ${DB_CREW_STATUSCODE_DESCRIPTION}

        OGField-Verify Crew Status on Topmenu    ${DB_CrewStatusDesc}    #NON AVAILABLE    
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-NOA.png     OGField-Start_NOA    passed
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-NOA.png     OGField-Start_NOA    failed
        FAIL    OGField-Start_NOA failed
    END


 OGField-Stop_NOA
    # Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel   ${loc_OGField_NOA}    ${loc_OGField_NOA_Reason}    NOA_Reason
    TRY

        OGField-Open Navigation Panel
        GetElementToView    ${loc_OGField_NOA}    OGField_NOA
        Sleep    10s
        GetElementToView    ${loc_OGField_NOA_Stop}    OGField_NOA_Stop
        GetElementToView    ${loc_OGField_NOA_Close}    OGField_NOA_Close
        Set Global Variable    ${DB_CrewStatusDesc}  ${DB_CREW_STATUSCODE_DESCRIPTION}

        OGField-Verify Crew Status on Topmenu    ${DB_CrewStatusDesc}      #CLEARED 
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-NOAstop.png     OGField-Stop_NOA    passed
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-NOAstop.png      OGField-Stop_NOA    failed
        FAIL     OGField-Stop_NOA failed
    END

OGField-Topmenu_UI_Verification
    seleniumlibrary. Switch Browser    ${OGF_Alias}   

    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page    ${loc_OGField_Map}    ${loc_OGField_MapAssetSearch}    Map_DisplayMode
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page    ${loc_OGField_Joblist}   ${loc_OGField_Joblist_TableHeader}    Joblist page
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page    ${loc_OGField_Panic}    ${loc_OGField_Panic_Yes}    Panic window
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page    ${loc_OGField_Mail}   ${loc_OGField_Mail_AddFolder}   Mail add folder 
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page    ${loc_OGField_Chat}   ${loc_OGField_Chat_Status}     IM chat Status dropdown
    Click Element    ${loc_OGField_Chat_Close}



OGField-Footer_UI_Verification 
    seleniumlibrary. Switch Browser    ${OGF_Alias}    

    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page    ${loc_OGField_Footer_Panic}    ${loc_OGField_Panic_No}   Panic_No
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page    ${loc_OGField_Footer_JobDetail}    ${loc_OGField_JobDetails_JobDetailsTAB}   JobDetailsTAB
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page    ${loc_OGField_Footer_FieldReport}    ${loc_OGField_FieldReport_Save}   FieldReport_Save
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page    ${loc_OGField_Footer_Attachment}    ${loc_OGField_NoAttachment}   NoAttachment
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page    ${loc_OGField_Footer_JobNotes}    ${loc_OGField_JobNotes_Disabled}   JobNotes_Disabled
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page    ${loc_OGField_Footer_Print}    ${loc_OGField_Print_SelectLayout}   Print_SelectLayout

    
OGField-RightNavigation_UI_Verification
    OGField-Open Navigation Panel   
    Generic-Click element if shown    ${loc_OGField_LunchOff}
    
    OGField-Perform DutyOff in OGField

    OGField-Click menu from NavigationPanel    ${loc_OGField_LunchOn} 
    
    ${sysmessg1}    set variable    ${UNABLE_TO_LUNCHON_CREW_OFFDUTY} 

    Element Should Contain    ${loc_OGField_LunchOnOff_Unable}      ${sysmessg1}
    ukw_Common.CaptureScreen    ${TEST_NAME}.png
    GetElementToView    ${loc_OGField_Acknowledge}    OGField_Acknowledge
    Sleep    2s 
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel    ${loc_OGField_CrewMakeUp}    ${loc_OGField_CrewMakeUP_AddPersonnel}    CrewMakeUP_AddPersonnel
    GetElementToView    ${loc_OGField_CrewMakeUp_Close}    OGField_CrewMakeUp_Close

    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel    ${loc_OGField_CrewDetails}    ${loc_OGField_CrewDetails_SchedulingTab}     CrewDetails_SchedulingTab
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel    ${loc_OGField_JobJar}    ${loc_OGField_JobJar_Table}     JobJar_Dropdown
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel    ${loc_OGField_NewJob}    ${loc_OGField_JobDetails_JobDetailsTAB}     NewJob_JobDetailsTab
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel    ${loc_OGField_Calendar}    ${loc_OGField_Calendar_AgendaTime}    Calendar_AgendaTime
    
    OGField-Click menu from NavigationPanel    ${loc_OGField_NOA}
    ${sysmessg2}    set variable    ${NOA_CANNOT_CREATE} 
    Element Should Contain    ${loc_OGField_NOA_WithoutDutyON}    ${sysmessg2} 
   
    GetElementToView    ${loc_OGField_Acknowledge}    OGField_Acknowledge
    
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel    ${loc_OGField_Home_FieldSupervisor}    ${loc_FS_Joblist_Query}    FS_Joblist_Query
   
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel    ${loc_OGField_PanicNow}    ${loc_OGField_Panic_No}    Panic No button
    
    GetElementToView    ${loc_OGField_Panic_No}    OGField_Panic_No

    Reloading Page   OGF

    GetElementToView    ${loc_OGField_Map}    OGField_Map
    Sleep   5s
    OGField-Click menu from NavigationPanel    ${loc_OGField_AssetFacilitySearch}   

    Wait Until Element Is Visible    ${loc_AssetFacilitySearch_AssetName}    20s
    GetElementToView    ${loc_AssetFacilitySearch_Cancel}    AssetFacilitySearch_Cancel

    #  GetElementToView    ${loc_OGField_Map}    OGField_Map
    GetElementToView    ${loc_OGField_Map_Layer}    OGField_Map_Layer

    OGField-Click menu from NavigationPanel    ${loc_OGField_MapAssetSearch}
    Wait Until Element Is Visible    ${loc_OGField_MapAssetSearch_Query}      
    
    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel    ${loc_OGField_ShowCrewActivities}    ${loc_OGField_ShowCrewActivities_StartDate}   ShowCrewActivities_StartDate
    GetElementToView    ${loc_OGField_ShowCrewActivities_Close}    OGField_ShowCrewActivities_Close

    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel    ${loc_OGField_AreaSearch}    ${loc_OGField_AreaSearch_StartDate}    AreaSearch_StartDate

    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel    ${loc_OGField_TimesheetApproval}    ${loc_OGField_TimesheetApproval_EmpName}    TimesheetApproval_EmpName

    # Perform Lunch on and NOA after Duty on
    OGField-Perform DutyOn in OGField

    Run Keyword And Continue On Failure    OGField-Click element_VerifyElement exists_Reload page_Open NavigationPanel    ${loc_OGField_TimesheetList}    ${loc_OGField_TimesheetList_Leader_FirstNameRow1}    TimesheetList_Leader_FirstNameRow1
    
    GetElementToView    ${loc_OGField_TimesheetList_Close}    OGField_TimesheetList_Close

    OGField-Click menu from NavigationPanel    ${loc_OGField_LunchOn}
    Set Global Variable    ${DB_CrewStatusDesc}    ${DB_CREW_STATUSCODE_DESCRIPTION}

    OGField-Verify Crew Status on Topmenu    ${DB_CrewStatusDesc}    #NON AVAILABLE   
    OGField-Click menu from NavigationPanel    ${loc_OGField_LunchOff}

    Set Global Variable    ${DB_CrewStatusDesc}       ${DB_CREW_STATUSCODE_DESCRIPTION}
    OGField-Verify Crew Status on Topmenu    ${DB_CrewStatusDesc}    #CLEARED 
    
    # Start NOA
     OGField-Start_NOA

     Sleep   10s

    # Stop NOA
    OGField-Stop_NOA


OGField-CreateJob_EnterJobDetails
    [Arguments]    ${tasktype}    ${jobtype}    ${address}    ${citycode}

    GetElementToView    ${loc_OGField_JobDetails_JobSummaryTab}   Job Summary TAB  
    # Open Job Details tab if its collapsed state
    ${elem_exist}    Run Keyword And Return Status  Page Should Contain Element  ${loc_OGField_JobDetails_JobdetailsTab_Collapsed}
    IF    '${elem_exist}' == 'True'          Generic-Click element if shown    ${loc_OGField_JobDetails_JobDetailsTAB}
     
    
    Select From List By value     ${loc_OGField_TaskType}    ${tasktype}
    Sleep    2s
    Select From List By Value     ${loc_OGField_Jobtype_WorkCode}    ${jobtype}
    Sleep    2s
    ${address}=    Generate Random String    5    [LETTERS]        
    Input Text    ${loc_OGField_Address}    ${address}
    # ${citycode}=    convert to string      ${citycode}
    Select From List By index    ${loc_OGField_CityCode}    ${citycode}
    
    OGField-SaveJobDetails_VerifyNewAssignment

OGField-SaveJobDetails_VerifyNewAssignment
    # scroll complete page down using Javascript
    Capture Screen    ${TEST_NAME}_OGField-SaveJobDetails1.png
    Sleep   2s
    GetElementToView    ${loc_OGField_JobDetails_Save}   JobDetails_Save
    Sleep   5s
    Capture Screen    ${TEST_NAME}_OGField-SaveJobDetails2.png
    # scroll complete page up using Javascript

    # Verify Create job is saved and New Assignment notification is shown
    ${Sys_messg}=     ukw_GetValue_FromDB_CAD_Parameter     PFASSIGNNEWJOB    ${DB_SYSTEMMESSAGE} 
    Set Global Variable    ${Sys_messg}    ${Sys_messg}
    ${loc_OGField_System_Notification}=    Replace Variables    ${loc_OGField_System_Notification}

    Sleep  5s

    # Verify if message shown Would you like to be assigned to the newly created job?
    ${elem_exist}    Run Keyword And Return Status  Page Should Contain Element  ${loc_OGField_System_Notification}
    IF    '${elem_exist}' == 'True'
        GetElementToView    ${loc_OGField_Yes2}    Yes button
        Sleep    10s

        # Verify Confirm new assignment message
        # OGField-Confirm New Assignment 
        Generic-Click element if shown    ${loc_OGField_ConfirmAll}  
        Generic-Click element if shown        ${loc_OGField_NewAssignment_OK}   
        Generic-Click element if shown    ${loc_OGField_Acknowledge}
        Sleep    10s 

        ${elem_exist}    Run Keyword And Return Status  Page Should Contain Element  ${loc_OGField_JobDetails_JobNumber}
        IF    '${elem_exist}' == 'True'           
            ${new_jobnumber} =    Seleniumlibrary.Get Element Attribute  ${loc_OGField_JobDetails_JobNumber}     title
            Set global variable     ${new_jobnumber}        

            OGField-Click OGField Topmenu links    Joblist
            Generic-Click element if shown    ${loc_OGField_Yes}
        END
           
    ELSE
        OGField-Confirm New Assignment
        
        #If joblist page is shown , navigate to Job details page and verify job number is same as shown in New Assignment notification
        Set Global variable    ${data}     ${new_jobnumber}
        ${loc_OGField_Joblist_TableValue}=    Replace Variables    ${loc_OGField_Joblist_TableValue}

         ${elem_exist}    Run Keyword And Return Status  Page Should Contain Element  ${loc_OGField_Joblist_TableValue}
        IF    '${elem_exist}' == 'True'           
            GetElementToView   ${loc_OGField_Joblist_TableValue}  Newly created job not found
            GetElementToView    ${loc_OGField_Footer_JobDetail}    OGField_Footer_JobDetail
        END   

        TRY
            Wait Until Element Is Visible    ${loc_OGField_JobDetails_JobDetailsTAB}    20s
            Page Should Contain Element    ${loc_OGField_JobDetails_JobDetailsTAB}    JobDetailsTAB not found     

            #verify if jobnumber on assignment notification is same as shown in jobdetails page
            ${new_jobdetails_jobnumber}=    Seleniumlibrary.Get Element Attribute  ${loc_OGField_JobDetails_JobNumber}     title
            Should Be Equal    ${new_jobdetails_jobnumber}    ${new_jobnumber} 
            Set global variable     ${new_jobnumber}

        EXCEPT    
            FAIL     Create Job-Job Details not loaded  or Job number not found       
        END  

        Capture Screen    ${TEST_NAME}_OGField-SaveJobDetails1.png
       
        GetElementToView    ${loc_OGField_JobDetails_Save}    JobDetails_Save
        
    END

    # Verify joblist
    OGField-Click OGField Topmenu links    Joblist
    Generic-Click element if shown    ${loc_OGField_Yes}

    Sleep   10s
     ${elem_exist}    Run Keyword And Return Status  Page Should Contain Element  ${loc_OGField_NewAssignment}
    IF    '${elem_exist}' == 'True'
        OGField-Confirm New Assignment
    END

    ukw-Verify Value contains Input Element partially    ${loc_OGField_Jobnumber_input}   ${new_jobnumber}  
    OGField-Select row in Joblist    ${new_jobnumber} 
    
OGField-JobDetails_EnterUDF14
    ${elem_exist}    Run Keyword And Return Status    Page Should Contain Element    ${loc_OGField_JobDetails_ReportingTAB}
    IF    '${elem_exist}' == 'True'
        GetElementToView   ${loc_OGField_JobDetails_ReportingTAB}    Work Review tab  
        Sleep    2s  
        ${tempval}=    generate random string    3    [LETTERS]
        Enter value if element is available    ${loc_OGField_Reporting_UDF14}    ${tempval}
    END
 

OGField_Doubleclick_Map_VerifyMenuItems
    Double Click Element    ${loc_OGField_Map_Canvas}
    Sleep     5s
    Generic-Verify page contains element and update report    ${loc_OGField_Map_Address}    Verify Address is shown 
    Generic-Verify page contains element and update report     ${loc_OGField_Map_CreateJob}   Verify Create job is shown
    Generic-Verify page contains element and update report    ${loc_OGField_Map_MoveJob}    Verify Move job is shown
    Generic-Verify page contains element and update report   ${loc_OGField_Map_GetRoute}     Verify Get Route is shown 
    Generic-Verify page contains element and update report   ${loc_OGField_Map_CreateCall}    Verify Create Call is shown

OGField-AcceptNotifications_ForNewAssignment
    seleniumlibrary.Switch Browser    ${OGF_Alias}   
    OGField-Timesheet_AdditionalInfo 
    OGField-Confirm New Assignment 
    Sleep   2s



OGField-Get JobCount from Topmenu
    TRY
        ${OGF_Topmenu_JobCount}=    Get Element Attribute    ${loc_OGField_Work_Count}    value    
        ${OGF_Topmenu_JobCount}=    Convert To Integer    ${OGF_Topmenu_JobCount}
        Set Global Variable    ${OGF_Topmenu_JobCount}   ${OGF_Topmenu_JobCount}
        Log    Job count is now ${OGF_Topmenu_JobCount}

        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Jobcount.png      OGField-Get JobCount from Topmenu    passed     
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-Jobcount.png      OGField-Get JobCount from Topmenu    failed  
        FAIL    OGField-Get JobCount from Topmenu failed
    END
 

OGField-Verify Topmenu JobCount Increased By One
    TRY
        ${initial_count}    Set Variable  ${OGF_Topmenu_JobCount} 
        # Perform actions that should increase the job count
        ${new_count}=    Get Element Attribute    ${loc_OGField_Work_Count}    value
        ${new_count}=    Convert To Integer    ${new_count}
        ${expected_count}=    Evaluate    ${initial_count} + 1
        ukw_Common.CaptureScreen    ${TEST_NAME}_OGField-jobcount_increase.png
        Should Be Equal As Numbers    ${new_count}    ${expected_count}    Job count did not increase by one
        Log    Job count is now ${new_count}

        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-jobcount_increase.png     OGField-Verify Topmenu JobCount Increased By One    passed
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGField-jobcount_increase.png    OGField-Verify Topmenu JobCount Increased By One    failed
        FAIL    OGField-Verify Topmenu JobCount Increased By One failed
    END

    

OGField-Open CrewMakeup_VerifyDefaultDisplay
    [Arguments]    ${OpenCrewMakeup}  ${DeleteHelpers} 
    
    # Open CrewMakeup
    IF    '${OpenCrewMakeup}' == 'Y'
        OGField-Open Navigation Panel
        OGField-Click menu from NavigationPanel    ${loc_OGField_CrewMakeUp}
    END

    IF  '${DeleteHelpers}' == 'Y'
        OGField-CrewMakeup_DeleteHelpers 
    END
    
    ukw_Common.CaptureScreen    ${TEST_NAME}_OGField-Crewmakeup.png

    # Verify Default display
    ${loc_OGField_CrewMakeUP_PrimaryCheckbox_On}=    Replace Variables    ${loc_OGField_CrewMakeUP_PrimaryCheckbox_On}
    
    Generic-Verify page contains element and update report    ${loc_OGField_CrewMakeUP_PrimaryCheckbox_On}   Verify ${Primary} checkbox is enabled in crew makeup window
    Generic-Verify page contains element and update report    ${loc_OGField_CrewMakeUP_Clear}    Verify Clear in crew makeup window
    Generic-Verify page contains element and update report    ${loc_OGField_CrewMakeUP_Cancel}     Verify Cancel in crew makeup window
  

OGField-CrewMakeup_Verify_PrimaryShown  

    ${loc_OGField_CrewMakeUP_Primary_InitialsID}=    Replace Variables    ${loc_OGField_CrewMakeUP_Primary_InitialsID}
    Generic-Verify page contains element and update report    ${loc_OGField_CrewMakeUP_Primary_InitialsID}   Verify ${Primary} Initials ID is found in crew makeup window

OGField-CrewMakeup_CloseWindow
    GetElementToView    ${loc_OGField_CrewMakeUp_Close}    OGField_CrewMakeUp_Close
    Sleep  5s

OGField-CrewMakeup_DeleteHelpers
        Sleep  5s
        Generic-Click element if shown    ${loc_OGField_CrewMakeUP_Helper_Delete}
        Generic-Click element if shown    ${loc_OGField_CrewMakeUP_Helper_Delete}
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGF_DeleteHelpers.png    OGField-CrewMakeup_DeleteHelpers    passed


OGField-CrewMakeup_AddHelper    
    [Arguments]    ${Agency}  ${BadgeNo}   ${App}

    TRY
        #Click Add Personnel, select Agency, Badge, Search and Add
        Wait Until Element Is Visible    ${loc_OGField_CrewMakeUP_AddPersonnel}    120s
        GetElementToView    ${loc_OGField_CrewMakeUP_AddPersonnel}    CrewMakeUP_AddPersonnel
        Select From List By Value    ${loc_OGField_CrewMakeUP_Agency}    ${Agency}
        Input text    ${loc_OGField_CrewMakeUP_BadgeNo}   ${BadgeNo}
        GetElementToView    ${loc_OGField_CrewMakeUP_Search}    CrewMakeUP_Search
        Sleep  5s
        GetElementToView    ${loc_OGField_CrewMakeUP_Add_Enabled}    CrewMakeUP_Add_Enabled
        Sleep  5s

        
    IF    '${App}' == 'FS'    
            Generic-Click element if shown    ${loc_FS_CrewDetails_Save}      
        END

        IF    '${App}' == 'OGW'    
            Generic-Click element if shown    ${loc_OGW_CrewDetails_Save}   
        END

        IF    '${App}' == 'OGF'    
            Generic-Click element if shown    ${loc_OGField_CrewMakeUP_Save}   
        END

        Sleep  15s
        Generic-Click element if shown    ${loc_OGField_Yes1}
        Sleep  5s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW-CrewMakeupAddHelper.png    CrewMakeup_AddHelper ${BadgeNo}   passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW-CrewMakeupAddHelper.png    CrewMakeup_AddHelper ${BadgeNo}    failed
        FAIL    CrewMakeup_AddHelper ${BadgeNo}   failed
    END


OGField-CrewMakeuup_Verify_PrimaryEnabled_HelperDisabled
    [Arguments]    ${Primary}    ${Helper}
    ${Primary}    Set Variable    ${Primary}[:4]
    ${Helper}    Set Variable    ${Helper}[:4]
    ukw_Common.CaptureScreen    ${TEST_NAME}_OGField-crewmakeup.png

    #Get Primary Badge number from DB and verify if its shown in Crew makeup
    ${loc_OGField_CrewMakeUP_Primary_InitialsID}=    Replace Variables    ${loc_OGField_CrewMakeUP_Primary_InitialsID}
    Generic-Verify page contains element and update report    ${loc_OGField_CrewMakeUP_Primary_InitialsID}    Verify ${Primary} Initials ID is found in crew makeup window

    #Verify if Primary checkbox is enabled
    ${loc_OGField_CrewMakeUP_PrimaryCheckbox_On}=    Replace Variables    ${loc_OGField_CrewMakeUP_PrimaryCheckbox_On}
    Generic-Verify page contains element and update report    ${loc_OGField_CrewMakeUP_PrimaryCheckbox_On}    Verify ${Primary} checkbox is enabled in crew makeup window

     #Verify if Primary Delete is disabled
    ${loc_OGField_CrewMakeUP_Primary_DeleteDisabled}=    Replace Variables    ${loc_OGField_CrewMakeUP_Primary_DeleteDisabled}
    Generic-Verify page contains element and update report    ${loc_OGField_CrewMakeUP_Primary_DeleteDisabled}    Verify ${Primary} Delete is disabled in crew makeup window
    
    #Get Helper1 Badge number from DB and verify if its shown in Crew makeup
    ${loc_OGField_CrewMakeUP_Helper_InitialsID}=    Replace Variables    ${loc_OGField_CrewMakeUP_Helper_InitialsID}
    Generic-Verify page contains element and update report    ${loc_OGField_CrewMakeUP_Helper_InitialsID}    Verify ${Helper} Initials ID is in crew makeup window
   
    #Verify Helper1 Delete is enabled
    ${loc_OGField_CrewMakeUP_Helper_DeleteEnabled}=    Replace Variables    ${loc_OGField_CrewMakeUP_Helper_DeleteEnabled}
    Generic-Verify page contains element and update report    ${loc_OGField_CrewMakeUP_Helper_DeleteEnabled}   Verify ${Helper} delete is enabled in crew makeup window

OGField-CrewMakeup_DeleteHelper_Save
    [Arguments]    ${Helper}    ${App}
    
    TRY
        ${loc_OGField_CrewMakeUP_Helper_DeleteEnabled}=    Replace Variables    ${loc_OGField_CrewMakeUP_Helper_DeleteEnabled}
        GetElementToView    ${loc_OGField_CrewMakeUP_Helper_DeleteEnabled}    OGField_CrewMakeUP_Helper_DeleteEnabled

        IF    '${App}' == 'FS'    
            Generic-Click element if shown    ${loc_FS_CrewDetails_Save}      
        END

        IF    '${App}' == 'OGW'    
            Generic-Click element if shown    ${loc_OGW_CrewDetails_Save}   
        END

        IF    '${App}' == 'OGF'    
            Generic-Click element if shown    ${loc_OGField_CrewMakeUP_Save}   
        END

        Sleep  15s

        Generic-Click element if shown    ${loc_OGField_Yes1}
        Sleep  5s
        Scroll complete page down using Javascript
        Generic-Click element if shown    ${loc_OGField_Timesheet_PeriodConfirmation_Save}    
        Sleep  5s   
        ukw_Common.CaptureScreen    ${TEST_NAME}_Helpersave.png
        Scroll complete page up using Javascript

        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW-Login.png    CrewMakeup_Delete Helper ${Helper}    passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_OGW-Login.png   CrewMakeup_Delete Helper ${Helper}    failed
        FAIL    CrewMakeup_Delete Helper ${Helper}  failed
    END


    

OGField-CrewMakeup_Verify_HelperDeleted
    [Arguments]    ${Helper}
    ukw_Common.CaptureScreen    ${TEST_NAME}_helperr.png
     TRY        
        ${loc_OGField_CrewMakeUP_Helper_InitialsID}=    Replace Variables    ${loc_OGField_CrewMakeUP_Helper_InitialsID}
        Page Should Not Contain Element   ${loc_OGField_CrewMakeUP_Helper_InitialsID}    ${Helper} Initials ID not found in crew makeup window
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_helper.png    CrewMakeup_Verify_Helper ${Helper} Deleted    passed 
    EXCEPT
        CaptureScreen_AddStepsToReport   ${TEST_NAME}_helper.png    CrewMakeup_Verify_Helper ${Helper} Deleted    failed
        FAIL    CrewMakeup_Verify_Helper ${Helper} Deleted  failed
    END
    

OGField-TimesheetList_Verify_Helper_Added_To_TimesheetList
    [Arguments]    ${Helper}    

    OGField-Open Navigation Panel
    OGField-Click menu from NavigationPanel    ${loc_OGField_TimesheetList}
    ${Currentdate}=    Get Current Date    result_format=%Y%m%d
    ukw_Common.CaptureScreen    ${TEST_NAME}_OGField-TSList.png
   
    ${loc_OGField_TimesheetList_Helper_CurrentDate}=    Replace Variables    ${loc_OGField_TimesheetList_Helper_CurrentDate}
    Generic-Verify page contains element and update report    ${loc_OGField_TimesheetList_Helper_CurrentDate}    Verify ${Helper} is found in Timesheetlist window   

    # Close Timesheet list
    GetelementToView    ${loc_OGField_TimesheetList_Close}    OGField_TimesheetList_Close

OGField-Get_CrewMakeup_Primary_UserDetails
    # Verify primary user details in Crew Makeup
    [Arguments]    ${Agency}   ${Primary_User}
    Set Global Variable    ${Agency}    ${Agency}
    Set Global Variable    ${Primary_User}    ${Primary_User}

    
    ${Primary_Badgeno}=    ukw_GetValue_FromDB    ${DB_CREW_MAKEUP_ACTIVE_PRIMARY_BADGENO}
    Set Global Variable    ${Primary}    ${Primary_Badgeno}

    # Get Firstname of Primary user
    Set Global Variable    ${User}    ${Primary}
    ${temp_Firstname_Qry}    Set Variable  ${DB_CREW_MAKEUP_ACTIVE_FIRSTNAME}
    ${temp_Firstname_Qry}=    Replace Variables    ${temp_Firstname_Qry}   #because it overwrites the variable so using temp
    ${FirstName_Primary}=    ukw_GetValue_FromDB    ${DB_CREW_MAKEUP_ACTIVE_FIRSTNAME}
    Set Global Variable    ${FirstName_Primary}    ${FirstName_Primary}

OGField-Get_CrewMakeup_Helper_Details 
    [Arguments]    ${Agency}
    Set Global Variable    ${Agency}    ${Agency}

    # Get available Badge number for a Helper then get first name of Helper
    ${DB_CREW_MAKEUP_ACTIVE_BADGENO}=    Replace Variables    ${DB_CREW_MAKEUP_ACTIVE_BADGENO}
    ${Helper_Badge}=    ukw_GetValue_FromDB    ${DB_CREW_MAKEUP_ACTIVE_BADGENO}
    Set Global Variable    ${Helper_Badge}    ${Helper_Badge}

    # Get Firstname of Helper
    Set Global Variable    ${User}    ${Helper_Badge}
    ${DB_CREW_MAKEUP_ACTIVE_FIRSTNAME}=    Replace Variables    ${DB_CREW_MAKEUP_ACTIVE_FIRSTNAME}
    ${FirstName_Helper}=    ukw_GetValue_FromDB    ${DB_CREW_MAKEUP_ACTIVE_FIRSTNAME}
    Set Global Variable    ${FirstName_Helper}    ${FirstName_Helper}

 OGField-Open_Calendar_Create_Agenda_Exception
    [Arguments]    ${Start_mm}    ${Start_dd}    ${Start_yyyy}    ${Start_hh}    ${Start_ss}     ${End_mm}    ${End_dd}    ${End_yyyy}    ${End_hh}   ${End_ss}  ${Close_AE}
    OGField-Open Navigation Panel 
    OGField-Click menu from NavigationPanel   ${loc_OGField_Calendar} 
    Sleep    5s

    GetElementToView    ${loc_OGField_Calendar_AgendaTime}      Calendar Agenda Time
    Sleep    2s
    GetElementToView     ${loc_OGField_Calendar_Add_Agenda}    Add Agenda
    Sleep    2s
    GetElementToView     ${loc_OGField_Agenda_StartDate_Calendar}    StartDate_Calendar
    Sleep    2s
    # Execute Javascript    document.querySelector("#page-main > div.ui-datebox-container.ui-overlay-shadow.ui-corner-all.pop.ui-body-b.in > span > div.ui-datebox-align.ui-datebox-dboxin.ui-grid-d > div.ui-block-d > input").value=10
    ukw_Generic_AppKeywords.Calendar-SelectStartDate       ${Start_mm}    ${Start_dd}    ${Start_yyyy}    ${Start_hh}    ${Start_ss}

    GetElementToView     ${loc_OGField_Agenda_EndDate_Calendar}    EndDate_Calendar
    Sleep    2s
    # Execute Javascript    document.querySelector("#page-main > div.ui-datebox-container.ui-overlay-shadow.ui-corner-all.pop.ui-body-b.in > span > div.ui-datebox-align.ui-datebox-dboxin.ui-grid-d > div.ui-block-d > input").value=10
    ukw_Generic_AppKeywords.Calendar-SelectStartDate      ${End_mm}    ${End_dd}    ${End_yyyy}    ${End_hh}   ${End_ss}


    IF    '${Close_AE}' == 'True'
        GetElementToView    ${loc_OGField_Agenda_Close}   Agenda_Close
        Sleep    2s
        GetElementToView    ${loc_OGField_CalendarAE_Close}   CalendarAE_Close
        Sleep    2s
    END
    


OGField-GetStatusGroup_VerifyStatus_Complete job  
    #Get Status Group , verify status for all next staus and complete job
    GetElementToView    ${loc_OGField_Joblist}    OGField_Topmenu_Joblist 
    
    ${TotalStatus}=    Evaluate    ${numberOfStatus} - 1  #Start from ACCEPTED and not DISPATCHED

    FOR    ${counter}    IN RANGE    0    ${numberOfStatus}    

        Set global variable    ${ActiveStatus}     ${ListOfActiveStatus}[${counter}]  
        Set Global Variable    ${Status}    ${ListOfStatus}[${counter}]
        Set Global Variable    ${StatusDescription}    ${ListOfStatusDescription}[${counter}]  

        # Log To Console    ${counter} -- ${ActiveStatus}--${Status} --${StatusDescription} 
    
        # OGField-Verify Crew Status on Topmenu is CLEARED
        IF    '${ActiveStatus}' == 'T'
            OGField-Verify Crew Status on Topmenu    ${StatusDescription}
        ELSE
            OGField-Verify Crew Status on Topmenu    CLEARED       
        END        

        IF  '${StatusDescription}' != 'CLEARED'
            # Verify PF job status in joblist
            GetElementToView    ${loc_OGField_Joblist}    OGField_Topmenu_Joblist
            Sleep    5s
            OGField-Verify Joblist value   ${StatusDescription}            

            # Switch to OGW
            seleniumlibrary.Switch Browser    ${OGW_Alias}
            Sleep    2s

            # OGW-Verify status in Joblist Crewlist Assignmentlist
            OGW-Verify StatusCode or StatusDescription in Joblist Crewlist Assignmentlist
            
            seleniumlibrary.Switch Browser    ${OGF_Alias}
            # OGField-Perform Next Status
            OGField-Select Footer Next Status
            Generic-Click element if shown    ${loc_OGField_SafetyMessage_OK}
            Generic-Click element if shown    ${loc_OGField_VehicleMileage_Cancel}              
            Sleep   5s
            Generic-Click element if shown    ${loc_OGField_Timesheet_Accept}  
            Sleep    5s
        ELSE
        
            IF    ${DB_DisposeJob} == $True
                Generic-Click element if shown    ${loc_OGField_Dispose_Yes}
                Sleep    5s
            END 
            
            OGField-DisposeJob
        END
    END


# ==============ATTACHMENT WINDOW==============================================
OGField-Attachment_OpenWindow_From_Footer
    TRY
        GetElementToView    ${loc_OGField_Footer_Attachment}    OGField_Footer_Attachment
        Wait Until Element Is Visible    ${loc_OGField_Attachment_UploadFile}    40s
    EXCEPT
        Log   Check the screenshot for more details
        ukw_Common.CaptureScreen    ${TEST_NAME}.png
       FAIL    Attachment window not found in footer
    END 
    
OGField-Attachment_UploadFile
    [Arguments]    ${attachfile}
    TRY
        GetElementToView    ${loc_OGField_Attachment_AddNewFile}    OGField_Attachment_AddNewFile
        Sleep    5s
        
        # Upload file
        ${file}    Set Variable    ${Upload_Download_Folder}${attachfile}
        Choose File    ${loc_OGField_Attachment_FileName_WindowsAlert}    ${file}
        GetElementToView    ${loc_OGField_Attachment_UploadFile}    OGField_Attachment_UploadFile    
        Sleep    5s
        
        # Verify if file is attached
        ukw-Verify Value contains Input Element partially    ${loc_OGField_Attachment_AttachedFilename}  ${attachfile}        

        Generic-Verify page contains element and update report    ${loc_OGField_Attachment_Comments}   Verify Comments is found
        Sleep    5s
    EXCEPT
        Log   Check the screenshot for more details
        ukw_Common.CaptureScreen    ${TEST_NAME}.png
        FAIL    Issue in OGField-Attachment_UploadFile
    END
    
   

OGField-Attachment_Close
    GetElementToView    ${loc_OGField_Attachment_Close}   OGField_Attachment_Close
    Sleep    5s

OGField-Attachment_DeleteFile   
    GetElementToView    ${loc_OGField_Attachment_Delete}   OGField_Attachment_Delete
    Sleep    5s
    Generic-Click element if shown    ${loc_OGField_Yes1}
    Sleep    20s

OGField-Attachment_VerifyFileDeleted
    [Arguments]    ${file}   
    # Verify file is deleted
    ${elem_exist}    Run Keyword And Return Status  Page Should Not Contain Element  ${loc_OGField_Attachment_AttachedFilename}
    IF    '${elem_exist}' == 'True'
        Log   File is deleted successfully
    ELSE
        Log   File is not deleted successfully
        ukw_Common.CaptureScreen    ${TEST_NAME}.png
        Fail   File is not deleted successfully
    END

OGField-Attachment_DownloadFile_VerifyDownloadedFile
    [Arguments]    ${attachfile}
    # Download file
    GetElementToView    ${loc_OGField_Attachment_Download}   OGField_Attachment_Download
    
    Sleep    5s
    
    # Verify if file is downloaded
    ukw_GetCurrentUserName
    ${pattern}    Set Variable    .*testing1\.txt$
    ${file}    Get File Matching Pattern    C:\\Users\\${current_user_name}\\Downloads\\    ${pattern}
    ${file_exist}    Run Keyword And Return Status    File Should Exist    ${file}
    
    IF  '${file_exist}' == 'True'
        Log   File is downloaded successfully
        Sleep   5s
        DeleteFile_FromFolder    ${file} 
    ELSE
        Log   File is not downloaded successfully
        ukw_Common.CaptureScreen    ${TEST_NAME}.png
        Fail   File is not downloaded successfully
    END

Get File Matching Pattern
    [Arguments]    ${folder}    ${pattern}
    ${files}=    List Files In Directory    ${folder}
    FOR    ${file}    IN    @{files}
        ${match}=    Run Keyword And Return Status    Should Match Regexp    ${file}    ${pattern}
       IF    '${match}' == 'True'
            RETURN    ${folder}${/}${file}
       END
    END
    Fail    No file matching pattern '${pattern}' found in folder '${folder}'

# ======Job Jar==========================================================================
OGField-Navigate to JobJar
    OGField-Open Navigation Panel
    OGField-Click menu from NavigationPanel    ${loc_OGField_JobJar}
    Generic-Click element if shown    ${loc_OGField_Acknowledge}    

    ${Sys_messg}=     ukw_GetValue_FromDB_CAD_Parameter     NOJOBJARDEFQUERY    ${DB_SYSTEMMESSAGE} 
    Set Global Variable    ${Sys_messg}    ${Sys_messg}
    ${loc_OGField_System_Notification}=    Replace Variables    ${loc_OGField_System_Notification}

    Generic-Click element if shown    ${loc_OGField_Acknowledge}    

OGField-Select JobJar Query
    GetElementToView    ${loc_OGField_JobJar_Filter}    JobJar Filter 

    ${loc_OGField_JobJar_SelectQuery1}=    Replace Variables    ${loc_OGField_JobJar_SelectQuery1}
    ${loc_OGField_JobJar_SelectQuery2}=    Replace Variables    ${loc_OGField_JobJar_SelectQuery2}

    GetElementToView    ${loc_OGField_JobJar_SelectQuery1}    JobJar_SelectQuery1
    GetElementToView    ${loc_OGField_JobJar_SelectQuery2}    JobJar_SelectQuery2
    
    Wait Until Element Is Visible    ${loc_OGField_JobJar_Table}    10 seconds   
    Generic-Verify page contains element and update report    ${loc_OGField_JobJar_Table}    Verify Job jar table is shown
    Generic-Verify page contains element and update report    ${loc_OGField_JobJar_Refresh}    Verify Refresh button is shown
    Generic-Verify page contains element and update report   ${loc_OGField_JobJar_AssignSelected}   Verify AssignSelected button is shown

OGField-Open TimesheetApproval_VerifyDefaultDisplay
    [Arguments]    ${OpenTSApproval}  
    
    # Open TimesheetApproval
    IF    '${OpenTSApproval}' == 'Y'
        OGField-Open Navigation Panel
        OGField-Click menu from NavigationPanel    ${loc_OGField_TimesheetApproval}
    END
	
	Generic-Verify page contains element and update report    ${loc_OGField_TSApproval_Query}    Verify TSApproval_Query is shown
    Generic-Verify page contains element and update report    ${loc_OGField_TSApproval_AgencyCode}    Verify TSApproval_AgencyCode is shown
    Generic-Verify page contains element and update report    ${loc_OGField_TSApproval_SupervisedBy}    Verify TSApproval_SupervisedBy is shown
    Generic-Verify page contains element and update report    ${loc_OGField_TSApproval_BadgeNo}    Verify TSApproval_BadgeNo is shown
    Generic-Verify page contains element and update report    ${loc_OGField_TSApproval_MemberName}   Verify TSApproval_MemberName is shown   
    Generic-Verify page contains element and update report    ${loc_OGField_TSApproval_Status}   Verify TSApproval_Status is shown 
    Generic-Verify page contains element and update report    ${loc_OGField_TSApproval_Search}   Verify TSApproval_Search is shown
    Generic-Verify page contains element and update report    ${loc_OGField_TSApproval_Clear}   Verify TSApproval_Clear is shown
    Generic-Verify page contains element and update report    ${loc_OGField_TSApproval_EmployeeName}   Verify TSApproval_EmployeeName is shown
