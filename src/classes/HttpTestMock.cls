/**************************************

Author             : Angel Robles (anyei)

Purpose            : Generic Mock HttpCallout response generator

Created Date       : 8/27/2015

Reviewed By        : Angel Robles

Last Modified By   : Angel Robles - Initial code

                   : 

**************************************/

@isTest

global class HttpTestMock implements HttpCalloutMock {



   global HttpTestMockResponseHandler responseHandler {get;set;}

    

    global HTTPResponse respond(HTTPRequest req) {

        if(responseHandler== null)

            throw new HttpTestMockException('responseHandler property is null');

        return responseHandler.respondToHTTPRequest(req);

    }

    

    global interface HttpTestMockResponseHandler{

        

        HTTPResponse respondToHTTPRequest(HTTPRequest req);

    }

    

    global class HttpTestMockException extends Exception{

        

    }

}
