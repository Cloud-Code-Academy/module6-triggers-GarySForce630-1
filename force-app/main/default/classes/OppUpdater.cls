public class OppUpdater {
    Public Static Void GetAndUpdate(){
    List<Opportunity> OppCollectionVar = new List<Opportunity>();
    List<Opportunity> GetOpportunities = new List<Opportunity>([SELECT ID, Type FROM Opportunity WHERE Type = '']);
    
     for (Opportunity op:GetOpportunities) {
       op.Type = 'New Customer';
       OppCollectionVar.add(op); 
    }
    Database.update(OppCollectionVar);
    }
}