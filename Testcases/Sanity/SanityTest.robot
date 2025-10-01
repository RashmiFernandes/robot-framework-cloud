*** Settings ***
Resource            ../../Keywords/ukw_Common.robot    # All resource files are in common.robot

Suite Setup         ukw_Suite_Setup
Suite Teardown      ukw_Suite_Teardown
Test Setup          SeleniumLibrary.Set Selenium Timeout    200 seconds
Test Teardown       Teardown_Update Report      #Custom Report


Library    RPA.RobotLogListener
# =============================================================================================================================
*** Test Cases ***
TC1-OGF_CreateJob_FromNavigationPanel
    [Documentation]    OGF_CreateJob_FromNavigationPanel
    [Tags]    OGF_CreateJob_FromNavigationPanel

    #Parameters: test_name    testdata_reference      customreport_index    customreport_testname  
    InitializeTest_CustomReport_LoadTestcaseData    SanityTest    SanityTest    0    "OGField_CreateJob_FromNavigationPanel"    

    # Get_OGField_LoginDetails
    IF  '${TEST_ENV}' == 'sprints-PREDEV '
        Get_OGField_LoginDetails_LoginToApp   None    ${DB_OGF_User_Filter1_MTRREAD}
    ELSE
        Get_OGField_LoginDetails_LoginToApp   DutyOn    ${DB_OGF_User}
    END

    #Get JobCount from Topmenu
    OGField-Get JobCount from Topmenu

    # # Create job from Navigation Panel
    OGField_Create_New_Job
    
    # # Verify JobCount increased by one
    OGField-Verify Topmenu JobCount Increased By One
    
    OGField-Logout from OGField

    Close Browser  
#  ============================================================================================================
TC2-HTML-Navigate_and_verify
    [Tags]    HTML_HomePage
    [Documentation]    Login to HTML and verify if login is successful
    
    #Parameters: test_name    testdata_reference      customreport_index    customreport_testname 
    InitializeTest_CustomReport         SanityTest    SanityTest   1    "HTML-Navigate_and_verify"
    
    ukw_Common.Open Browser to test    ${HTMLURL}   ${WebBrowser}   ${HTML_Alias}   
   
    HTML-Login To HTML    ${HTMLUSER}   ${HTMLPWD}   ${HTML_OGF}
    
    HTML-Logout from HTML
    
    HTML-Login To HTML    ${HTMLUSER}   ${HTMLPWD}   ${HTML_OGW}
    
    HTML-Logout from HTML
   
    Close Browser
#  ============================================================================================================

TC3-IncidentManager-Navigate and verify
    [Tags]    IncidentManager_HomePage
    [Documentation]    Login to IncidentManager and verify if login is successful 
    
    #Parameters: test_name    testdata_reference      customreport_index    customreport_testname 
    InitializeTest_CustomReport         SanityTest    SanityTest   3    "IncidentManager-Navigate_and_verify"

    ukw_Common.Open Browser to test    ${IncidentMgr_URL}   ${WebBrowser}     ${IncidentMgr_Alias}
    IncMgr-Login To IncMgr    ${IncMgr_USER}     ${IncMgr_PWD}
    # Calls tab
    Run Keyword And Continue On Failure      Incmgr-Click and verify element exists    ${loc_IncMgr_Calls}     ${loc_IncMgr_Account}    Calls

    # Incidents tab
    Run Keyword And Continue On Failure    Incmgr-Click and verify element exists    ${loc_IncMgr_Incidents}    ${loc_IncMgr_Incident_SelectFilter}    Incidents

    # Maps tab
    Run Keyword And Continue On Failure    Incmgr-Click and verify element exists    ${loc_IncMgr_Maps}    ${loc_IncMgr_Maps_ZoomIn}    Maps

    # Connectivity tab
    Run Keyword And Continue On Failure    Incmgr-Click and verify element exists    ${loc_IncMgr_Connectivity}    ${loc_IncMgr_Connectivity_CircuitDescription}    Connectivity

    # SwitchingPlans tab
    Run Keyword And Continue On Failure    Incmgr-Click and verify element exists    ${loc_IncMgr_SwitchingPlans}    ${loc_IncMgr_SwitchingPlans_Table}    SwitchingPlans

    IncMgr-Logout from IncMgr

    Close Browser  
  
