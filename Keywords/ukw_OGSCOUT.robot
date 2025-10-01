*** Settings ***
Resource    ukw_Common.robot


*** Keywords ***
PSCOUT-Login To PSCOUT
    [Arguments]    ${user}    ${password}
    TRY
        Wait Until Element Is Visible    ${loc_OGSCOUT_Username}    10s
        Clear Element Text    ${loc_OGSCOUT_Username}
        Input Text    ${loc_OGSCOUT_Username}    ${user}
        Clear Element Text    ${loc_OGSCOUT_Password}
        Input Text    ${loc_OGSCOUT_Password}    ${password}
        Sleep    3s
        GetElementToView    ${loc_OGSCOUT_Agree}    OGSCOUT_Agree
        Click Button    ${loc_OGSCOUT_Login}
    
        Wait Until Element Is Visible    ${loc_OGSCOUT_AddDamage}    150s
        Page Should Contain Element  ${loc_OGSCOUT_AddDamage}    Add Damage not found        
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_PScout_Login.png    Login to PScout    passed

    EXCEPT   
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_PScout_Login.png    Login to PScout    failed
        Close Browser   
        FAIL   Login to PScout failed
    END

PSCOUT-Logout from PSCOUT
    TRY
        GetElementToView    ${loc_OGSCOUT_LogOff}    OGSCOUT_LogOff
        Sleep    2s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_PScout_Logout.png    Logout from PScout    passed

    EXCEPT   
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_PScout_Logout.png    Logout from PScout    failed
        Close All Opened Browsers 
        FAIL     Logout from PScout failed
    END
    

PSCOUT-Click and verify element exists
    [Arguments]    ${locator1}    ${locator2}    ${screen}
    GetElementToView    ${locator1}    ${locator1}
    Sleep    10s
    Generic-Verify page contains element and update report    ${locator2}     PSCOUT-Click and verify ${locator2} exists
    ukw_Common.CaptureScreen    ${TEST_NAME}_${screen}.png

PSCOUT-Add Damage
    GetElementToView    ${loc_OGSCOUT_AddDamage}    OGSCOUT_AddDamage
    Sleep    5s
    GetElementToView    ${loc_OGSCOUT_AddDamage_AssedID}    OGSCOUT_AddDamage_AssedID
    GetElementToView    ${loc_OGSCOUT_AddDamage_AssedID_Data}    OGSCOUT_AddDamage_AssedID_Data
    Sleep     1s
    GetElementToView    ${loc_OGSCOUT_AddDamage_AssetIdentifier_DamageType}    OGSCOUT_AddDamage_AssetIdentifier_DamageType
    ${AssetID}=    SeleniumLibrary.Get Text   ${loc_OGSCOUT_AddDamage_AssedID}    
    Set Global Variable    ${AssetID}    ${AssetID}
    Select From List By Index    ${loc_OGSCOUT_AddDamage_AssetIdentifier_DamageType}    10
    ${AddDamage_Type}=    SeleniumLibrary.Get Text   ${loc_OGSCOUT_AddDamage_AssetIdentifier_DamageType_Value}    
    Set Global Variable    ${AddDamage_Type}    ${AddDamage_Type}
    ukw_Common.Scroll complete page down using Javascript
    GetElementToView    ${loc_OGSCOUT_AddDamage_Submit}    OGSCOUT_AddDamage_Submit
    Sleep    5s

PSCOUT-Get Damage ID
    ${DamageID}=     SeleniumLibrary.Get Element Attribute  ${loc_OGSCOUT_DamageList_DamageId}    title
    Set Global Variable    ${DamageID}    ${DamageID}
    Sleep    1s
    ${AsstIdentifier}=    SeleniumLibrary.Get Element Attribute   ${loc_OGSCOUT_DamageList_AssetIdentifier}    title
    Set Global Variable    ${AsstIdentifier}    ${AsstIdentifier} 
    # Should Be Equal As Strings    ${AsstIdentifier}    ${AssetID}
    ${AddDamage_Type_Actual}=    SeleniumLibrary.Get Text    ${loc_OGSCOUT_DamageList_Type}
    Should Be Equal As Strings        ${AddDamage_Type_Actual}    ${AddDamage_Type}
    Sleep    1s
    ${CreationDate_Damagelist}=    SeleniumLibrary.Get Element Attribute   ${loc_OGSCOUT_DamageList_CreationDate}    title
    Set Global Variable    ${CreationDate_Damagelist}    ${CreationDate_Damagelist} 
     @{temp} =  Split String    ${CreationDate_Damagelist}       ,${SPACE} 
    ${currentdate}=    Get Current Date
    Should Contain One Of These Substrings    ${currentdate}      ${temp}[0]

OGSCOUT-Click Home_Navigate to Tab_Verify Page Loaded 
    [Arguments]    ${tab_name}    ${locate_element}   ${tab_element}    ${element}
    GetElementToView    ${loc_OGSCOUT_Home}    OGScout Home
    Sleep    2s
    TRY    
        GetElementToView    ${tab_name}    ${tab_element}
        Sleep    10s
        ukw_Common.CaptureScreen    ${TEST_NAME}_${element}.png
        Page Should Contain Element    ${locate_element}    I${element} not found
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Pscout_${element}.png        ${element} found on page    passed 
    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_Pscout_${element}.png        ${element} found on page   failed 
        FAIL   ${element} not found on page
    END