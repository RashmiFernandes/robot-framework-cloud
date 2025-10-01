*** Settings ***
Library         OperatingSystem
Library         chromedriver_autoinstaller
Library         SeleniumLibrary    timeout=60 seconds
Library         Collections
Library         DatabaseLibrary
Library         String
Library         RequestsLibrary  #For API Testing
Library         XML
Library         DateTime
Library         RPA.JSON   #to read json files
Library         Process   #use windows command eg: execute a file etc

Library         pabot.PabotLib  #For parallel execution and for shared variables eg: Sanity tests Set Suite Setup for Sanity if Appstatus is true or false

# -------------------------------------------------------
Library         ../Resource/getXML.py
Library         ../Resource/getDBValue.py
Library         ../Resource/StatusGroup.py
Library         ../Resource/getData.py
# Library         RPA.Browser.Selenium
# -------------------------------------------------------
Resource        ukw_OGField.robot
Resource        ukw_OGWorkforce.robot
Resource        ukw_XMLAPI.robot
Resource        ukw_XL.robot
Resource        ukw_GlobalVariables.robot
Resource        ukw_HTMLEditor.robot
Resource        ukw_OGSCOUT.robot
Resource        ukw_Appconfig.robot
Resource        ukw_IncMgr.robot
Resource        ukw_FieldSupervisor.robot
Resource        ukw_Generic_AppKeywords.robot
Resource        ukw_Generate_Sanity_Report.robot
Resource        ../PageObjects/locators.robot

# -------------------------------------------------------
Variables       ../PageObjects/OGF_PO.py
Variables       ../PageObjects/OGW_PO.py
Variables       ../PageObjects/HTML_PO.py
Variables       ../PageObjects/OGSCOUT_PO.py
Variables       ../PageObjects/Appconfig_PO.py
Variables       ../PageObjects/IncMgr_PO.py
Variables       ../PageObjects/FS_PO.py


*** Keywords ***
Setup chromedriver   
    [Documentation]  This keyword sets up the chromedriver for Selenium WebDriver.
    Set Environment Variable    webdriver.chrome.driver    .\\Resource\\chromedriver.exe
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys,selenium.webdriver
    ${prefs}=    Create Dictionary   profile.password_manager_leak_detection=${False}
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    RETURN   ${chrome_options}

Empty folder and files
    [Arguments]    ${folderpath}
    OperatingSystem.Empty Directory    ${folderpath}

Open Browser to test    
    [Arguments]    ${url}    ${browser}    ${alias}
    TRY
        ${chrome_options}=    Setup chromedriver    # Initialize chrome_options
        seleniumlibrary.Open Browser    ${url}    ${browser}    alias=${alias}    options=${chrome_options}
        # seleniumlibrary.Open Browser    ${url}    headlesschrome    alias=${alias}    options=${chrome_options}

        # seleniumlibrary.Maximize Browser Window
        Set Window Size    1920    1080
        Sleep   3s
        CaptureScreen_AddStepsToReport    ${alias}_OpenBrowser.png     Open Browser ${alias}    passed
        
    EXCEPT
        CaptureScreen_AddStepsToReport    ${alias}_OpenBrowser.png    Open Browser ${alias}     failed
        FAIL    Failed to open browser: ${browser} at URL: ${url} with alias: ${alias}
    END

 Close All Opened Browsers
    seleniumlibrary.Close All Browsers

CaptureScreen_AddStepsToReport
    [Arguments]    ${screenfilename}    ${stepdetails}    ${stepstatus}
    IF    '${screenfilename}' != 'None'  #IF there is no screenshot required, then don't capture it
        CaptureScreen     ${screenfilename}    
    END
        
    
    # For Report
    ${report_step_counter}=    Evaluate    ${report_step_counter}+1
    Set Global Variable    ${report_step_counter}    ${report_step_counter}
    IF    '${screenfilename}' == 'None'
        @{report_templist}=    Create List    Step${report_step_counter}-${stepdetails}    ${stepstatus}    None
    ELSE
        @{report_templist}=    Create List    Step${report_step_counter}-${stepdetails}    ${stepstatus}    ${SCREENSHOT_PATH}\\${Screenshot_filename}_${screenfilename}
    END

    ${report_insert_to_list_counter}=    Evaluate    ${report_insert_to_list_counter}+1
    Set Global Variable    ${report_insert_to_list_counter}    ${report_insert_to_list_counter}
    Insert Into List    ${finalreport_templist}    ${report_insert_to_list_counter}     ${report_templist}   #${report_insert_to_list_counter} is the index or the line number of the step to be printed
    Log     ${finalreport_templist}
    Log    ${stepdetails}

