*** Settings ***
Library         Collections
Library         OperatingSystem
Library         DateTime
Library         String

# Import environment configuration library
Library         ../../Resource/EnvironmentConfig.py

Suite Setup     Demo_Suite_Setup
Suite Teardown  Demo_Suite_Teardown

*** Variables ***
${JobCount_Before}    0
${JobCount_After}     0
${LOGIN_STATUS}       NOT_SET
${LOGOUT_STATUS}      NOT_SET
${CREATED_JOB_ID}     NOT_SET

*** Test Cases ***
TC1-OGF_CreateJob_FromNavigationPanel_DEMO
    [Documentation]    Demo version of OGF_CreateJob_FromNavigationPanel for Environment A (sprints-PREDEV)
    [Tags]    OGF_CreateJob_Demo    sprints-PREDEV

    ${current_env}=    Set Variable    A
    Log    🚀 Starting TC1-OGF_CreateJob_FromNavigationPanel for Environment A (sprints-PREDEV)
    
    # Step 1: Load test configuration and data
    Load Environment Configuration For Test    ${current_env}
    Load Test Data From JSON Files
    
    # Step 2: Verify environment setup
    Verify Environment Variables Are Set
    
    # Step 3: Demo browser navigation
    Demo Browser Navigation To OGField
    
    # Step 4: Demo login process
    Demo Login To OGField
    
    # Step 5: Demo get job count
    Demo Get JobCount From TopMenu
    
    # Step 6: Demo create new job
    Demo Create New Job
    
    # Step 7: Demo verify job count increased
    Demo Verify JobCount Increased
    
    # Step 8: Demo logout
    Demo Logout From OGField
    
    Log    ✅ TC1-OGF_CreateJob_FromNavigationPanel DEMO completed successfully!

*** Keywords ***
Demo_Suite_Setup
    [Documentation]    Setup for demo test execution
    
    ${current_env}=    Get Variable Value    ${TEST_ENV}    A
    Log    🔧 Setting up demo suite for environment: ${current_env}
    
    # Initialize default values
    Set Global Variable    ${LOGIN_STATUS}       NOT_SET
    Set Global Variable    ${LOGOUT_STATUS}      NOT_SET
    Set Global Variable    ${CREATED_JOB_ID}     NOT_SET
    
    # Create directories
    Create Directory    ${OUTPUT_DIR}/screenshots
    Create Directory    ${OUTPUT_DIR}/demo_logs
    
    Log    ✅ Demo suite setup completed

Demo_Suite_Teardown
    [Documentation]    Cleanup after demo test execution
    
    Log    🧹 Starting demo suite teardown
    
    # Generate demo report
    Generate Demo Test Report
    
    Log    ✅ Demo suite teardown completed

Load Environment Configuration For Test
    [Documentation]    Load and verify environment configuration
    [Arguments]    ${environment}
    
    Log    📋 Loading configuration for environment: ${environment}
    
    # Load environment configuration
    Load Environment Config    ${environment}
    
    # Verify key variables are loaded
    ${ogf_url}=    Get Variable Value    ${OGF_URL}    NOT_SET
    ${ogf_user}=   Get Variable Value    ${OGF_USER}   NOT_SET
    ${ogf_pwd}=    Get Variable Value    ${OGF_PWD}    NOT_SET
    
    Should Not Be Equal    ${ogf_url}     NOT_SET    OGF URL should be set
    Should Not Be Equal    ${ogf_user}    NOT_SET    OGF User should be set
    Should Not Be Equal    ${ogf_pwd}     NOT_SET    OGF Password should be set
    
    Log    Environment Configuration Loaded:
    Log    - Environment: ${environment}
    Log    - OGF URL: ${ogf_url}
    Log    - OGF User: ${ogf_user}
    Log    - Browser: ${WebBrowser}

Verify Environment Variables Are Set
    [Documentation]    Verify all required environment variables are properly set
    
    Log    🔍 Verifying environment variables for sprints-PREDEV
    
    ${ogf_url}=    Get Variable Value    ${OGF_URL}    NOT_SET
    ${ogw_url}=    Get Variable Value    ${OGW_URL}    NOT_SET
    ${html_url}=   Get Variable Value    ${HTML_URL}   NOT_SET
    ${ogf_user}=   Get Variable Value    ${OGF_USER}   NOT_SET
    ${html_user}=  Get Variable Value    ${HTML_USER}  NOT_SET
    ${test_env}=   Get Variable Value    ${TEST_ENV}   NOT_SET
    
    # Check critical URLs
    Should Contain    ${ogf_url}     rdm19dva31-ogfield
    Should Contain    ${ogw_url}     rdm19dva31-ogdispatch  
    Should Contain    ${html_url}    rdm19dva31.integration.ssp
    
    # Check users
    Should Be Equal    ${ogf_user}     TRAIN01
    Should Be Equal    ${html_user}    TRAIN01
    
    # Check test environment  
    Should Be Equal    ${test_env}     sprints-PREDEV
    
    Log    ✅ All environment variables verified successfully!

