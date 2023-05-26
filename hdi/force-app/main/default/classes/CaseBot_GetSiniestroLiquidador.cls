public without sharing class CaseBot_GetSiniestroLiquidador {
    
    public class SiniestroOutput {
        @InvocableVariable(required=true)
        public Id sOrderLiquidador;
      }
    
      public class SiniestroInput {
        @InvocableVariable(required=true)
        public String sOrderNumber;
      }
    
      @InvocableMethod(label='Get Liquidador')
      public static List<SiniestroOutput> getSiniestroLiquidador(list<SiniestroInput> orderInputs) {
        List<SiniestroOutput> orderOutputs = new List<SiniestroOutput>();
        SiniestroOutput orderOutput = new SiniestroOutput();

        try {
          
          List<Case> sCaso = new HDI_CaseSelector().selectByNumSiniestro(orderInputs[0].sOrderNumber);
            
          for(GroupMember objMember : [SELECT GroupId FROM GroupMember WHERE UserOrGroupId =: sCaso[0].OwnerId]){
              orderOutput = new SiniestroOutput();
              orderOutput.sOrderLiquidador = objMember.GroupId;
              orderOutputs.add(orderOutput);  
          }
          if(orderOutputs.isEmpty()){
            List<group> defaultQueue = [Select id From group where developername = 'Liquidadores' limit 1];
            orderOutput.sOrderLiquidador = defaultQueue[0].id;
            orderOutputs.add(orderOutput);  
          }  
        }catch (Exception e) {
          System.debug('CaseBot_GetSiniestroLiquidador: ' + e.getMessage());
        }
        return orderOutputs;    
      }
}