CaptureScreen
    [Arguments]    ${filename}
    TRY
        ${Screenshot_filename}=    Evaluate    ${Screenshot_filename}+1
        Set Global Variable    ${Screenshot_filename}    ${Screenshot_filename}
        # Re-enable screenshots after this section which is disabled in Suite Setup
        seleniumlibrary.Capture Page Screenshot    ${SCREENSHOT_PATH}\\${Screenshot_filename}_${filename}
    EXCEPT
        Log    Failed to capture screenshot: ${filename}    WARN
    END

Press Enter
    [Arguments]    ${arg1}
    TRY
        seleniumlibrary.Press Keys    ${arg1}    RETURN
    EXCEPT
        Log    Failed to PRESS KEYS  WARN
        CaptureScreen    ${TEST_NAME}.png
    END

Reloading Page_Generic
    # Execute Javascript    window.location.reload(true)
    seleniumlibrary.Reload Page
    Sleep    120s


Reloading Page 
    [Arguments]    ${arg}
    IF    '${arg}' == 'OGF'
        seleniumlibrary.Reload Page
        Wait until element is visible    ${loc_OGField_Joblist}    200s
    ELSE IF    '${arg}' == 'OGW'
        seleniumlibrary.Reload Page
        Wait until element is visible    ${loc_OGW_JobList_SelectQuery1}    200s
    ELSE IF    '${arg}' == 'FS'
        seleniumlibrary.Reload Page
        Wait until element is visible    ${loc_FS_JobList_SelectQuery1}    200s   
    ELSE IF    '${arg}' == 'Appconfig'     
        seleniumlibrary.Reload Page
        Wait until element is visible    ${loc_Appconfig_MainMenu}    200s 
    END

    Sleep    5s
  

Capture Screenshot and embed it into the report
    [Arguments]    ${filename}
    TRY
        Capture Page Screenshot    ${filename}=EMBED
    EXCEPT
        Log    Failed to capture screenshot: ${filename}    WARN 
    END

Switch to Window
    [Arguments]    ${alias}
    TRY
        # Switch Window    locator=NEW
        Switch Window    ${alias}    EXCEPT
    EXCEPT
        Log   Failed to Switch Window  ${alias}   WARN 
        CaptureScreen    ${TEST_NAME}.png

    END

    

Switch Main Window    # Parent tab
    Switch Window    MAIN

Switch New window    # New Tab
    Switch Window    NEW

Open New Tab
    Execute Javascript    window.open()

Navigate URL
    [Arguments]    ${URL}
    Go To    ${URL}

Scroll using Javascript
    [Arguments]    ${horizontal}    ${vertical}
    # EXAMPLE Execute Javascript    window.scrollTo(0,1500)
    ${horizontal1}=    Convert To Integer    ${horizontal}
    ${vertical1}=    Convert To Integer    ${vertical}
    Execute Javascript    window.scrollTo(${horizontal1},${vertical1})

Scroll complete page down using Javascript
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight)

Scroll complete page up using Javascript
    Execute Javascript    window.scrollTo(0,-document.body.scrollHeight)

Scroll left using Javascript
    Execute Javascript    document.body.scrollLeft


Switch OGF offline
    Execute Javascript    DiagnosticsBusinessRules.ToggleSimulOffline()
    Wait Until Page Contains Element    ${loc_OGField_ConnectivityStatus_Offline}    200s

Switch OGF online
    Execute Javascript    DiagnosticsBusinessRules.ToggleSimulOffline()
    Wait Until Page Contains Element    ${loc_OGField_ConnectivityStatus_Online}    200s

ConvertDate_DD_MM_YYYY
    [Arguments]    ${date}

    ${date1}=    Convert Date    ${date}    result_format=%d/%m/%Y
    Set Global Variable    ${date1}    ${date1}
    # Log To Console    ${date1}
    RETURN    ${date1}

