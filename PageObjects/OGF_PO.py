loc_OGField_Username = "xpath=//input[@id='UserName']"
loc_OGField_Password = "xpath=//input[@id='Password']"
loc_OGField_Agree =    "xpath=//*[@class='ui-icon ui-icon-checkbox-off ui-icon-shadow']"
loc_OGField_Login =    "xpath=//input[@id='submit-button' and @value='Log On']"
loc_OGField_Login_BOS =    "xpath=//div[@controlname='BOS_Close']//a"


# PField Top menu
loc_OGField_Joblist=    "xpath=//div[@controlname='Action_Links_Panel']/a/img[contains(@src,'Joblist-icon-44')]"
loc_OGField_NavigationPanel_Open=    "xpath=//div[@controlname='Action_Links_ShowRightPane']/a"
loc_OGField_NavigationPanel_Close=    "xpath=//div[contains(@class,'ui-panel-open')]//a[contains(@id,'RightSlidingPane_Close-0-')]"
loc_OGField_Work_Count=    "xpath=//div[@controlname='Status_JobCount']//input"
loc_OGField_Mail=    "xpath=//div[@controlname='Action_Links_Panel19']/a"
loc_OGField_CrewStatus=    "xpath=//div[@controlname='CrewInformation_StatusCodeDescription']//input"
loc_OGField_ConnectivityStatus = "xpath=//*[contains(@id,'online_info_Status_Connection')]"
loc_OGField_ConnectivityStatus_Online = "xpath=//*[contains(@id,'imgConnectivity_Status_Connection') and contains(@src,'Green')]"
# //label[contains(@id,'online_info_Status_Connection-0-') and contains(text(),'Online') or contains(text(),'ONLINE')]
loc_OGField_ConnectivityStatus_Offline = "xpath=//*[contains(@id,'imgConnectivity_Status_Connection') and contains(@src,'Red')]"
loc_OGField_Notification = "xpath=//div[@controlname='Action_Notification']//a"
loc_OGField_Chat = "xpath=//img[contains(@src,'Chat')]"
loc_OGField_Map = "xpath=//img[contains(@src,'Map')]"
loc_OGField_Panic = "xpath=//img[contains(@src,'Safety-Timer')]"

# PF Navigation panel
loc_OGField_Home_Logout=    "xpath=//div[@controlname='Action_LogOff']"
loc_OGField_DutyIn=    "xpath=//div[@controlname='Action_Duty']//span[contains(text(),'Go Shift: On')]"
loc_OGField_DutyOff=    "xpath=//span[text()='Go Shift: Off']"
loc_OGField_Home_FieldSupervisor=    "xpath=//div[@controlname='Action_Links_Panel21']/a"
loc_OGField_Navigation_Icon = "xpath=//div[@controlname='Action_Links_ShowRightPane']"
loc_OGField_Navigation_Close = "xpath=//div[@controlname='RightSlidingPane_Close']/a"
loc_OGField_Go_Shift = "xpath=xpath=//*[@controlname='Action_Duty']//a"
loc_OGField_NOA = "xpath=//*[@controlname='Action_NonOrderActivity']//a"
loc_OGField_CrewDetails = "xpath =//span[contains(text(),'Crew Detail')]"
loc_OGField_JobJar = "xpath=//span[contains(text(),'Job Jar')]"
loc_OGField_LunchOn = "xpath=//span[text()='Lunch On']"
loc_OGField_LunchOff = "xpath=//span[text()='Lunch Off']"
loc_OGField_Calendar = "xpath=//span[text()='Calendar']"
loc_OGField_CrewMakeUp = "xpath=//div[@controlname='Action_CrewMakeUp']/a"
loc_OGField_CrewMakeUp_Close = "xpath=//div[@class='crewmakeup-dialog-header ui-content']/a"
loc_OGField_NewJob = "xpath=//span[text()='New Job']"
loc_OGField_TimesheetApproval = "xpath=//span[text()='Timesheet Approval']"
loc_OGField_TimesheetList = "xpath=//span[contains(text(),'Timesheet List')]"
loc_OGField_TimesheetList_Close= "xpath=//div[@id='timesheet2List-dialog']/a"
loc_OGField_PanicNow = "xpath=//div[@id='right-sliding-pane-container']//div[@controlname='Action_PanicNowButton']/a"
loc_OGField_AssetFacilitySearch = "xpath=//div[@controlname='Action_AssetFacilitySearch']/a"
loc_OGField_ShowCrewActivities = "xpath=//div[@id='right-sliding-pane-container']//div[@controlname='Action_ShowCrewActivities']/a"
loc_OGField_ShowCrewActivities_Close =  "xpath=//div[@controlname='CrewActivityList_Close']/a"
loc_OGField_AreaSearch = "xpath=//div[@controlname='Action_Links_Panel31']/a"
loc_OGField_MapAssetSearch = "xpath=//div[@controlname='Action_MapAssetSearch']/a"
loc_OGField_MapAllJobs = "xpath=//span[contains(@id,'Action_MapViewAllJobs-')]"