#  ============================================================================================================
TC4-Appconfig-Navigate and verify
    [Tags]    OGAppConfig_HomePage
    [Documentation]    Login to OGAppConfig and verify if login is successful
    
    #Parameters: test_name    testdata_reference      customreport_index    customreport_testname 
    InitializeTest_CustomReport         SanityTest    SanityTest   4     "Appconfig-Navigate_and_verify"
    
    ukw_Common.Open Browser to test    ${OGAPPCONFIG_URL}   ${WebBrowser}     ${Appconfig_Alias}
   
    Appconfig-Login to Appconfig    ${APPCONFIG_USER}    ${APPCONFIG_PWD}  
    
    Appconfig-Logout from Appconfig

    Close Browser

#  ============================================================================================================
TC5-PSCOUT-Navigate and verify
    [Tags]    PSCOUT_HomePage
    [Documentation]    Login to PSCOUT and verify if login is successful
    
    #Parameters: test_name    testdata_reference      customreport_index    customreport_testname 
    InitializeTest_CustomReport         SanityTest    SanityTest   5     "PScout-Navigate_and_verify"

    ukw_Common.Open Browser to test    ${PSCOUTURL}    ${WebBrowser}     ${Pscout_Alias}
    
    PSCOUT-Login To PSCOUT     ${PSCOUTUSER}   ${PSCOUTPWD}
    
    OGSCOUT-Click Home_Navigate to Tab_Verify Page Loaded     ${loc_OGSCOUT_AddDamage}    ${loc_OGSCOUT_AddDamage_AssedID}    AddDamage    AddDamage_AssedID
    
    OGSCOUT-Click Home_Navigate to Tab_Verify Page Loaded     ${loc_OGSCOUT_DamagesList}    ${loc_OGSCOUT_DamageList_AssetIdentifier}    DamagesList    DamageList_AssetIdentifier

    OGSCOUT-Click Home_Navigate to Tab_Verify Page Loaded     ${loc_OGSCOUT_IncidentsList}    ${loc_OGSCOUT_IncidentList_IncidentId}    IncidentsList    IncidentList_IncidentId

    OGSCOUT-Click Home_Navigate to Tab_Verify Page Loaded     ${loc_OGSCOUT_DevicesList}    ${loc_OGSCOUT_DevicesList_DeviceTable}    DevicesList    DevicesList_DeviceTable
   
    OGSCOUT-Click Home_Navigate to Tab_Verify Page Loaded     ${loc_OGSCOUT_CoarseDamage}    ${loc_OGSCOUT_CoarseDamage_Table}    CoarseDamage   CoarseDamage_Table

    PSCOUT-Logout from PSCOUT

    Close Browser
   

#  ============================================================================================================
TC6-IncidentManager_CreateCall
    [Tags]    IncidentManager_CreateCall
    [Documentation]    Login to IncidentManager and verify CreateCall is successful
    
    #Parameters: test_name    testdata_reference      customreport_index    customreport_testname  
    InitializeTest_CustomReport_LoadTestcaseData    IncMgr_CreateCall    IncMgr_CreateCall    6     "IncidentManager-CreateCall" 
   
    ukw_Common.Open Browser to test    ${IncidentMgr_URL}   ${WebBrowser}    ${IncidentMgr_Alias}
    
    # Login to Incident Manager   
    IncMgr-Login To IncMgr    ${IncMgr_USER}    ${IncMgr_PWD}

    Incmgr-Click and verify element exists    ${loc_IncMgr_Calls}     ${loc_IncMgr_Account}    Calls

    # PWEB-Create a Non Connected Call
    Incmgr-Create Call    ${CustomerName}  ${IncidentPhone}  ${IncidentServiceAddress}  ${IncidentCity}  ${IncidentStructure}  ${IncidentDistrict}  ${IncidentRemarks}  ${IncidentDestination}  ${IncidentCallType}   ${IncidentProblemCode}
    
    # PWEB-Select an Incident and Create a Job
    Incmgr-Click Topmenu links    Incidents
    
    Incmgr-Search Incident and get Incident and Location ID    ${IncidentQuery}    
    
    IncMgr-Logout from IncMgr
    
    Close Browser    
  