ConvertDate_YYYYMMDD
    [Arguments]    ${date}

    ${date1}=    Convert Date    ${date}    result_format=%Y/%m/%d
    Set Global Variable    ${date1}    ${date1}
    # Log To Console    ${date1}
    RETURN    ${date1}

ConvertDate_MM_DD_YYYY
    [Arguments]    ${date}

    ${date1}=    Convert Date    ${date}    result_format=%m/%d/%Y
    # Log To Console    ${date1}
    RETURN    ${date1}

ConvertDate_YYYY-MM-DD
    [Arguments]    ${date}    

    ${date1}=    Convert Date    ${date}    result_format=%Y-%m-%d
    @{date_new}=    Split String To List    ${date1}    ""   
    RETURN    ${date_new}[0]

ConvertDate_MM_DD_YYYY_HH_SS
    [Arguments]    ${date}
    # @{words} =  Split String    ${date}           
    @{temp} =  Split String    ${date}       ,${SPACE} 
    ${date1}=    Convert Date    ${temp}[0]    result_format=%m/%d/%Y
    # Log To Console    ${date1}
    RETURN    ${date1}

Convert_CurrentDate_YYYY-MM-DD-HH-MM
    ${date1}=    Get Current Date    result_format=%Y-%m-%d-%H-%M   exclude_millis=False  
    RETURN    ${date1}

AddDaysToDate_YYYY-MM-DD-HH-MM
    #Days should be passed as 7 days, 30 days etc
    [Arguments]    ${date}    ${days}
    ${date1}=    Add Time To Date    ${date}    ${days}    exclude_millis=False 
    ${date1}=    Convert Date    date=${date1}    result_format=%Y-%m-%d-%H-%M   exclude_millis=False 
    RETURN    ${date1}    

AddTimetoDate_YYYY-MM-DD-HH-MM
# Increment by time..eg: by 24 means increment by 24 hours  eg increment=24:00:00
    [Arguments]    ${date}    ${time}
    ${date1}=    Get Current Date    increment=${time}  result_format=%Y-%m-%d-%H:%M  exclude_millis=False
    ${date1}=    Convert Date    date=${date1}    result_format=%Y-%m-%d-%H-%M   exclude_millis=False 
    RETURN    ${date1} 

Should Contain One Of These Substrings
    [Arguments]    ${value}    @{substrings}
    ${ns}=    Create Dictionary    substrings    ${substrings}    value    ${value}
    ${contains}=    Evaluate    any(substring in value for substring in substrings)    namespace=${ns}

Clear folder    
    [Arguments]    ${path} 
    Empty Directory    ${path} 


Copy folder
    [Arguments]    ${source}  ${destination} 
    Copy Directory    ${source}    ${destination}

GetElementToView    
    [Arguments]    ${element}  ${err_description}
    TRY 
        Wait Until Element Is Visible    ${element}    200s
        scroll element into view    ${element} 
        ukw_Common.CaptureScreen    ${TEST_NAME}.png
        Click Element    ${element} 
    EXCEPT   
        CaptureScreen_AddStepsToReport   ${TEST_NAME}.png   ${err_description} not found   failed
        FAIL   Cannot click ${err_description}, Verify if element exists
    END 

