public class testClass {
    
    
    public static void testCall ()
    {
        try{
            String body = '';
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://RCQA.hdi.cl/esb-ws-gtw/ConectorUniversalSiniestro/GetCertificadoAnotacionesVigentes');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Accept-Encoding','gzip, deflate, br');
            req.setHeader('Connection','keep-alive');
            req.setHeader('User-Agent','PostmanRuntime/7.30.0');
            req.setHeader('Accept','*/*');
            req.setHeader('Authorization', 'Bearer '+'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoienR6dGVjaCIsImV4cCI6MTk4NDY4MjQ4MH0.kJ-LVVO3dyPlhTBKNfQu9nwxhdkubZzWLWjtLGFKxRWCB5YZlIU26RUxB628swvaWjYjmVl8nuYiIR8-mxRVnQ');
            req.setMethod('POST');
            req.setBody(body);
            req.setTimeout(35000);
            http httpreq = new Http();
            httpResponse res = httpreq.send(req);
            system.debug(res.getBody());
        }catch(Exception e){
            System.debug('Error--'+e.getMessage());
        }
    }
}