# Navigationpanel_Map_AssetSearch
loc_OGField_MapAssetSearch_Query = "xpath=//div[@controlname='MapAssetSearchPanel_Query']//select"
loc_OGField_MapAssetSearch_SearchText= "xpath=//input[contains(@id,'MapAssetSearchPanel_SearchText-0-')]"

#PField Home Page
loc_OGField_Home=    "id=Action_Links_Panel-401-lbl"
loc_OGField_SyncUpdated=    "id=syncLoad_info"
loc_OGField_Home_JobList=    "xpath=//*[text()='Job List']"

loc_OGField_Home_JobsDropdown1=    "xpath=//a[@id='btnJobListFilter']"
loc_OGField_Home_JobsDropdown2=    "xpath=//div[@id='QueryTree']/ul//li[contains(@class,'jqtree-closed')]/div[1]/span[text()='${OGF_Joblist_Qrydropdown1}']/parent::div/a/img[@class='QueryTree-Closed']" #First dropdown
loc_OGField_Home_JobsDropdown3=    "xpath=//span[contains(text(),'${OGF_Joblist_Qrydropdown2}')]"

# PF_Footer
# loc_OGField_Footer_NextStatus=    "xpath=//div[@controlname='Action_NextStatus']/a//span[contains(text(),'${NextStatus_Desc}')]"   #Override
loc_OGField_Footer_NextStatus=    "xpath=//div[@controlname='Action_NextStatus']/a"   
loc_OGField_Footer_Panic=    "xpath=//div[@id='_Footer-0']//div[@controlname='Action_PanicNowButton']/a"  

loc_OGField_Footer_FooterNavigationPanel=    "xpath=//div[@controlname='Action_Links_ShowLeftPane']/a"   
loc_OGField_Footer_LeftSlidingPane=    "xpath=//div[@id='_LeftSlidingPane-0']//span[contains(text(),'${data}')]"  #Override
loc_OGField_Footer_FieldReport=    "xpath=//span[contains(text(),'Field Reports')]"  
loc_OGField_Footer_WAITING_FOR_APPROVAL=    "xpath=//span[text()='WAITING FOR APPROVAL']"
loc_OGField_Footer_JobDetail = "//*[text()='Job Details']"
loc_OGField_Footer_Attachment=    "xpath=//span[contains(text(),'Attachment')]" 
loc_OGField_Footer_JobNotes=    "xpath=//span[contains(text(),'Job Notes')]" 
loc_OGField_Footer_Print=    "xpath=//span[contains(text(),'Print')]" 

#PField Joblist Page
loc_OGField_Joblist_TableHeader=    "xpath=//div[@id='_JobListHeader-0']//label[contains(text(),'Job #')]"
loc_OGField_SelectJobNumber_CheckBox=    "xpath=//a[@data-job-list-item='${data}']//label[contains(@id,'Job_IsSelected-')]/span/span[2]"  #Override jobnumber
loc_OGField_Joblist_TableValue=    "xpath=//div[@id='_JobList-0']//td[@title='${data}']"  
loc_OGField_Jobnumber_input=    "xpath=//input[contains(@id,'Job_JobNumber-0-')]"
loc_OGField_Address_input=    "xpath=//input[contains(@id,'Job_LocationAddress-0-')]"

