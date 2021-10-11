public abstract with sharing class SSACAsyncAction implements ISSACAction, Queueable {
    private Boolean isTest;
    public abstract List<SSACResult> test();
    public abstract List<SSACResult> execute();

    public void execute(QueueableContext param1) {
        if (this.isTest) {
            this.test();
        } else {
            this.execute();
        }
    }

    public Id testAsync() {
        this.isTest = true;
        return System.enqueueJob( this);
    }

    public Id executeAsync() {
        this.isTest = false;
        return System.enqueueJob( this);
    }
}