*** Settings ***
Library         Collections
Library         OperatingSystem
Library         DateTime
Library         SeleniumLibrary
Library         String

# Import environment configuration library
Library         ../../Resource/EnvironmentConfig.py

Suite Setup     Demo_Suite_Setup
Suite Teardown  Demo_Suite_Teardown
Test Setup      Set Selenium Timeout    200 seconds
Test Teardown   Demo_Test_Teardown

*** Variables ***
${JobCount_Before}    0
${JobCount_After}     0

*** Test Cases ***
TC1-OGF_CreateJob_FromNavigationPanel_DEMO
    [Documentation]    Demo version of OGF_CreateJob_FromNavigationPanel for Environment A (sprints-PREDEV)
    [Tags]    OGF_CreateJob_Demo    sprints-PREDEV

    Log    🚀 Starting TC1-OGF_CreateJob_FromNavigationPanel for Environment ${TEST_ENV}
    
    # Step 1: Load test configuration and data
    Load Environment Configuration For Test
    
    # Step 2: Verify environment setup
    Verify Environment Variables Are Set
    
    # Step 3: Open browser and navigate to OGField
    Open Browser And Navigate To OGField
    
    # Step 4: Login to OGField
    Login To OGField Demo
    
    # Step 5: Get initial job count (simulation)
    Get JobCount From TopMenu Demo
    
    # Step 6: Create new job (simulation)
    Create New Job Demo
    
    # Step 7: Verify job count increased
    Verify JobCount Increased Demo
    
    # Step 8: Logout
    Logout From OGField Demo
    
    Log    ✅ TC1-OGF_CreateJob_FromNavigationPanel completed successfully!

*** Keywords ***
Demo_Suite_Setup
    [Documentation]    Setup for demo test execution
    
    Log    🔧 Setting up demo suite for environment: ${TEST_ENV}
    
    # Load environment configuration
    ${env}=    Get Variable Value    ${TEST_ENV}    A
    Load Environment Config    ${env}
    
    # Set browser options for demo
    ${chrome_options}=    Create List    --disable-web-security    --allow-running-insecure-content
    
    # Create directories
    Create Directory    ${OUTPUT_DIR}/screenshots
    Create Directory    ${OUTPUT_DIR}/demo_logs
    
    Log    ✅ Demo suite setup completed

Demo_Suite_Teardown
    [Documentation]    Cleanup after demo test execution
    
    Log    🧹 Starting demo suite teardown
    
    # Close all browsers
    Close All Browsers
    
    # Generate demo report
    Generate Demo Test Report
    
    Log    ✅ Demo suite teardown completed

Demo_Test_Teardown
    [Documentation]    Test-level teardown for demo
    
    Run Keyword If Test Failed    Capture Demo Screenshot On Failure
    
    Log    Test completed

Load Environment Configuration For Test
    [Documentation]    Load and verify environment configuration
    
    Log    📋 Loading configuration for environment: ${TEST_ENV}
    
    # Verify key variables are loaded
    Should Not Be Empty    ${OGF_URL}    OGF URL should be set
    Should Not Be Empty    ${OGF_USER}   OGF User should be set
    Should Not Be Empty    ${OGF_PWD}    OGF Password should be set
    
    Log    Environment Configuration Loaded:
    Log    - Environment: ${TEST_ENV}
    Log    - OGF URL: ${OGF_URL}
    Log    - OGF User: ${OGF_USER}
    Log    - Browser: ${WebBrowser}
    
    Set Test Variable    ${ENV_LOADED}    true

Verify Environment Variables Are Set
    [Documentation]    Verify all required environment variables are properly set
    
    Log    🔍 Verifying environment variables for sprints-PREDEV
    
    # Check critical URLs
    Should Contain    ${OGF_URL}    rdm19dva31-ogfield
    Should Contain    ${OGW_URL}    rdm19dva31-ogdispatch
    Should Contain    ${HTML_URL}   rdm19dva31.integration.ssp
    
    # Check users
    Should Be Equal    ${OGF_USER}    TRAIN01
    Should Be Equal    ${HTML_USER}   TRAIN01
    
    # Check test environment
    Should Be Equal    ${TEST_ENV}    sprints-PREDEV
    
    Log    ✅ All environment variables verified successfully!

Open Browser And Navigate To OGField
    [Documentation]    Open browser and navigate to OGField URL
    
    Log    🌐 Opening browser and navigating to OGField
    Log    URL: ${OGF_URL}
    Log    Browser: ${WebBrowser}
    
    # For demo purposes, we'll simulate browser opening without actually opening
    # Remove this condition and uncomment below lines for real execution
    ${demo_mode}=    Get Variable Value    ${DEMO_MODE}    true
    
    Run Keyword If    '${demo_mode}' == 'false'
    ...    Open Browser    ${OGF_URL}    ${WebBrowser}    alias=${OGF_Alias}
    ...    ELSE
    ...    Log    🎭 DEMO MODE: Simulating browser opening to ${OGF_URL}
    
    Log    ✅ Browser navigation completed

