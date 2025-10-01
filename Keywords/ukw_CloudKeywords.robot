*** Settings ***
Library         ../Resource/EnvironmentConfig.py
Library         OperatingSystem
Library         Collections

*** Variables ***
${DEFAULT_ENV}    A

*** Keywords ***
Cloud Suite Setup
    [Documentation]    Setup for cloud-based test execution
    [Arguments]    ${environment}=${DEFAULT_ENV}
    
    Log    Setting up cloud test environment: ${environment}
    
    # Load environment-specific configuration
    Load Environment Config    ${environment}
    
    # Set browser options for cloud execution
    Set Browser Options For Environment
    
    # Create screenshots directory
    Create Directory    ${OUTPUT_DIR}/screenshots
    
    # Set global test environment variable
    Set Global Variable    ${TEST_ENV}    ${environment}
    
    Log    Cloud setup completed for environment: ${environment}

Cloud Suite Teardown
    [Documentation]    Cleanup after cloud test execution
    
    Log    Starting cloud test cleanup
    
    # Close all browsers
    Close All Browsers
    
    # Generate custom reports if needed
    Run Keyword And Ignore Error    Generate Cloud Test Report
    
    Log    Cloud test cleanup completed

Generate Cloud Test Report
    [Documentation]    Generate additional reports for cloud execution
    
    ${report_file}=    Set Variable    ${OUTPUT_DIR}/cloud_summary.html
    
    Create File    ${report_file}    
    ...    <html><head><title>Cloud Test Summary</title></head>
    ...    <body><h1>Test Execution Summary</h1>
    ...    <p>Environment: ${TEST_ENV}</p>
    ...    <p>Execution Time: ${SUITE START TIME}</p>
    ...    </body></html>
    
    Log    Cloud test report generated: ${report_file}

Open Browser For Cloud
    [Documentation]    Open browser with cloud-specific configurations
    [Arguments]    ${url}    ${browser}=chrome    ${alias}=None
    
    # Get chrome options from environment config
    ${chrome_options}=    Get Variable Value    ${CHROME_OPTIONS}    []
    
    # Create desired capabilities for cloud execution
    ${chrome_capabilities}=    Create Dictionary    
    ...    browserName=chrome
    ...    version=latest
    ...    platform=LINUX
    
    # Add chrome options to capabilities
    Run Keyword If    ${chrome_options}    
    ...    Set To Dictionary    ${chrome_capabilities}    goog:chromeOptions    ${chrome_options}
    
    # Open browser with capabilities
    Open Browser    ${url}    ${browser}    alias=${alias}    desired_capabilities=${chrome_capabilities}
    
    # Set timeouts
    Set Browser Implicit Wait    30
    Set Selenium Timeout    60
    
    # Maximize window for cloud execution
    Maximize Browser Window

Wait And Capture Screenshot On Failure
    [Documentation]    Capture screenshot on test failure for cloud debugging
    
    ${test_name}=    Get Variable Value    ${TEST_NAME}    unknown_test
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${screenshot_name}=    Set Variable    ${test_name}_${timestamp}_failure.png
    
    Run Keyword And Ignore Error    Capture Page Screenshot    ${OUTPUT_DIR}/screenshots/${screenshot_name}
    
    Log    Screenshot captured: ${screenshot_name}

Verify Environment Connection
    [Documentation]    Verify connectivity to the test environment
    [Arguments]    ${url}
    
    ${status}=    Run Keyword And Return Status    
    ...    Create Session    health_check    ${url}    verify=False
    
    Run Keyword If    ${status}    
    ...    Log    Successfully connected to ${url}
    ...    ELSE    
    ...    Fail    Failed to connect to environment: ${url}

Load Test Data For Environment
    [Documentation]    Load environment-specific test data
    [Arguments]    ${data_file}
    
    ${env_data_file}=    Set Variable    ${data_file}_${TEST_ENV}.json
    ${file_exists}=    Run Keyword And Return Status    File Should Exist    ${env_data_file}
    
    ${final_data_file}=    Set Variable If    ${file_exists}    ${env_data_file}    ${data_file}
    
    ${test_data}=    Load JSON From File    ${final_data_file}
    
    Log    Loaded test data from: ${final_data_file}
    
    [Return]    ${test_data}