#PField Select Shift date Page
loc_OGField_SelectShift=    "id=ShiftCodeDate-button"
loc_OGField_SelectShiftDate=    "xpath=//a[contains(text(),'${newdate}')]" # M/D/YYYY   #Override value
loc_OGField_SelectShift_Continue=    "xpath=//input[@id='submit-button' and @value='Continue']"

# PF_FieldReport
loc_OGField_FieldReport_R02Template=    "xpath=//div[@controlname='AvailableJobFieldReports_TemplateName']"
loc_OGField_FieldReport_Pole_UDF12=    "xpath=//div[contains(@controlname,'UDF12')]//input"
loc_OGField_FieldReport_Save=    "xpath=//div[@controlname='JobFieldReportLists_SaveReport']/a"
loc_OGField_FieldReport_RemoveFixture=    "xpath=//div[contains(@controlname,'Remove Fixture 1 (UDF6)')]//select"
loc_OGField_FieldReport_InstallFixture=    "xpath=//div[contains(@controlname,'Install Fixture 1 (UDF9)')]//select"
loc_OGField_FieldReport_Notes=    "xpath=//div[contains(@controlname,'Notes (UDF1)')]//textarea"
loc_OGField_FieldReport_Pole_UDF18=    "xpath=//div[contains(@controlname,'UDF18')]//input"
loc_OGField_FieldReport_LocationType=    "xpath=//div[contains(@controlname,'UDF13')]//select"
loc_OGField_FieldReport_PolesReplaced=    "xpath=//div[contains(@controlname,'UDF8')]//select"
loc_OGField_FieldReport_PrimarySpansPutUp=    "xpath=//div[contains(@controlname,'UDF9')]//select"
loc_OGField_FieldReport_TfmrsReplaced=    "xpath=//div[contains(@controlname,'UDF10')]//select"
loc_OGField_FieldReport_Outage=    "xpath=//div[contains(@controlname,'UDF5')]//select"
loc_OGField_FieldReport_Cause=    "xpath=//div[contains(@controlname,'Cause(UDF1)')]//select"
loc_OGField_FieldReport_Category=    "xpath=//div[contains(@controlname,'UDF6')]//select"
loc_OGField_FieldReport_SubCause=    "xpath=//div[contains(@controlname,'UDF2')]//select"
loc_OGField_FieldReport_EquipmentFacilityImpacted=    "xpath=//div[contains(@controlname,'UDF11')]//select"
loc_OGField_FieldReport_EquipmentFacilityRequired=    "xpath=//div[contains(@controlname,'UDF3')]//select"
loc_OGField_FieldReport_ConditionFound=    "xpath=//div[contains(@controlname,'UDF12')]//select"
loc_OGField_FieldReport_ActionPerformed=    "xpath=//div[contains(@controlname,'UDF4')]//select"
loc_OGField_FieldReport_Remarks=    "xpath=//div[contains(@controlname,'Remarks(UDF7)')]//textarea"
loc_OGField_FieldReport_FieldReportNumber=    "xpath=//div[contains(@controlname,'ExistingJobFieldReports_FieldReportNumber')]//input"

