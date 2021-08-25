public interface IAction {
    List<DiagnosticResult> test();
    List<DiagnosticResult> execute();
}