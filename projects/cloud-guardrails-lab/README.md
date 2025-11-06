# AWS Cloud Guardrails – CIS-Lite Baseline (Student Project)

# Implementation Summary (Day 1)
Identity & Access
- Enabled MFA for IAM user used for administration.
- Verified root account hygiene: MFA enabled; no active root access keys.
- Granted temporary AdministratorAccess to the lab IAM user (for setup only).

# CloudTrail (Account-wide Logging)
- Created multi-region trail: org-trail.
- Storage: new S3 bucket cloudtrail-logs-<account-id>-us-east-1-<suffix> with public access block ON and SSE-KMS encryption.
- Enabled log file validation.
- Events: Management events = All; Data events = S3 object-level logging.
- Outcome: Trail status Logging = ON; multi-region = Yes.

# AWS Config (Change Tracking)
- Region of recorder: us-east-2.
- Storage: new S3 bucket awsconfig-<account-id>-us-east-2-<suffix> (same region as recorder).
- Added S3 bucket policy to allow config.amazonaws.com to GetBucketAcl and PutObject to AWSLogs/<account-id>/Config/* with bucket-owner-full-control.
- Recorder settings: Record all supported resource types; continuous recording.
- IAM: Confirmed/created service-linked role AWSServiceRoleForConfig.
- Outcome: Config started recording; configuration items observed in dashboard metrics.

# Buckets Created
- cloudtrail-logs-<account-id>-us-east-1-<suffix> (CloudTrail logs).
- awsconfig-<account-id>-us-east-2-<suffix> (AWS Config snapshots/change history).

# Evidence Artifacts (added to /evidence)
- iam-mfa-enabled.png
- root-keys-none.png
- cloudtrail-multiregion.png
- config-enabled.png
- config-enabled-2.png

# SCP Policy Intent (saved to /scp/)
deny-root-actions.json — Deny most actions when principal is root (except MFA-related and list/get).
deny-public-s3.json — Prevent disabling S3 account/bucket public-access blocks.