# PField System message and pop ups
loc_OGField_Timesheet_Accept=    "xpath=//div[contains(@class,'ui-popup-active')]//div[@id='Timesheet2ActivityConfirmationScreen-0']//a[contains(@id,'Timesheet2ActivityConfirmationScreen_Accept-0-')]"  
loc_OGField_Timesheet_OK=    "xpath=//div[contains(@class,'ui-popup-active')]//div[@controlname='Timesheet2AdditionalInformation_Ok']/a/span"  
loc_OGField_Yes=    "xpath=//div[@id='notifications-content']//span[contains(text(),'Yes')]"
loc_OGField_Dispose_Yes=    "xpath=//tbody/tr[2]/td[2]//div[@id='popup-notif-button-yes']/span/span[text()='Yes']"
loc_OGField_Yes1=    "xpath=//tbody/tr[1]/td[1]/div[1]/span[1]/span[1][contains(text(),'Yes')]"
loc_OGField_Yes2=    "xpath=//div[@id='popup-notif-button-yes']"   #Create job  Duplicate job
loc_OGField_Paycode_OK=    "xpath=//tbody/tr[3]/td[2]/div[1]/span[1]/span[1][contains(text(),'OK')]"
loc_OGField_No=    "xpath=//div[@id='notifications-content']//span[contains(text(),'No')]"
loc_OGField_ConfirmAll=    "xpath=//div[contains(@class,'ui-popup-active')]//a[@id='popup-messages-clear' and not(contains(@class,'ui-disabled'))]//span[contains(text(),'Confirm All')]"
loc_OGField_NewAssignment_OK=    "xpath=//div[contains(@class,'ui-popup-active')]//div[@id='popup-notif-button-info']//span[text()='OK']"
loc_OGField_NewAssignment=    "xpath=//div[contains(@class,'ui-popup-active')]//div[contains(text(),'New assignment received')]"
loc_OGField_AssignmentRemoved=    "xpath=//div[contains(text(),'ASSIGNMENT REMOVED')]"
loc_OGField_LunchOnOff_Unable=    "xpath=//div[@class='cgi-notif-message'][contains(text(),'Lunch On/Off - Unable to set lunch on, crew is off duty or in duty')]"
loc_OGField_Acknowledge=    "xpath=//span[contains(text(),'Acknowledge')]"       #//tbody/tr[2]/td[2]/div[1]/span[1]/span[1][text()='Acknowledge']"
loc_OGField_NOA_WithoutDutyON=    "xpath=//div[@class='cgi-notif-message'][contains(text(),'Cannot create a Non Order Activity - The crew has to be in duty to create a Non Order Activity')]"
loc_OGField_ConfirmDutyIn=    "xpath=//span[contains(@id,'ConfirmNewDutyIn_DutyIn-')]"
loc_OGField_VehicleMileage_Cancel=    "xpath=//div[@controlname='Mileage_Cancel']//a"
loc_OGField_System_Notification=    "xpath=//div[@class='cgi-notif-message'][contains(text(),'${Sys_messg}')]"
loc_OGField_DuplicateJob=   "xpath=//div[contains(text(),'Duplicate Job - DO YOU WANT TO DUPLICATE THIS JOB?')]"
loc_OGField_SafetyMessage_Text= "xpath=//h3[@id='panel-dialog-clone-3-title' and contains(text(),'Safety Messages')]"
loc_OGField_SafetyMessage_OK= "xpath=//a[contains(@onclick,'SafetyMessagePanelDialog')]//span[text()='OK']"
loc_OGField_DisposeCode_Select =  "xpath=//select[contains(@id,'Dispose_ComboDisposesCodes-0')]"
loc_OGField_DisposeCode_Add =  "xpath=//a[contains(@id,'Dispose_AddDisposeCode-0')]"
loc_OGField_DisposeCode_Remark =  "xpath=//textarea[contains(@id,'Dispose_RemarkDispose-0-')]"
loc_OGField_DisposeCode_Dispose =  "xpath=//a[contains(@id,'Dispose_SaveDisposeCodes-0-')]"
loc_OGField_NoAttachment =  "xpath=//div[contains(text(),'Attachment - NO JOB SELECTED')]"
loc_OGField_GritterMessage_AssignmentCompleted =  "xpath=//div[@class='gritter-without-image']//p[contains(text(),'ASSIGNMENT COMPLETED')]"
loc_OGField_GritterMessage =  "xpath=//div[@class='gritter-without-image']"
loc_OGField_General_Notification=    "xpath=//div[contains(@class,'ui-popup-active')]//div[@class='cgi-notif-message']"
loc_OGField_AcceptAll=    "xpath =//div[contains(@class,'popup-active')]//span[contains(@id,'AcceptAll')]"

