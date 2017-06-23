# LayoutDescriberHelper
Salesforce.com apex class to describe page layouts.

### Install

##### Deploy to Salesforce Button

<a href="https://githubsfdeploy.herokuapp.com?owner=anyei&repo=LayoutDescriberHelper">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

##### Manual
Download this repo and use eclipse or jenkins to deploy the src folder's content.


##### Remote Site Settings entry

After you install, you must make sure the salesforce instance server where you are login is included in the remote site settings.

1. Go to setup
2. Then in the left menu, click on "Security Controls" -> "Remote Site Settings" option 
3. If you dont have an entry of your salesforce instance, click "New Remote Site" button 
4. Put a name name to that entry in the "Remote Site Name" field, could be something like "salesforce sandbox" or "salesforce prod"
5. In the "Remote Site URl" type in the correct url of the salesforce instance you are loggin, mine looks like "https://na17.salesforce.com" without quotes 
6. Finally make sure the "Active" checkbox is checked and save the record. 
7. Navigate to Setup -> Session Settings -> Ensure  "Lock sessions to the IP address from which they originated" is turned off. 
8. If 7, was deselected, you will need to log out and log in again for this change to take effect. 

### Usage
Just do the following in your visualforce page controller
```sh
public class EditAccountController {
//expose public property, this property will be listing each layout section
	public List < LayoutDescriberHelper.LayoutSection > layoutSections {
		get;
		set;
	}
	//...... more members of your controller class.......

public EditAccountController(ApexPages.StandardController controller) {

// Create list of fields to add to controller for object 
            
            
	/* dynamically get all fields for the Account object and add them to the controller */
    List<String> fieldList = new List<String>(Schema.getGlobalDescribe().get('Account').getDescribe().fields.getMap().keyset());		

// Add fields to controller. This is to avoid the SOQL error in visualforce page
controller.addFields(fieldList);

sObject obj = controller.getRecord();

//.... more code to do things



/************************************************************************/
 //getting the default record type
//if we want an specific layout we must provide the appropriate record type id
id theRecordTypeIdToDescribe = LayoutDescriberHelper.getDefaultRecordType(obj);
        
//get the layout section items
layoutSections = LayoutDescriberHelper.describeSectionWithFields(theRecordTypeIdToDescribe, 'Account');

/***************************************************************************/

}

}
```
Where layoutSections is a public property in your controller and 'Account' is your sobject type.
Make sure you select the fields of the object before referencing them otherwise you'll get an annoying sfdc standard error.

See the following visualforce page example which will generate an edit form for the Account object:
```sh
<apex:page standardController='Account' extensions="EditAccountController" >
    
    <apex:form>
    <apex:pageblock >
        <apex:pageBlockButtons >
            <apex:commandButton action="{!save}" value="save"/>
            <apex:commandButton action="{!cancel}" value="cancel"/>
        </apex:pageBlockButtons>
         
        <!-- Iterate the layoutSections, which is a list of sections -->
        <apex:repeat value="{!layoutSections}" var="layoutSection">
                <apex:pageBlockSection title="{!layoutSection.Name}" collapsible="{!layoutSection.allowCollapse}" columns="{!layoutSection.columns}">
                    
                    <!--Each section has layoutFields, let's iterate them as well-->
                    <apex:repeat value="{!layoutSection.layoutFields}" var="layoutField">
                        <apex:inputField value="{!Account[layoutField.ApiName]}" rendered="{!not(layoutField.isPlaceHOlder)}" required="{!layoutField.required}"  />
                        <apex:pageblocksectionitem rendered="{!layoutField.isPlaceHolder}" >
                        </apex:pageblocksectionitem>
                    </apex:repeat>
                    
                </apex:pageBlockSection>
            </apex:repeat>  
    </apex:pageblock>
        </apex:form>
</apex:page>

```
