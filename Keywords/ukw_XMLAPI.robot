*** Settings ***
Resource    ukw_Common.robot
Library    getDBValue

*** Variables ***
${JobNum}       .//ConfirmJob/DataArea/Job/JobNumber

${CreateAssignment}    ..//CreateAssignment/DataArea/Assignment/JobNumber


*** Keywords ***
API_CreateSingleJob
    IF  '${TEST_ENV}' == 'integration7-Cloud-QC' or '${TEST_ENV}' == 'integration7-Cloud-Sprints_Testcases'
        Set Global Variable     ${JOBTYPE}    ${JOBTYPE}   
        ${USER_ID}    Set Variable  ${XML_Authentication_User}
        ${PASSWORD}    Set Variable  ${XML_Authentication_Pwd}
        @{auth}=    Create List  ${USER_ID}  ${PASSWORD} 
        ${headers}  Create Dictionary   Content-Type=text/xml   Authorization=Basic 
        Create Session    session1    ${BASEURL}    headers=${headers}  auth=${auth}
        ${XML_Createjob}=    Replace Variables    ${XML_Createjob}
        ${xmlfile}    Get File    ${XML_Createjob}   
        # If the response is not found within 20 seconds, the test will fail 
        ${response}=    POST on Session  session1    ${XML_Job_auth_Service}     data=${xmlfile}     headers=${headers}    timeout=20  
    
    ELSE
        Set Global Variable     ${JOBTYPE}    ${JOBTYPE}
        ${XML_Createjob}=    Replace Variables    ${XML_Createjob}
        ${xmlfile}    Get File    ${XML_Createjob}
    
        ${Mysession}    RequestsLibrary.Create Session    session1    ${BASEURL}
        ${headers}    Create Dictionary    Content-Type=text/xml
        ${xmlfile}    Get File    ${XML_Createjob} 
        ${xmlfile}    Get File    ${XML_Createjob}

        # If the response is not found within 20 seconds, the test will fail
        ${response}=    RequestsLibrary.POST on Session  session1    ${XML_Job_auth_Service}    data=${xmlfile}     headers=${headers}    timeout=20

    END


    TRY
        ${status_code}=  convert to string  ${response.status_code}  
        # IF    ${status_code} != 200 
        #     Fail     XML API - JOB not created        
        # END   
        should be equal  ${status_code}  200     XMLAPI job not created
        ${res}    Parse Xml    ${response.content}
        ${JOBNUMBER}    Get Element Text    ${res}    ${JobNum}    
        Set Global Variable    ${JOBNUMBER}
        # Log To Console    Created ${JOBNUMBER} for jobtype ${JOBTYPE}
        Log   Created ${JOBNUMBER} for jobtype ${JOBTYPE}
        CaptureScreen_AddStepsToReport    None    Created ${JOBNUMBER} for jobtype ${JOBTYPE}    passed
    EXCEPT    
        CaptureScreen_AddStepsToReport    None    Created ${JOBNUMBER} for jobtype ${JOBTYPE}    failed
        Fail    XML API - JOB not created        
    END
   
    
    
# =====================================================================================================================================================
API_CreateMultipleJobs
    [Arguments]    ${JOBTYPE_Jobs}  #Argument to be passed 9100^2 jobs
    # VAR  @{JOBNUMBER_LIST}    0
    ${JOBNUMBER_LIST}    Create list
    ${temp}    Split String    ${JOBTYPE_Jobs}    ^
    # ${num_jobs}    Set Variable    ${temp[1]}
    VAR  ${num_jobs}  ${temp[1]}
    Set Global Variable     ${JOBTYPE}    ${temp[0]}
    FOR    ${counter}    IN RANGE    0    ${num_jobs}    
            API_CreateSingleJob
            Append to list    ${JOBNUMBER_LIST}   ${JOBNUMBER}  
            Set Global Variable    ${JOBNUMBER_LIST}    ${JOBNUMBER_LIST}           
    END
    Log  ${JOBNUMBER_LIST}
    

# =====================================================================================================================================================