# PField Crew Makeup
loc_OGField_CrewMakeUP_AddPersonnel=    "xpath=//label[text()='Add Personnel']"
loc_OGField_CrewMakeUP_Agency=    "xpath=//div[@controlname='CrewMembersResearchPanel_AgencyCode']//select"
loc_OGField_CrewMakeUP_Search=    "xpath=//span[contains(@id,'CrewMembersResearchPanel_Search-')]"
loc_OGField_CrewMakeUP_Save=    "xpath=//a[contains(@id,'CrewMembersListHeader_Save')]"
loc_OGField_CrewMakeUP_Cancel=    "xpath=//a[contains(@id,'CrewMembersListHeader_Cancel')]"
loc_OGField_CrewMakeUP_BadgeNo=  "xpath=//input[contains(@id,'CrewMembersResearchPanel_BadgeNumber-0-')]"
loc_OGField_CrewMakeUP_Add_Enabled=   "xpath=//a[contains(@id,'CrewMembersResearchResult_Add') and contains(@style,'1')]"
loc_OGField_CrewMakeUP_Close=   "xpath=//div[@id='crewmakeup-dialog']/div[1]/a"
loc_OGField_CrewMakeUP_Clear=    "xpath=//div[@controlname='CrewMembersResearchPanel_Clear']"
loc_OGField_CrewMakeUP_Primary_InitialsID=  "xpath=//li//div[contains(@id,'_CrewMembersList')]//td[1]/table/tbody/tr[1]/td[contains(@title,'${Primary}')]//input"
# loc_OGField_CrewMakeUP_PrimaryCheckbox_On=    "xpath=//li//div[contains(@id,'_CrewMembersList')]//td[1]/table/tbody/tr[1]/td[contains(@title,'${Primary}')]/parent::tr/parent::tbody/parent::table/parent::td//following-sibling::td[3]//div[@controlname='CrewMember_Leader']//div[@class='ui-checkbox']/label[@data-icon='checkbox-on']"
loc_OGField_CrewMakeUP_PrimaryCheckbox_On=    "xpath=//div[@controlname='CrewMember_Leader']//div[@class='ui-checkbox']/label[@data-icon='checkbox-on']"

loc_OGField_CrewMakeUP_Primary_DeleteDisabled=    "xpath=//div[@controlname='CrewMembersList_Delete']//a[contains(@onclick,'${Primary}') and contains(@style,'0.5')]"
loc_OGField_CrewMakeUP_Helper_InitialsID=  "xpath=//li//div[contains(@id,'_CrewMembersList')]//td[1]/table/tbody/tr[1]/td[contains(@title,'${Helper}')]//input"
loc_OGField_CrewMakeUP_Helper_DeleteEnabled=    "xpath=//div[@controlname='CrewMembersList_Delete']//a[contains(@onclick,'${Helper}') and contains(@style,'1')]"
loc_OGField_CrewMakeUP_Helper1_Row2=    "xpath=//ul[@id='CrewMembersList-listview']/li[2]//div[@controlname='CrewMembersList_Delete']/a"
loc_OGField_CrewMakeUP_Helper2_Row2=    "xpath=//ul[@id='CrewMembersList-listview']/li[3]//div[@controlname='CrewMembersList_Delete']/a"
loc_OGField_CrewMakeUP_HelperCheckbox_Off=    "xpath=//div[@controlname='CrewMember_Leader']//div[@class='ui-checkbox']/label[@data-icon='checkbox-off']"
# loc_OGField_CrewMakeUP_Helper_Delete=    "xpath=//label[@data-icon='checkbox-off']/parent::div/parent::div/parent::td/parent::tr/parent::tbody/parent::table/parent::td//following::div[@controlname='CrewMembersList_Delete']/a"
loc_OGField_CrewMakeUP_Helper_Delete=    "xpath=//div[@controlname='CrewMembersList_Delete']//a[contains(@style,'1')]"

# PField Crew Details
loc_OGField_CrewDetails_SchedulingTab=    "xpath=//label[text()='Scheduling']"

# PField Job Jar
loc_OGField_JobJar_Calendarpopup=    "xpath=//div[@id='calendarsubmenu-dialog-popup' and @class='ui-popup-container ui-popup-active']//a[contains(@class,'close-popupbtn-position-right')]"
loc_OGField_JobJar_Filter=    "xpath=//a[@id='btnJobJarFilter']"
loc_OGField_JobJar_SelectQuery1=    "xpath=//div[@controlname='JobJarQuery']/div[1]/div[1]//ul//span[contains(text(),'${JobJarQuery1}')]/parent::div/a/img[@class='QueryTree-Closed']"
loc_OGField_JobJar_SelectQuery2=    "xpath=//li[@class='jqtree_common']//span[contains(text(),'${JobJarQuery2}')]"
loc_OGField_JobJar_Table=    "xpath=//div[@id='JobJarList-container']/ul[2]//div[@id='_JobJarList-0']"
loc_OGField_JobJar_Refresh=    "xpath=//div[@controlname='JobJar_Refresh']//a"
loc_OGField_JobJar_AssignSelected=    "xpath=//div[@controlname='JobJar_Assign']//a"

