@IsTest
private class CORE_RestApiHandler_CLSTest {
    
    @IsTest
    static void testPostCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpGeneratorApiHandlerCLass()); 
        // Create an HTTP response for the mock callout
        List<String> entryData = new List<String>{'lvkj24'};
            HttpRequest req = new HttpRequest();
        HttpResponse response = MockHttpGeneratorApiHandlerCLass.respond(req);
        response.setBody
            (
                '{'+
                '"RvmVehiculo": {'+
                '"IdRvm": "LV-KJ24",'+
                '"Tipo": "AUTOMOVIL",'+
                '"Marca": "SUZUKI"'+
                '}'+
                '}'
            );
        String actualValue = response.getBody();
        //respuesta data
        List<CORE_RestApiHandler_CLS.FlowOutput> output = CORE_RestApiHandler_CLS.postCallout(entryData);
        CORE_RestApiHandler_CLS.FlowOutput flowOutput = output[0];
        //debug
        system.debug('estado respuesta : '+response.getbody()+' estado output : '+flowOutput.respuesta);
        System.assertEquals(actualValue, flowOutput.respuesta);
        //------------------------
        //testear wrapper response
        // Ejemplo de JSON para parsear
        String json = '{"Codigo": "200", "Contenido": "Success", "Result": { "RvmVehiculo": { "IdRvm": "123", "Tipo": "Sedan", "Marca": "Toyota", "Modelo": "Camry", "Color": "Red", "Motor": "ABC", "Chasis": "DEF", "Serie": "GHI", "Vin": "JKL", "AnioFabricacion": 2020, "SegEntidad": "MNO", "SegPoliza": "PQR", "SegVence": "STU", "ProRut": "VWX", "ProDV": "YZ", "ProNombre": "John", "ProPaterno": "Doe", "ProMaterno": "Smith", "AdQFecha": "2022-01-01", "AdQrepertorio": "ABC", "AdQNroRepertorio": 123, "AdQFecha_Repertorio": "2022-01-02" }, "RvmProAnt": [ {}, {} ], "RvmAnotaciones": [ {}, {} ] }, "Mensaje": "Success"}';
        
        // Llamada al método parse
        CORE_RestApiHandler_CLS.wrapperResponse resp = CORE_RestApiHandler_CLS.wrapperResponse.parse(json);
		system.debug('respuesta     :  '+resp);        
        // Verificación de valores deserializados
        System.assertEquals('200', resp.Codigo);
        System.assertEquals('Success', resp.Contenido);
        System.assertEquals('Success', resp.Mensaje);
        System.assertNotEquals(null, resp.Result);
        System.assertNotEquals(null, resp.Result.RvmVehiculo);
        System.assertEquals('123', resp.Result.RvmVehiculo.IdRvm);
        System.assertEquals('Sedan', resp.Result.RvmVehiculo.Tipo);
        
        
    }
}