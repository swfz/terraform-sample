resource "google_workflows_workflow" "sample_workflow" {
  name = "sample_workflow"
  description = "sample workflow"
  service_account = google_service_account.workflow_invoker.id
  source_contents = file("sample.workflow.yml")
}