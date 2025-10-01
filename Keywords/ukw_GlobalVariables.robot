*** Settings ***


*** Variables ***
${TEST_ENV}         sprints-QC    #sprints-PREDEV     #sprints-ST sprints-QC integration7-QC  integration7-Cloud-QC  integration7-Cloud-Sprints_Testcases
${XML_FOLDER}           C:\\RobotSource\\Robot\\Testdata\\XML\\       #C:\\RobotSource\\Robot=C:\\RobotSource\\Robot
${Global_JSON_File}       C:\\RobotSource\\Robot\\Testdata\\GlobalData.json 
${AppStatus_JSON_File}       C:\\RobotSource\\Robot\\Testdata\\AppStatus.json 
${Testcase_JSON_File}   C:\\RobotSource\\Robot\\Testdata\\${TEST_ENV}_TestCases.json 
${PROJECT_PATH}     C:/RobotSource/Robot
${CreateJob_TmpFile}           ${PROJECT_PATH}/Testdata/XML/temp.xml
${Upload_Download_Folder}   C:\\RobotSource\\Robot\\Testdata\\Upload_Download_Files\\
${SCREENSHOT_PATH}   C:\\RobotSource\\Robot\\screenshots\\
${REPORT_HTMLFILE}    C:\\RobotSource\\Robot\\sanity_test_report.html

