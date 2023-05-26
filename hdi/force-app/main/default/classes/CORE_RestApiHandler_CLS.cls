global 
class CORE_RestApiHandler_CLS {
   
    @InvocableMethod(label='EXT_calloutHdiPost')
    public static List<FlowOutput> postCallout(List<String> entryData) {
        CONF_EndPoint__mdt config = [SELECT id,baseURL__c,auth__c from CONF_EndPoint__mdt	 Limit 1];
        
       String resp = null;
        
        wrapperSend bodySend = new wrapperSend();
        bodySend.patente = entryData[0];
        HttpRequest req = new HttpRequest();
        req.setEndpoint(config.baseURL__c);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', config.auth__c);
        req.setMethod('POST');
        system.debug('bodysend ' + json.serialize(bodySend)); 
        req.setBody(json.serialize(bodySend));
        req.setTimeout(35000);
        Http httpreq = new Http();
        HttpResponse  res;
        
        try
        {    
            res = httpreq.send(req);
           //system.debug('codigo de respuesta > ' + res.getStatusCode() + res.getBody());
            
            if(res.getStatusCode() != 200) {
                
                resp = 'NO OBTUVO RESPUESTA';
                
               // System.debug('The status code returned was not expected: ' +
                 //            res.getStatusCode() + ' ' + res.getStatus());
            } else {
                wrapperResponse respuesta= (CORE_RestApiHandler_CLS.wrapperResponse) JSON.deserialize(res.getBody(),CORE_RestApiHandler_CLS.wrapperResponse.class);
				resp = res.getBody();

            }                   
            
        }catch(Exception e){
            System.debug('Error--'+e.getMessage());
        }
        FlowOutput output = new FlowOutput();
        output.respuesta  =  resp;
        return new List<FlowOutput>{output};
        
    }
        public class Solicitud {
        @invocableVariable(required=true)
        public String patente;
        public Solicitud (String data){
            patente=data;
        }
        public Solicitud ( ){
            
        }
    }
    
    
    public class wrapperResponse {
        
        public String Codigo;
        public String Contenido;
        public Result Result;
        public String Mensaje;
    }
    public class RvmProAnt {
    }
    
    public class Result {
        public RvmVehiculo RvmVehiculo;
        public List<RvmProAnt> RvmProAnt;
        public List<RvmProAnt> RvmAnotaciones;
    }
    
    public class RvmVehiculo {
        public String IdRvm;
        public String Tipo;
        public String Marca;
        public String Modelo;
        public String Color;
        public String Motor;
        public String Chasis;
        public String Serie;
        public String Vin;
        public Integer AnioFabricacion;
        public String SegEntidad;
        public String SegPoliza;
        public String SegVence;
        public String ProRut;
        public String ProDV;
        public String ProNombre;
        public String ProPaterno;
        public String ProMaterno;
        public String AdQFecha;
        public String AdQrepertorio;
        public Integer AdQNroRepertorio;
        public String AdQFecha_Repertorio;
    }    
    
    public class wrapperSend {
        public String Patente;
    }
    
    public static  wrapperResponse parse(String json) {
        return (wrapperResponse) System.JSON.deserialize(json, wrapperResponse.class);
    }
    /*
    public static void calloutExtPostHDI(List<Solicitud> path) {
        string aa = '';
        aa = path[0].patente;
        postCallout(JSON.serialize(aa, true));
    } */
    public class FlowOutput{
        @InvocableVariable public String respuesta;
    }
    
    private class RestAPIException extends Exception {}
}