Click_Element_in_Scrollable_Page  
    [Arguments]    ${element}    

    FOR    ${scroll_range}    IN RANGE    0    ${pageHeight}    ${browserHeight}
        Execute Javascript    window.scrollBy(0, ${browserHeight})
        ${element_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${element}
        IF  ${element_visible} == ${True}  BREAK
    END
    Click Element      ${element}
    
DeleteFile_FromFolder
    [Arguments]    ${filename}
    Remove File    ${filename}

Delete_AllFiles_FromFolder
    [Arguments]    ${folderpath}     
    Run Keyword And Ignore Error    OperatingSystem.Empty Directory    ${folderpath}
    
ukw_Suite_Setup
    Close All Opened Browsers
    Register Keyword To Run On Failure    None  # Disable screenshots for this section... some steps where you don't want screenshots ...

ukw_Suite_Teardown
    Close All Opened Browsers

ukw_Suite_SanityExecution
    Close All Opened Browsers
    Load_Access_Global_JSON_File  
    Load_JSON_AppStatusFile   #Check AppStatus if App is working or not 

    # Get new value from AppStatus.json file
    ${OGField_AppStatus_NewValue}=    Read_JSON_AppStatusFile_and_ReturnSingleValue   OGField_AppStatus 
    ${OGW_AppStatus_NewValue}=    Read_JSON_AppStatusFile_and_ReturnSingleValue   OGWorkforce_AppStatus
    ${IncMgr_AppStatus_NewValue}=    Read_JSON_AppStatusFile_and_ReturnSingleValue   IncMgr_AppStatus
    ${PScout_AppStatus_NewValue}=    Read_JSON_AppStatusFile_and_ReturnSingleValue   PScout_AppStatus
    ${Appconfig_AppStatus_NewValue}=    Read_JSON_AppStatusFile_and_ReturnSingleValue   Appconfig_AppStatus
    ${HTML_AppStatus_NewValue}=    Read_JSON_AppStatusFile_and_ReturnSingleValue   HTML_AppStatus


    Set Global Variable    ${OGField_AppStatus_NewValue}    ${OGField_AppStatus_NewValue}    
    Set Global Variable    ${OGW_AppStatus_NewValue}    ${OGW_AppStatus_NewValue}    
    Set Global Variable    ${IncMgr_AppStatus_NewValue}    ${IncMgr_AppStatus_NewValue} 
    Set Global Variable    ${PScout_AppStatus_NewValue}    ${PScout_AppStatus_NewValue}    
    Set Global Variable    ${Appconfig_AppStatus_NewValue}    ${Appconfig_AppStatus_NewValue}    
    Set Global Variable    ${HTML_AppStatus_NewValue}    ${HTML_AppStatus_NewValue} 
    


ukw_Suite_SanityPreSetup
    Close All Opened Browsers

    InitializeTest         SanityTest    SanityTest 
    # Load_Access_Testcase_JSON_File 

    Load_JSON_AppStatusFile   #Check AppStatus if App is working or not   
    
    # Load apps before execution , and get value = True or False
    ${OGField_AppStatus_AfterLoadingPage}=     Load App and Get Status    ${OGF_URL}   ${WebBrowser}    ${OGF_Alias}     ${loc_OGField_Username} 
    ${OGW_AppStatus_AfterLoadingPage}=     Load App and Get Status    ${OGW_URL}   ${WebBrowser}   ${OGW_Alias}   ${loc_OGW_Username}
    ${IncMgr_AppStatus_AfterLoadingPage}=     Load App and Get Status    ${IncidentMgr_URL}   ${WebBrowser}     ${IncidentMgr_Alias}   ${loc_IncMgr_Username}         
    ${Pscout_AppStatus_AfterLoadingPage}=     Load App and Get Status    ${PSCOUTURL}   ${WebBrowser}    ${Pscout_Alias}     ${loc_OGSCOUT_Username} 
    ${Appconfig_AppStatus_AfterLoadingPage}=     Load App and Get Status    ${OGAPPCONFIG_URL}   ${WebBrowser}   ${Appconfig_Alias}   ${loc_Appconfig_Username}
    ${HTML_AppStatus_AfterLoadingPage}=     Load App and Get Status    ${HTMLURL}   ${WebBrowser}     ${HTML_Alias}   ${loc_HTML_Username}     

    # Update AppStatus.json file if App is loaded or not
    Write_JSON_AppStatusFile    OGField_AppStatus    ${OGField_AppStatus_AfterLoadingPage}
    Write_JSON_AppStatusFile    OGWorkforce_AppStatus    ${OGW_AppStatus_AfterLoadingPage}
    Write_JSON_AppStatusFile    IncMgr_AppStatus    ${IncMgr_AppStatus_AfterLoadingPage}

    Write_JSON_AppStatusFile    PScout_AppStatus    ${Pscout_AppStatus_AfterLoadingPage}
    Write_JSON_AppStatusFile    Appconfig_AppStatus    ${Appconfig_AppStatus_AfterLoadingPage}
    Write_JSON_AppStatusFile    HTML_AppStatus    ${HTML_AppStatus_AfterLoadingPage}

    # Get new value from AppStatus.json file
    ${OGField_AppStatus_NewValue}=    Read_JSON_AppStatusFile_and_ReturnSingleValue   OGField_AppStatus 
    ${OGW_AppStatus_NewValue}=    Read_JSON_AppStatusFile_and_ReturnSingleValue   OGWorkforce_AppStatus
    ${IncMgr_AppStatus_NewValue}=    Read_JSON_AppStatusFile_and_ReturnSingleValue   IncMgr_AppStatus
    ${PScout_AppStatus_NewValue}=    Read_JSON_AppStatusFile_and_ReturnSingleValue   PScout_AppStatus
    ${Appconfig_AppStatus_NewValue}=    Read_JSON_AppStatusFile_and_ReturnSingleValue   Appconfig_AppStatus
    ${HTML_AppStatus_NewValue}=    Read_JSON_AppStatusFile_and_ReturnSingleValue   HTML_AppStatus


    Set Global Variable    ${OGField_AppStatus_NewValue}    ${OGField_AppStatus_NewValue}    
    Set Global Variable    ${OGW_AppStatus_NewValue}    ${OGW_AppStatus_NewValue}    
    Set Global Variable    ${IncMgr_AppStatus_NewValue}    ${IncMgr_AppStatus_NewValue} 
    Set Global Variable    ${PScout_AppStatus_NewValue}    ${PScout_AppStatus_NewValue}    
    Set Global Variable    ${Appconfig_AppStatus_NewValue}    ${Appconfig_AppStatus_NewValue}    
    Set Global Variable    ${HTML_AppStatus_NewValue}    ${HTML_AppStatus_NewValue} 
    
    Close All Opened Browsers  

ukw_Suite_Teardown_For_SanityTest
    Close All Opened Browsers
    # Reset AppStatus.json file
    # Load_JSON_AppStatusFile   #Check AppStatus if App is working or not   

    # Write_JSON_AppStatusFile    OGField_AppStatus    DEFAULT
    # Write_JSON_AppStatusFile    OGWorkforce_AppStatus    DEFAULT
    # Write_JSON_AppStatusFile    IncMgr_AppStatus    DEFAULT


# ============================================================
ukw-Verify Value contains Input Element partially
    [Arguments]    ${element}    ${data} 
    TRY
        ${temp}=    SeleniumLibrary.Get Element Attribute   ${element}  value
        ukw_Common.CaptureScreen    ${TEST_NAME}.png
        Should Contain    ${temp}    ${data}     Value not found in the given item.
        Log   ${data} is found in ${temp}
    
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_VerifyValue.png    Verify if value is shown-${data}     passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}__VerifyValue.png    Verify if value is shown-${data}     failed
        FAIL    Verify if value is shown-${data} failed   
    END