#  ============================================================================================================

TC7-OGField_OGWorkforce_Status_DP_to_CL    
    [Tags]    Status_DP_to_CL
    [Documentation]    Change job status from DP to CL in OGField and verify status change in both OGF and OGW 

    #Parameters: test_name    testdata_reference      customreport_index    customreport_testname  
    InitializeTest_CustomReport_LoadTestcaseData    Status_DP_to_CL   Status_DP_to_CL     7     "OGField_OGWorkforce_Status_DP_to_CL"
    
    # Create job
    ukw_XMLAPI.API_CreateSingleJob 

    # Get Dipsose Job Yes or No (0 means dispose job, 1 means do not dispose)
    ukw_Generic_AppKeywords.ukw_GetDispose(Y/N)

    #Get Statusgroup list of values
    ukw_Generic_AppKeywords.ukw_StatusGroup_GetListValues
    
    # OGField-Login To OGField and DutyOn
    IF  '${TEST_ENV}' == 'sprints-PREDEV '
        Get_OGField_LoginDetails_LoginToApp   None    ${DB_OGF_User_Filter1_NOT_MTRREAD}
    ELSE
        Get_OGField_LoginDetails_LoginToApp   DutyOn    ${DB_OGF_User}
    END

    # Login To OGW and Switch to OGW-Unassign jobs from Crewlist
    IF  '${TEST_ENV}' == 'integration7-QC' or '${TEST_ENV}' == 'integration7-Cloud-QC' or '${TEST_ENV}' == 'integration7-Cloud-Sprints_Testcases'
        Get_OGW_LoginDetails_LoginToApp_UsingValue_FromGlobalData    ${OGWUSER_TESTDATA}            

    ELSE
         Get_OGW_LoginDetails_LoginToApp 
    END


    OGW_GetDBCount_UnassignJobs    StayLoggedIn

    OGW_Select job from Joblist_Assign job_Select jobnumber from Assignmentlist  

    # Switch to OGF and accept notifications
    OGField-AcceptNotifications_ForNewAssignment    
    
    # OGF-Select row in Joblist-Verify status is DISPATCHED
    OGField-Select row in Joblist    ${JOBNUMBER}
    
    OGField-Verify Joblist value   ${ListOfStatusDescription}[0]

    # OGField-Enter Field Report
    OGField_Enter_FieldReport      

    #Get status and complete job
    OGField-GetStatusGroup_VerifyStatus_Complete job      
    
    # Logout from OGField
    OGField-Logout from OGField
    
    # Logout from OGW
    OGW-Logout from OGW

    Close Browser

#  ============================================================================================================

TC8-Field Supervisor-Navigate and verify 
    [Documentation]    Verify Field Supervisor Page
    [Tags]    FS_HomePage

    #Parameters: test_name    testdata_reference      customreport_index    customreport_testname  
    InitializeTest_CustomReport_LoadTestcaseData    SanityTest    SanityTest    8    "Field Supervisor-Navigate and verify"      

    # Login To FS user
    IF  '${TEST_ENV}' == 'integration7-QC' or '${TEST_ENV}' == 'integration7-Cloud-QC' or '${TEST_ENV}' == 'integration7-Cloud-Sprints_Testcases'
        Get_FieldSupervisor_LoginDetails_LoginToApp_UsingValue_FromGlobalData    

    ELSE
        Get_FieldSupervisor_LoginDetails_LoginToApp    ${DB_FS_User}
    END

    # Get Crew details to search in crewlist
    ukw_Generic_AppKeywords.ukw_Get_OGF_LoginDetails    ${DB_OGF_User}

    # CreateSingleJob_FromXMLAPI
    API_CreateSingleJob
    
    # SearchJob_SearchCrew_AssignJob
    FS-SearchJob_SearchCrew_AssignJob

    # Refersh Crewlist and verify if Assignment list shows the new jobnumber assigned to the crew
    FS-Refresh Crewlist
    
    FS-Verify value in AssignmentList   ${JOBNUMBER}

    FS-Verify value in AssignmentList   ${CREW}

    # Verify status of job in Assignment list is DISPATCHED
    FS-Verify value in AssignmentList   DP  

    # Logout from OGField
    OGField-Logout from OGField

    Close Browser

#  ============================================================================================================