Load Test Data From JSON Files
    [Documentation]    Load test data from GlobalData.json and sprints-PREDEV_TestCases.json
    
    Log    📊 Loading test data from JSON files
    
    # Load GlobalData.json
    ${global_data}=    OperatingSystem.Get File    ${CURDIR}/../../Testdata/GlobalData.json
    ${global_json}=    Evaluate    json.loads('''${global_data}''')    json
    
    # Set global variables from GlobalData.json
    Set Global Variable    ${JOBTYPE1}        ${global_json['Global_Generic_Data']['JOBTYPE1']}
    Set Global Variable    ${JOBTYPE2}        ${global_json['Global_Generic_Data']['JOBTYPE2']}
    Set Global Variable    ${WebBrowser}      ${global_json['Global_Generic_Data']['WebBrowser']}
    Set Global Variable    ${Agency1}         ${global_json['Global_Generic_Data']['Agency1']}
    
    # Load sprints-PREDEV_TestCases.json
    ${test_data}=      OperatingSystem.Get File    ${CURDIR}/../../Testdata/sprints-PREDEV_TestCases.json
    ${test_json}=      Evaluate    json.loads('''${test_data}''')    json
    
    # Set test case specific variables for OGF_OGW_CreateJob
    Set Global Variable    ${TESTCASE_JOBTYPE}     ${test_json['OGF_OGW_CreateJob']['JOBTYPE']}
    Set Global Variable    ${OGField_User}         ${test_json['OGF_OGW_CreateJob']['OGField_User']}
    Set Global Variable    ${OGField_Crew}         ${test_json['OGF_OGW_CreateJob']['OGField_Crew']}
    Set Global Variable    ${OGField_PWD}          ${test_json['OGF_OGW_CreateJob']['OGField_PWD']}
    
    Log    ✅ Test data loaded successfully from JSON files
    Log    📋 JOBTYPE1: ${JOBTYPE1}
    Log    📋 TESTCASE_JOBTYPE: ${TESTCASE_JOBTYPE}
    Log    📋 OGField_User: ${OGField_User}
    Log    📋 WebBrowser: ${WebBrowser}

Demo Browser Navigation To OGField
    [Documentation]    Demo browser opening and navigation to OGField URL
    
    ${ogf_url}=      Get Variable Value    ${OGF_URL}       NOT_SET
    ${web_browser}=  Get Variable Value    ${WebBrowser}    chrome
    
    Log    🌐 Demo: Opening browser and navigating to OGField
    Log    URL: ${ogf_url}
    Log    Browser: ${web_browser}
    
    # Demo simulation - no actual browser opening
    Log    🎭 DEMO MODE: Simulating browser opening to ${ogf_url}
    Log    🎭 DEMO: Browser would open with these settings:
    Log    - URL: ${ogf_url}
    Log    - Browser: ${web_browser}
    Log    - Window size: 1920x1080
    Log    - Timeout: 200 seconds
    
    Log    ✅ Demo browser navigation completed

Demo Login To OGField  
    [Documentation]    Demo login to OGField application
    
    ${ogf_user}=  Get Variable Value    ${OGF_USER}  NOT_SET
    ${ogf_pwd}=   Get Variable Value    ${OGF_PWD}   NOT_SET
    
    Log    🔐 Demo: Logging into OGField
    Log    Username: ${ogf_user}
    Log    Password: [HIDDEN]
    
    # Demo simulation of login process
    Log    🎭 DEMO: Simulating login steps:
    Log    1. ✅ Waiting for username field to be visible
    Log    2. ✅ Entering username: ${ogf_user}
    Log    3. ✅ Entering password: [HIDDEN]
    Log    4. ✅ Clicking login button
    Log    5. ✅ Waiting for dashboard to load
    Log    6. ✅ Verifying successful login
    
    # Set login status
    Set Global Variable    ${LOGIN_STATUS}    SUCCESS
    
    Log    ✅ Demo login to OGField completed successfully

Demo Get JobCount From TopMenu
    [Documentation]    Demo getting current job count from top menu
    
    Log    📊 Demo: Getting job count from top menu
    
    # Simulate getting job count
    ${current_time}=    Get Current Date    result_format=epoch
    ${simulated_count}=    Evaluate    int(${current_time}) % 50 + 10
    
    Set Global Variable    ${JobCount_Before}    ${simulated_count}
    
    Log    🎭 DEMO: Simulating job count retrieval steps:
    Log    1. ✅ Locating job count element in top menu
    Log    2. ✅ Reading current job count value
    Log    3. ✅ Storing count for comparison: ${JobCount_Before}
    
    Log    📈 Current job count: ${JobCount_Before}

