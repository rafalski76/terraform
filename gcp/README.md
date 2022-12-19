Commands used:

1. Use Application Default Credentials (ADC):
`gcloud auth application-default login`

2. List all GCP Projects:
`gcloud projects list`

3. Set active Project:
`gcloud config set project szkola-chmury-proj`

4. Use Service Account Credentials:
```
gcloud iam service-accounts list
gcloud iam service-accounts create prod-svc
gcloud projects add-iam-policy-binding szkola-chmury-proj --member="serviceAccount:prod-svc@szkola-chmury-proj.iam.gserviceaccount.com" --role="roles/owner"
gcloud iam service-accounts keys create prod-svc-creds.json --iam-account=prod-svc@szkola-chmury-proj.iam.gserviceaccount.com
```

5. Set GCP Credentials:
`set GOOGLE_APPLICATION_CREDENTIALS=prod-svc-creds.json`

6. Bootstrap bucket for terraform state 
`gsutil mb -p szkola-chmury-proj gs://szkola-chmury-bucket`

7. Run init
`terraform init`

8. Run Validate
`terraform validate`

9. Run Apply
`terraform apply`

10. Connect to vm
`ssh -i vm-gcp rafal@34.118.123.34`

11. Run Destroy
`terraform destroy`
