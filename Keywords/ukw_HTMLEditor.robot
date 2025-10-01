*** Settings ***
Resource    ukw_Common.robot


*** Keywords ***
HTML-Login To HTML
    [Arguments]    ${user}    ${password}    ${application}
    TRY 
        Wait Until Element Is Visible    ${loc_HTML_Username}    10s
        Clear Element Text    ${loc_HTML_Username}
        Input Text    ${loc_HTML_Username}    ${user}
        Clear Element Text    ${loc_HTML_Password}
        Input Text    ${loc_HTML_Password}    ${password}

        Select From List By Value    ${loc_HTML_ApplicationDropdown}    ${application}
        Click Button    ${loc_HTML_Login}
         
        Wait Until Element Is Visible    ${loc_HTML_AvailableObjects}    20s
        GetElementToView    ${loc_HTML_AvailableObjects}    HTML_AvailableObjects          

        CaptureScreen_AddStepsToReport    ${TEST_NAME}_HTML-Login.png     Login To HTML    passed

    EXCEPT
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_HTML-Login.png    Login To HTML    failed
        Close Browser
        FAIL     Login to HTML failed
    END

     
HTML-Logout from HTML
    TRY
        GetElementToView    ${loc_HTML_LogOff}    HTML_LogOff
        Sleep    2s
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_HTML-Logout.png    Logout from HTML    passed

    EXCEPT 
        CaptureScreen_AddStepsToReport    ${TEST_NAME}_HTML-Logout.png    Logout from HTML    failed
        Close Browser
        FAIL     Logout from HTML failed     
    END
    