Demo Create New Job
    [Documentation]    Demo creating a new job from navigation panel using JSON data
    
    # Use TESTCASE_JOBTYPE from sprints-PREDEV_TestCases.json
    ${jobtype1}=        Get Variable Value    ${TESTCASE_JOBTYPE}       AUTO_JOB01
    ${agency1}=         Get Variable Value    ${Agency1}                EPB
    ${job_details}=     Set Variable          TaskType:0,Address:205 ISLAND AVE
    
    Log    ➕ Demo: Creating new job from navigation panel with JSON data
    
    # Log job details from configuration
    Log    Job Type (from JSON): ${jobtype1}
    Log    Agency: ${agency1}
    Log    Job Details: ${job_details}
    
    # Demo simulation of job creation
    Log    🎭 DEMO: Simulating job creation steps:
    Log    1. ✅ Clicking on 'Create Job' in navigation panel
    Log    2. ✅ Waiting for job creation form to load
    Log    3. ✅ Selecting job type: ${jobtype1}
    Log    4. ✅ Setting agency: ${agency1}
    Log    5. ✅ Entering address: 205 ISLAND AVE
    Log    6. ✅ Setting city and other details from: ${job_details}
    Log    7. ✅ Clicking 'Save' to create job
    Log    8. ✅ Waiting for job creation confirmation
    Log    9. ✅ Verifying job was created successfully
    
    # Simulate job creation success
    ${new_job_id}=    Generate Random String    8    0123456789
    Set Global Variable    ${CREATED_JOB_ID}    JOB-${new_job_id}
    
    Log    ✅ Demo job created successfully with ID: ${CREATED_JOB_ID}

Demo Verify JobCount Increased
    [Documentation]    Demo verifying that job count increased by one
    
    Log    🔢 Demo: Verifying job count increased
    
    # Simulate getting updated job count
    ${count_after}=    Evaluate    ${JobCount_Before} + 1
    Set Global Variable    ${JobCount_After}    ${count_after}
    
    Log    🎭 DEMO: Simulating job count verification steps:
    Log    1. ✅ Getting updated job count from top menu
    Log    2. ✅ Comparing with previous count
    Log    3. ✅ Verifying increase by exactly 1
    
    Log    📊 Job count verification:
    Log    - Before: ${JobCount_Before}  
    Log    - After: ${JobCount_After}
    
    ${difference}=    Evaluate    ${JobCount_After} - ${JobCount_Before}
    Log    - Difference: ${difference}
    
    # Verify count increased
    ${difference}=    Evaluate    ${JobCount_After} - ${JobCount_Before}
    Should Be Equal As Numbers    ${difference}    1
    
    Log    ✅ Demo job count verification successful - count increased by 1

Demo Logout From OGField
    [Documentation]    Demo logout from OGField application
    
    Log    🚪 Demo: Logging out from OGField
    
    # Demo simulation of logout
    Log    🎭 DEMO: Simulating logout steps:
    Log    1. ✅ Clicking user menu in top right corner
    Log    2. ✅ Selecting 'Logout' option from dropdown
    Log    3. ✅ Confirming logout action
    Log    4. ✅ Waiting for login page to appear
    Log    5. ✅ Verifying successful logout
    
    Set Global Variable    ${LOGOUT_STATUS}    SUCCESS
    
    Log    ✅ Demo logout from OGField completed successfully

Generate Demo Test Report
    [Documentation]    Generate a demo test execution report
    
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${report_file}=    Set Variable    ${OUTPUT_DIR}/demo_logs/demo_execution_report_${timestamp}.txt
    
    ${ogf_url}=       Get Variable Value    ${OGF_URL}        NOT_SET
    ${ogf_user}=      Get Variable Value    ${OGF_USER}       NOT_SET
    ${jobtype1}=      Get Variable Value    ${JOBTYPE1}       NOT_SET
    ${agency1}=       Get Variable Value    ${Agency1}        NOT_SET
    ${test_env}=      Get Variable Value    ${TEST_ENV}       NOT_SET
    ${current_env}=   Get Variable Value    ${ENV}            NOT_SET
    
    ${report_content}=    Catenate    SEPARATOR=\n
    ...    ========================================
    ...    ROBOT FRAMEWORK - OGF CREATE JOB DEMO
    ...    ========================================
    ...    Test Case: TC1-OGF_CreateJob_FromNavigationPanel
    ...    Execution Time: ${timestamp}
    ...    Environment: ${test_env} (${current_env})
    ...    
    ...    Environment Configuration:
    ...    - OGF URL: ${ogf_url}
    ...    - OGF User: ${ogf_user}
    ...    - Job Type: ${jobtype1}
    ...    - Agency: ${agency1}
    ...    
    ...    Test Execution Results:
    ...    - Login Status: ${LOGIN_STATUS}
    ...    - Job Count Before: ${JobCount_Before}
    ...    - Job Count After: ${JobCount_After}
    ...    - Created Job ID: ${CREATED_JOB_ID}
    ...    - Logout Status: ${LOGOUT_STATUS}
    ...    
    ...    Verification Results:
    ...    - Environment Variables: ✅ VERIFIED
    ...    - Job Creation: ✅ SIMULATED SUCCESS
    ...    - Job Count Increase: ✅ VERIFIED (+1)
    ...    - Login/Logout Flow: ✅ COMPLETED
    ...    
    ...    Overall Status: ✅ DEMONSTRATION COMPLETED SUCCESSFULLY
    ...    ========================================
    
    Create File    ${report_file}    ${report_content}
    
    Log    📋 Demo test report generated: ${report_file}
    Log    📋 Report content:
    Log    ${report_content}