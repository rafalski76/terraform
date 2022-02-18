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

6. Run init
`terraform init`

7. Run Validate
`terraform validate`

8. Run Apply
`terraform apply`

9. Run Destroy
`terraform destroy`