# PField Calendar
loc_OGField_Calendar_AgendaTime=    "xpath=//div[@id='CalendarDayView']//tr[@data-time='15:00']//tr[@data-time='15:00']"
loc_OGField_Calendar_Add_Agenda=    "xpath=//div[@controlname='CalendarSubMenu_AgendaExceptionEdit']//a"
loc_OGField_Agenda_StartDate_Calendar=    "xpath=//div[@controlname='AgendaExceptionEdit_StartDateTime']//a"
loc_OGField_Agenda_EndDate_Calendar=    "xpath=//div[@controlname='AgendaExceptionEdit_EndDateTime']//a"

loc_OGField_Agenda_Hour_Input=    "document.querySelector("#page-main > div.ui-datebox-container.ui-overlay-shadow.ui-corner-all.pop.ui-body-b.in > span > div.ui-datebox-align.ui-datebox-dboxin.ui-grid-d > div.ui-block-d > input")"
loc_OGField_Agenda_Close=    "xpath=//div[@class='agendaexceptionedit-dialog-content ui-content']//a"
loc_OGField_CalendarAE_Close = "xpath=//div[@id='calendarsubmenu-dialog-popup']//div[@id='calendarsubmenu-dialog']/div[1]/a"
loc_OGField_Agenda_DateControl_Ok=  "xpath=//div[@class='ui-datebox-controls']/a//span[text()='Ok']"

#Timesheet Period confirmation
loc_OGField_Timesheet_PeriodConfirmation_Save=    "xpath=//div[@controlname='Timesheet2NewAndOldCrewMembersPeriodInfo_Save']/a"

# Timesheet Additional Info
loc_OGField_Timesheet_AdditionalInfo_Leader_Checkbox_Checked=    "xpath=//div[@controlname='CrewMemberAcknowledgeGrid']//tr[2]//td[3]//input[@checked]"
loc_OGField_Timesheet_AdditionalInfo_Helper1_Checkbox_Unchecked=    "xpath=//div[@controlname='CrewMemberAcknowledgeGrid']//tr[3]//td[6]//input"

# PField Timesheet List
loc_OGField_TimesheetList_Leader_FirstNameRow1=    "xpath=//div[@id='Timesheet2List-container']//tr[@pq-row-indx='0']//td[@pq-col-indx='1']"
loc_OGField_TimesheetList_Helper_CurrentDate=    "xpath=//div[@id='Timesheet2ListHelper-container']/div[2]/div[2]//tbody//tr//td[contains(text(),'${Currentdate}')]//preceding-sibling::td[contains(text(),'${Helper}')]"

# PField Timesheet Details
loc_OGField_Timesheet_Submit=    "xpath=//div[@controlname='Timesheet2Header_EndTimesheet2']//a//span[@class='ui-btn-inner']"

#Timesheet Approval 
loc_OGField_TSApproval_Query= "xpath=//div[@controlname='Timesheet2ApprovalList_TimesheetQuery']//select"
loc_OGField_TSApproval_AgencyCode= "xpath=//div[@controlname='Timesheet2ApprovalList_AgencyCode']//select"
loc_OGField_TSApproval_SupervisedBy= "xpath=//div[@controlname='Timesheet2ApprovalList_SupervisedBy']//select"
loc_OGField_TSApproval_BadgeNo= "xpath=//div[@controlname='Timesheet2ApprovalList_BadgeNo']//select"
loc_OGField_TSApproval_MemberName= "xpath=//div[@controlname='Timesheet2ApprovalList_MemberName']//select"
loc_OGField_TSApproval_Status= "xpath=//div[@controlname='Timesheet2ApprovalList_ReportStatus']//select"
loc_OGField_TSApproval_Search= "xpath=//div[@controlname='Timesheet2ApprovalList_TimeSheetListSearch']//a"
loc_OGField_TSApproval_Clear=   "xpath=//div[@controlname='Timesheet2ApprovalList_ClearSearchFilters']//a"
loc_OGField_TSApproval_EmployeeName=   "xpath=//div[@controlname='Timesheet2ApprovalListModel']//input[@name='EmployeeName']"



