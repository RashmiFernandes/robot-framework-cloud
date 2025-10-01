*** Settings ***
Resource    ukw_Common.robot


*** Keywords ***
Appconfig-Login to Appconfig
    [Arguments]    ${user}    ${password}  
    TRY
        Wait Until Element Is Visible    ${loc_Appconfig_Username}    20s
        Clear Element Text    ${loc_Appconfig_Username}
        Input Text    ${loc_Appconfig_Username}    ${user}
        Clear Element Text    ${loc_Appconfig_Password}
        Input Text    ${loc_Appconfig_Password}    ${password}
        Click Button    ${loc_Appconfig_Login}
    
        # Wait Until Element Is Not Visible    ${loc_Appconfig_Login}    5s
        Wait Until Element Is Visible    ${loc_Appconfig_MainMenu}    50s
        Sleep    5s
        Mouse Over    ${loc_Appconfig_MainMenu}
        Click Element    ${loc_Appconfig_SafetyMessage}
        Wait Until Element Is Visible    ${loc_Appconfig_SafetyMessage_Message}    50s
        Page Should Contain Element    ${loc_Appconfig_SafetyMessage_Message}    Saftery Message page not loaded
        ukw_Common.CaptureScreen    ${TEST_NAME}_Login.png
        Sleep    5s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Appconfig-Login.png    Login to Appconfig    passed

    EXCEPT   
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Appconfig-Login.png    Login to Appconfig   failed
        Close All Opened Browsers 
        FAIL     OGAppconfig home page not loaded       
    END

Appconfig-Logout from Appconfig
    TRY
        Mouse Over    ${loc_Appconfig_MainMenu}
        GetElementToView    ${loc_Appconfig_LogOff}    Appconfig_LogOff
        Sleep    2s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Appconfig-Logout.png    Logout from Appconfig    passed

    EXCEPT 
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Appconfig-Logout.png    Logout from Appconfig    failed
        Close Browser
        FAIL     Logout from Appconfig failed
    END
    


Appconfig-UI Verification of all menus
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_alarm_maintenance}   ${loc_Appconfig_AlarmMaintenance_AlarmConfig_Name}    AlarmMaintenance_AlarmConfig_Name
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_auditlogs}   ${loc_Appconfig_AuditLog_ModificationDate}    AuditLog_ModificationDate
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_bundling}   ${loc_Appconfig_Bundling_BundlingDefinition_Agency}    Bundling_BundlingDefinition_Agency
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_calendar}   ${loc_Appconfig_Calendar_Holiday_Name}    Calendar_Holiday_Name
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_conditions}   ${loc_Appconfig_Conditions_ConditionType}    Conditions_ConditionType
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_copy_config}   ${loc_Appconfig_CopyConfig_CopyConfig_SourceDatabase}    CopyConfig_CopyConfig_SourceDatabase
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_configuration_manager}   ${loc_Appconfig_ConfigManager_Application}    ConfigManager_Application
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_damage_assessment}   ${loc_Appconfig_DamageAssessment_DamageTypes_Name}    DamageAssessment_DamageTypes_Name
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_material_maintenace}   ${loc_Appconfig_MaterialMaint_MaterialCategories_Name}    MaterialMaint_MaterialCategories_Name
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_query_builder}   ${loc_Appconfig_QueryBuilder_Form}    QueryBuilder_Form

        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_resource_work_optimization}   ${loc_Appconfig_RWO_Maintenance_ProfileList}    RWO_Maintenance_ProfileList
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_create_new_personnel}   ${loc_Appconfig_CreateNewPersonnel_Agency}    CreateNewPersonnel_Agency
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_test_maintenance}   ${loc_Appconfig_TestMaint_NumberPropertyID}    TestMaint_NumberPropertyID
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_same_premise}   ${loc_Appconfig_SamePremise_AgenciesGroupDefinition_Name}    SamePremise_AgenciesGroupDefinition_Name
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_SafetyMessage}   ${loc_Appconfig_SafetyMessage_CommunicationGroups}    SafetyMessage_CommunicationGroups
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_status_group_maintenance}   ${loc_Appconfig_StatusGroupMaintenance_Statuses_StatusGroup}    StatusGroupMaintenance_Statuses_StatusGroup
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_reason_exception_color}   ${loc_Appconfig_ReasonExceptionColor_Name}    ReasonExceptionColor_Name
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_job_field_lock_maintenance}   ${loc_Appconfig_JobFieldLockMaintenance_AgencyCode}    JobFieldLockMaintenance_AgencyCode
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_job_report_selections}   ${loc_Appconfig_JobReportSelections_AgencyCode}    JobReportSelections_AgencyCode
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_disposal_codes}   ${loc_Appconfig_DisposalCode_AgencyCode}    DisposalCode_AgencyCode
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_esp_configuration}   ${loc_Appconfig_EspConfig_AgencyCode}    EspConfig_AgencyCode
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_esp_schedule}   ${loc_Appconfig_EspSchedule_Schedule_AgencyCode}    EspSchedule_Schedule_AgencyCode
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_timesheet_configuration}   ${loc_Appconfig_TimesheetConfiguration_General_Personnelmode}    TimesheetConfiguration_General_Personnelmode
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_error_handling}   ${loc_Appconfig_ErrHandling_ErrList_TransanctionID}    ErrHandling_ErrList_TransanctionID
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_priority}   ${loc_Appconfig_Priority_SystemPriority}    Priority_SystemPriority
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_me_activity_type}   ${loc_Appconfig_MeActivityType_ActivityType_ActivityName}    MeActivityType_ActivityType_ActivityName
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_me_activity_job_types}   ${loc_Appconfig_MeActivityJobType_ActivityType_ButtonCode}    MeActivityJobType_ActivityType_ActivityName
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_me_data_source}   ${loc_Appconfig_MeDataSource_AttributeName}    MeDataSource_AttributeName
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_me_button_action}   ${loc_Appconfig_ButtonActions_ButtonCode}    ButtonActions_ButtonCode
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_agenda_exception}   ${loc_Appconfig_AgendaExcep_AgencyCode}    AgendaExcep_AgencyCode


Appconfig-Click element_VerifyElement exists_Reload page
    [Arguments]    ${element}    ${elementToVerify}    ${messg}
    TRY
        Reloading Page     Appconfig   
        Mouse Over    ${loc_Appconfig_MainMenu}
        # Run Keyword And Continue On Failure   GetElementToView    ${loc_Appconfig_LeftPanel_Home}    LeftPanel_Home        
        # Run Keyword And Continue On Failure   Mouse Over    ${loc_Appconfig_MainMenu}
        # Sleep   2s
        Run Keyword And Continue On Failure   GetElementToView    ${element}    ${element} 

        Run Keyword And Continue On Failure   Wait Until Element Is Visible    ${elementToVerify}    60s
        ukw_Common.CaptureScreen    ${messg}.png
        Page Should Contain Element    ${elementToVerify}    ${messg} not found    

        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Appconfig-Verify_${messg}.png    ${messg} found on page     passed
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Appconfig-Verify_${messg}.png    ${messg} found on page     failed
        FAIL    Appconfig-Click element_VerifyElement exists failed
    END

        
    

    
TEST-UI Verification of all menus
        Run Keyword And Continue On Failure    Appconfig-Click element_VerifyElement exists_Reload page    ${loc_Appconfig_LeftPanel_agenda_exception}   ${loc_Appconfig_AgendaExcep_AgencyCode}    AgendaExcep_AgencyCode
