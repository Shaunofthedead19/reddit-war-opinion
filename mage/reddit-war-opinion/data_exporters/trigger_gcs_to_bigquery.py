from mage_ai.orchestration.triggers.api import trigger_pipeline
if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


@data_exporter
def trigger(*args, **kwargs):
    """
    Trigger another pipeline to run.

    Documentation: https://docs.mage.ai/orchestration/triggers/trigger-pipeline
    """

    trigger_pipeline(
        'gcs_to_bigquery',        # Required: enter the UUID of the pipeline to trigger
        variables={'env': 'prod'},           # Optional: runtime variables for the pipeline
        check_status=True,     # Optional: poll and check the status of the triggered pipeline
        error_on_failure=True, # Optional: if triggered pipeline fails, raise an exception
        poll_interval=300,       # Optional: check the status of triggered pipeline every N seconds
        poll_timeout=600,      # Optional: raise an exception after N seconds
        verbose=True,           # Optional: print status of triggered pipeline run
    )
