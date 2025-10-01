# WebD Login Page
loc_OGW_Username=   "id=UserName"
loc_OGW_Password=   "id=Password"
loc_OGW_Submit=   "id=submit-button"

#--------------------------Topmenu and Workspace manager-------------------------------------------------
loc_OGW_Logout=   "xpath=//span[contains(@id,'DispatchViewAction_LogOut-')]"
loc_OGW_NavigationPanel=   "xpath=//div[@controlname='DispatchViewAction_WebDispatchLinks_ShowRightPane']/a"
loc_OGW_Navigate_WorkSpacemanager=   "xpath=//div[@controlname='DispatchViewAction_WorkspaceManager']/a"
loc_OGW_Navigate_SystemPanel=   "xpath=//label[@id='titleTab-lbl-{id}'][text()='System Panels']"
loc_OGW_Navigate_WorkSpaceManger_SystemPanel_Dropdown=   "xpath=//div[@controlname='WorkSpaceManager_MainPanelList']/div"
loc_OGW_Navigate_WorkSpaceManger_SystemPanel_Select=   "xpath=//div[@controlname='WorkSpaceManager_MainPanelList']//select"

loc_OGW_Navigate_WorkSpaceManger_Close=   "xpath=//div[@controlname='WorkSpaceManager_Close']/a"
loc_OGW_Navigate_TimesheetApproval=   "xpath=//div[@controlname='DispatchViewAction_WorkspaceManager']/a"
#
loc_OGW_Topmenu_Username=   "xpath=//div[@controlname='DispatchViewAction_LoggedUserName']//input"
loc_OGW_Topmenu_QueryBuilder=   "xpath=//div[@controlname='DispatchViewAction_WebDispatchLinks_Panel15']/a"
loc_OGW_Topmenu_JobSearch=   "xpath=//div[@controlname='DispatchViewAction_WebDispatchLinks_Panel22']/a"
loc_OGW_Topmenu_Chat=   "xpath=//div[@controlname='DispatchViewAction_WebDispatchLinks_ShowInstantMessenger']/a"
loc_OGW_Topmenu_Mail=   "xpath=//div[@controlname='DispatchViewAction_WebDispatchLinks_Panel19']/a"
loc_OGW_Topmenu_ListRefresh=   "xpath=//div[@controlname='DispatchViewAction_StopAllAutomaticRefresh']/a"
loc_OGW_Topmenu_Notifications=   "xpath=//div[@controlname='DispatchViewAction_Notification']/a"

# Query Builder
loc_OGW_QueryBuilder_Agency=   "xpath=//div[@controlname='DispatchViewQueryBuilder_Agency']//select"


#---------------------------ASSIGNMENT DETAILS-------------------------------------------------

#Assignment list
loc_OGW_AssignmentList_SelectQuery1=   "xpath=//div[contains(@id,'DispatchViewAssignmentList_AssignmentListGrid-0-')]//a[contains(@class,'TreeViewFilter')]" 
loc_OGW_AssignmentList_SelectQuery2=   "xpath=//div[@controlname='DispatchViewAssignmentList_AssignmentListGrid']/div[1]/div[1]/ul//span[contains(text(),'${AssignmentListQuery1}')]/parent::div/a/img[@class='QueryTree-Closed']"
loc_OGW_AssignmentList_QueryName_BYCREWTODAY=   "xpath=//div[contains(@controlname,'DispatchViewAssignmentList_AssignmentListGrid')]/div[1]/div[1]//span[text()='${WEBD_AssignmentQuery_SearchCrew}']"
loc_OGW_AssignmentList_QueryName=   "xpath=//li[@class='jqtree_common']//span[text()='${AssignmentListQueryName}']"