ukw-Verify Input Element is shown or exists
    [Arguments]    ${element}    ${data} 
    ${temp}=    SeleniumLibrary.Get Element Attribute   ${element}  value
    ukw_Common.CaptureScreen    ${TEST_NAME}.png
    Should Be Equal   ${temp}    ${data}
    Log   ${data} and ${temp} are equal

# =======================================
#To retrieve value from DB for System Parameter value, the variable in query should be passed as ${CAD_Parameter} in the query.
ukw_GetValue_FromDB_CAD_Parameter   
    #Pass the CAD_Parameter that has to be updated in the query and connection query . ${DBConnect} is the connection string from json file
    [Arguments]    ${CAD_Parameter}     ${query}
    TRY
        Set Global Variable     ${CAD_Parameter}    ${CAD_Parameter} 
        ${query}=      Replace Variables    ${query}       #Replace variable from data to env var
        ${DBTempValue}=    Fetch Value From Db   ${DBConnect}   ${query}
        Log   ${DBTempValue}
        RETURN    ${DBTempValue}
    
    EXCEPT
        CaptureScreen_AddStepsToReport    GetValue_FromDB_CAD_Parameter.png    GetValue_FromDB_CAD_Parameter-did not fetch value-${CAD_Parameter}-${query}    failed
        FAIL    Failed to get DB Values. Verify if the query is correct and DB connection is established -${CAD_Parameter}-${query}       
        CaptureScreen    ${TEST_NAME}.png
    END
    
   

ukw_GetValue_FromDB
    [Arguments]   ${query}
    TRY
        ${query}=      Replace Variables    ${query}       #Replace variable from data to env var
        ${DBTempValue}=    Fetch Value From Db   ${DBConnect}   ${query}
        IF    not isinstance($DBTempValue, list)
            RETURN    ${DBTempValue}
            Log    ${DBTempValue}
        ELSE
            RETURN    ${DBTempValue}[0] 
            Log   ${DBTempValue}[0] 
        END
    
    EXCEPT
        CaptureScreen_AddStepsToReport    GetValue_FromDB.png    GetValue_FromDB-did not fetch value-${query}    failed 
        FAIL    Failed to get DB Values. Verify if the query is correct and DB connection is established -${query}       
    END
    