loc_OGField_TSApproval_TimesheetRow= "xpath=//tr[@pq-row-indx='0']"



# PField NOA
loc_OGField_NOA_ReasonClick=    "xpath=  //div[@controlname='NOA_Reason']/div"  
loc_OGField_NOA_Reason=    "xpath=  //select[contains(@id,'NOA_Reason-0-')]"                  #//label[contains(text(),'Reason')]//following::select"
loc_OGField_NOA_Close=    "xpath=//div[@controlname='NOA_Close']//a"
loc_OGField_NOA_Start=    "xpath=//div[@controlname='NOA_Start']/a"
loc_OGField_NOA_Stop=    "xpath=//div[@controlname='NOA_Stop']/a"

# PField Map
loc_OGField_Map_Layer = "xpath = //div[contains(@class,'sublayer-position')]//button[contains(text(),'L')]"
loc_OGField_Map_Layer_GeoServer1 = "xpath = //li[1][contains(@class,'jqtree-closed')]"
loc_OGField_Map_Layer_GeoServer1_Checkbox1 = "xpath = //fieldset[1]/div[1]/ul[1]/li[1]/ul[1]/li[1]/div[1]/label[1]/span[1]"
loc_OGField_Map_Layer_GeoServer1_Checkbox2= "xpath = //fieldset[1]/div[1]/ul[1]/li[1]/ul[1]/li[2]/div[1]/label[1]/span[1]"


loc_OGField_Map_DisplayMode=    "xpath=//div[@controlname='Action_MapDisplayMode']"
loc_OGField_Map_Canvas = "xpath=//tbody/tr[2]/td[1]/div[1]/div[1]/div[1]/div[16]/canvas[1]"
loc_OGField_Map_Address = "xpath=//div[@controlname='MapGetAddressPopup_Address']//textarea"
loc_OGField_Map_CreateJob = "xpath=//div[@controlname='MapGetAddressPopup_CreateJob']//a"
loc_OGField_Map_MoveJob = "xpath=//div[@controlname='MapGetAddressPopup_MoveJob']//a"
loc_OGField_Map_GetRoute = "xpath=//div[@controlname='MapGetAddressPopup_GetRouteWithDirections']//a"
loc_OGField_Map_CreateCall = "xpath=//div[@controlname='MapGetAddressPopup_CreateCall']//a"

# PField Panic
loc_OGField_Panic_Yes=    "xpath=//div[contains(@id,'panel-dialog-clone')]//span[contains(text(),'Yes') or contains(text(),'YES')]"
loc_OGField_Panic_No=    "xpath=//div[contains(@id,'panel-dialog-clone')]//span[contains(text(),'No') or contains(text(),'NO')]"
loc_OGField_Panic_EmergencyClose=    "xpath=//div[@controlname='PanicButton_ClosePanicDialog']/a"

# PField Mail
loc_OGField_Mail_AddFolder=    "xpath=//span[contains(@id,'MailButton_NewFolder-')]"

# PField Chat
loc_OGField_Chat_Status=    "xpath=//select[contains(@id,'InstantMessengerUsers_UserStatus-0-')]"
loc_OGField_Chat_Close=    "xpath=//div[@id='instantmessenger-dialog']/div/a"

# Field Supervisor Joblist
loc_FS_Joblist_Query=    "xpath=//a[contains(@id,'job-list-grid')][1]"

# Asset Facility Search
loc_AssetFacilitySearch_AssetName=    "xpath=//div[@controlname='AssetFacility_AssetName']/div/input"
loc_AssetFacilitySearch_Cancel=    "xpath=//div[@controlname='AssetFacilitySearch_Cancel']/a"

# ShowCrewActivities
loc_OGField_ShowCrewActivities_StartDate = "xpath=//div[@controlname='CrewActivityList_QueryFromDate']/div/div/input"

# AreaSearch
loc_OGField_AreaSearch_StartDate = "xpath=//div[@controlname='AreaSearchCriteria_FromDate']/div/div/input"

