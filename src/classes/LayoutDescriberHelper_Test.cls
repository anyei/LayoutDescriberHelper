/**************************************

Author             : Angel Robles (anyei)

Purpose            : Test for LayoutDescriberHelper 

                   :

Created Date       : 8/27/2015

Reviewed By        : 

Last Modified By   : Angel Robles - Initial code

                   :

**************************************/

@IsTest

public class LayoutDescriberHelper_Test implements HttpTestMock.HttpTestMockResponseHandler {

    public Map<string,object> additionalTestingParameters = new Map<string,object>();

    public HTTPResponse respondToHTTPRequest(HTTPRequest req){

        

        HttpResponse res = new HttpResponse();

        res.setHeader('Content-Type', 'application/json');

        res.setStatusCode(200);

        

        string endp = req.getEndpoint();

        

        system.debug('=======> endpoint'+ endp);

        

        //getting what's object to ge the layout for

        string theTargetObject = endp.substring(endp.indexof('/sobjects/') + 10, endp.indexof('/describe/'));

        

        //getting what's the record type the to get the layout for.

        string theTargetRecordTypeId = endp.substring(endp.indexof('/layouts/') + 9, endp.length());

       

        system.debug('======> target object ' + theTargetObject);

        

        

        

        //root of the resulting json

        Map<string,object>  rawDataToReturn = new Map<string,object>();

        

        //list of sections in the layout

        List<object> sections = new List<object>();

        

        

        

        /*

         * FIRST SCENARIO

         * SECTION WITH NO HEADING

         * This will cover also the rest of the code

         * 

         * */

        if(additionalTestingParameters.get('testType') == 'secondSectionWithNoHeader' && theTargetObject.tolowerCase() =='account' && additionalTestingParameters.get('expectedRecordTypeId') ==theTargetRecordTypeId ){

        

            //first section item, this represents a section in the layout

            Map<string,object> sectionItem = new Map<string,object>();

           

            sectionItem.put('useHeading',true);

            

            sectionItem.put('heading','testing heading..');

            

            sectionItem.put('columns',2);

            sectionItem.put('useCollapsibleSection',true);

            

            //a layout row list

            List<object> layoutRows = new List<object>();

            

            //a layout row to be included in a section

            map<string,object> layoutRow1 = new map<string,object>();

            

            //list of row items, this list will contains the columns in the rows

            //maximun of two items is allowed here, that's what the real service give me

            List<object> layoutItems = new List<object>();

            

            /*

             * A FIELD FIELD COLUMN

             * */

            //an actual column for the layout

            //you can say a column is pretty much a field or placeholder

            Map<string, object> fieldItems = new Map<string,object>();

            fieldItems.put('placeholder',false);

            fieldItems.put('editable',true);

            

            //some component for a column

            List<object> layoutComponents = new List<object>();

            Map<string,object> layoutComponent = new Map<string,object>();

            layoutComponent.put('value','Field_Api_Name__c');

            layoutComponent.put('type','Field');

            layoutComponents.add(layoutComponent);

            

            fieldItems.put('layoutComponents', layoutComponents);

            

            /*

             * A PLACEHOLDER COLUMN

             * */

            //second field, this one will be a placeholder   

            //it means an empty column     

            Map<string, object> fieldItemsForPlaceHolder = new Map<string,object>();

            fieldItemsForPlaceHolder.put('placeholder',true);

            fieldItemsForPlaceHolder.put('editable',false);

            

            //as the thing that this component will be related to its a placeholder

            //the layoutComponent will not have relevant information

            //but we must add a layoutComponent even if its empty

            List<object> layoutComponentsForPlaceHolder = new List<object>();

            Map<string,object> layoutComponentForPlaceHolder = new Map<string,object>();

            layoutComponentForPlaceHolder.put('value','');

            layoutComponentForPlaceHolder.put('type','PlaceHolder');

            layoutComponentsForPlaceHolder.add(layoutComponentForPlaceHolder);        

            fieldItemsForPlaceHolder.put('layoutComponents', layoutComponentsForPlaceHolder);

            

            

            layoutItems.add(fieldItems);

            layoutItems.add(fieldItemsForPlaceHolder);

            

            //adding the columns to the rows

            //so the row has two columns now, a field and a placeholder

            layoutRow1.put('layoutItems', layoutItems);

            

            //adding a row to the list of rows

            layoutRows.add(layoutRow1);      

            

            //a section has a row now with two columns

            sectionItem.put('layoutRows',layoutRows);        

            

            

            //adding one section to the list of sections

            sections.add(sectionItem);

            

            

            

            

            //second section item, this represents a section in the layout

            //THIS IS THE SECTION WITH HEADING FALSE

            Map<string,object> sectionItem2 = new Map<string,object>();

           

            sectionItem2.put('useHeading',false);

            

            sectionItem2.put('heading','');

            

            sectionItem2.put('columns',2);

            sectionItem2.put('useCollapsibleSection',true);

            

            //a layout row list

            List<object> layoutRows2 = new List<object>();

            

            //a layout row to be included in a section

            map<string,object> layoutRow12 = new map<string,object>();

            

            //list of row items, this list will contains the columns in the rows

            //maximun of two items is allowed here, that's what the real service give me

            List<object> layoutItems2 = new List<object>();

            

            /*

             * A FIELD FIELD COLUMN

             * */

            //an actual column for the layout

            //you can say a column is pretty much a field or placeholder

            Map<string, object> fieldItems12 = new Map<string,object>();

            fieldItems12.put('placeholder',false);

            fieldItems12.put('editable',true);

            

            //some component for a column

            List<object> layoutComponents22 = new List<object>();

            Map<string,object> layoutComponent2 = new Map<string,object>();

            layoutComponent2.put('value','Field_Api_Name__c');

            layoutComponent2.put('type','Field');

            layoutComponents22.add(layoutComponent2);

            

            fieldItems12.put('layoutComponents', layoutComponents22);

            

            /*

             * A PLACEHOLDER COLUMN

             * */

            //second field, this one will be a placeholder   

            //it means an empty column     

                Map<string, object> fieldItems122 = new Map<string,object>();

            fieldItems122.put('placeholder',true);

            fieldItems122.put('editable',false);

            

            //as the thing that this component will be related to its a placeholder

            //the layoutComponent will not have relevant information

            //but we must add a layoutComponent even if its empty

            List<object> layoutComponents122 = new List<object>();

            Map<string,object> layoutComponent122 = new Map<string,object>();

            layoutComponent122.put('value','');

            layoutComponent122.put('type','PlaceHolder');

            layoutComponents122.add(layoutComponent122);        

            fieldItems122.put('layoutComponents', layoutComponents122);

            

            

            layoutItems2.add(fieldItems12);

            layoutItems2.add(fieldItems122);

            

            //adding the columns to the rows

            //so the row has two columns now, a field and a placeholder

            layoutRow12.put('layoutItems', layoutItems2);

            

            //adding a row to the list of rows

            layoutRows2.add(layoutRow12);      

            

            //a section has a row now with two columns

            sectionItem2.put('layoutRows',layoutRows2);        

            

            

            //adding one section to the list of sections

            sections.add(sectionItem2);

        

        }

        

        rawDataToReturn.put('editLayoutSections', sections);

                 

        string resultingJson = JSON.serialize(rawDataToReturn);

        

        

       // id recordId = endp.substring(endp.indexof('id=') + 3, endp.indexof('&'));

        //string apexJobId =endp.substring(endp.indexof('jobid=') + 6);

        system.debug('==================> response endpoint ' + endp);

        system.debug('==================> resultingJson '+resultingJson);

        res.setBody(resultingJson);

        return res;

    }

    

