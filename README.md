# LayoutDescriberHelper
Salesforce.com apex class to describe page layouts.


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
                        <apex:inputField value="{!Account[layoutField.ApiName]}" rendered="{!not(layoutField.isPlaceHOlder)}"    />
                        <apex:pageblocksectionitem rendered="{!layoutField.isPlaceHolder}" >
                            <apex:outputPanel ></apex:outputPanel>
                        </apex:pageblocksectionitem>
                    </apex:repeat>
                    
                </apex:pageBlockSection>
            </apex:repeat>  
    </apex:pageblock>
        </apex:form>
</apex:page>

```