# Timesheet Approval
loc_OGField_TimesheetApproval_Query = "xpath=//select[contains(@id,'Timesheet2ApprovalList_TimesheetQuery-0-')]"
loc_OGField_TimesheetApproval_EmpName = "xpath=//input[@name='EmployeeName']"

# Job Details page
loc_OGField_JobDetails_JobdetailsTab_Collapsed = "xpath=//div[@id='_JobDetails-0']/table/tbody/tr[1]//td[1]//div[@controlname='Accordion']//h3[contains(@class,'collapsed')]"
loc_OGField_JobDetails_JobNumber = "xpath=//div[@id='_Panel-0']/table/tbody/tr[2]//tbody/tr/td[3]//tr/td[1]"
# loc_OGField_JobDetails_JobNumber = "xpath=//div[@id='_Panel-0']/table[1]/tbody[1]/tr[2]//div[@controlname='Job_JobNumber']//input"
loc_OGField_JobDetails_JobSummaryTab = "xpath=//label[contains(text(),'Job Summary')]"
loc_OGField_JobDetails_JobDetailsTAB= "xpath=//label[contains(text(),'Job Details')]"
loc_OGField_JobDetails_ReportingTAB= "xpath=//label[contains(text(),'Work Review')]"
loc_OGField_JobDetails_AdditionalInfoTAB= "xpath=//label[contains(text(),'Additional Job Information')]"
loc_OGField_JobDetails_Reporting=    "xpath=//div[@controlname='Assignment_StatusCodeDescription']//input"
loc_OGField_JobDetails_Save=    "xpath=//div[@controlname='Action_SaveJob']//a"
loc_OGField_TaskType=    "xpath=//div[contains(@controlname,'Job_TaskType')]//select"
loc_OGField_Jobtype_WorkCode=    "xpath=//div[contains(@controlname,'Job_WorkCode')]//select"
loc_OGField_JobPriority=    "xpath=//div[contains(@controlname,'Job_Priority')]//select"
loc_OGField_Address	=    "xpath=//div[@controlname='Job_FreeFormat']//textarea"
loc_OGField_CityCode=    "xpath=//div[contains(@controlname,'Job_CityCode')]//select"
loc_OGField_Reporting_UDF14=    "xpath=//div[@controlname='WLOT#(UDF14)']//input[contains(@id,'UDF14-0-')]"
loc_OGField_Reporting_UDF14_Disabled=    "xpath=//div[@controlname='WLOT#(UDF14)']//input[contains(@id,'UDF14-0-') and @aria-disabled='true']"

# Job Notes
loc_OGField_JobNotes_Disabled= "xpath=//div[@controlname='Remarks_NewRemark']/label"

# Print
loc_OGField_Print_SelectLayout= "xpath=//label[contains(text(),'Select a layout')]"

#Attachments
loc_OGField_Attachment_Dialog=    "xpath=//div[@id='AttachmentsDialog-popup' and contains(@class,'ui-popup-active')]"
loc_OGField_Attachment_AddNewFile=    "xpath=//div[@controlname='AddAttachments_ChooseFile']//a"
loc_OGField_Attachment_Comments=    "xpath=//div[@controlname='AddAttachments_Comment']//textarea"
loc_OGField_Attachment_Close=    "xpath=//a[@id='AttachmentsList_CloseModal']"
loc_OGField_Attachment_UploadFile=    "xpath=//div[@controlname='AddAttachments_UploadAttachments']//a"
loc_OGField_Attachment_Upload_Choose_File=    "xpath=//div[@class='choose-file-a']/a"
loc_OGField_Attachment_FileName_WindowsAlert=    "xpath=//div[@class='choose-file-a']//input[@type='file']"
loc_OGField_Attachment_AttachedFilename=    "xpath=//div[@controlname='AttachmentsList_FileName']/div/input"
loc_OGField_Attachment_Delete=    "xpath=//div[@controlname='AttachmentsList_Delete']//a"
loc_OGField_Attachment_Download=    "xpath=//div[@controlname='AttachmentsList']//ul[@id='AttachmentsList-listview']//li[1]//div[@controlname='AttachmentsList_Download']//a"
loc_OGField_Attachment_UploadDialogClose=    "xpath=//div[@id='upload-dialog']//a[@title='Close']"