Load_Access_Global_JSON_File
    # Load JSON data from file
    ${json_global_data}=    RPA.JSON.Load Json From File    ${Global_JSON_File}    
    
    # Access values from the respective sections in json file
    ${system_messages}=    Collections.Get From Dictionary    ${json_global_data}    SystemMessages    default
    ${xml_data}=    Collections.Get From Dictionary    ${json_global_data}    XML_Data    default
    ${dbquery_data}=    Collections.Get From Dictionary    ${json_global_data}    DBQuery_Data     default
    ${global_generic_data}=    Collections.Get From Dictionary    ${json_global_data}    Global_Generic_Data     default
    ${TEST_ENV_TO_USE}=     Collections.Get From Dictionary    ${json_global_data}    ${TEST_ENV}    default

     
    

    # Test Env- Iterate through the dictionary and set variables dynamically--#eg: sprints-PREDEV
    FOR    ${key}    ${value}    IN    &{TEST_ENV_TO_USE}  
        Set Global Variable    ${${key}}    ${value}
    END

    # Generic data- Iterate through the dictionary and set variables dynamically
    FOR    ${key}    ${value}    IN    &{global_generic_data}  
        Set Global Variable    ${${key}}    ${value}
    END

    # DBQuery- Iterate through the dictionary and set variables dynamically
    FOR    ${key}    ${value}    IN    &{dbquery_data}  
        Set Global Variable    ${${key}}    ${value}
    END

    # System Message- Iterate through the dictionary and set variables dynamically
    FOR    ${key}    ${value}    IN    &{system_messages}  
        Set Global Variable    ${${key}}    ${value}
    END

    # XML data- Iterate through the dictionary and set variables dynamically
    FOR    ${key}    ${value}    IN    &{xml_data}  
        Set Global Variable    ${${key}}    ${value}
    END

    

Load_Access_Testcase_JSON_File
    ${json_testcase_data}=    RPA.JSON.Load Json From File    ${Testcase_JSON_File}   

    # Access values from the Testcase section in json file
    ${testcase_data}=    Collections.Get From Dictionary    ${json_testcase_data}    ${TName}     default
    ${generic_data}=       Collections.Get From Dictionary    ${json_testcase_data}    Generic_Data   default
    

    # Testcase data- Iterate through the dictionary and set variables dynamically
    FOR    ${key}    ${value}    IN    &{testcase_data}  
        Set Global Variable    ${${key}}    ${value}
    END

    # Generic data- Iterate through the dictionary and set variables dynamically
    FOR    ${key}    ${value}    IN    &{generic_data}  
        Set Global Variable    ${${key}}    ${value}
    END

# ================================================================================================
Load_JSON_GlobalDataFile    
# Use RPA.JSON libarary for reading json files
    ${GlobalJSONValue}    Load JSON from file    ${Global_JSON_File}
    Set Global Variable    ${GlobalJSONValue}   ${GlobalJSONValue}
    # Log to console     $.${GlobalJSONValue}.sprints-PREDEV.ENV
    # Log to console          ${GlobalDataValue}[ENV]--> get single value   
    # ${name}    Get value from JSON    ${file}    $.${TEST_ENV}.ENV--> get single value
    # Log to console     ${name} 

Load_JSON_TestcaseDataFile    
# Use RPA.JSON libarary for reading json files
    ${GlobalJSON_TestcaseValue}    Load JSON from file    ${Testcase_JSON_File}    
    Set Global Variable    ${GlobalJSON_TestcaseValue}   ${GlobalJSON_TestcaseValue}  

Load_JSON_XMLDataFile    
# Use RPA.JSON libarary for reading json files
    ${GlobalJSON_XMLValue}    Load JSON from file    ${XML_JSON_File}    
    Set Global Variable    ${GlobalJSON_XMLValue}   ${GlobalJSON_XMLValue}  

Load_JSON_DBQueryDataFile    
# Use RPA.JSON libarary for reading json files
    ${GlobalJSON_DBQueryValue}    Load JSON from file    ${DBQuery_JSON_File}    
    Set Global Variable    ${GlobalJSON_DBQueryValue}   ${GlobalJSON_DBQueryValue}  

