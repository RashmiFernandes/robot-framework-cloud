#Job list
loc_FS_JobList_SelectQuery1=   "xpath=//div[contains(@id,'SupervisorJobList_JobListGrid-0-') and @class='QueryCombo-Parent'][1]/div[1]/a[1]" 
# loc_FS_JobList_SelectQuery1=   "xpath=//div[@id='_Panel-0']/table/tbody/tr[1]//div[contains(@id,'SupervisorJobList_JobListGrid-0-') and @class='QueryCombo-Parent'][1]/div[1]/a[1]" 
loc_FS_JobList_SelectQuery2=   "xpath=//div[contains(@id,'SupervisorJobList_JobListGrid-0-') and @class='QueryCombo-Parent'][1]//ul//div/span[contains(text(),'${FS_JobQuery}')]/parent::div[1]/a[1]/img"  #Override value-Enter query name
loc_FS_JobList_QueryName=   "xpath=//span[text()='${FS_JobQueryName}']"#Override value

# Joblist Wildcard pop up
loc_FS_JobListWildcard_Text=  "id=WildCardReplaceField__0"
loc_FS_JobListWildcard_OK=  "id=wildcard-ok-button"

#Joblist table
loc_FS_JoblistTableValue=   "xpath=//table[contains(@id,'job-list-grid-')]//tr[@id='@!']//td[@class='dispatchgrid-cbox']" #Override value-Enter jobnumber
loc_FS_JoblistTableText=   "xpath=//table[contains(@id,'job-list-grid-')]//span[contains(text(),'${data}')]" #Override value-Enter jobnumber
loc_FS_Joblist_JobCheckbox=  "xpath=//tbody/tr[@id='${data}']/td[1]"   #Override value-Enter jobnumber

# Joblist links
loc_FS_JobList_NextStatus=    "xpath=//div[@controlname='SupervisorJobList_NextStatus']//a"
loc_FS_JobList_Refresh=   "xpath=//div[contains(@id,'SupervisorJobList_JobListGrid-0-')]//a[contains(@id,'refresh')]"
loc_FS_JobList_JobDetails=   "xpath=//div[@controlname='SupervisorJobList_SupervisorJobDetails']//a"
loc_FS_JobList_Assign=   "xpath=//div[@controlname='SupervisorJobList_SupervisorJobListAssign']//a"


#Crewlist
loc_FS_CrewList_SelectQuery1=   "xpath=//div[contains(@id,'SupervisorCrewList_CrewListGrid-0-') and @class='QueryCombo-Parent'][1]/div[1]/a[1]" 
loc_FS_CrewList_SelectQuery2=   "xpath=//div[contains(@id,'SupervisorCrewList_CrewListGrid-0-') and @class='QueryCombo-Parent'][1]//ul//span[contains(text(),'${CrewList_SelectQuery2}')]/parent::div[1]/a[1]/img"
loc_FS_CrewList_QueryName=   "xpath=//span[text()='${CrewListQueryName}']"#Override value-Enter query name

# Crew list wildcard pop up
loc_FS_CrewListWildcard_Text=  "id=TxtWildCardReplaceField__0"
loc_FS_CrewListWildcard_OK=  "id=wildcard-ok-button"
loc_FS_CrewListWildcard_Cancel=  "xpath=//div[contains(@class,'ui-popup-active')]//td[@class='ui-wildcard-dialog-action-btn']/a//span[contains(text(),'Cancel')]"

# Crewlist links
loc_FS_CrewList_Refresh=   "xpath=//div[contains(@id,'SupervisorCrewList_CrewListGrid-0-')]//a[contains(@id,'refresh')]"
loc_FS_CrewList_Open=   "xpath=//div[@controlname='SupervisorCrewList_SupervisorCrewDetails']/a"

#Crewlist table
loc_FS_CrewList_TableValue=   "xpath=//table[contains(@id,'crew-list-grid-')]//td[@title='@!']" #Override value-Enter crew
loc_FS_CrewList_TableText=   "xpath=//table[contains(@id,'crew-list-grid-')]//span[contains(text(),'${data}')]" #Override value-Enter crew
loc_FS_Crewlist_JobCheckbox=  "xpath=//table[contains(@id,'crew-list-grid-')]/td[1]" 


#Assignment list
loc_FS_AssignmentList_SelectQuery1=   "xpath=//div[contains(@id,'SupervisorAssignmentList_AssignmentListGrid-0-') and @class='QueryCombo-Parent'][1]/div[1]/a[1]" 
loc_FS_AssignmentList_SelectQuery2=   "xpath=//div[contains(@id,'SupervisorAssignmentList_AssignmentListGrid-0-') and @class='QueryCombo-Parent'][1]/ul[1]/li[2]//img"
loc_FS_AssignmentList_QueryName=   "xpath=//div[contains(@id,'SupervisorAssignmentList_AssignmentListGrid-0-')]//div[1]/div[1]/ul[1]//li[2]//ul[1]//span[text()='@!']"#Override value-Enter query name
loc_FS_AssignmentList_QueryName_BYCREWTODAY=   "xpath=//div[contains(@id,'DispatchViewAssignmentList_AssignmentListGrid-0-')]//div[1]/div[1]/ul[1]//li[2]//ul[1]//li[10]//span"


