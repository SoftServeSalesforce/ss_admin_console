public abstract with sharing class AsyncDiagnosticAction implements IAction, Queueable {
    private Boolean isTest;
    public abstract List<DiagnosticResult> test();
    public abstract List<DiagnosticResult> execute();

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