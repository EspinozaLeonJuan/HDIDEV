global class MockHttpGeneratorApiHandlerCLass  implements HttpCalloutMock{
    static global HTTPResponse respond(HTTPRequest req) 
    {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody
        (
            '{'+
            '"RvmVehiculo": {'+
            '"IdRvm": "LV-KJ24",'+
            '"Tipo": "AUTOMOVIL",'+
            '"Marca": "SUZUKI"'+
    		'}'+
            '}'
        );
        res.setStatusCode(200);
        return res;
    }    
}