#AssignmentList table
loc_OGW_AssignmentList_TableValue=   "xpath=//table[contains(@id,'assignment-list-grid-')]//td[@title='@!']" #Override value-Enter crew/jobnum
loc_OGW_AssignmentList_Status_BYJOB=   "xpath=//table[contains(@id,'assignment-list-grid-')]//td[@title='${JOBNUMBER}']/following-sibling::td[contains(@title,'${Status}') or contains(@title,'${StatusDescription}')]"
loc_OGW_AssignmentList_TableText=   "xpath=//table[contains(@id,'assignment-list-grid-')]//td[@title='@!']/parent::tr/td[@title='${data}']"
loc_OGW_AssignmentList_SelectAllCrews=   "xpath=//div[contains(@id,'DispatchViewAssignmentList_AssignmentListGrid-0-')]//div[contains(@id,'-table_cb')]"
loc_OGW_AssignmentList_NoRecordsToView=   "xpath=//td[contains(@id,'assignment-list-grid-')]//*[text()='No records to view']"
loc_OGW_AssignmentList_TableRow1=   "xpath=//table[contains(@id,'assignment-list-grid-')]//tr[2]"

# AssignmentList links
loc_OGW_AssignmentList_Refresh=   "xpath=//div[contains(@id,'DispatchViewAssignmentList_AssignmentListGrid-0-')]//a[contains(@id,'refresh')]"
loc_OGW_AssignmentList_Unassign=   "xpath=//div[@controlname='DispatchViewAssignmentListAction_Unassign']//a"
loc_OGW_AssignmentList_Hold=   "xpath=//div[@controlname='DispatchViewAssignmentListAction_Hold']//a"
loc_OGW_AssignmentList_PreviousStatus=   "xpath=//div[@controlname='DispatchViewAssignmentListAction_PreviousStatus']//a"
loc_OGW_AssignmentList_SetStatus=   "xpath=//div[@controlname='DispatchViewAssignmentListAction_SetStatus']//a"
loc_OGW_AssignmentList_NextStatus=   "xpath=//div[@controlname='DispatchViewAssignmentListAction_NextStatus']//a"
loc_OGW_AssignmentList_Open=   "xpath=//div[@controlname='DispatchViewAssignmentListAction_Open']//a"


# AssignmentList wildcard pop up
loc_OGW_AssignmentListWildcard_Text=  "id=WildCardReplaceField__0"
loc_OGW_AssignmentListWildcard_Crew=  "id=TxtWildCardReplaceField__0"
loc_OGW_AssignmentListWildcard_OK=  "id=wildcard-ok-button"

#-------------------------CREW DETAILS------------------------------------------------

# CrewDetails links
loc_OGW_CrewDetails_Save=   "xpath=//div[@controlname='DispatchViewCrewDetail_SaveCrew']//a"
loc_OGW_CrewDetails_Close=   "xpath=//div[@controlname='DispatchViewCrewDetail_Close']//a"

# CrewDetilsMisc Tabs
loc_OGW_CrewDetails_MiscTab=   "xpath=//label[contains(text(),'Misc')]"
loc_OGW_CrewDetails_LunchCalendar=   "xpath=//div[@controlname='Crew_LunchTime']//a[@title='Open Date Picker']"
loc_OGW_CrewDetails_LunchSetTime=   "xpath=//span[contains(text(),'Set Time')]"
loc_OGW_CrewDetails_LunchTimeInputBox=   "xpath=//input[contains(@id,'Crew_LunchTime-0-')]"

#-------------------------CREW LIST----------------------------------------------

#Crew list
loc_OGW_CrewList_SelectQuery1=   "xpath=//div[contains(@id,'DispatchViewCrewList_CrewListGrid-0-')]//a[contains(@class,'TreeViewFilter ui-link')]" 
loc_OGW_CrewList_SelectQuery2=   "xpath=//div[contains(@id,'crew-list-grid-')]/ul//span[contains(text(),'${CrewList_SelectQuery2}')]/parent::div/a/img[@class='QueryTree-Closed']"
loc_OGW_CrewList_SelectQuery_General=   "xpath=//div[contains(@id,'crew-list-grid-')]/ul[1]/li[2]//span[contains(text(),'General')]/parent::div/a/img[@class='QueryTree-Closed']"

loc_OGW_CrewList_QueryName=   "xpath=//li[@class='jqtree_common']//span[text()='${CrewListQueryName}']"
loc_OGW_Crewlist_MainDiv =     "xpath=//div[contains(@id,'_DispatchViewCrewList-0-')]"