Read_JSON_GlobalDataFile_and_CreateDictionary
    [Arguments]    @{key}
    ${splitstr}=    Split String    @{key}    ^
    ${len}=    Get Length    ${splitstr}  

    ${tempdict}=    Create Dictionary
    FOR    ${counter}    IN RANGE    0    ${len}
        ${name}=    Get value from JSON    ${GlobalJSONValue}    $.${TEST_ENV}.${splitstr}[${counter}]
        Set To Dictionary    ${tempdict}    ${splitstr}[${counter}]    ${name}
    END
    RETURN    ${tempdict}

Read_JSON_GenericDataFile_and_CreateDictionary
    [Arguments]    @{key}
    ${splitstr}=    Split String    @{key}    ^
    ${len}=    Get Length    ${splitstr}  

    ${tempdict}=    Create Dictionary
    FOR    ${counter}    IN RANGE    0    ${len}
        ${name}=    Get value from JSON    ${GlobalJSONValue}    $.Generic_Data.${splitstr}[${counter}]
        Set To Dictionary    ${tempdict}    ${splitstr}[${counter}]    ${name}
    END
    RETURN    ${tempdict}

Read_JSON_TestcaseDataFile_and_CreateDictionary
    [Arguments]    @{key}
    ${splitstr}=    Split String    @{key}    ^
    ${len}=    Get Length    ${splitstr}  

    ${tempdict}=    Create Dictionary
    FOR    ${counter}    IN RANGE    0    ${len}
        ${name}=    Get value from JSON    ${GlobalJSON_TestcaseValue}    $.${TName}.${splitstr}[${counter}]
        Set To Dictionary    ${tempdict}    ${splitstr}[${counter}]    ${name}
    END
    RETURN    ${tempdict}

Read_JSON_XMLDataFile_and_CreateDictionary
    [Arguments]    @{key}
    ${splitstr}=    Split String    @{key}    ^
    ${len}=    Get Length    ${splitstr}  

    ${tempdict}=    Create Dictionary
    FOR    ${counter}    IN RANGE    0    ${len}
        ${name}=    Get value from JSON    ${GlobalJSON_XMLValue}    $.${splitstr}[${counter}]
        Set To Dictionary    ${tempdict}    ${splitstr}[${counter}]    ${name}
    END
    RETURN    ${tempdict}

Read_JSON_DBQueryDataFile_and_CreateDictionary
    [Arguments]    @{key}
    ${splitstr}=    Split String    @{key}    ^
    ${len}=    Get Length    ${splitstr}  

    ${tempdict}=    Create Dictionary
    FOR    ${counter}    IN RANGE    0    ${len}
        ${name}=    Get value from JSON    ${GlobalJSON_DBQueryValue}    $.${splitstr}[${counter}]
        Set To Dictionary    ${tempdict}    ${splitstr}[${counter}]    ${name}
    END
    RETURN    ${tempdict}

Read_JSON_GlobalDataFile_and_ReturnSingleValue
    [Arguments]    ${key}
    ${name}    Get value from JSON    ${GlobalJSONValue}    $.${TEST_ENV}.${key}
    RETURN    ${name}

Read_JSON_TestcaseDataFile_and_ReturnSingleValue
    [Arguments]    ${key}
    ${name}    Get value from JSON    ${GlobalJSON_TestcaseValue}    $.${TName}.${key}
    RETURN    ${name}

Read_JSON_XMLDataFile_and_ReturnSingleValue
    [Arguments]    ${key}
    ${name}    Get value from JSON    ${GlobalJSON_XMLValue}    $.${key}
    RETURN    ${name}

Read_JSON_DBQueryDataFile_and_ReturnSingleValue
    [Arguments]    ${key}
    ${name}    Get value from JSON    ${GlobalJSON_DBQueryValue}    $.${key}
    RETURN    ${name}

Read_JSON_GenericDataFile_and_ReturnSingleValue
    [Arguments]    ${key}
    ${name}    Get value from JSON    ${GlobalJSONValue}    $.Generic_Data.${key}
    RETURN    ${name}


