/*

 * Author: Angel Robles

 * Created Date: 8/26/2015

 * Purpose: Controller class for vf page EditAccountPage

 * Test Class: EditAccountController_Test

 * History: 

 * 		8/26/2015 - Angel Robles - Initial Code.

 * 

 * */

public class EditAccountController {



	//expose public property, this property will be listing each layout section

	public List < LayoutDescriberHelper.LayoutSection > layoutSections {

		get;

		set;

	}



	public EditAccountController(ApexPages.StandardController controller) {

        

        //we get all the fields in the object

		Map < string, Schema.SObjectField > describeFields = Schema.getGlobalDescribe().get('Account').getDescribe().fields.getMap();



		set < string > fieldsToAdd = new set < string > ();

        

        //this list is to skipp some fields we dont want to show up in the layout

		set < string > fieldsToSkipp = new set < string > {

			'CreatedDate', 'CreatedById', 'LastModifiedDate', 'LastModifiedById', 'SystemModstamp', 'LastActivityDate', 'LastReferencedDate', 'IsDeleted', 'Id', 'LastViewedDate'

		};

      

		for (Schema.SObjectField f: describeFields.values()) {

			DescribeFieldResult fr = f.getDescribe();

			if (fr.isUpdateable() && !fr.IsCalculated() && !fr.IsAutoNumber() && !fieldsToSkipp.contains(fr.getName())) fieldsToAdd.add(fr.getName());

		}

		controller.addFields(new List < string > (fieldsToAdd));

        

        //get the current account record

		SObject obj = controller.getRecord();





        //getting the default record type

        //if we want an specific layout we must provide the appropriate record type id

		id theRecordTypeIdToDescribe = LayoutDescriberHelper.getDefaultRecordType(obj);

        

        //get the layout section items

		layoutSections = LayoutDescriberHelper.describeSectionWithFields(theRecordTypeIdToDescribe, 'Account');

        

		system.debug('final layouts===>' + layoutSections);



	}

}