#AssignmentList table
loc_FS_AssignmentList_TableValue=   "xpath=///table[contains(@id,'assignment-list-grid-')]//td[@title='${data}']" #Override value-Enter crew/jobnum
loc_FS_AssignmentList_TableText=   "xpath=//table[contains(@id,'assignment-list-grid-')]" #Override value-Enter jobnum
loc_FS_AssignmentList_SelectAllCrews=   "xpath=//div[contains(@id,'DispatchViewAssignmentList_AssignmentListGrid-0-')]//div[contains(@id,'-table_cb')]"


# AssignmentList links
loc_FS_AssignmentList_Refresh=   "xpath=//div[contains(@id,'SupervisorAssignmentList_AssignmentListGrid-0-')]//a[contains(@id,'refresh')]"

# Job Details page
loc_FS_JobDetails_Attachments=   "xpath=//div[@id='_JobDetailDialog-0']//div[@controlname='Action_Attachment']//a"
loc_FS_JobDetails_DetailsTAB= "xpath=//label[text()='Details']"
loc_FS_JobDetails_JobDetailsTAB= "xpath=//label[text()='Job Details']"
loc_FS_JobDetails_AdditionalInfoTAB= "xpath=//label[contains(text(),'Additional Job Information')]"
loc_FS_JobDetails_Agency=  "xpath=//select[contains(@id,'Job_AgencyCode-0-')]"

loc_FS_TaskType=    "xpath=//select[contains(@id,'Job_TaskType-0')]"
loc_FS_Jobtype_WorkCode=    "xpath=//select[contains(@id,'Job_WorkCode-0')]"
loc_FS_JobPriority=    "xpath=//div[contains(@controlname,'Job_Priority')]//select"
loc_FS_JobDetails_Address=  "xpath=//div[@controlname='Job_FreeFormat']//textarea"
loc_FS_CityCode=    "xpath=//div[contains(@controlname,'Job_CityCode')]//select"
loc_FS_JobDetails_Save=   "xpath=//div[@id='_JobDetailDialog-0']//div[@controlname='Action_SaveJob']//a"
loc_FS_JobDetails_Close=   "xpath=//div[@controlname='DispatchViewJobDetailAction_Close']//a" 
loc_FS_JobDetails_Close2=   "xpath=//div[@controlname='JobDetailDialog_Close']/a"
loc_FS_JobDetails_Duplicate=   "xpath=//div[@controlname='DispatchViewAction_DuplicateJob']//a"

# Map
loc_FS_Map_CreateSupervisorJob = "xpath=//div[@controlname='SupMapGetAddressPopup_CreateSupervisorJob']//a"
loc_FS_Map_Canvas = "xpath=//tbody/tr[1]/td[1]/div[1]/div[1]/div[1]/div[16]/canvas[1]"


#Crew Makeup - Crew Details
loc_FS_CrewDetails_AddPersonnel=    "xpath=//label[text()='Add Personnel']"
loc_FS_CrewDetails_Agency=    "xpath=//div[@controlname='CrewMembersResearchPanel_AgencyCode']//select"
loc_FS_CrewDetails_Search=    "xpath=//span[contains(@id,'CrewMembersResearchPanel_Search-')]"
loc_FS_CrewDetails_Save=    "xpath=//a[contains(@id,'SupervisorCrewDetail_SaveCrew')]"
loc_FS_CrewDetails_Cancel=    "xpath=//a[contains(@id,'CrewMembersListHeader_Cancel')]"
loc_FS_CrewDetails_BadgeNo=  "xpath=//input[contains(@id,'CrewMembersResearchPanel_BadgeNumber-0-')]"
loc_FS_CrewDetails_Add_Enabled=   "xpath=//a[contains(@id,'CrewMembersResearchResult_Add') and contains(@style,'1')]"
loc_FS_CrewDetails_Close=   "xpath=//div[@id='supervisorcrewdetailpanel-dialog-popup']//div[@id='supervisorcrewdetailpanel-dialog']//a[@data-icon='delete']"
loc_FS_CrewDetails_Clear=    "xpath=//div[@controlname='CrewMembersResearchPanel_Clear']"
loc_FS_CrewDetails_Primary_InitialsID=  "xpath=//li//div[contains(@id,'_CrewMembersList')]//td[1]/table/tbody/tr[1]/td[contains(@title,'${Primary}')]//input"
loc_FS_CrewDetails_PrimaryCheckbox_On=    "xpath=//li//div[contains(@id,'_CrewMembersList')]//td[1]/table/tbody/tr[1]/td[contains(@title,'${Primary}')]/parent::tr/parent::tbody/parent::table/parent::td//following-sibling::td[3]//div[@controlname='CrewMember_Leader']//div[@class='ui-checkbox']/label[@data-icon='checkbox-on']"
loc_FS_CrewDetails_Primary_DeleteDisabled=    "xpath=//div[@controlname='CrewMembersList_Delete']//a[contains(@onclick,'${Primary}') and contains(@style,'0.5')]"
loc_FS_CrewDetails_Helper_InitialsID=  "xpath=//li//div[contains(@id,'_CrewMembersList')]//td[1]/table/tbody/tr[1]/td[contains(@title,'${Helper}')]//input"
loc_FS_CrewDetails_Helper_DeleteEnabled=    "xpath=//div[@controlname='CrewMembersList_Delete']//a[contains(@onclick,'${Helper}') and contains(@style,'1')]"
loc_FS_CrewDetails_Helper1_Row2=    "xpath=//ul[@id='CrewMembersList-listview']/li[2]//div[@controlname='CrewMembersList_Delete']/a"
loc_FS_CrewDetails_Helper2_Row2=    "xpath=//ul[@id='CrewMembersList-listview']/li[3]//div[@controlname='CrewMembersList_Delete']/a"