# Crew list wildcard pop up
loc_OGW_CrewListWildcard_Text=  "id=TxtWildCardReplaceField__0"
loc_OGW_CrewListWildcard_OK=  "id=wildcard-ok-button"

# Crewlist links
loc_OGW_CrewList_Assign=   "xpath=//div[@controlname='DispatchViewCrewListAction_Assign']//a"
loc_OGW_CrewList_CrewDetails=   "xpath=//div[@controlname='DispatchViewCrewListAction_Open']//a"
loc_OGW_CrewList_DutyOff=   "xpath=//div[@controlname='DispatchViewCrewListAction_DutyOff']//a"
loc_OGW_CrewList_DutyOn=   "xpath=//div[@controlname='DispatchViewCrewListAction_DutyIn']//a"
loc_OGW_CrewList_LunchOff=   "xpath=//div[@controlname='DispatchViewCrewListAction_LunchOn']//a"
loc_OGW_CrewList_LunchOn=   "xpath=//div[@controlname='DispatchViewCrewListAction_LunchOff']//a"
loc_OGW_CrewList_Refresh=   "//div[@controlname='DispatchViewCrewList_CrewListGrid']//a[contains(@class,'refresh')]"
loc_OGW_CrewList_NestStatus=    "xpath=//div[@controlname='DispatchViewCrewListAction_NextStatus']//a"
loc_OGW_Crewist_PreviousStatus=    "xpath=//div[@controlname='DispatchViewCrewListAction_PreviousStatus']/a"
loc_OGW_Crewlist_Unassign=   "xpath=//div[@controlname='DispatchViewCrewListAction_Unassign']//a"

#Crewlist table
loc_OGW_CrewList_TableValue=   "xpath=//table[contains(@id,'crew-list-grid-')]//td[@title='${data}']" #Override value-Enter crew
loc_OGW_CrewList_TableText=   "xpath=//table[contains(@id,'crew-list-grid-')]" #Override value-Enter crew
loc_OGW_CrewList_TableRow1=   "xpath=//table[contains(@id,'crew-list-grid')]//tr[2]"
loc_OGW_Crewlist_Status=   "xpath=//table[contains(@id,'crew-list-grid-')]//td[@title='${CREW}']/following-sibling::td[contains(@title,'${Status}') or contains(@title,'${StatusDescription}')]"


#--------------------------JOB DETAILS--------------------------------------------------

# Job Details page

loc_OGW_JobDetails_DetailsTAB= "xpath = //label[text()='Details')]"
loc_OGW_JobDetails_JobDetailsTAB= "xpath = //labeltext()='Job Details')]"

loc_OGW_TaskType=    "xpath = //div[contains(@controlname,'Job_TaskType')]//select"
loc_OGW_Jobtype_WorkCode=    "xpath = //div[contains(@controlname,'Job_WorkCode')]//select"
loc_OGW_JobPriority=    "xpath = //div[contains(@controlname,'Job_Priority')]//select"
loc_OGW_JobDetails_Address	=    "xpath = //div[@controlname='Job_FreeFormat']//textarea"
loc_OGW_CityCode=    "xpath = //div[contains(@controlname,'Job_CityCode')]//select"




# JobDetails links
loc_OGW_JobDetails_Save=   "xpath=//div[@controlname='DispatchViewAction_SaveJob']//a"
loc_OGW_JobDetails_Close=   "xpath=//div[@controlname='DispatchViewJobDetailAction_Close']//a"
loc_OGW_JobDetails_Duplicate=   "xpath=//div[@controlname='DispatchViewAction_DuplicateJob']//a"
loc_OGW_JobDetails_Attachments=   "xpath=//div[@controlname='DispatchViewJobDetailAction_Attachment']//a"


