public class logoutCP {

    public PageReference updateUser() {
        User u=[Select Id,Feedback_Check__c From User Where Id=:UserInfo.getUserId()];
        u.Feedback_Check__c =false;
        update u;
        return null;
    }

}