global class ScheduleLeadConversion implements Schedulable {

    global void execute(SchedulableContext sc) {
        ConvertLeadsBatch batch = new ConvertLeadsBatch();
        Integer batchSize = 200; 
        Database.executeBatch(batch, batchSize);
    }
}