#---------------------------JOB LIST-------------------------------------------------
#Job list
loc_OGW_JobList_SelectQuery1=   "xpath=//div[contains(@id,'DispatchViewJobList_JobListGrid-0-')]//a[contains(@class,'TreeViewFilter')]" 
loc_OGW_JobList_SelectQuery2=   "xpath=//div[contains(@id,'DispatchViewJobList_JobListGrid-0-')]//span[@role='treeitem' and text()='${JobList_SelectQuery2}']/parent::div/a/img[@class='QueryTree-Closed']"
loc_OGW_JobList_QueryName=   "xpath=//div[contains(@id,'job-list-grid-')]//li[@class='jqtree_common']//span[text()='${JobListQueryName}']"

# Joblist Wildcard pop up
loc_OGW_JobListWildcard_Text=  "id=WildCardReplaceField__0"
loc_OGW_JobListWildcard_OK=  "id=wildcard-ok-button"
loc_OGW_JobListWildcard_Cancel=  "xpath=//span[contains(text(),'Cancel')]"


# Joblist links
loc_OGW_JobList_Assignjob=   "xpath=//div[@controlname='DispatchViewJobListAction_Assign']//a"
loc_OGW_JobList_Attachments=   "xpath=//div[@controlname='DispatchViewJobListAction_Attachment']//a"
loc_OGW_JobList_Disposejob=   "xpath=//div[@controlname='DispatchViewJobListAction_Dispose']//a"
loc_OGW_JobList_JobDetails=   "xpath=//div[@controlname='DispatchViewJobListAction_Open']//a"
loc_OGW_JobList_Unassignjob=   "xpath=//div[@controlname='DispatchViewJobListAction_Unassign']//a"
loc_OGW_JobList_Refresh=   "xpath=//div[contains(@id,'DispatchViewJobList_JobListGrid-0-')]//a[contains(@id,'refresh')]"
loc_OGW_JobList_NestStatus=    "xpath=//div[@controlname='DispatchViewJobListAction_NextStatus']/a"
loc_OGW_JobList_PreviousStatus=    "xpath=//div[@controlname='DispatchViewJobListAction_PreviousStatus']/a"

#Joblist table
loc_OGW_JoblistTableValue=   "xpath=//table[contains(@id,'job-list-grid-')]//tr[@id='${data}']//td[@class='dispatchgrid-cbox']" #Override value-Enter jobnumber
loc_OGW_Joblist_Status=   "//table[contains(@id,'job-list-grid-')]//tr[@id='${JOBNUMBER}']//td[contains(@title,'${Status}') or contains(@title,'${StatusDescription}')]"
loc_OGW_JoblistTableText=   "xpath=//table[contains(@id,'job-list-grid-')]" 
loc_OGW_Joblist_JobCheckbox=  "xpath=//tr[@id='${data}']//td[@class='dispatchgrid-cbox']"   
loc_OGW_Joblist_TableRow1=  "xpath=//table[contains(@id,'job-list-grid')]//tr[2]"
loc_OGW_Joblist_ContainsText=   "xpath=//div[contains(@id,'DispatchViewJobList_JobListGrid-0-')]//td[contains(@aria-describedby,'table_Address')]//span[contains(text(),'${data}')]" 


#----------------------SYSTEM MESSAGES------------------------------------------------------
# WEBD System messages
loc_OGW_Acknowledge=    "xpath = //span[contains(text(),'Acknowledge')]"
loc_OGW_Unassign=    "xpath =//a[@id='Okbtn']//span[contains(text(),'Unassign')]"
loc_OGW_AcceptAll=    "xpath =//div[contains(@class,'popup-active')]//span[contains(@id,'DispatchValidationResult_AcceptAll-')]"

# Set Reason pop up
loc_OGW_SetReason_Popup=    "xpath = //div[contains(@class,'ui-popup-active') and @id='AssignmentHoldReasonDialog-popup']"
loc_OGW_SetReason_Reason=    "xpath = //input[contains(@id,'DispatchAssignmentHoldReasonCode_ReasonComment-0-')]"
loc_OGW_SetReason_Save=    "xpath = //a[contains(@id,'DispatchAssignmentHoldReasonCode_Save-0-')]"

