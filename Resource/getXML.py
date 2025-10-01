import requests
import xml.etree.ElementTree as ET
import getData

TEST = 'JobNumber:EPB-20241120-00011^AgencyCode:EPB^CrewCode:AUTCREW92^ShiftCode:ALL DAY^ShiftDate:2024-11-19'

def get_all_nodes(root):
    """Recursively traverse the XML tree and return all nodes."""
    nodes = [root]
    for child in root:
        nodes.extend(get_all_nodes(child))
    return nodes


def update_xmlNode_NewValue(filename,tempfile,nodevalue,NEWVALUE):
    tree = ET.parse(filename)
    root = tree.getroot()
    all_nodes = get_all_nodes(root)
    print(all_nodes)
    for node in all_nodes:        
        temp_list = node.tag.split('}')
        if temp_list[1] == nodevalue:
            node.text = NEWVALUE
            # print(node.tag, node.attrib, node.text)
            # break
    tree.write(tempfile, encoding='utf-8', xml_declaration=True)


#After updating Assigned job to crew xml the nodes values change so need to update it to original
def find_replace_AssignJobCrew(filename):
    soap_new = 'xmlns:xsi="http://www.utilitysolutions.cgi.com/MWFMS-1_2" xmlns:xsd="http://www.openapplications.org/oagis"'
    soap_old = 'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"'
   
    find_and_replace_in_file(filename, 'ns0', 'soap')
    find_and_replace_in_file(filename, 'ns1:', '')
    find_and_replace_in_file(filename, 'ns2:', '')
    find_and_replace_in_file(filename, 'ns1', 'xsi')
    find_and_replace_in_file(filename, 'ns2', 'xsd')
    find_and_replace_in_file(filename, soap_new, soap_old)
    find_and_replace_in_file(filename, '<CreateAssignment environment="Test">', '<CreateAssignment xmlns:tns="http://www.utilitysolutions.cgi.com/MWFMS-1_2" environment="Test" xmlns="http://www.utilitysolutions.cgi.com/MWFMS-1_2">') 
    find_and_replace_in_file(filename, '<ApplicationArea> ', '<ApplicationArea xmlns="http://www.openapplications.org/oagis">')



def update_xmlNode_AssignJobToCrew(originalfile,tempfilename,values):
    nodevalue = []
    NEWVALUE = []

    # copy file to temp file-work on temp file
    getData.copyfile(originalfile,tempfilename)  

    lst1 = getData.split_string_to_list(values,'^')
    for i in range(0,len(lst1)):
        lst2 = lst1[i].split(':')   
        print(lst2)
        nodevalue.append(lst2[0])
        NEWVALUE.append(lst2[1])

    # Read xml file and get the root and the nodes
    tree = ET.parse(tempfilename)   

    root = tree.getroot()

    for i in range(0,len(nodevalue)):
        
        all_nodes = get_all_nodes(root)
        for node in all_nodes:        
            temp_list = node.tag.split('}')
            if temp_list[1] == nodevalue[i]:
                node.text = NEWVALUE[i]                
                break
    

    tree.write(tempfilename, encoding='utf-8', xml_declaration=True)
    find_replace_AssignJobCrew('C:/RobotSource/Robot/Testdata/XML/temp.xml')

# ===============================================================================================   

# Function to find and replace text in a file
def find_and_replace_in_file(file_path, old_text, new_text):
    # Read the content of the file
    with open(file_path, 'r') as file:
        file_content = file.read()
    
    # Replace the old text with the new text
    updated_content = file_content.replace(old_text, new_text)
    
    # Write the updated content back to the file
    with open(file_path, 'w') as file:
        file.write(updated_content)



# update_xmlNode_NewValue('C:/RobotSource/Robot/Testdata/XML/AssignJobToCrew.xml', 'JobNumber' ,'RASHMI')


# find_replace_AssignJobCrew('C:/RobotSource/Robot/Testdata/XML/temp.xml')

# update_xmlNode_AssignJobToCrew('C:/RobotSource/Robot/Testdata/XML/AssignJobToCrew.xml','C:/RobotSource/Robot/Testdata/XML/temp.xml','AgencyCode:ABD^CrewCode:AUTCREW100^JobNumber:EPB-20241120-00011^ShiftCode:1^ShiftDate:2024-11-20')
# find_replace_AssignJobCrew('C:/RobotSource/Robot/Testdata/XML/Test.xml')