Login To OGField Demo
    [Documentation]    Login to OGField application
    
    Log    🔐 Logging into OGField
    Log    Username: ${OGF_USER}
    Log    Password: [HIDDEN]
    
    # Demo simulation of login process
    Log    🎭 DEMO: Simulating login steps:
    Log    1. Waiting for username field to be visible
    Log    2. Entering username: ${OGF_USER}
    Log    3. Entering password
    Log    4. Clicking login button
    Log    5. Waiting for dashboard to load
    
    # Set login status
    Set Test Variable    ${LOGIN_STATUS}    SUCCESS
    
    Log    ✅ Login to OGField completed successfully

Get JobCount From TopMenu Demo
    [Documentation]    Get current job count from top menu
    
    Log    📊 Getting job count from top menu
    
    # Simulate getting job count
    ${current_time}=    Get Current Date    result_format=epoch
    ${simulated_count}=    Evaluate    int(${current_time}) % 100
    
    Set Test Variable    ${JobCount_Before}    ${simulated_count}
    
    Log    📈 Current job count: ${JobCount_Before}
    Log    🎭 DEMO: Simulated job count retrieval from top menu

Create New Job Demo
    [Documentation]    Create a new job from navigation panel
    
    Log    ➕ Creating new job from navigation panel
    
    # Log job details from configuration
    Log    Job Type: ${JOBTYPE1}
    Log    Agency: ${Agency1}
    Log    Job Details: ${CreateJob_JobDetails1}
    
    # Demo simulation of job creation
    Log    🎭 DEMO: Simulating job creation steps:
    Log    1. Clicking on 'Create Job' in navigation panel
    Log    2. Selecting job type: ${JOBTYPE1}
    Log    3. Setting agency: ${Agency1}
    Log    4. Entering address: 205 ISLAND AVE
    Log    5. Setting city and other details
    Log    6. Clicking 'Save' to create job
    Log    7. Waiting for job creation confirmation
    
    # Simulate job creation success
    ${new_job_id}=    Generate Random String    8    0123456789
    Set Test Variable    ${CREATED_JOB_ID}    JOB-${new_job_id}
    
    Log    ✅ Job created successfully with ID: ${CREATED_JOB_ID}

Verify JobCount Increased Demo
    [Documentation]    Verify that job count increased by one
    
    Log    🔢 Verifying job count increased
    
    # Simulate getting updated job count
    ${JobCount_After}=    Evaluate    ${JobCount_Before} + 1
    Set Test Variable    ${JobCount_After}    ${JobCount_After}
    
    Log    📊 Job count verification:
    Log    - Before: ${JobCount_Before}
    Log    - After: ${JobCount_After}
    Log    - Difference: ${JobCount_After - JobCount_Before}
    
    # Verify count increased
    Should Be Equal As Numbers    ${JobCount_After}    ${JobCount_Before + 1}
    
    Log    ✅ Job count verification successful - count increased by 1

Logout From OGField Demo
    [Documentation]    Logout from OGField application
    
    Log    🚪 Logging out from OGField
    
    # Demo simulation of logout
    Log    🎭 DEMO: Simulating logout steps:
    Log    1. Clicking user menu
    Log    2. Selecting 'Logout' option
    Log    3. Confirming logout
    Log    4. Waiting for login page to appear
    
    Set Test Variable    ${LOGOUT_STATUS}    SUCCESS
    
    Log    ✅ Logout from OGField completed successfully

Capture Demo Screenshot On Failure
    [Documentation]    Capture screenshot on test failure
    
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${screenshot_name}=    Set Variable    demo_failure_${timestamp}.png
    
    Log    📸 Capturing failure screenshot: ${screenshot_name}
    
    # In demo mode, just log the action
    Log    🎭 DEMO: Would capture screenshot to ${OUTPUT_DIR}/screenshots/${screenshot_name}

Generate Demo Test Report
    [Documentation]    Generate a demo test execution report
    
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${report_file}=    Set Variable    ${OUTPUT_DIR}/demo_logs/demo_execution_report_${timestamp}.txt
    
    ${report_content}=    Catenate    SEPARATOR=\n
    ...    ========================================
    ...    DEMO TEST EXECUTION REPORT
    ...    ========================================
    ...    Environment: ${TEST_ENV} (sprints-PREDEV)
    ...    Test Case: TC1-OGF_CreateJob_FromNavigationPanel
    ...    Execution Time: ${timestamp}
    ...    
    ...    Configuration Loaded:
    ...    - OGF URL: ${OGF_URL}
    ...    - OGF User: ${OGF_USER}
    ...    - Job Type: ${JOBTYPE1}
    ...    - Agency: ${Agency1}
    ...    
    ...    Test Results:
    ...    - Login Status: ${LOGIN_STATUS}
    ...    - Job Count Before: ${JobCount_Before}
    ...    - Job Count After: ${JobCount_After}
    ...    - Created Job ID: ${CREATED_JOB_ID}
    ...    - Logout Status: ${LOGOUT_STATUS}
    ...    
    ...    Status: DEMONSTRATION COMPLETED SUCCESSFULLY
    ...    ========================================
    
    Create File    ${report_file}    ${report_content}
    
    Log    📋 Demo test report generated: ${report_file}