#---------------------------MAP-------------------------------------------------
# OGW Map
loc_OGW_Map_Layer = "xpath = //div[@id='map-panel-container']//button[contains(text(),'L')]"
loc_OGW_Map_Canvas = "xpath = //div[contains(@id,'DispatchMapFullFeatures-0')]//div[@id='Map-dispatch']//canvas[1]"
loc_OGW_Map_Address = "xpath = //div[@controlname='MapGetAddressPopup_Address']//textarea"
loc_OGW_Map_CreateJob = "xpath = //div[@controlname='MapGetAddressPopup_CreateJob']//a"
loc_OGW_Map_MoveJob = "xpath = //div[@controlname='MapGetAddressPopup_MoveJob']//a"
loc_OGW_Map_GetRoute = "xpath =  //span[contains(text(),'GetRoute')]"      #//div[@controlname='MapGetAddressPopup_GetRouteWithDirections']//a"
loc_OGW_Map_Actions = "xpath = //div[@controlname='MapGetAddressPopup_GlobalActionsPanel']//a"
loc_OGW_Map_CreateCall = "xpath = //div[@controlname='MapGetAddressPopup_CreateCall']//a"


#---------------------------GDM-------------------------------------------------
loc_GDM_QueryFilter_Button = "dom:document.getElementById('the-gdm').shadowRoot.querySelector('a')"
loc_GDM_QueryFilter_MainQuery = "dom:document.getElementById('the-gdm').shadowRoot.getElementById('${GDM_MainQuery}')"
loc_GDM_MultiRoute_Cancel = "xpath= //div[@controlname='DispatchGDMComponentMultiCrewRoute_Cancel']/a"
loc_GDM_Settings_Dialog = "xpath= //div[@id='gdmcomponentsettingsdetailpanel-dialog-popup' and @class='ui-popup-container ui-popup-active']"
loc_GDM_Settings_HeightTimeBar = "xpath= //div[@controlname='DispatchGDMComponentSettings_HeightTimeBar']//input"
loc_GDM_Settings_Close = "xpath= //div[@id='gdmcomponentsettingsdetailpanel-dialog-popup']//div[@id='gdmcomponentsettingsdetailpanel-dialog']/div[1]/a"



#---------------------------PANIC Window------------------------------------------------
loc_OGW_PanicAlert_Window_Checkbox = "xpath= //div[contains(@class,'panicalert-CheckboxAll')]/input"
loc_OGW_PanicAlert_Window_Acknowledge = "xpath= //div[@controlname='DispatchPanicAlertsPanel_Acknowledge']/a"

#--------------------------JOB SEARCH------------------------------------------------

loc_OGW_JobSearch_Active_Checked=   "xpath=//div[@controlname='DispatchViewJobSearch_ActiveJobs']//div[@class='ui-checkbox']/label[contains(@class,'checkbox-on')]"
loc_OGW_JobSearch_Active_Checked=   "xpath=//div[@controlname='DispatchViewJobSearch_ActiveJobs']//div[@class='ui-checkbox']/label[contains(@class,'checkbox-on')]"
loc_OGW_JobSearch_Job_Tab=   "xpath=//div[@controlname='Tabs']//label[text()='Job']"
loc_OGW_JobSearch_JobtypeUDF_Tab=   "xpath=//div[@controlname='Tabs']//label[text()='Job Type UDF']"
loc_OGW_JobSearch_AgencyUDF_Tab=   "xpath=//div[@controlname='Tabs']//label[text()='Agency UDF']"
loc_OGW_JobSearch_Search=   "xpath=//div[@controlname='DispatchViewJobSearch_Search']/a"
loc_OGW_JobSearch_Clear=   "xpath=//div[@controlname='DispatchViewJobSearch_Clear']/a"
loc_OGW_JobSearch_Start_Date_Calendar=   "xpath=//div[@controlname='DispatchViewJobSearch_StatusDateFrom']//a;//input[contains(@id,'DispatchViewJobSearch_StatusDateFrom')]"
loc_OGW_JobSearch_End_Date_Calendar=   "xpath=//div[@controlname='DispatchViewJobSearch_StatusDateTo']//a;//input[contains(@id,'DispatchViewJobSearch_StatusDateTo')]"
loc_OGW_JobSearch_Agency=   "xpath=//div[contains(@controlname,'JobSearchResult_AgencyCode')]//select"