    @isTest

    public static void  sectionsWithNoNamesWithFieldsDescribed(){

       

        //generic mock

       HttpTestMock genericHTTPMock = new HttpTestMock();

        

        //this current test class is implementing an interface, therefore i can use it and

        //pass it over my mock callout class

       LayoutDescriberHelper_Test testHelper = new LayoutDescriberHelper_Test();

       genericHTTPMock.responseHandler = testHelper;        

        

        //setting the mock       

       Test.setMock(HttpCalloutMock.class,genericHTTPMock);

        

        Id theRecordTypeIdToDescribe = LayoutDescriberHelper.getDefaultRecordType(new Account());

        

        //putting some values in this map so that my response method will use it        

        testHelper.additionalTestingParameters.put('testType','secondSectionWithNoHeader');

        testHelper.additionalTestingParameters.put('expectedRecordTypeId',theRecordTypeIdToDescribe);

        

        List<LayoutDescriberHelper.LayoutSection> sections = new List<LayoutDescriberHelper.LayoutSection> ();

        Test.StartTest();

        

        sections = LayoutDescriberHelper.describeSectionWithFields(theRecordTypeIdToDescribe,'Account');

        Test.StopTest();

        //when second section has empty title all its fields shall be added to the previous section.

        system.assert(sections.size() == 1,'Layout was not described correctly');

        system.assert(sections.get(0).layoutFields.size() == 4,'it should have three items in this list');

    }

}
