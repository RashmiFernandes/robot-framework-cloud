*** Settings ***
Resource            ../../Keywords/ukw_Common.robot    # All resource files are in common.robot

# Simplified suite setup/teardown for cloud testing
Suite Setup         Simplified_Suite_Setup
Suite Teardown      Simplified_Suite_Teardown
Test Setup          SeleniumLibrary.Set Selenium Timeout    200 seconds
Test Teardown       Simplified_Test_Teardown

# Use standard Robot Framework libraries instead of RPA
Library    Collections
Library    OperatingSystem
Library    DateTime

# =============================================================================================================================
*** Test Cases ***
TC1-Cloud_Test_Demo
    [Documentation]    Demo test for cloud execution
    [Tags]    CloudDemo

    Log    🚀 Running test in environment: ${TEST_ENV}
    
    # Initialize test data
    ${test_data}=    Create Dictionary    
    ...    environment=${TEST_ENV}
    ...    browser=${BROWSER}
    ...    timestamp=${EMPTY}
    
    ${current_time}=    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    Set To Dictionary    ${test_data}    timestamp    ${current_time}
    
    Log    Test data: ${test_data}
    
    # Verify environment configuration
    Should Not Be Empty    ${TEST_ENV}    Environment should be set
    Should Be True    '${TEST_ENV}' in ['A', 'B', 'C']    Environment should be A, B, or C
    
    Log    ✅ Cloud test demo completed successfully!

TC2-Environment_Verification
    [Tags]    EnvironmentCheck
    [Documentation]    Verify environment configuration is loaded correctly
    
    Log    🌍 Verifying environment configuration for: ${TEST_ENV}
    
    # Check if environment variables are set
    ${browser}=    Get Variable Value    ${BROWSER}    chrome
    ${headless}=    Get Variable Value    ${HEADLESS}    false
    
    Log    Environment: ${TEST_ENV}
    Log    Browser: ${browser}  
    Log    Headless: ${headless}
    
    # Verify configuration
    Should Not Be Empty    ${TEST_ENV}
    Should Not Be Empty    ${browser}
    
    Log    ✅ Environment verification completed!

*** Keywords ***
Simplified_Suite_Setup
    [Documentation]    Simplified setup for cloud testing
    
    Log    🔧 Starting simplified suite setup
    
    # Set default values if not provided
    ${test_env}=    Get Variable Value    ${TEST_ENV}    A
    ${browser}=    Get Variable Value    ${BROWSER}    chrome
    ${headless}=    Get Variable Value    ${HEADLESS}    false
    
    Set Global Variable    ${TEST_ENV}    ${test_env}
    Set Global Variable    ${BROWSER}    ${browser}
    Set Global Variable    ${HEADLESS}    ${headless}
    
    Log    Environment configured: ${TEST_ENV}
    Log    Browser configured: ${BROWSER}
    Log    Headless mode: ${HEADLESS}
    
    # Create results directory
    Create Directory    ${OUTPUT_DIR}/screenshots
    
    Log    ✅ Simplified suite setup completed

Simplified_Suite_Teardown
    [Documentation]    Simplified teardown for cloud testing
    
    Log    🧹 Starting simplified suite teardown
    
    # Close any open browsers
    Run Keyword And Ignore Error    Close All Browsers
    
    # Generate summary
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    Log    Test execution completed at: ${timestamp}
    
    Log    ✅ Simplified suite teardown completed

Simplified_Test_Teardown
    [Documentation]    Simplified test teardown
    
    Run Keyword If Test Failed    Log    ❌ Test failed in environment: ${TEST_ENV}
    Run Keyword If Test Passed     Log    ✅ Test passed in environment: ${TEST_ENV}
    
    # Capture screenshot on failure
    Run Keyword If Test Failed    Run Keyword And Ignore Error    Capture Page Screenshot