# =========Read AppStatus json file to know the app status whehter loaded or not to start sanity===================
Load_JSON_AppStatusFile    
# Use RPA.JSON libarary for reading json files
    ${AppStatusValue}    Load JSON from file    ${AppStatus_JSON_File}
    Set Global Variable    ${AppStatusValue}   ${AppStatusValue}
    ${appstatus_data}=    Collections.Get From Dictionary    ${AppStatusValue}    App_Status    default
    
    FOR    ${key}    ${value}    IN    &{appstatus_data}  
        Set Global Variable    ${${key}}    ${value}
    END



Read_JSON_AppStatusFile_and_CreateDictionary
    [Arguments]    @{key}
    ${splitstr}=    Split String    @{key}    ^
    ${len}=    Get Length    ${splitstr}  

    ${tempdict}=    Create Dictionary
    FOR    ${counter}    IN RANGE    0    ${len}
        ${name}=    Get value from JSON    ${AppStatusValue}    $.${TEST_ENV}.${splitstr}[${counter}]
        Set To Dictionary    ${tempdict}    ${splitstr}[${counter}]    ${name}
    END
    RETURN    ${tempdict}


Read_JSON_AppStatusFile_and_ReturnSingleValue
    [Arguments]    ${key}
    ${name}    Get value from JSON    ${AppStatusValue}    $.App_Status.${key}
    RETURN    ${name}

Write_JSON_AppStatusFile
    [Arguments]    ${key}    ${value}
    # rpa.json.Update value to JSON    ${AppStatus_JSON_File}    $.App_Status.${key}    ${value}
    ${data}=    RPA.JSON.Load Json From File    ${AppStatus_JSON_File}
    ${status}=   Get From Dictionary    ${data}   App_Status    default

    Set To Dictionary     ${status}      ${key}      ${value}
     Set To Dictionary      ${data}     App_Status       ${status}
     ${json_string}=      Convert To String       ${data}
     Create File   ${AppStatus_JSON_File}  ${json_string}
     ${content}=    Get File    ${AppStatus_JSON_File}
     ${content}=    Replace String    ${content}    '    "
     Create File    ${AppStatus_JSON_File}    ${content}

    

# ==============================================

Enter value if element is available
    [Arguments]    ${element}    ${data}
    ${elem_exist1}    Run Keyword And Return Status    Page Should Contain Element    ${element}
    ${elem_exist2}    Run Keyword And Return Status    Element Should Be Enabled    ${element}

    IF    '${elem_exist1}' == 'True' and '${elem_exist2}' == 'True'
        Input Text    ${element}    ${data}
        Sleep    5s
        ukw_Common.CaptureScreen    ${TEST_NAME}_OGF_${element}.png

    END


InitializeTest
    [Arguments]   ${test_name}    ${testdata_reference}  
    Set Global Variable    ${TEST_ENV}    ${TEST_ENV}   
    Set Global Variable    ${TName}    ${test_name} 
    Load_Access_Global_JSON_File   
    Chromeinsall
    Set Global Variable    ${Screenshot_filename}    0    #Screenshot filename counter    
    Set Global Variable    ${report_step_counter}    0   #For Report step counter
    Set Global Variable    ${report_insert_to_list_counter}    0   #For insert to list - Report step counter

    ${finalreport_templist}=    Create List   
    Set Global Variable    ${finalreport_templist}    ${finalreport_templist}



# In Each Test Suite, Check the App Status Before Proceeding
Check If App Is Available
    [Arguments]  ${app_name}
    ${status}=   Get From Dictionary    ${app_status}    ${app_name}   default
    IF    '${status}' == 'FAIL'
        Fail    ${app_name} is not available. Skipping tests
    END


Load App and Get Status
    [Arguments]    ${url}   ${browser}   ${alias}   ${element}
    ukw_Common.Open Browser to test    ${url}   ${browser}    ${alias} 
    ${result}=     Run Keyword And Return Status     Page Should Contain Element    ${element}    30s
    IF    ${result}
        ukw_Common.CaptureScreen    ${alias}_Page.png
        RETURN    PASS
    ELSE
        ukw_Common.CaptureScreen    ${alias}_Page.png
        RETURN   FAIL
    END

ukw_GetCurrentUserName
    ${current_user_name}=    Get Environment Variable    USERNAME
    SET Global Variable    ${current_user_name}    ${current_user_name}
    Log    Current logged in user: ${current_user_name}