API_Create_TempFile_ForAssignJobToCrew
    [Arguments]    ${CREW}    ${JOBNUMBER}

    # Create a temp file that stores current information
    # Inputs required, current date, agency, crew , crew shift code, the shift date is current date

    Set global Variable   ${AssignJobToCrew_tempfile}       ${CreateJob_TmpFile}      #eg: C:/RobotSource/Robot/Testdata/XML/temp.xml
    OperatingSystem.Remove File    ${AssignJobToCrew_tempfile}  #Delete file before execution

    ${date}   Get Current Date  
    ${date_new}=    ConvertDate_YYYY-MM-DD     ${date}
    Set Global Variable    ${JOBNUMBER}    ${JOBNUMBER}

    # Get Agency Code
    ${DB_JOBAgency}=    Replace Variables    ${DB_JOBAgency}
    ${AgencyVal}=   Fetch Value From Db  ${DBConnect}    ${DB_JOBAgency} 

    IF    '${AgencyVal}' == $None
        Fail    SQL query did not return User values, verify DB    
    END
    
    # Get Shift Code
    ${DB_CREW_SHIFTCODE}=    Replace Variables    ${DB_CREW_SHIFTCODE}
    ${Shift}=   Fetch Value From Db  ${DBConnect}    ${DB_CREW_SHIFTCODE} 

    IF    '${Shift}' == $None
        Fail    SQL query did not return User values, verify DB   
    END

    ${temp}    set variable    AgencyCode:${AgencyVal}^CrewCode:${CREW}^JobNumber:${JOBNUMBER}^ShiftCode:${Shift}^ShiftDate:${date_new}

    # Get xml path from testdata
    ${XML_AssignJobToCrew}=    Replace Variables    ${XML_AssignJobToCrew}

     # temp file is created at this point
    getxml.Update XmlNode AssignJobToCrew    ${XML_AssignJobToCrew}    ${AssignJobToCrew_tempfile}   ${temp}

# =====================================================================================================================================================

API_AssignJobToCrew 
    IF  '${TEST_ENV}' == 'integration7-Cloud-QC' or '${TEST_ENV}' == 'integration7-Cloud-Sprints_Testcases'
        ${USER_ID}    Set Variable  ${XML_Authentication_User}
        ${PASSWORD}    Set Variable  ${XML_Authentication_Pwd}
        @{auth}=    Create List  ${USER_ID}  ${PASSWORD} 
        ${headers}  Create Dictionary   Content-Type=text/xml   Authorization=Basic 
        Create Session    session1    ${BASEURL}    headers=${headers}  auth=${auth}
        ${xmlfile}    Get File   C:\\RobotSource\\Robot\\Testdata\\XML\\temp.xml

        # If the response is not found within 20 seconds, the test will fail
        ${response}=    RequestsLibrary.POST on Session  session1    /InboundAssignmentService.asmx    data=${xmlfile}     headers=${headers}    timeout=20
    ELSE
        ${Mysession}    RequestsLibrary.Create Session    session1    ${BASEURL}
        ${headers}    Create Dictionary    Content-Type=text/xml
        ${xmlfile}    Get File   C:\\RobotSource\\Robot\\Testdata\\XML\\temp.xml

        # If the response is not found within 20 seconds, the test will fail
        ${response}=    RequestsLibrary.POST on Session  session1    /InboundAssignmentService.asmx    data=${xmlfile}     headers=${headers}    timeout=20
    END 


    TRY
        Should Not Contain    ${response}    None    timeout error
        Log    PASS-Assigned Job to Crew
    EXCEPT  
        Log    ${response}  
        Fail    XML API-AssignJob2Crew-JOB not assigned-Response Time out    

    END

# =====================================================================================================================================================

Post XML File And Get Response
    [Arguments]    ${session}    ${xmlfile}    ${xmlservice}
    ${Mysession}    RequestsLibrary.Create Session    ${session}    ${ENVSERVER}
    ${headers}    Create Dictionary    Content-Type=text/xml
    # ${xmlfile}    Get File    ${xmlfile}
    RequestsLibrary.POST On Session   ${session}    ${xmlservice}    data=${xmlfile}    headers=${headers}

    # ${response}=  RequestsLibrary.POST on Session    ${session}    ${xmlservice}    data=${xmlfile}    headers=${headers}    timeout=20

    TRY
        Should Not Contain    ${response}    None    timeout error
    EXCEPT
        Log    ${response}
        Fail    XML API - Request failed - Response Timeout
    END

    TRY
        ${status_code}=    Convert To String    ${response.status_code}
        Should Be Equal    ${status_code}    200    XML API request failed
        ${res}    Parse Xml    ${response.content}
        Log To Console    ${res}
    EXCEPT
        Fail    XML API - Request failed
    END

    # RETURN    ${res}