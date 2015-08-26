/*
 * Author: Angel Robles (anyei)
 * Github: https://github.com/anyei/LayoutDescriberHelper
 * Created Date: 8/25/2015
 * Purpose: Utility class with some functions to allow describe layouts
 * Test Class: LayoutDescriberHelper_Test
 * History: 
 * 		8/25/2015 - Angel Robles - Initial Code.
 * 
 * */

public class LayoutDescriberHelper {
    public static string urlPrefixToUse {get;set;}
    
    public static List<LayoutSection> describeSectionWithFields(Id recordTypeId, string objectType){
        system.debug('record type id ===>'+ recordTypeId);
        List<LayoutSection> layoutSections;
       Map<string,List<LayoutField>> layoutFields;
        
        layoutSections = new List<LayoutSection>();

		
       		string theRespBody = GetLayoutSchema(recordTypeId, objectType);
           system.debug('======>'+theRespbody);
                    //resp is a JSON string
           // JSONParser parser = JSON.createParser(theRespBody);
        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(theRespBody);
     
        if(m.containsKey('editLayoutSections'))
        {
           List<object > targetLayout = (List<object>) m.get('editLayoutSections');
            
            for(object sectionObject: targetLayout){
               Map<String,object> section = (Map<String,object>) sectionObject;
                string sectionH = (string)section.get('heading');
                boolean useH = (boolean)section.get('useHeading');
                integer columns = (integer)section.get('columns');
                boolean useCollapse = (boolean)section.get('useCollapsibleSection');
                
                LayoutSection ls = new LayoutSection();
                ls.Name = sectionH;// == 'Stage 0+' || useH == false ? '' : sectionH;
                ls.useHeader = useH;
                ls.columns = columns;
                ls.allowCollapse = useCollapse;
                ls.layoutFields = new List<LayoutField>();                
                layoutSections.add(ls);

                
                List<object> layoutRows = (List<object>)  section.get('layoutRows');
                system.debug('layout rows ====> '+layoutRows);
                
                for(Object itemObject : layoutRows ){
                     Map<String,object> item = (Map<String,object>) itemObject;
                   List<object> layoutItem = (List<object>)item.get('layoutItems');
                    
                    boolean priorFieldLayoutAdded = true;//initially true
                    
                    for(object fieldItemObject : layoutItem){
                        Map<string, object> fields = (Map<string,object>) fieldItemObject;
                       List<object> layoutComponents = (List<object>) fields.get('layoutComponents');
                         string apiName = '';
                        string fieldType = '';
                        for(Object layoutComponent: layoutComponents){
                            Map<string, object> componentMap = (Map<string,object>)layoutComponent;
                            if(componentMap.containsKey('value')){
                                apiName = (string) componentMap.get('value');
                            }
                            
                             if(componentMap.containsKey('type')){
                                fieldType = (string) componentMap.get('type');
                            }
                            /*
                            if(componentMap.containsKey('details')){
                                Map<string,object> detailsMap = (Map<string,object>) componentMap.get('details');
                                boolean calculatedField = (boolean)detailsMap.get('calculated');
                                boolean autoNumberField = (boolean)detailsMap.get('autoNumber');
                                if(calculatedField || autoNumberField)
                                    apiName = '';
                            }*/
                            
                        }
                         /*Map<string, object> nameDetails = (Map<string,object>) layoutComponents.get('Name');
                       
*/                      boolean placeholderF = (boolean) fields.get('placeholder'); 
                        boolean isEditable = (boolean) fields.get('editable');
                        if( (apiName != '' && fieldType =='Field') || (   placeholderF)){
                            
                            LayoutField lf = new LayoutField();
    						lf.isPlaceHolder = placeholderF;
                            lf.editableField =  isEditable;
                            lf.ApiName = apiName;
    						if(ls.Name != '' || layoutSections.size() == 1)                                
                            	ls.layoutFields.add(lf);
    						else if(layoutSections.size() - 2 >= 0)
                                layoutSections.get(layoutSections.size() - 2).layoutFields.add(lf);
                            priorFieldLayoutAdded = true;
						}else
                            priorFieldLayoutAdded = false;
                       system.debug(fields);
                    }/**/
                  
                }
              if(layoutSections.get(layoutSections.size() -1).layoutFields.size() <= 0)  
                  layoutSections.remove(layoutSections.size() - 1);
            }
        }
        return layoutSections;
    }
    static string getUrlPrefix(){
        
        	string baseurl= System.URL.getSalesforceBaseUrl().toExternalForm();
            system.debug('original prefix is ===>'+ baseurl);
            if(baseurl.contains('c.cs'))
                baseurl = baseurl.substring(baseurl.indexof('.cs') + 1,baseurl.indexof('.visual'));
            else if(baseurl.contains('.na'))
                baseurl = baseurl.substring(baseurl.indexof('.na') + 1,baseurl.indexof('.visual'));
            else
                baseurl = baseurl.substring(baseurl.indexof('/cs') + 1, baseurl.indexof('.salesforce'));
       
        system.debug('prefix is ===>'+ baseurl);
        return baseurl;
    }
    public static string GetLayoutSchema(id recordTypeId, string objectType){
        string allLayoutsRestUrl = 'https://'+getUrlPrefix()+'.salesforce.com/services/data/v29.0/sobjects/'+objectType+'/describe/layouts/';
        string urlToRequest = allLayoutsRestUrl +  recordtypeid;
        
		
        HttpResponse resp = null;
         
            HttpRequest req = new HttpRequest();
         
            req.setMethod('GET');
            req.setEndpoint(urlToRequest);
         
            /*if(contentType != null)
                req.setHeader('Content-type', contentType);*/
    
            /*if(requestBody != null)
                req.setBody(requestBody);*/
                
           
                req.setHeader('Authorization', 'Bearer ' + userinfo.getsessionid());
                
            Http client = new Http();    
            resp = client.send(req);
            system.debug('====================> sent the request');
            system.debug('====================> get the response body ');
        return resp.getBody();
    }
    public static Id  getDefaultRecordType(SObject obj) {
    // in case it's null, the user has only one record type available. 
        
            Schema.DescribeSObjectResult describeResult = obj.getsObjectType().getDescribe();
            List<Schema.RecordTypeInfo> rtInfos = describeResult.getRecordTypeInfos();
            for(Schema.RecordTypeInfo rtInfo : rtInfos) {
            // walk through the map to determine the correct record type, this is done with the isAvailable() function
                if(rtInfo.DefaultRecordTypeMapping) {              
                    return  rtInfo.getRecordTypeId();
                       
                }
            }       
           
       
        return null;
     }
   public class LayoutSection
   {
       public boolean useHeader {get;set;}
       public string name {get;set;}
       public boolean allowCollapse {get;set;}  
       public integer columns {get;set;}
       public List<LayoutField> layoutFields {get;set;}
   }
    
    public class LayoutField
    {
        public boolean isPlaceHolder {get;set;}        
        public string ApiName {get;set;}
        public boolean editableField {get;set;}
    }
}
